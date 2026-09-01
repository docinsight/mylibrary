---
xref:
  base: mylibrary/MyLibrary.Collections
  aliases:
    types: mylibrary/MyLibrary.Types
---

# Collections

The collections framework provides generic interfaces and implementations for common collection patterns in Delphi.

## Choosing a collection

Use [[IEnumerable{T}]] when callers only need to iterate values. Use [[IReadOnlyCollection{T}]] when they also need [[IReadOnlyCollection{T}.Count]] or [[IReadOnlyCollection{T}.Contains]]. Use [[IList{T}]] for an ordered, mutable collection with indexed access.

Use the [[IDictionary{TKey,TValue}]] interface when callers need keyed lookup. Prefer the [[TCollections]] factory methods when creating collection instances.

Use [[TCollections.CreateObjectList{T}]] for a list that can own object lifetimes. When ownership is enabled, removing or deleting an object, clearing the list, or destroying the list frees the affected objects. Assigning a new value through the indexed [[IList{T}.Items]] property does not free the object being replaced.

## Comparers

The equality comparer passed to [[TCollections.CreateList{T}]] controls [[IReadOnlyCollection{T}.Contains]], [[IList{T}.IndexOf]], and [[ICollection{T}.Remove]]. It does not control sorting; pass an [[types/IComparer{T}]] or [[types/TComparison{T}]] to [[IList{T}.Sort]] for a custom order.

The equality comparer passed to [[TCollections.CreateDictionary{TKey,TValue}]] applies to keys. Dictionary value comparisons use the default equality comparer for the value type.

## Dictionary pair operations

The collection members inherited by [[IDictionary{TKey,TValue}]] operate on [[types/TPair{TKey,TValue}]] values. [[IReadOnlyCollection{T}.Contains]] and [[ICollection{T}.Remove]] require both the key and value to match. [[ICollection{T}.Add]] rejects a pair whose key already exists, while assigning through [[IDictionary{TKey,TValue}.Items]] adds or replaces a value.

The [[IDictionary{TKey,TValue}.Keys]] and [[IDictionary{TKey,TValue}.Values]] properties return live read-only views that reflect later changes to the dictionary.

## Performance

Choose the collection that matches the access pattern: lists for ordered traversal and indexed access, and dictionaries for keyed lookup.
