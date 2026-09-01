---
xref:
  base: mylibrary/MyLibrary.Types
  aliases:
    collections: mylibrary/MyLibrary.Collections
---

# Base Types

The base types in [[.]] support comparison, equality, and key/value pairs used by the collection interfaces.

Use [[IEqualityComparer{T}]] when lookup operations need custom equality. Lists use it for methods such as [[collections/IReadOnlyCollection{T}.Contains]] and [[collections/IList{T}.IndexOf]]. Dictionaries use it for key lookup.

Use [[IComparer{T}]] or [[TComparison{T}]] when callers need custom sort order for [[collections/IList{T}.Sort]].

Use [[TPair{TKey,TValue}]] for dictionary enumeration and APIs that need to pass a key and value as one item.

The unit also defines common exception types used by the collection contracts, including [[EArgumentException]], [[EArgumentNilException]], [[EArgumentOutOfRangeException]], [[EInvalidOperationException]], and [[EKeyNotFoundException]].
