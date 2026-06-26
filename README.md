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

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).
