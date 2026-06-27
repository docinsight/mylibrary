/// <summary>
///   Provides dictionary implementations for the MyLibrary collection interfaces.
/// </summary>
/// <remarks>
///   This unit contains the default hash-based dictionary implementation returned
///   by <see cref="TCollections" /> factory methods.
/// </remarks>
unit MyLibrary.Collections.Dictionaries;

interface

uses
  System.Generics.Collections,
  MyLibrary.Collections,
  MyLibrary.Types;

type
  /// <summary>
  ///   Provides a hash-based implementation of
  ///   <see cref="IDictionary&lt;TKey,TValue&gt;" />.
  /// </summary>
  /// <typeparam name="TKey">
  ///   The type of keys in the dictionary.
  /// </typeparam>
  /// <typeparam name="TValue">
  ///   The type of values in the dictionary.
  /// </typeparam>
  /// <remarks>
  ///   This class is the default implementation returned by
  ///   <see cref="TCollections" />.<c>CreateDictionary&lt;TKey,TValue&gt;</c>.
  /// </remarks>
  THashDictionary<TKey, TValue> = class(TInterfacedObject,
    MyLibrary.Collections.IDictionary<TKey, TValue>)
  private
    FItems: System.Generics.Collections.TDictionary<TKey, TValue>;

    function GetCount: Integer;
    function GetItem(const Key: TKey): TValue;
    procedure SetItem(const Key: TKey; const Value: TValue);

  public
    /// <summary>
    ///   Initializes a new instance of the
    ///   <see cref="THashDictionary&lt;TKey,TValue&gt;" /> class.
    /// </summary>
    constructor Create; overload;

    /// <summary>
    ///   Initializes a new instance of the
    ///   <see cref="THashDictionary&lt;TKey,TValue&gt;" /> class with a key comparer.
    /// </summary>
    /// <param name="Comparer">
    ///   The <see cref="IEqualityComparer&lt;TKey&gt;" /> used for dictionary keys.
    /// </param>
    constructor Create(
      const Comparer: MyLibrary.Types.IEqualityComparer<TKey>); overload;

    /// <summary>
    ///   Releases the resources used by the dictionary.
    /// </summary>
    destructor Destroy; override;
    function GetEnumerator:
      MyLibrary.Collections.IEnumerator<MyLibrary.Types.TPair<TKey, TValue>>;
    function IsEmpty: Boolean;
    function Contains(
      const Value: MyLibrary.Types.TPair<TKey, TValue>): Boolean;
    function ContainsKey(const Key: TKey): Boolean;
    function TryGetValue(const Key: TKey; out Value: TValue): Boolean;
    procedure Add(const Value: MyLibrary.Types.TPair<TKey, TValue>); overload;
    procedure Add(const Key: TKey; const Value: TValue); overload;
    procedure AddRange(
      const Values:
        MyLibrary.Collections.IEnumerable<MyLibrary.Types.TPair<TKey, TValue>>);
      overload;
    procedure AddRange(
      const Values: array of MyLibrary.Types.TPair<TKey, TValue>); overload;
    function Remove(
      const Value: MyLibrary.Types.TPair<TKey, TValue>): Boolean; overload;
    function Remove(const Key: TKey): Boolean; overload;
    procedure Clear;
    function GetKeys: MyLibrary.Collections.IReadOnlyCollection<TKey>;
    function GetValues: MyLibrary.Collections.IReadOnlyCollection<TValue>;
    property Count: Integer read GetCount;
    property Items[const Key: TKey]: TValue read GetItem write SetItem; default;
    property Keys: MyLibrary.Collections.IReadOnlyCollection<TKey> read GetKeys;
    property Values: MyLibrary.Collections.IReadOnlyCollection<TValue>
      read GetValues;
  end;

implementation

uses
  System.Generics.Defaults;

