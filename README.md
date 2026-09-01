# MyLibrary

> [!NOTE]
>
> This preview was built with an unreleased prerelease build of **DocInsight 2026.1**.

MyLibrary is a compact Delphi sample project for demonstrating DocInsight documentation. It includes a small interface-first generic collection model centered on `IList<T>`, `IDictionary<TKey, TValue>`, and `TCollections`.

## Documentation

Run the DocInsight checks and build the HTML output:

```bash
docinsight check
docinsight build --open
```

The generated site is written to `dist/docs/site`.

## GitHub Pages deployment

This repository publishes GitHub Pages from the `gh-pages` branch. Deployment is
currently done by running the publish script locally:

```bash
scripts/publish-gh-pages.sh --push
```

The script builds the documentation site, creates a fresh orphan commit on
`gh-pages`, and pushes it to the configured remote.

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).
