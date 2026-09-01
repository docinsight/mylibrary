(function () {
  const script = document.currentScript;
  const rootHref = script && script.src
    ? new URL("../../../../", script.src).href
    : new URL("./", document.baseURI).href;

  function absolutize(items) {
    return items.map((item) => {
      const next = { ...item };
      if (next.href) {
        next.href = new URL(next.href, rootHref).href;
      }
      if (next.children) {
        next.children = absolutize(next.children);
      }
      return next;
    });
  }

  window.DocInsight = window.DocInsight || {};
  window.DocInsight.toc = window.DocInsight.toc || {};
  window.DocInsight.toc["site:docs"] = absolutize([{"id":"site:docs:0","uid":"index.md","title":"Introduction","href":"index.html"},{"id":"site:docs:1","uid":"base-types.md","title":"Base Types","href":"base-types.html"},{"id":"site:docs:2","uid":"collections.md","title":"Collections","href":"collections.html"}]);
})();