type
  TEqualityComparerAdapter<T> = class(TInterfacedObject,
    System.Generics.Defaults.IEqualityComparer<T>)
  private
    FComparer: MyLibrary.Types.IEqualityComparer<T>;
  public
    constructor Create(const Comparer: MyLibrary.Types.IEqualityComparer<T>);
    function Equals(const Left, Right: T): Boolean; reintroduce;
    function GetHashCode(const Value: T): Integer;
  end;

  TRtlEnumerator<T> = class(TInterfacedObject,
    MyLibrary.Collections.IEnumerator<T>)
  private
    FEnumerator: System.Generics.Collections.TEnumerator<T>;
    FHasCurrent: Boolean;
  public
    constructor Create(
      Enumerator: System.Generics.Collections.TEnumerator<T>);
    destructor Destroy; override;
    function MoveNext: Boolean;
    function GetCurrent: T;
  end;

  TDictionaryEnumerator<TKey, TValue> = class(TInterfacedObject,
    MyLibrary.Collections.IEnumerator<MyLibrary.Types.TPair<TKey, TValue>>)
  private
    FEnumerator: System.Generics.Collections.TEnumerator<
      System.Generics.Collections.TPair<TKey, TValue>>;
    FHasCurrent: Boolean;
  public
    constructor Create(
      Dictionary: System.Generics.Collections.TDictionary<TKey, TValue>);
    destructor Destroy; override;
    function MoveNext: Boolean;
    function GetCurrent: MyLibrary.Types.TPair<TKey, TValue>;
  end;

  TDictionaryKeys<TKey, TValue> = class(TInterfacedObject,
    MyLibrary.Collections.IReadOnlyCollection<TKey>)
  private
    FOwner: IInterface;
    FItems: System.Generics.Collections.TDictionary<TKey, TValue>;

    function GetCount: Integer;
  public
    constructor Create(
      const Owner: IInterface;
      Items: System.Generics.Collections.TDictionary<TKey, TValue>);
    function GetEnumerator: MyLibrary.Collections.IEnumerator<TKey>;
    function IsEmpty: Boolean;
    function Contains(const Value: TKey): Boolean;
    property Count: Integer read GetCount;
  end;

  TDictionaryValues<TKey, TValue> = class(TInterfacedObject,
    MyLibrary.Collections.IReadOnlyCollection<TValue>)
  private
    FOwner: IInterface;
    FItems: System.Generics.Collections.TDictionary<TKey, TValue>;

    function GetCount: Integer;
  public
    constructor Create(
      const Owner: IInterface;
      Items: System.Generics.Collections.TDictionary<TKey, TValue>);
    function GetEnumerator: MyLibrary.Collections.IEnumerator<TValue>;
    function IsEmpty: Boolean;
    function Contains(const Value: TValue): Boolean;
    property Count: Integer read GetCount;
  end;

{ TEqualityComparerAdapter<T> }

constructor TEqualityComparerAdapter<T>.Create(
  const Comparer: MyLibrary.Types.IEqualityComparer<T>);
begin
  inherited Create;
  FComparer := Comparer;
end;

function TEqualityComparerAdapter<T>.Equals(
  const Left, Right: T): Boolean;
begin
  Result := FComparer.Equals(Left, Right);
end;

function TEqualityComparerAdapter<T>.GetHashCode(const Value: T): Integer;
begin
  Result := FComparer.GetHashCode(Value);
end;

{ TRtlEnumerator<T> }

constructor TRtlEnumerator<T>.Create(
  Enumerator: System.Generics.Collections.TEnumerator<T>);
begin
  inherited Create;
  FEnumerator := Enumerator;
end;

destructor TRtlEnumerator<T>.Destroy;
begin
  FEnumerator.Free;
  inherited Destroy;
end;

function TRtlEnumerator<T>.GetCurrent: T;
begin
  if not FHasCurrent then
    raise MyLibrary.Types.EInvalidOperationException.Create(
      'The enumerator is not positioned on a value.');

  Result := FEnumerator.Current;
end;

function TRtlEnumerator<T>.MoveNext: Boolean;
begin
  Result := FEnumerator.MoveNext;
  FHasCurrent := Result;
