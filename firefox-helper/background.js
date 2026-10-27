browser.runtime.onInstalled.addListener(() => {
  browser.contextMenus.create({
    id: "politikcheck-send-selection",
    title: "Für PolitikCheck übernehmen",
    contexts: ["selection"],
    documentUrlPatterns: ["*://facebook.com/*", "*://*.facebook.com/*"]
  });
});

browser.contextMenus.onClicked.addListener(async (info) => {
  if (info.menuItemId !== "politikcheck-send-selection" || !info.selectionText) return;
  const text = info.selectionText.trim();
  await browser.storage.local.set({
    selectedComment: text,
    selectedAt: Date.now()
  });

  if (!text) return;
  const deepLink = "politikcheck://check?text=" + encodeURIComponent(text);
  try {
    await browser.tabs.create({ url: deepLink });
  } catch (_error) {
    await browser.tabs.create({
      url: browser.runtime.getURL("handoff.html") + "?text=" + encodeURIComponent(text)
    });
  }
});
