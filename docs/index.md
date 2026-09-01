---
xref:
  base: mylibrary
---

# Introduction

MyLibrary is a compact Delphi sample library for demonstrating DocInsight API documentation. It uses a small [Spring4D](https://spring4d.org)-inspired collection model without trying to become a production collection framework.

The library is split across four units:

- [[MyLibrary.Types]] defines comparer and key/value helper types.
- [[MyLibrary.Collections]] defines the public collection interfaces and factories.
- [[MyLibrary.Collections.Lists]] provides the list implementations.
- [[MyLibrary.Collections.Dictionaries]] provides the dictionary implementation.

Most application code should depend on interfaces such as [[MyLibrary.Collections/IList{T}]] and [[MyLibrary.Collections/IDictionary{TKey,TValue}]]. The implementation classes are included so DocInsight can show inherited documentation, source links, and interface implementation relationships.
