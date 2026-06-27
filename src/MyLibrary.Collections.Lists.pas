/// <summary>
///   Provides list implementations for the MyLibrary collection interfaces.
/// </summary>
/// <remarks>
///   This unit contains the default array-backed implementations returned by
///   <see cref="TCollections" /> factory methods.
/// </remarks>
unit MyLibrary.Collections.Lists;

interface

uses
  System.Generics.Collections,
  MyLibrary.Collections,
  MyLibrary.Types;

type
  /// <summary>
  ///   Provides a resizable array-backed implementation of
  ///   <see cref="IList&lt;T&gt;" />.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of values in the list.
  /// </typeparam>
  /// <remarks>
  ///   This class is the default implementation returned by
  ///   <see cref="TCollections" />.<c>CreateList&lt;T&gt;</c>.
  /// </remarks>
  TArrayList<T> = class(TInterfacedObject, MyLibrary.Collections.IList<T>)
  private
    FItems: System.Generics.Collections.TList<T>;
    FEqualityComparer: MyLibrary.Types.IEqualityComparer<T>;

    procedure CheckInsertIndex(Index: Integer);
    procedure CheckItemIndex(Index: Integer);
    function GetCount: Integer;
    function GetItem(Index: Integer): T;
    procedure SetItem(Index: Integer; const Value: T);

  public
    /// <summary>
    ///   Initializes a new instance of the <see cref="TArrayList&lt;T&gt;" /> class.
    /// </summary>
    constructor Create; overload;

    /// <summary>
    ///   Initializes a new instance of the <see cref="TArrayList&lt;T&gt;" /> class
    ///   with an equality comparer.
    /// </summary>
    /// <param name="Comparer">
    ///   The <see cref="IEqualityComparer&lt;T&gt;" /> used by lookup operations such
    ///   as <see cref="Contains" /> and <see cref="IndexOf" />.
    /// </param>
    constructor Create(
      const Comparer: MyLibrary.Types.IEqualityComparer<T>); overload;

    /// <summary>
    ///   Releases the resources used by the list.
    /// </summary>
    destructor Destroy; override;
    function GetEnumerator: MyLibrary.Collections.IEnumerator<T>;
    function IsEmpty: Boolean;
    function Contains(const Value: T): Boolean;
    procedure Add(const Value: T);
    procedure AddRange(
      const Values: MyLibrary.Collections.IEnumerable<T>); overload;
    procedure AddRange(const Values: array of T); overload;
    function Remove(const Value: T): Boolean;
    procedure Clear; virtual;
    function IndexOf(const Value: T): Integer;
    procedure Insert(Index: Integer; const Value: T);
    procedure Delete(Index: Integer); virtual;
    procedure Sort; overload;
    procedure Sort(const Comparer: MyLibrary.Types.IComparer<T>); overload;
    procedure Sort(const Comparison: MyLibrary.Types.TComparison<T>); overload;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: T read GetItem write SetItem; default;
  end;

  /// <summary>
  ///   Provides a resizable array-backed list for object references.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of objects in the list.
  /// </typeparam>
  /// <remarks>
  ///   When <see cref="OwnsObjects" /> is true, the list frees contained objects
  ///   when they are deleted, cleared, or when the list is destroyed.
  /// </remarks>
  TObjectArrayList<T: class> = class(TArrayList<T>)
  private
    FOwnsObjects: Boolean;

  public
    /// <summary>
    ///   Initializes a new instance of the <see cref="TObjectArrayList&lt;T&gt;" />
    ///   class.
    /// </summary>
    /// <param name="OwnsObjects">
    ///   True to free contained objects when they are removed from the list or when
    ///   the list is destroyed; otherwise, false.
    /// </param>
    /// <remarks>
    ///   The ownership setting is fixed for the lifetime of the list.
    /// </remarks>
    constructor Create(OwnsObjects: Boolean = True);

    /// <summary>
    ///   Releases the resources used by the object list.
    /// </summary>
    /// <remarks>
    ///   If <see cref="OwnsObjects" /> is true, all remaining objects are freed
    ///   before the list releases its storage.
    /// </remarks>
    destructor Destroy; override;

    /// <summary>
    ///   Removes all objects from the list.
    /// </summary>
    /// <remarks>
    ///   If <see cref="OwnsObjects" /> is true, each contained object is freed
    ///   before the list storage is cleared.
    /// </remarks>
    procedure Clear; override;

    /// <summary>
    ///   Deletes the object at the specified index.
    /// </summary>
    /// <param name="Index">
    ///   The zero-based index of the object to delete.
    /// </param>
    /// <remarks>
    ///   If <see cref="OwnsObjects" /> is true, the removed object is freed.
    /// </remarks>
    procedure Delete(Index: Integer); override;

    /// <summary>
    ///   Gets a value indicating whether the list owns the objects it contains.
    /// </summary>
    /// <remarks>
    ///   Owned objects are freed by <see cref="Clear" />, <see cref="Delete" />,
    ///   and the destructor.
    /// </remarks>
    property OwnsObjects: Boolean read FOwnsObjects;
  end;

