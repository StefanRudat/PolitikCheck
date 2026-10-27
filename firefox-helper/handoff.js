const text = new URLSearchParams(window.location.search).get("text") || "";
document.getElementById("open").addEventListener("click", () => {
  window.location.href = "politikcheck://check?text=" + encodeURIComponent(text);
});
