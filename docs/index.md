# Introduction

> [!NOTE]
>
> This preview was built with an **unreleased** prerelease build of DocInsight 2026.1.

MyLibrary is a compact Delphi sample library for demonstrating DocInsight API documentation. It uses a small [Spring4D](https://spring4d.org)-inspired collection model without trying to become a production collection framework.

The public API is split across three units:

- <xref:api/mylibrary.types> defines comparer and key/value helper types.
- <xref:api/mylibrary.collections> defines the public collection interfaces and factories.
- <xref:api/mylibrary.collections.lists> and <xref:api/mylibrary.collections.dictionaries> provide concrete implementations.

Most application code should depend on interfaces such as <xref:api/mylibrary.collections/ilist`1> and <xref:api/mylibrary.collections/idictionary`2>. The implementation classes are included so DocInsight can show inherited documentation, source links, and interface implementation relationships.
