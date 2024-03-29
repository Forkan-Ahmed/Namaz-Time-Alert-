import 'package:flutter/material.dart';
import 'package:search_islam/data/model/doya_details_models.dart';
import 'package:search_islam/data/model/doya_name_models.dart';
import 'package:search_islam/data/repository/doya_repo.dart';
import 'package:search_islam/helper/database_helper.dart';

class DoyaProvider with ChangeNotifier {
  final DoyaRepo doyaRepo;

  DoyaProvider({required this.doyaRepo});

  late DatabaseHelper _getDatabaseHelper;

  DatabaseHelper get getDatabaseHelper => _getDatabaseHelper;

  accessDatabase(DatabaseHelper db) {
    _getDatabaseHelper = db;
    initializeDoyaNames();
    //notifyListeners();
  }

  // for page view builder
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // for animation text
  List<String> allAnimationText = [];

  initializeAnimationText() {
    if (allAnimationText.length == 0) {
      allAnimationText.clear();
      allAnimationText = doyaRepo.allAnimationText;
      notifyListeners();
    }
  }

  // for Doya List
  List<DoyaNameModels> _doyaNameList = [];
  List<DoyaNameModels> _allDoyaNameList = [];

  List<DoyaNameModels> get doyaNameList => _doyaNameList;

  Future<void> initializeDoyaNames() async {
    if (_allDoyaNameList.length == 0) {
      _getDatabaseHelper.getDuyaNameFromTable().then((rows) {
        rows.forEach((row) {
          _doyaNameList.add(DoyaNameModels.fromMap(row));
          _allDoyaNameList.add(DoyaNameModels.fromMap(row));
        });
      });
      //notifyListeners();
    }
  }

  // bisoy vittik doya somuh
  List<DoyaNameModels> bisoyVittikDoya = [];

  initializeBisoyVittikDoya(int id) async {
    bisoyVittikDoya = [];
    await _getDatabaseHelper.getDuyaCategoryNameFromTable(id).then((doyaNames) {
      doyaNames.forEach((element) {
        bisoyVittikDoya.add(DoyaNameModels.fromMap(element));
      });
    });
    notifyListeners();
  }

  // doya Details
  List<DoyaDetailsModels> doyaDetailsModels = [];

  initializeDoyaDetails(String id) async {
    doyaDetailsModels = [];
    await _getDatabaseHelper.getDuyaDetailsFromTable(id).then((doyaDetails) {
      doyaDetails.forEach((element) {
        doyaDetailsModels.add(DoyaDetailsModels.fromMap(element));
      });
    });
    notifyListeners();
  }

  // For Search
  bool _notEmptyText = false;

  bool get notEmptyText => _notEmptyText;
  TextEditingController controller = TextEditingController();

  searchDoyaByNames(String query) {
    if (query.isEmpty) {
      _doyaNameList.clear();
      _doyaNameList = _allDoyaNameList;
      _notEmptyText = false;
    } else {
      _notEmptyText = true;
      _doyaNameList = [];
      _allDoyaNameList.forEach((doyaNameModel) async {
        if (doyaNameModel.name.toLowerCase().contains(query.toLowerCase())) {
          _doyaNameList.add(doyaNameModel);
        }
      });
    }
    notifyListeners();
  }

  clearSearchList() {
    _notEmptyText = false;
    _doyaNameList.clear();
    _doyaNameList = _allDoyaNameList;

    controller.clear();
    notifyListeners();
  }

}
