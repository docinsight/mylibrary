# Base Types

The base types in <xref:api/mylibrary.types> support comparison, equality, and key/value pairs used by the collection interfaces.

Use <xref:api/mylibrary.types/iequalitycomparer`1> when lookup operations need custom equality. Lists use it for methods such as <xref:api/mylibrary.collections/ireadonlycollection`1.contains> and <xref:api/mylibrary.collections/ilist`1.indexof>. Dictionaries use it for key lookup.

Use <xref:api/mylibrary.types/icomparer`1> or <xref:api/mylibrary.types/tcomparison`1> when callers need custom sort order for <xref:api/mylibrary.collections/ilist`1.sort>.

Use <xref:api/mylibrary.types/tpair`2> for dictionary enumeration and APIs that need to pass a key and value as one item.

The unit also defines common exception types used by the collection contracts, including <xref:api/mylibrary.types/eargumentexception>, <xref:api/mylibrary.types/eargumentnilexception>, <xref:api/mylibrary.types/eargumentoutofrangeexception>, and <xref:api/mylibrary.types/ekeynotfoundexception>.
