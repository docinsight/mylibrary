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
  window.DocInsight.toc["api"] = absolutize([{"id":"mylibrary","uid":"mylibrary.api/mylibrary","title":"MyLibrary","href":"api/mylibrary/index.html"}]);
})();
