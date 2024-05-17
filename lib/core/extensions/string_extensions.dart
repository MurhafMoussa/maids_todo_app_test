import 'package:maids_todo_app_test/core/utils/utility_functions.dart';

extension GetStringUtils on String {
  /// Discover if the String is a valid number
  bool get isNum => UtilityFunctions.isNum(this);

  /// Discover if the String is numeric only
  bool get isNumericOnly => UtilityFunctions.isNumericOnly(this);

  String numericOnly({bool firstWordOnly = false}) =>
      UtilityFunctions.numericOnly(this, firstWordOnly: firstWordOnly);

  /// Discover if the String is alphanumeric only
  bool get isAlphabetOnly => UtilityFunctions.isAlphabetOnly(this);

  /// Discover if the String is a boolean
  bool get isBool => UtilityFunctions.isBool(this);

  /// Discover if the String is a vector
  bool get isVectorFileName => UtilityFunctions.isVector(this);

  /// Discover if the String is a ImageFileName
  bool get isImageFileName => UtilityFunctions.isImage(this);

  /// Discover if the String is a AudioFileName
  bool get isAudioFileName => UtilityFunctions.isAudio(this);

  /// Discover if the String is a VideoFileName
  bool get isVideoFileName => UtilityFunctions.isVideo(this);

  /// Discover if the String is a TxtFileName
  bool get isTxtFileName => UtilityFunctions.isTxt(this);

  /// Discover if the String is a Document Word
  bool get isDocumentFileName => UtilityFunctions.isWord(this);

  /// Discover if the String is a Document Excel
  bool get isExcelFileName => UtilityFunctions.isExcel(this);

  /// Discover if the String is a Document Powerpoint
  bool get isPPTFileName => UtilityFunctions.isPPT(this);

  /// Discover if the String is a APK File
  bool get isAPKFileName => UtilityFunctions.isAPK(this);

  /// Discover if the String is a PDF file
  bool get isPDFFileName => UtilityFunctions.isPDF(this);

  /// Discover if the String is a HTML file
  bool get isHTMLFileName => UtilityFunctions.isHTML(this);

  /// Discover if the String is a URL file
  bool get isURL => UtilityFunctions.isURL(this);

  /// Discover if the String is a Email
  bool get isEmail => UtilityFunctions.isEmail(this);

  /// Discover if the String is a Phone Number
  bool get isPhoneNumber => UtilityFunctions.isPhoneNumber(this);

  /// Discover if the String is a DateTime
  bool get isDateTime => UtilityFunctions.isDateTime(this);

  /// Discover if the String is a MD5 Hash
  bool get isMD5 => UtilityFunctions.isMD5(this);

  /// Discover if the String is a SHA1 Hash
  bool get isSHA1 => UtilityFunctions.isSHA1(this);

  /// Discover if the String is a SHA256 Hash
  bool get isSHA256 => UtilityFunctions.isSHA256(this);

  /// Discover if the String is a bynary value
  bool get isBinary => UtilityFunctions.isBinary(this);

  /// Discover if the String is a ipv4
  bool get isIPv4 => UtilityFunctions.isIPv4(this);

  bool get isIPv6 => UtilityFunctions.isIPv6(this);

  /// Discover if the String is a Hexadecimal
  bool get isHexadecimal => UtilityFunctions.isHexadecimal(this);

  /// Discover if the String is a palindrom
  bool get isPalindrom => UtilityFunctions.isPalindrom(this);

  /// Discover if the String is a passport number
  bool get isPassport => UtilityFunctions.isPassport(this);

  /// Discover if the String is a case insensitive
  bool isCaseInsensitiveContains(String b) =>
      UtilityFunctions.isCaseInsensitiveContains(this, b);

  /// Discover if the String is a case sensitive and contains any value
  bool isCaseInsensitiveContainsAny(String b) =>
      UtilityFunctions.isCaseInsensitiveContainsAny(this, b);

  /// capitalize the String
  String? get capitalize => UtilityFunctions.capitalize(this);

  /// Capitalize the first letter of the String
  String? get capitalizeFirst => UtilityFunctions.capitalizeFirst(this);

  /// remove all whitespace from the String
  String get removeAllWhitespace => UtilityFunctions.removeAllWhitespace(this);

  /// converter the String
  String? get camelCase => UtilityFunctions.camelCase(this);

  /// Discover if the String is a valid URL
  String? get paramCase => UtilityFunctions.paramCase(this);

  /// capitalize only first letter in String words to upper case
  String capitalizeAllWordsFirstLetter() =>
      UtilityFunctions.capitalizeAllWordsFirstLetter(this);
}
