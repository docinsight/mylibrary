# Collections

The collections framework provides generic interfaces and implementations for common collection patterns in Delphi.

## Choosing a collection

Use the <xref:api/mylibrary.collections/ilist`1> interface when callers need an ordered collection with indexed access and enumeration. If callers only need to iterate values, expose a smaller read-only interface to keep the API flexible.

Use the <xref:api/mylibrary.collections/idictionary`2> interface when callers need keyed lookup. Prefer the <xref:api/mylibrary.collections/tcollections> factory methods when creating collection instances.

## Performance

Choose the collection that matches the access pattern: lists for ordered traversal and indexed access, and dictionaries for keyed lookup.