end;

{ TDictionaryEnumerator<TKey, TValue> }

constructor TDictionaryEnumerator<TKey, TValue>.Create(
  Dictionary: System.Generics.Collections.TDictionary<TKey, TValue>);
begin
  inherited Create;
  FEnumerator := Dictionary.GetEnumerator;
end;

destructor TDictionaryEnumerator<TKey, TValue>.Destroy;
begin
  FEnumerator.Free;
  inherited Destroy;
end;

function TDictionaryEnumerator<TKey, TValue>.GetCurrent:
  MyLibrary.Types.TPair<TKey, TValue>;
var
  Pair: System.Generics.Collections.TPair<TKey, TValue>;
begin
  if not FHasCurrent then
    raise MyLibrary.Types.EInvalidOperationException.Create(
      'The enumerator is not positioned on a value.');

  Pair := FEnumerator.Current;
  Result := MyLibrary.Types.TPair<TKey, TValue>.Create(Pair.Key, Pair.Value);
end;

function TDictionaryEnumerator<TKey, TValue>.MoveNext: Boolean;
begin
  Result := FEnumerator.MoveNext;
  FHasCurrent := Result;
end;

{ TDictionaryKeys<TKey, TValue> }

constructor TDictionaryKeys<TKey, TValue>.Create(
  const Owner: IInterface;
  Items: System.Generics.Collections.TDictionary<TKey, TValue>);
begin
  inherited Create;
  FOwner := Owner;
  FItems := Items;
end;

function TDictionaryKeys<TKey, TValue>.Contains(const Value: TKey): Boolean;
begin
  Result := FItems.ContainsKey(Value);
end;

function TDictionaryKeys<TKey, TValue>.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TDictionaryKeys<TKey, TValue>.GetEnumerator:
  MyLibrary.Collections.IEnumerator<TKey>;
begin
  Result := TRtlEnumerator<TKey>.Create(FItems.Keys.GetEnumerator);
end;

function TDictionaryKeys<TKey, TValue>.IsEmpty: Boolean;
begin
  Result := FItems.Count = 0;
end;

{ TDictionaryValues<TKey, TValue> }

constructor TDictionaryValues<TKey, TValue>.Create(
  const Owner: IInterface;
  Items: System.Generics.Collections.TDictionary<TKey, TValue>);
begin
  inherited Create;
  FOwner := Owner;
  FItems := Items;
end;

function TDictionaryValues<TKey, TValue>.Contains(
  const Value: TValue): Boolean;
var
  Item: TValue;
begin
  for Item in FItems.Values do
    if System.Generics.Defaults.TEqualityComparer<TValue>.Default.Equals(
      Item, Value) then
      Exit(True);

  Result := False;
end;

function TDictionaryValues<TKey, TValue>.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TDictionaryValues<TKey, TValue>.GetEnumerator:
  MyLibrary.Collections.IEnumerator<TValue>;
begin
  Result := TRtlEnumerator<TValue>.Create(FItems.Values.GetEnumerator);
end;

function TDictionaryValues<TKey, TValue>.IsEmpty: Boolean;
begin
  Result := FItems.Count = 0;
end;

{ THashDictionary<TKey, TValue> }

constructor THashDictionary<TKey, TValue>.Create;
begin
  inherited Create;
  FItems := System.Generics.Collections.TDictionary<TKey, TValue>.Create;
end;

constructor THashDictionary<TKey, TValue>.Create(
  const Comparer: MyLibrary.Types.IEqualityComparer<TKey>);
begin
  inherited Create;
  if Comparer = nil then
    FItems := System.Generics.Collections.TDictionary<TKey, TValue>.Create
  else
    FItems := System.Generics.Collections.TDictionary<TKey, TValue>.Create(
      TEqualityComparerAdapter<TKey>.Create(Comparer));
end;

destructor THashDictionary<TKey, TValue>.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure THashDictionary<TKey, TValue>.Add(
  const Value: MyLibrary.Types.TPair<TKey, TValue>);
