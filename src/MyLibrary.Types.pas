/// <summary>
///   Defines shared generic helper types used by MyLibrary collections.
/// </summary>
/// <remarks>
///   This unit contains small, documentation-friendly abstractions that mirror
///   common collection concepts without exposing RTL comparer types directly.
///   The key types are <see cref="IComparer&lt;T&gt;" />,
///   <see cref="IEqualityComparer&lt;T&gt;" />, <see cref="TComparison&lt;T&gt;" />, and
///   <see cref="TPair&lt;TKey,TValue&gt;" />.
/// </remarks>
unit MyLibrary.Types;

interface

type
  /// <summary>
  ///   Defines a method that compares two values.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of values to compare.
  /// </typeparam>
  IComparer<T> = interface
    /// <summary>
    ///   Compares two values and returns an indication of their relative order.
    /// </summary>
    /// <param name="Left">
    ///   The first value to compare.
    /// </param>
    /// <param name="Right">
    ///   The second value to compare.
    /// </param>
    /// <returns>
    ///   A value less than zero if <paramref name="Left" /> is less than
    ///   <paramref name="Right" />, zero if they are equal, or a value greater
    ///   than zero if <paramref name="Left" /> is greater than
    ///   <paramref name="Right" />.
    /// </returns>
    function Compare(const Left, Right: T): Integer;
  end;

  /// <summary>
  ///   Defines methods that test values for equality and produce hash codes.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of values to compare.
  /// </typeparam>
  IEqualityComparer<T> = interface
    /// <summary>
    ///   Determines whether two values are equal.
    /// </summary>
    /// <param name="Left">
    ///   The first value to compare.
    /// </param>
    /// <param name="Right">
    ///   The second value to compare.
    /// </param>
    /// <returns>
    ///   True if the values are equal; otherwise, false.
    /// </returns>
    function Equals(const Left, Right: T): Boolean;

    /// <summary>
    ///   Returns a hash code for a value.
    /// </summary>
    /// <param name="Value">
    ///   The value for which to return a hash code.
    /// </param>
    /// <returns>
    ///   A hash code for the value.
    /// </returns>
    function GetHashCode(const Value: T): Integer;
  end;

  /// <summary>
  ///   Represents a comparison callback for two values that can be used where an
  ///   <see cref="IComparer&lt;T&gt;" /> would otherwise be required.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of values to compare.
  /// </typeparam>
  /// <param name="Left">
  ///   The first value to compare.
  /// </param>
  /// <param name="Right">
  ///   The second value to compare.
  /// </param>
  /// <returns>
  ///   A value less than zero, zero, or greater than zero to indicate relative
  ///   order.
  /// </returns>
  TComparison<T> = reference to function(const Left, Right: T): Integer;

  /// <summary>
  ///   Represents a key/value pair.
  /// </summary>
  /// <typeparam name="TKey">
  ///   The type of the key.
  /// </typeparam>
  /// <typeparam name="TValue">
  ///   The type of the value.
  /// </typeparam>
  TPair<TKey, TValue> = record
  private
    FKey: TKey;
    FValue: TValue;

  public
    /// <summary>
    ///   Initializes a new instance of the <c>TPair&lt;TKey,TValue&gt;</c> record.
    /// </summary>
    /// <param name="Key">
    ///   The key stored by the pair.
    /// </param>
    /// <param name="Value">
    ///   The value stored by the pair.
    /// </param>
    constructor Create(const Key: TKey; const Value: TValue);

    /// <summary>
    ///   Gets the key stored by the pair.
    /// </summary>
    property Key: TKey read FKey;

    /// <summary>
    ///   Gets the value stored by the pair.
    /// </summary>
    property Value: TValue read FValue;
  end;

implementation

constructor TPair<TKey, TValue>.Create(const Key: TKey; const Value: TValue);
begin
  FKey := Key;
  FValue := Value;
end;

end.
