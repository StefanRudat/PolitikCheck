const commentField = document.getElementById("comment");
const statusField = document.getElementById("status");
const sendButton = document.getElementById("send");

function updateState(message = "") {
  statusField.textContent = message;
  sendButton.disabled = !commentField.value.trim();
}

browser.storage.local.get(["selectedComment"]).then((value) => {
  if (value.selectedComment) commentField.value = value.selectedComment;
  updateState();
});

document.getElementById("capture").addEventListener("click", async () => {
  try {
    const [tab] = await browser.tabs.query({ active: true, currentWindow: true });
    const results = await browser.tabs.executeScript(tab.id, {
      code: "window.getSelection().toString()"
    });
    const selection = (results && results[0] || "").trim();
    if (!selection) {
      updateState("Bitte zuerst einen Kommentar auf Facebook markieren.");
      return;
    }
    commentField.value = selection;
    updateState();
  } catch (_error) {
    updateState("Markierung nicht lesbar. Nutze auf Facebook das Rechtsklick-Menü.");
  }
});

commentField.addEventListener("input", () => updateState());

sendButton.addEventListener("click", async () => {
  const text = commentField.value.trim();
  if (!text) return;
  if (text.length > 12000) {
    updateState("Bitte nur den einzelnen Kommentar übernehmen (max. 12.000 Zeichen).");
    return;
  }
  await browser.storage.local.set({ selectedComment: text });
  const deepLink = "politikcheck://check?text=" + encodeURIComponent(text);
  window.location.href = deepLink;
  updateState("PolitikCheck wird geöffnet …");
});