begin
  Add(Value.Key, Value.Value);
end;

procedure THashDictionary<TKey, TValue>.Add(
  const Key: TKey; const Value: TValue);
begin
  if FItems.ContainsKey(Key) then
    raise MyLibrary.Types.EArgumentException.Create(
      'The key already exists in the dictionary.');

  FItems.Add(Key, Value);
end;

procedure THashDictionary<TKey, TValue>.AddRange(
  const Values:
    MyLibrary.Collections.IEnumerable<MyLibrary.Types.TPair<TKey, TValue>>);
var
  Enumerator:
    MyLibrary.Collections.IEnumerator<MyLibrary.Types.TPair<TKey, TValue>>;
begin
  if Values = nil then
    raise MyLibrary.Types.EArgumentNilException.Create(
      'Values cannot be nil.');

  Enumerator := Values.GetEnumerator;
  while Enumerator.MoveNext do
    Add(Enumerator.Current);
end;

procedure THashDictionary<TKey, TValue>.AddRange(
  const Values: array of MyLibrary.Types.TPair<TKey, TValue>);
var
  Index: Integer;
begin
  for Index := Low(Values) to High(Values) do
    Add(Values[Index]);
end;

procedure THashDictionary<TKey, TValue>.Clear;
begin
  FItems.Clear;
end;

function THashDictionary<TKey, TValue>.Contains(
  const Value: MyLibrary.Types.TPair<TKey, TValue>): Boolean;
var
  CurrentValue: TValue;
begin
  Result := TryGetValue(Value.Key, CurrentValue) and
    System.Generics.Defaults.TEqualityComparer<TValue>.Default.Equals(
      CurrentValue, Value.Value);
end;

function THashDictionary<TKey, TValue>.ContainsKey(
  const Key: TKey): Boolean;
begin
  Result := FItems.ContainsKey(Key);
end;

function THashDictionary<TKey, TValue>.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function THashDictionary<TKey, TValue>.GetEnumerator:
  MyLibrary.Collections.IEnumerator<MyLibrary.Types.TPair<TKey, TValue>>;
begin
  Result := TDictionaryEnumerator<TKey, TValue>.Create(FItems);
end;

function THashDictionary<TKey, TValue>.GetItem(const Key: TKey): TValue;
begin
  if not FItems.TryGetValue(Key, Result) then
    raise MyLibrary.Types.EKeyNotFoundException.Create(
      'The key was not found in the dictionary.');
end;

function THashDictionary<TKey, TValue>.GetKeys:
  MyLibrary.Collections.IReadOnlyCollection<TKey>;
begin
  Result := TDictionaryKeys<TKey, TValue>.Create(Self as IInterface, FItems);
end;

function THashDictionary<TKey, TValue>.GetValues:
  MyLibrary.Collections.IReadOnlyCollection<TValue>;
begin
  Result := TDictionaryValues<TKey, TValue>.Create(Self as IInterface, FItems);
end;

function THashDictionary<TKey, TValue>.IsEmpty: Boolean;
begin
  Result := FItems.Count = 0;
end;

function THashDictionary<TKey, TValue>.Remove(
  const Value: MyLibrary.Types.TPair<TKey, TValue>): Boolean;
begin
  Result := Contains(Value);
  if Result then
    FItems.Remove(Value.Key);
end;

function THashDictionary<TKey, TValue>.Remove(const Key: TKey): Boolean;
begin
  Result := FItems.ContainsKey(Key);
  if Result then
    FItems.Remove(Key);
end;

procedure THashDictionary<TKey, TValue>.SetItem(
  const Key: TKey; const Value: TValue);
begin
  FItems.AddOrSetValue(Key, Value);
end;

function THashDictionary<TKey, TValue>.TryGetValue(
  const Key: TKey; out Value: TValue): Boolean;
begin
  Result := FItems.TryGetValue(Key, Value);
end;

end.
