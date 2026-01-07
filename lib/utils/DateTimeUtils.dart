import 'package:intl/intl.dart';

class DateTimeUtils{

  //get time stamp of length 13...
  static int get getCurrentTimeStamp => DateTime.now().millisecondsSinceEpoch;

  // convert timeStamp to format string ....
  static String stampToPattern(int timeStamp, String pattern)=> dateTimeToPattern(stampToDateTime(timeStamp),pattern);

  // convert time stamp to dateTime .....
  static DateTime stampToDateTime(int timeStamp)=> DateTime.fromMillisecondsSinceEpoch(timeStamp);

  // convert string to dateTime .... returns DateTime
  static DateTime patternToDateTime(String value, String pattern)=> DateFormat(pattern).parse(value);

  // convert dateTime to string pattern .... returns String
  static String dateTimeToPattern(DateTime dTime, String pattern)=> DateFormat(pattern).format(dTime);
}


class DateTimePattern{
  static const String dd_MM_yyyy_HHss = 'dd-MM-yyyy HH:ss';//08-12-2023 12:00
  static const String ddMMMyyyy_hhmma = 'dd MMM yyyy, hh:mm a';//08-12-2023 12:00
  static const String yyyy_MM_ddTHH_mm = 'yyyy-MM-ddTHH:mm';//2024-02-04T00:00
  static const String ddMMyyyy = 'dd-MM-yyyy';//08-12-2023
  static const String ddMMMyyyy = 'dd-MMM-yyyy';//08-12-2023
  static const String HHmm = 'HH:mm';//12:00
  static const String EEEc_HHmm = 'EEE, HH:mm';//Sat, 13:40
}

// ' 12 Dec 2024, 12:30 PM'


// Extension
extension StampToPatternExtension on int{
  String get dd_MM_yyyy_HHss =>DateTimeUtils.stampToPattern(this, DateTimePattern.dd_MM_yyyy_HHss);
  String get ddMMMyyyy_hhmma =>DateTimeUtils.stampToPattern(this, DateTimePattern.ddMMMyyyy_hhmma);
  String get ddMMyyyy =>DateTimeUtils.stampToPattern(this, DateTimePattern.ddMMyyyy);
  String get ddMMMyyyy =>DateTimeUtils.stampToPattern(this, DateTimePattern.ddMMMyyyy);
  String get HHmm =>DateTimeUtils.stampToPattern(this, DateTimePattern.HHmm);
}


extension dateTimeToPatternExtension on DateTime{
  String get dd_MM_yyyy_HHss =>DateTimeUtils.dateTimeToPattern(this, DateTimePattern.dd_MM_yyyy_HHss);
  String get ddMMMyyyy_hhmma =>DateTimeUtils.dateTimeToPattern(this, DateTimePattern.ddMMMyyyy_hhmma);
  String get ddMMyyyy =>DateTimeUtils.dateTimeToPattern(this, DateTimePattern.ddMMyyyy);
  String get ddMMMyyyy =>DateTimeUtils.dateTimeToPattern(this, DateTimePattern.ddMMMyyyy);
  String get HHmm =>DateTimeUtils.dateTimeToPattern(this, DateTimePattern.HHmm);
  String get EEEc_HHmm =>DateTimeUtils.dateTimeToPattern(this, DateTimePattern.EEEc_HHmm);
}


extension stringToPatternExtension on String{
  DateTime get dd_MM_yyyy_HHss =>DateTimeUtils.patternToDateTime(this, DateTimePattern.dd_MM_yyyy_HHss);
  DateTime get ddMMMyyyy_hhmma =>DateTimeUtils.patternToDateTime(this, DateTimePattern.ddMMMyyyy_hhmma);
  DateTime get ddMMyyyy =>DateTimeUtils.patternToDateTime(this, DateTimePattern.ddMMyyyy);
  DateTime get ddMMMyyyy =>DateTimeUtils.patternToDateTime(this, DateTimePattern.ddMMMyyyy);
  DateTime get HHmm =>DateTimeUtils.patternToDateTime(this, DateTimePattern.HHmm);
  DateTime get yyyy_MM_ddTHH_mm =>DateTimeUtils.patternToDateTime(this, DateTimePattern.yyyy_MM_ddTHH_mm);

}