import 'package:flutter/material.dart';

class ChecksModel extends ChangeNotifier {

  Map<int, bool> interior = {1: false, 2: false, 3: false};
  Map<int, bool> exterior = {1: false, 2: false, 3: false};
  Map<int, bool> papers = {1: false, 2: false, 3: false};
  Map<int, bool> engine = {1: false, 2: false, 3: false};

  bool isPristine = true;

  int currentCheckListId;
  String currentCheckListName = "";

  String note = "";

  void unCheckAll() {
    interior.forEach((i, state) {
      interior[i] = false;
    });
    exterior.forEach((i, state) {
      exterior[i] = false;
    });
    papers.forEach((i, state) {
      papers[i] = false;
    });
    engine.forEach((i, state) {
      engine[i] = false;
    });
    note = "";
    isPristine = true;
    notifyListeners();
  }

  void resetChecklistIdAndName() {
    currentCheckListId = null;
    currentCheckListName = "";
    notifyListeners();
  }

  void updateNote(String content) {
    note = content;
    notifyListeners();
  }

  void updateCurrentCheckListName(String name) {
    currentCheckListName = name;
    notifyListeners();
  }

  void updateCurrentCheckListId(int id) {
    currentCheckListId = id;
    notifyListeners();
  }

  void checkInterior(int checkNb) {
    interior[checkNb] = true;
    isPristine = false;
    notifyListeners();
  }

  void unCheckInterior(int checkNb) {
    interior[checkNb] = false;
    isPristine = false;
    notifyListeners();
  }

  int getNbCheckedInterior() {
    int nbChecked = 0;
    interior.forEach( (k, v) => v ? nbChecked = nbChecked +1 : nbChecked = nbChecked);
    return nbChecked;
  }

  bool isCheckedInterior(int checkNb) {
    return interior[checkNb];
  }

  void checkExterior(int checkNb) {
    exterior[checkNb] = true;
    isPristine = false;
    notifyListeners();
  }

  void unCheckExterior(int checkNb) {
    exterior[checkNb] = false;
    isPristine = false;
    notifyListeners();
  }

  int getNbCheckedExterior() {
    int nbChecked = 0;
    exterior.forEach( (k, v) => v ? nbChecked = nbChecked +1 : nbChecked = nbChecked);
    return nbChecked;
  }

  bool isCheckedExterior(int checkNb) {
    return exterior[checkNb];
  }

  void checkPapers(int checkNb) {
    papers[checkNb] = true;
    isPristine = false;
    notifyListeners();
  }

  void unCheckPapers(int checkNb) {
    papers[checkNb] = false;
    isPristine = false;
    notifyListeners();
  }

  int getNbCheckedPapers() {
    int nbChecked = 0;
    papers.forEach( (k, v) => v ? nbChecked = nbChecked +1 : nbChecked = nbChecked);
    return nbChecked;
  }

  bool isCheckedPapers(int checkNb) {
    return papers[checkNb];
  }

  void checkEngine(int checkNb) {
    engine[checkNb] = true;
    isPristine = false;
    notifyListeners();
  }

  void unCheckEngine(int checkNb) {
    engine[checkNb] = false;
    isPristine = false;
    notifyListeners();
  }

  int getNbCheckedEngine() {
    int nbChecked = 0;
    engine.forEach( (k, v) => v ? nbChecked = nbChecked +1 : nbChecked = nbChecked);
    return nbChecked;
  }

  bool isCheckedEngine(int checkNb) {
    return engine[checkNb];
  }
}
