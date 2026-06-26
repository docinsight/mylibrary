/// <summary>
///   Defines the public collection abstractions and factory methods for MyLibrary.
/// </summary>
/// <remarks>
///   This unit is the main API entry point for the sample collection library.
///   The primary entry points are <see cref="IList&lt;T&gt;" />,
///   <see cref="IDictionary&lt;TKey,TValue&gt;" />, and <see cref="TCollections" />.
/// </remarks>
unit MyLibrary.Collections;

interface

uses
  MyLibrary.Types;

type
  /// <summary>
  ///   Provides forward-only access to a sequence of values.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of values returned by the enumerator.
  /// </typeparam>
  IEnumerator<T> = interface
    /// <summary>
    ///   Advances the enumerator to the next value in the sequence.
    /// </summary>
    /// <returns>
    ///   True if the enumerator was advanced to the next value; otherwise, false.
    /// </returns>
    function MoveNext: Boolean;

    /// <summary>
    ///   Gets the value at the current position of the enumerator.
    /// </summary>
    /// <returns>
    ///   The value at the current position of the enumerator.
    /// </returns>
    function GetCurrent: T;

    /// <summary>
    ///   Gets the value at the current position of the enumerator.
    /// </summary>
    property Current: T read GetCurrent;
  end;

  /// <summary>
  ///   Defines a sequence that can be enumerated.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of values in the sequence.
  /// </typeparam>
  IEnumerable<T> = interface
    /// <summary>
    ///   Returns an enumerator that iterates through the sequence.
    /// </summary>
    /// <returns>
    ///   An <see cref="IEnumerator&lt;T&gt;" /> for the sequence.
    /// </returns>
    function GetEnumerator: IEnumerator<T>;
  end;

  /// <summary>
  ///   Defines an <see cref="IEnumerable&lt;T&gt;" /> with a count and read-only
  ///   query operations.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of values in the collection.
  /// </typeparam>
  IReadOnlyCollection<T> = interface(IEnumerable<T>)
    /// <summary>
    ///   Gets the number of values in the collection.
    /// </summary>
    /// <returns>
    ///   The number of values in the collection.
    /// </returns>
    function GetCount: Integer;

    /// <summary>
    ///   Determines whether the collection contains no values.
    /// </summary>
    /// <returns>
    ///   True if the collection is empty; otherwise, false.
    /// </returns>
    function IsEmpty: Boolean;

    /// <summary>
    ///   Determines whether the collection contains a specific value.
    /// </summary>
    /// <param name="Value">
    ///   The value to locate in the collection.
    /// </param>
    /// <returns>
    ///   True if the value is found in the collection; otherwise, false.
    /// </returns>
    function Contains(const Value: T): Boolean;

    /// <summary>
    ///   Gets the number of values in the collection.
    /// </summary>
    property Count: Integer read GetCount;
  end;

  /// <summary>
  ///   Defines an <see cref="IReadOnlyCollection&lt;T&gt;" /> that can be modified.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of values in the collection.
  /// </typeparam>
  ICollection<T> = interface(IReadOnlyCollection<T>)
    /// <summary>
    ///   Adds a value to the collection.
    /// </summary>
    /// <param name="Value">
    ///   The value to add.
    /// </param>
    procedure Add(const Value: T);

    /// <summary>
    ///   Adds the values of a sequence to the collection.
    /// </summary>
    /// <param name="Values">
    ///   The values to add.
    /// </param>
    procedure AddRange(const Values: IEnumerable<T>); overload;

    /// <summary>
    ///   Adds the values of an open array to the collection.
    /// </summary>
    /// <param name="Values">
    ///   The values to add.
    /// </param>
    /// <remarks>
    ///   Values are added in array order.
    /// </remarks>
    procedure AddRange(const Values: array of T); overload;

    /// <summary>
    ///   Removes the first occurrence of a value from the collection.
    /// </summary>
    /// <param name="Value">
    ///   The value to remove.
    /// </param>
    /// <returns>
    ///   True if the value was removed; otherwise, false.
    /// </returns>
    function Remove(const Value: T): Boolean;

    /// <summary>
    ///   Removes all values from the collection.
    /// </summary>
    procedure Clear;
  end;

  /// <summary>
  ///   Defines an <see cref="ICollection&lt;T&gt;" /> whose values can be accessed by
  ///   zero-based index.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of values in the list.
  /// </typeparam>
  IList<T> = interface(ICollection<T>)
    /// <summary>
    ///   Gets the value at the specified index.
    /// </summary>
    /// <param name="Index">
    ///   The zero-based index of the value to get.
    /// </param>
    /// <returns>
    ///   The value at the specified index.
    /// </returns>
    function GetItem(Index: Integer): T;

    /// <summary>
    ///   Sets the value at the specified index.
    /// </summary>
    /// <param name="Index">
    ///   The zero-based index of the value to set.
    /// </param>
    /// <param name="Value">
    ///   The new value.
    /// </param>
    procedure SetItem(Index: Integer; const Value: T);

    /// <summary>
    ///   Returns the zero-based index of the first occurrence of a value.
    /// </summary>
    /// <param name="Value">
    ///   The value to locate in the list.
    /// </param>
    /// <returns>
    ///   The zero-based index of the value if found; otherwise, -1.
    /// </returns>
    function IndexOf(const Value: T): Integer;

    /// <summary>
    ///   Inserts a value at the specified index.
    /// </summary>
    /// <param name="Index">
    ///   The zero-based index at which the value should be inserted.
    /// </param>
    /// <param name="Value">
    ///   The value to insert.
    /// </param>
    procedure Insert(Index: Integer; const Value: T);

    /// <summary>
    ///   Deletes the value at the specified index.
    /// </summary>
    /// <param name="Index">
    ///   The zero-based index of the value to delete.
    /// </param>
    procedure Delete(Index: Integer);

    /// <summary>
    ///   Sorts the values in the list by using the default comparer.
    /// </summary>
    /// <remarks>
    ///   The default comparer is provided by the Delphi RTL for the value type.
    /// </remarks>
    procedure Sort; overload;

    /// <summary>
    ///   Sorts the values in the list by using a comparer.
    /// </summary>
    /// <param name="Comparer">
    ///   The <see cref="IComparer&lt;T&gt;" /> used to order values.
    /// </param>
    /// <remarks>
    ///   If <paramref name="Comparer" /> is nil, the default comparer is used.
    /// </remarks>
    procedure Sort(const Comparer: IComparer<T>); overload;

    /// <summary>
    ///   Sorts the values in the list by using a comparison callback.
    /// </summary>
    /// <param name="Comparison">
    ///   The <see cref="TComparison&lt;T&gt;" /> callback used to order values.
    /// </param>
    /// <remarks>
    ///   If <paramref name="Comparison" /> is nil, the default comparer is used.
    /// </remarks>
    procedure Sort(const Comparison: TComparison<T>); overload;

    /// <summary>
    ///   Gets or sets the value at the specified index.
    /// </summary>
    /// <param name="Index">
    ///   The zero-based index of the value to get or set.
    /// </param>
    property Items[Index: Integer]: T read GetItem write SetItem; default;
  end;

  /// <summary>
  ///   Defines a collection of <see cref="TPair&lt;TKey,TValue&gt;" /> values that can be
  ///   accessed by key.
  /// </summary>
  /// <typeparam name="TKey">
  ///   The type of keys in the dictionary.
  /// </typeparam>
  /// <typeparam name="TValue">
  ///   The type of values in the dictionary.
  /// </typeparam>
  IDictionary<TKey, TValue> = interface(ICollection<TPair<TKey, TValue>>)
    /// <summary>
    ///   Gets the value associated with the specified key.
    /// </summary>
    /// <param name="Key">
    ///   The key whose value should be returned.
    /// </param>
    /// <returns>
    ///   The value associated with the specified key.
    /// </returns>
    function GetItem(const Key: TKey): TValue;

    /// <summary>
    ///   Sets the value associated with the specified key.
    /// </summary>
    /// <param name="Key">
    ///   The key whose value should be set.
    /// </param>
    /// <param name="Value">
    ///   The value to associate with the key.
    /// </param>
    procedure SetItem(const Key: TKey; const Value: TValue);

    /// <summary>
    ///   Returns a read-only view containing the keys in the dictionary.
    /// </summary>
    /// <returns>
    ///   An <see cref="IReadOnlyCollection&lt;TKey&gt;" /> view of the dictionary
    ///   keys.
    /// </returns>
    /// <remarks>
    ///   The returned collection reflects subsequent changes to the dictionary;
    ///   it is not a snapshot.
    /// </remarks>
    function GetKeys: IReadOnlyCollection<TKey>;

    /// <summary>
    ///   Returns a read-only view containing the values in the dictionary.
    /// </summary>
    /// <returns>
    ///   An <see cref="IReadOnlyCollection&lt;TValue&gt;" /> view of the dictionary
    ///   values.
    /// </returns>
    /// <remarks>
    ///   The returned collection reflects subsequent changes to the dictionary;
    ///   it is not a snapshot.
    /// </remarks>
    function GetValues: IReadOnlyCollection<TValue>;

    /// <summary>
    ///   Determines whether the dictionary contains a specific key.
    /// </summary>
    /// <param name="Key">
    ///   The key to locate in the dictionary.
    /// </param>
    /// <returns>
    ///   True if the key is found in the dictionary; otherwise, false.
    /// </returns>
    function ContainsKey(const Key: TKey): Boolean;

    /// <summary>
    ///   Returns the value associated with a key.
    /// </summary>
    /// <param name="Key">
    ///   The key whose value should be returned.
    /// </param>
    /// <param name="Value">
    ///   When this method returns, contains the value associated with the key if
    ///   the key is found.
    /// </param>
    /// <returns>
    ///   True if the key is found; otherwise, false.
    /// </returns>
    function TryGetValue(const Key: TKey; out Value: TValue): Boolean;

    /// <summary>
    ///   Adds a key and value to the dictionary.
    /// </summary>
    /// <param name="Key">
    ///   The key to add.
    /// </param>
    /// <param name="Value">
    ///   The value to add.
    /// </param>
    procedure Add(const Key: TKey; const Value: TValue); overload;

    /// <summary>
    ///   Removes the value with the specified key from the dictionary.
    /// </summary>
    /// <param name="Key">
    ///   The key of the value to remove.
    /// </param>
    /// <returns>
    ///   True if the key was found and removed; otherwise, false.
    /// </returns>
    function Remove(const Key: TKey): Boolean; overload;

    /// <summary>
    ///   Gets or sets the value associated with the specified key.
    /// </summary>
    /// <param name="Key">
    ///   The key of the value to get or set.
    /// </param>
    property Items[const Key: TKey]: TValue read GetItem write SetItem; default;

    /// <summary>
    ///   Gets a read-only view containing the keys in the dictionary.
    /// </summary>
    property Keys: IReadOnlyCollection<TKey> read GetKeys;

    /// <summary>
    ///   Gets a read-only view containing the values in the dictionary.
    /// </summary>
    property Values: IReadOnlyCollection<TValue> read GetValues;
  end;

  /// <summary>
  ///   Provides factory methods for creating collection instances.
  /// </summary>
  /// <remarks>
  ///   Factory methods return <see cref="IList&lt;T&gt;" /> and
  ///   <see cref="IDictionary&lt;TKey,TValue&gt;" /> interfaces so callers can depend on
  ///   abstractions rather than concrete implementation classes.
  /// </remarks>
  TCollections = class
  public
    /// <summary>
    ///   Creates a resizable list.
    /// </summary>
    /// <typeparam name="T">
    ///   The type of values in the list.
    /// </typeparam>
    /// <returns>
    ///   A new <see cref="IList&lt;T&gt;" /> instance.
    /// </returns>
    /// <example>
    /// <code>
    ///   var
    ///     Names: IList&lt;string&gt;;
    ///   begin
    ///     Names := TCollections.CreateList&lt;string&gt;;
    ///     Names.AddRange(['Ada', 'Grace']);
    ///   end;
    /// </code>
    /// </example>
    class function CreateList<T>: IList<T>; overload; static;

    /// <summary>
    ///   Creates a resizable list that uses an equality comparer for lookup.
    /// </summary>
    /// <typeparam name="T">
    ///   The type of values in the list.
    /// </typeparam>
    /// <param name="Comparer">
    ///   The <see cref="IEqualityComparer&lt;T&gt;" /> used by lookup operations such
    ///   as <see cref="IReadOnlyCollection&lt;T&gt;.Contains" /> and
    ///   <see cref="IList&lt;T&gt;.IndexOf" />.
    /// </param>
    /// <returns>
    ///   A new <see cref="IList&lt;T&gt;" /> instance.
    /// </returns>
    /// <remarks>
    ///   Sorting still uses the comparer or comparison callback passed to
    ///   <see cref="IList&lt;T&gt;.Sort" />.
    /// </remarks>
    class function CreateList<T>(
      const Comparer: IEqualityComparer<T>): IList<T>; overload; static;

    /// <summary>
    ///   Creates a resizable list for object references.
    /// </summary>
    /// <typeparam name="T">
    ///   The type of objects in the list.
    /// </typeparam>
    /// <param name="OwnsObjects">
    ///   True to free objects when they are removed from the list or when the list
    ///   is destroyed; otherwise, false.
    /// </param>
    /// <returns>
    ///   A new <see cref="IList&lt;T&gt;" /> instance for object references.
    /// </returns>
    /// <remarks>
    ///   Use this factory when the returned <see cref="IList&lt;T&gt;" /> should own
    ///   the lifetime of the objects it contains.
    /// </remarks>
    /// <example>
    /// <code>
    ///   var
    ///     Items: IList&lt;TObject&gt;;
    ///   begin
    ///     Items := TCollections.CreateObjectList&lt;TObject&gt;(True);
    ///     Items.Add(TObject.Create);
    ///     Items.Clear;
    ///   end;
    /// </code>
    /// </example>
    class function CreateObjectList<T: class>(
      OwnsObjects: Boolean = True): IList<T>; static;

    /// <summary>
    ///   Creates a hash-based dictionary.
    /// </summary>
    /// <typeparam name="TKey">
    ///   The type of keys in the dictionary.
    /// </typeparam>
    /// <typeparam name="TValue">
    ///   The type of values in the dictionary.
    /// </typeparam>
    /// <returns>
    ///   A new <see cref="IDictionary&lt;TKey,TValue&gt;" /> instance.
    /// </returns>
    /// <example>
    /// <code>
    ///   var
    ///     Ages: IDictionary&lt;string,Integer&gt;;
    ///   begin
    ///     Ages := TCollections.CreateDictionary&lt;string,Integer&gt;;
    ///     Ages.Add('Ada', 36);
    ///   end;
    /// </code>
    /// </example>
    class function CreateDictionary<TKey, TValue>: IDictionary<TKey, TValue>;
      overload; static;

    /// <summary>
    ///   Creates a hash-based dictionary that uses an equality comparer for keys.
    /// </summary>
    /// <typeparam name="TKey">
    ///   The type of keys in the dictionary.
    /// </typeparam>
    /// <typeparam name="TValue">
    ///   The type of values in the dictionary.
    /// </typeparam>
    /// <param name="Comparer">
    ///   The <see cref="IEqualityComparer&lt;TKey&gt;" /> used for dictionary keys.
    /// </param>
    /// <returns>
    ///   A new <see cref="IDictionary&lt;TKey,TValue&gt;" /> instance.
    /// </returns>
    class function CreateDictionary<TKey, TValue>(
      const Comparer: IEqualityComparer<TKey>): IDictionary<TKey, TValue>;
      overload; static;
  end;

implementation

uses
  MyLibrary.Collections.Dictionaries,
  MyLibrary.Collections.Lists;

class function TCollections.CreateList<T>: IList<T>;
begin
  Result := TArrayList<T>.Create;
end;

class function TCollections.CreateList<T>(
  const Comparer: IEqualityComparer<T>): IList<T>;
begin
  Result := TArrayList<T>.Create(Comparer);
end;

class function TCollections.CreateObjectList<T>(
  OwnsObjects: Boolean): IList<T>;
begin
  Result := TObjectArrayList<T>.Create(OwnsObjects);
end;

class function TCollections.CreateDictionary<TKey, TValue>:
  IDictionary<TKey, TValue>;
begin
  Result := THashDictionary<TKey, TValue>.Create;
end;

class function TCollections.CreateDictionary<TKey, TValue>(
  const Comparer: IEqualityComparer<TKey>): IDictionary<TKey, TValue>;
begin
  Result := THashDictionary<TKey, TValue>.Create(Comparer);
end;

end.