implementation

uses
  System.Generics.Defaults;

type
  TComparerAdapter<T> = class(TInterfacedObject, System.Generics.Defaults.IComparer<T>)
  private
    FComparer: MyLibrary.Types.IComparer<T>;
  public
    constructor Create(const Comparer: MyLibrary.Types.IComparer<T>);
    function Compare(const Left, Right: T): Integer;
  end;

  TComparisonAdapter<T> = class(TInterfacedObject, System.Generics.Defaults.IComparer<T>)
  private
    FComparison: MyLibrary.Types.TComparison<T>;
  public
    constructor Create(const Comparison: MyLibrary.Types.TComparison<T>);
    function Compare(const Left, Right: T): Integer;
  end;

  TListEnumerator<T> = class(TInterfacedObject, MyLibrary.Collections.IEnumerator<T>)
  private
    FItems: System.Generics.Collections.TList<T>;
    FHasCurrent: Boolean;
    FIndex: Integer;
  public
    constructor Create(Items: System.Generics.Collections.TList<T>);
    function MoveNext: Boolean;
    function GetCurrent: T;
  end;

{ TComparerAdapter<T> }

constructor TComparerAdapter<T>.Create(const Comparer: MyLibrary.Types.IComparer<T>);
begin
  inherited Create;
  FComparer := Comparer;
end;

function TComparerAdapter<T>.Compare(const Left, Right: T): Integer;
begin
  Result := FComparer.Compare(Left, Right);
end;

{ TComparisonAdapter<T> }

constructor TComparisonAdapter<T>.Create(
  const Comparison: MyLibrary.Types.TComparison<T>);
begin
  inherited Create;
  FComparison := Comparison;
end;

function TComparisonAdapter<T>.Compare(const Left, Right: T): Integer;
begin
  Result := FComparison(Left, Right);
end;

{ TListEnumerator<T> }

constructor TListEnumerator<T>.Create(Items: System.Generics.Collections.TList<T>);
begin
  inherited Create;
  FItems := Items;
  FIndex := -1;
end;

function TListEnumerator<T>.GetCurrent: T;
begin
  if not FHasCurrent then
    raise MyLibrary.Types.EInvalidOperationException.Create(
      'The enumerator is not positioned on a value.');

  Result := FItems[FIndex];
end;

function TListEnumerator<T>.MoveNext: Boolean;
begin
  Result := FIndex < FItems.Count - 1;
  if Result then
  begin
    Inc(FIndex);
    FHasCurrent := True;
  end
  else
    FHasCurrent := False;
end;

{ TArrayList<T> }

constructor TArrayList<T>.Create;
begin
  inherited Create;
  FItems := System.Generics.Collections.TList<T>.Create;
end;

constructor TArrayList<T>.Create(
  const Comparer: MyLibrary.Types.IEqualityComparer<T>);
begin
  inherited Create;
  FItems := System.Generics.Collections.TList<T>.Create;
  FEqualityComparer := Comparer;
end;

