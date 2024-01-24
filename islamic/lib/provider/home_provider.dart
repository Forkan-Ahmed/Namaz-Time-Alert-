import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:search_islam/helper/bangla_utilities.dart';

class HomeProvider with ChangeNotifier {
  String banglaDate = '';
  String arabyDate = '';
  String englishDate = '';
  String banglaDateWithMessage = '';
  String arabyDateWithMessage = '';
  String englishDateWithMessage = '';
  String dayName = '';

  String nbanglaDate = '';
  String narabyDate = '';
  String nenglishDate = '';
  String nbanglaDateWithMessage = '';
  String narabyDateWithMessage = '';
  String nenglishDateWithMessage = '';
  String ndayName = '';
  DateTime? selectDateTime;

  initializeAllDate() {
    var _today = new HijriCalendar.now();
    banglaDate = BanglaUtility.getBanglaDate(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year);
    arabyDate = _today.toFormat("dd MMMM,yyyy");
    englishDate = DateFormat('dd MMMM,yyyy').format(DateTime.now());
    dayName = DateFormat('EEEE').format(DateTime.now());
    banglaDateWithMessage = 'Today: $banglaDate';
    arabyDateWithMessage = 'Today: $arabyDate';
    englishDateWithMessage = 'Today: $englishDate';
    selectDateTime=DateTime.now();
  }

  queryDate(DateTime dateTime) {
    var _today = HijriCalendar.fromDate(dateTime);
    nbanglaDate = BanglaUtility.getBanglaDate(day: dateTime.day, month: dateTime.month, year: dateTime.year);
    narabyDate = _today.toFormat("dd MMMM,yyyy");
    nenglishDate = DateFormat('dd MMMM,yyyy').format(dateTime);
    ndayName = DateFormat('EEEE').format(dateTime);
    nbanglaDateWithMessage = 'Today: $banglaDate';
    narabyDateWithMessage = 'Today: $arabyDate';
    nenglishDateWithMessage = 'Today: $englishDate';
    selectDateTime=dateTime;
    notifyListeners();
  }

  List<String> allDate() {
    List<String> _getAllDateData = [banglaDateWithMessage, englishDateWithMessage, arabyDateWithMessage];
    return _getAllDateData;
  }
}
