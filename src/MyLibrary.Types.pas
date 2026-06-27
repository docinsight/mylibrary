/// <summary>
///   Defines common generic helper types used by MyLibrary collections.
/// </summary>
/// <remarks>
///   Use these types to pass custom comparison and equality behavior, and to
///   represent dictionary entries without depending on RTL-specific types.
/// </remarks>
unit MyLibrary.Types;

interface

uses
  System.SysUtils;

type
  /// <summary>
  ///   The exception that is thrown when an argument value is not valid.
  /// </summary>
  EArgumentException = class(Exception);

  /// <summary>
  ///   The exception that is thrown when an argument is nil and the called
  ///   method does not accept nil.
  /// </summary>
  EArgumentNilException = class(EArgumentException);

  /// <summary>
  ///   The exception that is thrown when an argument is outside the allowed
  ///   range of values.
  /// </summary>
  EArgumentOutOfRangeException = class(EArgumentException);

  /// <summary>
  ///   The exception that is thrown when a method call is not valid for the
  ///   object's current state.
  /// </summary>
  EInvalidOperationException = class(Exception);

  /// <summary>
  ///   The exception that is thrown when a specified key cannot be found in a
  ///   dictionary.
  /// </summary>
  EKeyNotFoundException = class(Exception);

  /// <summary>
  ///   Defines a method that compares two values of the same type.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of values to compare.
  /// </typeparam>
  /// <seealso cref="TComparison&lt;T&gt;" />
  IComparer<T> = interface
    /// <summary>
    ///   Compares two values and returns a value that indicates their relative
    ///   order.
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
  ///   Defines methods to support equality comparison of values.
  /// </summary>
  /// <typeparam name="T">
  ///   The type of values to compare.
  /// </typeparam>
  /// <seealso cref="IComparer&lt;T&gt;" />
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
    ///   Returns a hash code for the specified value.
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
  ///   Represents a method that compares two values of the same type.
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
  ///   A value less than zero if <paramref name="Left" /> is less than
  ///   <paramref name="Right" />, zero if they are equal, or a value greater
  ///   than zero if <paramref name="Left" /> is greater than
  ///   <paramref name="Right" />.
  /// </returns>
  /// <seealso cref="IComparer&lt;T&gt;" />
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
  /// <seealso cref="MyLibrary.Collections.IDictionary&lt;TKey,TValue&gt;" />
  TPair<TKey, TValue> = record
  private
    FKey: TKey;
    FValue: TValue;

  public
    /// <summary>
    ///   Initializes a new instance of the <see cref="TPair&lt;TKey,TValue&gt;" />
    ///   record with the specified key and value.
    /// </summary>
    /// <param name="Key">
    ///   The key stored by the pair.
    /// </param>
    /// <param name="Value">
    ///   The value stored by the pair.
    /// </param>
    constructor Create(const Key: TKey; const Value: TValue);

    /// <summary>
    ///   Gets the key in the key/value pair.
    /// </summary>
    property Key: TKey read FKey;

    /// <summary>
    ///   Gets the value in the key/value pair.
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