procedure TArrayList<T>.CheckInsertIndex(Index: Integer);
begin
  if (Index < 0) or (Index > FItems.Count) then
    raise MyLibrary.Types.EArgumentOutOfRangeException.Create(
      'Index is outside the valid range of insert positions.');
end;

procedure TArrayList<T>.CheckItemIndex(Index: Integer);
begin
  if (Index < 0) or (Index >= FItems.Count) then
    raise MyLibrary.Types.EArgumentOutOfRangeException.Create(
      'Index is outside the valid range of indexes.');
end;

destructor TArrayList<T>.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TArrayList<T>.Add(const Value: T);
begin
  FItems.Add(Value);
end;

procedure TArrayList<T>.AddRange(
  const Values: MyLibrary.Collections.IEnumerable<T>);
var
  Enumerator: MyLibrary.Collections.IEnumerator<T>;
begin
  if Values = nil then
    raise MyLibrary.Types.EArgumentNilException.Create(
      'Values cannot be nil.');

  Enumerator := Values.GetEnumerator;
  while Enumerator.MoveNext do
    Add(Enumerator.Current);
end;

procedure TArrayList<T>.AddRange(const Values: array of T);
var
  Index: Integer;
begin
  for Index := Low(Values) to High(Values) do
    Add(Values[Index]);
end;

procedure TArrayList<T>.Clear;
begin
  FItems.Clear;
end;

function TArrayList<T>.Contains(const Value: T): Boolean;
begin
  Result := IndexOf(Value) >= 0;
end;

procedure TArrayList<T>.Delete(Index: Integer);
begin
  CheckItemIndex(Index);
  FItems.Delete(Index);
end;

function TArrayList<T>.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TArrayList<T>.GetEnumerator: MyLibrary.Collections.IEnumerator<T>;
begin
  Result := TListEnumerator<T>.Create(FItems);
end;

function TArrayList<T>.GetItem(Index: Integer): T;
begin
  CheckItemIndex(Index);
  Result := FItems[Index];
end;

function TArrayList<T>.IndexOf(const Value: T): Integer;
var
  Index: Integer;
begin
  if FEqualityComparer = nil then
    Exit(FItems.IndexOf(Value));

  for Index := 0 to FItems.Count - 1 do
    if FEqualityComparer.Equals(FItems[Index], Value) then
      Exit(Index);

  Result := -1;
end;

procedure TArrayList<T>.Insert(Index: Integer; const Value: T);
begin
  CheckInsertIndex(Index);
  FItems.Insert(Index, Value);
end;

function TArrayList<T>.IsEmpty: Boolean;
begin
  Result := FItems.Count = 0;
end;

function TArrayList<T>.Remove(const Value: T): Boolean;
var
  Index: Integer;
begin
  Index := IndexOf(Value);
  Result := Index >= 0;
  if Result then
    Delete(Index);
end;

procedure TArrayList<T>.SetItem(Index: Integer; const Value: T);
begin
  CheckItemIndex(Index);
  FItems[Index] := Value;
end;

procedure TArrayList<T>.Sort;
begin
  FItems.Sort;
end;

procedure TArrayList<T>.Sort(const Comparer: MyLibrary.Types.IComparer<T>);
begin
  if Comparer = nil then
    Sort
  else
    FItems.Sort(TComparerAdapter<T>.Create(Comparer));
end;

procedure TArrayList<T>.Sort(
  const Comparison: MyLibrary.Types.TComparison<T>);
begin
  if not Assigned(Comparison) then
    Sort
  else
    FItems.Sort(TComparisonAdapter<T>.Create(Comparison));
end;

{ TObjectArrayList<T> }

constructor TObjectArrayList<T>.Create(OwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := OwnsObjects;
end;

destructor TObjectArrayList<T>.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TObjectArrayList<T>.Clear;
begin
  if FOwnsObjects then
    while Count > 0 do
      Delete(Count - 1)
  else
    inherited Clear;
end;

procedure TObjectArrayList<T>.Delete(Index: Integer);
var
  Item: T;
begin
  if FOwnsObjects then
  begin
    Item := Items[Index];
    inherited Delete(Index);
    Item.Free;
  end
  else
    inherited Delete(Index);
end;

end.
