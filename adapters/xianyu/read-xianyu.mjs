#!/usr/bin/env node
// 闲鱼「半自动读取」adapter —— B 档(read-only, 用你已登录的有界面浏览器)
//
// 已验证的事实:
//  - 无头 Chrome 会被闲鱼反爬挡("非法访问") → 必须用有界面的正常浏览器
//  - 匿名看不到搜索结果(显示"登录"+"加载中") → 必须先登录
// 所以前提:先用 ./launch-chrome.sh 起【有界面】Chrome 并【登录闲鱼】(扫码,只能你做)。
//
// 用法: node read-xianyu.mjs <关键词> [调试端口,默认9222]
//   例: node read-xianyu.mjs "AI头像" 9222
//
// 它在你已登录的浏览器里新开一页、搜该词、读结果。read-only:不下单、不私聊、不批量翻页。
// 诚实说明:提取是启发式("找含单个 ¥价格 的卡片"),已用 mock 验证 3/3;
// 真实结果页若条数不对,把输出的 diagnostics 发回即可几分钟调好选择器。

import { chromium } from 'playwright-core';

const KEYWORD = process.argv[2];
const PORT = process.argv[3] || '9222';

if (!KEYWORD) {
  console.error('用法: node read-xianyu.mjs <关键词> [端口]\n例:  node read-xianyu.mjs "AI头像" 9222');
  process.exit(1);
}

function pageExtractor() {
  const out = { url: location.href, title: document.title, items: [], diagnostics: {} };
  const bodyText = (document.body.innerText || '');

  // 反爬/登录拦截探测
  if (/非法访问|请使用正常浏览器/.test(bodyText)) out.diagnostics.blocked = '被反爬拦截(非法访问)';
  if (/加载中/.test(bodyText) && bodyText.length < 600) out.diagnostics.maybeNeedLogin = '疑似未登录/结果未加载(页面停在"加载中")';

  const priceRe = /[¥￥]\s?\d[\d,.]*/;
  const priceReG = /[¥￥]\s?\d[\d,.]*/g;
  const wantRe = /(\d[\d,.]*)\s*人?想要/;
  const priceCount = s => (s.match(priceReG) || []).length;
  const seen = new Set();
  const cards = [];
  for (const el of Array.from(document.querySelectorAll('a, div, li'))) {
    const t = (el.innerText || '').trim();
    if (!t || t.length > 300) continue;
    if (priceCount(t) !== 1) continue;               // 只认含单个价格的卡片种子
    let card = el;
    for (let i = 0; i < 4 && card.parentElement; i++) {
      const pt = (card.parentElement.innerText || '').trim();
      if (pt.length > 400 || priceCount(pt) > 1) break; // 再多一个价格就停,别吞相邻卡片
      card = card.parentElement;
    }
    const ct = (card.innerText || '').trim();
    if (seen.has(ct)) continue;
    seen.add(ct);
    // 价格重组:闲鱼把 ¥ / 整数 / .小数 拆成多节点,innerText 里夹了换行
    const pm = ct.match(/[¥￥]\s*(\d+)\s*(\.\s*\d+)?/);
    const price = pm ? ('¥' + pm[1] + (pm[2] ? pm[2].replace(/\s+/g, '') : '')) : '';
    const want = (ct.match(wantRe) || [null, null])[1];
    // 标题:排除纯数字/价格碎片/想要 等行,取最长
    const title = ct.split('\n').map(s => s.trim())
      .filter(s => s && !/想要/.test(s) && !/^[\d.,%¥￥]+$/.test(s) && s.length >= 4)
      .sort((a, b) => b.length - a.length)[0] || '';
    const link = (card.querySelector('a') || el.closest('a') || {}).href || '';
    cards.push({ title, price, want, link });
  }
  // 同一商品的价格碎片会生成多个 card → 按链接 id 归并,每个取最长标题
  const byId = new Map();
  for (const c of cards) {
    const id = (c.link.match(/[?&]id=(\d+)/) || [null, c.link])[1] || c.link || c.title;
    const prev = byId.get(id);
    if (!prev) { byId.set(id, c); continue; }
    byId.set(id, {
      title: (c.title.length > prev.title.length ? c.title : prev.title),
      price: prev.price || c.price,
      want: prev.want || c.want,
      link: prev.link || c.link,
    });
  }
  out.items = [...byId.values()].filter(c => c.title && c.price).slice(0, 60);
  out.diagnostics.rawCandidateCount = cards.length;
  out.diagnostics.mergedCount = out.items.length;
  out.diagnostics.sampleRawText = bodyText.slice(0, 300);
  return out;
}

(async () => {
  let browser;
  try {
    browser = await chromium.connectOverCDP(`http://localhost:${PORT}`);
  } catch (e) {
    console.error(`❌ 连不上 Chrome 调试端口 ${PORT}。先运行 ./launch-chrome.sh 启动【有界面】Chrome 并登录闲鱼。\n原因: ${e.message}`);
    process.exit(1);
  }
  const ctx = browser.contexts()[0];
  if (!ctx) { console.error('❌ 没有浏览器上下文'); process.exit(1); }

  // 在你已登录的浏览器里新开一页(共享登录态),搜关键词
  const page = await ctx.newPage();
  const url = `https://www.goofish.com/search?q=${encodeURIComponent(KEYWORD)}`;
  await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 25000 }).catch(() => {});
  // 等结果 + 轻滚动触发懒加载(不翻页)
  await page.waitForTimeout(4000);
  await page.evaluate(() => window.scrollBy(0, 1600)).catch(() => {});
  await page.waitForTimeout(3000);

  const data = await page.evaluate(pageExtractor);
  console.log(JSON.stringify(data, null, 2));
  await page.close().catch(() => {});
  await browser.close().catch(() => {});
})();
