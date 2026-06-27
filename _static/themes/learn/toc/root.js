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
  window.DocInsight.toc["__root"] = absolutize([{"id":"index","uid":"mylibrary.docs/index","title":"Introduction","href":"index.html"},{"id":"base-types","uid":"mylibrary.docs/base-types","title":"Base Types","href":"base-types.html"},{"id":"collections","uid":"mylibrary.docs/collections","title":"Collections","href":"collections.html"}]);
})();
