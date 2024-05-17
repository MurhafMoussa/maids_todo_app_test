class UtilityFunctions {
  UtilityFunctions._();

  /// Returns whether a dynamic value PROBABLY
  /// has the isEmpty getter/method by checking
  /// standard dart types that contains it.
  ///
  /// This is here to for the 'DRY'
  static bool _isEmpty(dynamic value) {
    if (value is String) {
      return value.trim().isEmpty;
    }
    return (value is Iterable || value is Map) ? value.isEmpty : false;
  }

  /// Returns whether a dynamic value PROBABLY
  /// has the length getter/method by checking
  /// standard dart types that contains it.
  ///
  /// This is here to for the 'DRY'
  static bool _hasLength(dynamic value) =>
      value is Iterable || value is String || value is Map;

  /// Obtains a length of a dynamic value
  /// by previously validating it's type
  ///
  /// Note: if [value] is double/int
  /// it will be taking the .toString
  /// length of the given value.
  ///
  /// Note 2: **this may return null!**
  ///
  /// Note 3: null [value] returns null.
  static int? _obtainDynamicLength(dynamic value) {
    if (isNull(value)) return null;

    if (_hasLength(value)) {
      return value.length ;
    }

    if (value is int) {
      return value.toString().length;
    }

    if (value is double) {
      return value.toString().replaceAll('.', '').length;
    }

    return null;
  }

  /// Checks if data is null.
  static bool isNull(dynamic value) => value == null;

  /// Checks if data is null or blank (empty or only contains whitespace).
  static bool? isNullOrBlank(dynamic value) {
    if (isNull(value)) {
      return true;
    }

    // Pretty sure that isNullOrBlank should't be validating
    // iterables... but I'm going to keep this for compatibility.
    return _isEmpty(value);
  }

  /// Checks if data is null or blank (empty or only contains whitespace).
  static bool isBlank(dynamic value) => _isEmpty(value);

  /// Checks if all data have same value.
  /// Example: 111111 -> true, wwwww -> true, 1,1,1,1 -> true
  static bool isOneAKind(dynamic value) {
    if ((value is String || value is List) && !isNullOrBlank(value)!) {
      final first = value[0];
      return value.every((element) => element == first);
    }

    if (value is int) {
      final stringValue = value.toString();
      final first = stringValue[0];
      return stringValue.runes.every((rune) => rune == first.runes.first);
    }

    return false;
  }

  /// Checks if string is Passport No.
  static bool isPassport(String s) =>
      hasMatch(s, r'^(?!^0+$)[a-zA-Z0-9]{6,9}$');

  /// Checks if string is int or double.
  static bool isNum(String value) {
    if (isNull(value)) {
      return false;
    }

    return num.tryParse(value) is num;
  }

  /// Checks if string consist only numeric.
  /// Numeric only doesn't accepting "." which double data type have
  static bool isNumericOnly(String s) => hasMatch(s, r'^\d+$');

  /// Checks if string consist only Alphabet. (No Whitespace)
  static bool isAlphabetOnly(String s) => hasMatch(s, r'^[a-zA-Z]+$');

  /// Checks if string contains at least one Capital Letter
  static bool hasCapitalletter(String s) => hasMatch(s, '[A-Z]');

  /// Checks if string is boolean.
  static bool isBool(String value) {
    if (isNull(value)) {
      return false;
    }

    return value == 'true' || value == 'false';
  }

  /// Checks if string is an video file.
  static bool isVideo(String filePath) {
    var ext = filePath.toLowerCase();

    return ext.endsWith('.mp4') ||
        ext.endsWith('.avi') ||
        ext.endsWith('.wmv') ||
        ext.endsWith('.rmvb') ||
        ext.endsWith('.mpg') ||
        ext.endsWith('.mpeg') ||
        ext.endsWith('.3gp');
  }

  /// Checks if string is an image file.
  static bool isImage(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.png') ||
        ext.endsWith('.gif') ||
        ext.endsWith('.bmp');
  }

  /// Checks if string is an audio file.
  static bool isAudio(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith('.mp3') ||
        ext.endsWith('.wav') ||
        ext.endsWith('.wma') ||
        ext.endsWith('.amr') ||
        ext.endsWith('.ogg');
  }

  /// Checks if string is an powerpoint file.
  static bool isPPT(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith('.ppt') || ext.endsWith('.pptx');
  }

  /// Checks if string is an word file.
  static bool isWord(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith('.doc') || ext.endsWith('.docx');
  }

  /// Checks if string is an excel file.
  static bool isExcel(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith('.xls') || ext.endsWith('.xlsx');
  }

  /// Checks if string is an apk file.
  static bool isAPK(String filePath) => filePath.toLowerCase().endsWith('.apk');

  /// Checks if string is an pdf file.
  static bool isPDF(String filePath) => filePath.toLowerCase().endsWith('.pdf');

  /// Checks if string is an txt file.
  static bool isTxt(String filePath) => filePath.toLowerCase().endsWith('.txt');

  /// Checks if string is an chm file.
  static bool isChm(String filePath) => filePath.toLowerCase().endsWith('.chm');

  /// Checks if string is a vector file.
  static bool isVector(String filePath) =>
      filePath.toLowerCase().endsWith('.svg');

  /// Checks if string is an html file.
  static bool isHTML(String filePath) =>
      filePath.toLowerCase().endsWith('.html');

  /// Checks if string is a valid username.
  static bool isUsername(String s) =>
      hasMatch(s, r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');

  /// Checks if string is URL.
  static bool isURL(String s) => hasMatch(
        s,
        r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,7}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$",
      );

  /// Checks if string is email.
  static bool isEmail(String s) => hasMatch(
        s,
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      );

  /// Checks if string is phone number.
  static bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 9) {
      return false;
    }
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// Checks if string is DateTime (UTC or Iso8601).
  static bool isDateTime(String s) =>
      hasMatch(s, r'^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}:\d{2}.\d{3}Z?$');

  /// Checks if string is MD5 hash.
  static bool isMD5(String s) => hasMatch(s, r'^[a-f0-9]{32}$');

  /// Checks if string is SHA1 hash.
  static bool isSHA1(String s) =>
      hasMatch(s, r'(([A-Fa-f0-9]{2}\:){19}[A-Fa-f0-9]{2}|[A-Fa-f0-9]{40})');

  /// Checks if string is SHA256 hash.
  static bool isSHA256(String s) =>
      hasMatch(s, r'([A-Fa-f0-9]{2}\:){31}[A-Fa-f0-9]{2}|[A-Fa-f0-9]{64}');

  /// Checks if string is SSN (Social Security Number).
  static bool isSSN(String s) => hasMatch(
        s,
        r'^(?!0{3}|6{3}|9[0-9]{2})[0-9]{3}-?(?!0{2})[0-9]{2}-?(?!0{4})[0-9]{4}$',
      );

  /// Checks if string is binary.
  static bool isBinary(String s) => hasMatch(s, r'^[0-1]+$');

  /// Checks if string is IPv4.
  static bool isIPv4(String s) =>
      hasMatch(s, r'^(?:(?:^|\.)(?:2(?:5[0-5]|[0-4]\d)|1?\d?\d)){4}$');

  /// Checks if string is IPv6.
  static bool isIPv6(String s) => hasMatch(
        s,
        r'^((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(([0-9A-Fa-f]{1,4}:){0,5}:((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(::([0-9A-Fa-f]{1,4}:){0,5}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})|(::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,7}:))$',
      );

  /// Checks if string is hexadecimal.
  /// Example: HexColor => #12F
  static bool isHexadecimal(String s) =>
      hasMatch(s, r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

  /// Checks if string is Palindrom.
  static bool isPalindrom(String string) {
    final cleanString = string
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll(RegExp('[^0-9a-zA-Z]+'), '');

    for (var i = 0; i < cleanString.length; i++) {
      if (cleanString[i] != cleanString[cleanString.length - i - 1]) {
        return false;
      }
    }

    return true;
  }

  /// Checks if length of data is GREATER than maxLength.
  static bool isLengthGreaterThan(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length > maxLength;
  }

  /// Checks if length of data is GREATER OR EQUAL to maxLength.
  static bool isLengthGreaterOrEqual(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length >= maxLength;
  }

  /// Checks if length of data is LESS than maxLength.
  static bool isLengthLessThan(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);
    if (length == null) {
      return false;
    }

    return length < maxLength;
  }

  /// Checks if length of data is LESS OR EQUAL to maxLength.
  static bool isLengthLessOrEqual(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length <= maxLength;
  }

  /// Checks if length of data is EQUAL to maxLength.
  static bool isLengthEqualTo(dynamic value, int otherLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length == otherLength;
  }

  /// Checks if length of data is BETWEEN minLength to maxLength.
  static bool isLengthBetween(dynamic value, int minLength, int maxLength) {
    if (isNull(value)) {
      return false;
    }

    return isLengthGreaterOrEqual(value, minLength) &&
        isLengthLessOrEqual(value, maxLength);
  }

  /// Checks if a contains b (Treating or interpreting upper- and lowercase
  /// letters as being the same).
  static bool isCaseInsensitiveContains(String a, String b) =>
      a.toLowerCase().contains(b.toLowerCase());

  /// Checks if a contains b or b contains a (Treating or
  /// interpreting upper- and lowercase letters as being the same).
  static bool isCaseInsensitiveContainsAny(String a, String b) {
    final lowA = a.toLowerCase();
    final lowB = b.toLowerCase();

    return lowA.contains(lowB) || lowB.contains(lowA);
  }

  /// Checks if num a LOWER than num b.
  static bool isLowerThan(num a, num b) => a < b;

  /// Checks if num a GREATER than num b.
  static bool isGreaterThan(num a, num b) => a > b;

  /// Checks if num a EQUAL than num b.
  static bool isEqual(num a, num b) => a == b;

  /// Capitalize the first letter of each word inside string
  /// Example: your name => Your Name, your name => Your name
  static String capitalize(String value) {
    
    if (isBlank(value)) {
      return value;
    }
    return value.split(' ').map(capitalizeFirst).join(' ');
  }

  /// Uppercase first letter inside string and let the others lowercase
  /// Example: your name => Your name
  static String capitalizeFirst(String s) {
   
    if (isBlank(s)) {
      return s;
    }
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  /// Remove all whitespace inside string
  /// Example: your name => yourname
  static String removeAllWhitespace(String value) => value.replaceAll(' ', '');

  /// Camelcase string
  /// Example: your name => yourName
  static String camelCase(String value) {
    if (isBlank(value)) {
      return value;
    }

    final separatedWords =
        value.split(RegExp(r'[!@#<>?":`~;[\]\\|=+)(*&^%-\s_]+'));
    var newString = '';

    for (final word in separatedWords) {
      newString += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }

    return newString[0].toLowerCase() + newString.substring(1);
  }

  static List<String> _groupIntoWords(String text) {
    final RegExp _upperAlphaRegex = RegExp('[A-Z]');
    final _symbolSet = {' ', '.', '/', '_', r'\', '-'};
    final sb = StringBuffer();
    final words = <String>[];
    final isAllCaps = text.toUpperCase() == text;

    for (var i = 0; i < text.length; i++) {
      var char = text[i];
      var nextChar = i + 1 == text.length ? null : text[i + 1];
      if (_symbolSet.contains(char)) {
        continue;
      }
      sb.write(char);
      var isEndOfWord = nextChar == null ||
          (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          _symbolSet.contains(nextChar);
      if (isEndOfWord) {
        words.add('$sb');
        sb.clear();
      }
    }
    return words;
  }

  /// snake_case
  static String? snakeCase(String? text, {String separator = '_'}) {
    if (isNullOrBlank(text)!) {
      return null;
    }
    return _groupIntoWords(text!)
        .map((word) => word.toLowerCase())
        .join(separator);
  }

  /// param-case
  static String? paramCase(String? text) => snakeCase(text, separator: '-');

  /// Extract numeric value of string
  /// Example: OTP 12312 27/04/2020 => 1231227042020ß
  /// If firstword only is true, then the example return is "12312"
  /// (first found numeric word)
  static String numericOnly(String s, {bool firstWordOnly = false}) {
    var numericOnlyStr = '';

    for (var i = 0; i < s.length; i++) {
      if (isNumericOnly(s[i])) {
        numericOnlyStr += s[i];
      }
      if (firstWordOnly && numericOnlyStr.isNotEmpty && s[i] == ' ') {
        break;
      }
    }

    return numericOnlyStr;
  }

  /// Capitalize only the first letter of each word in a string
  /// Example: getx will make it easy  => Getx Will Make It Easy
  /// Example 2 : this is an example text => This Is An Example Text
  static String capitalizeAllWordsFirstLetter(String s) {
    String lowerCasedString = s.toLowerCase();
    String stringWithoutExtraSpaces = lowerCasedString.trim();

    if (stringWithoutExtraSpaces.isEmpty) {
      return '';
    }
    if (stringWithoutExtraSpaces.length == 1) {
      return stringWithoutExtraSpaces.toUpperCase();
    }

    List<String> stringWordsList = stringWithoutExtraSpaces.split(' ');
    List<String> capitalizedWordsFirstLetter = stringWordsList
        .map(
          (word) {
            if (word.trim().isEmpty) {
              return '';
            }
            return word.trim();
          },
        )
        .where(
          (word) => word != '',
        )
        .map(
          (word) {
            if (word.startsWith(RegExp(r'[\n\t\r]'))) {
              return word;
            }
            return word[0].toUpperCase() + word.substring(1).toLowerCase();
          },
        )
        .toList();
    String finalResult = capitalizedWordsFirstLetter.join(' ');
    return finalResult;
  }

  static bool hasMatch(String? value, String pattern) =>
      (value == null) ? false : RegExp(pattern).hasMatch(value);

 
}
