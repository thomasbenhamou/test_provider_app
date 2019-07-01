import 'package:flutter/material.dart';

class ChecksModel extends ChangeNotifier {
  Map<int, bool> interior = {1: false, 2: false, 3: false};
  Map<int, bool> exterior = {1: false, 2: false, 3: false};
  Map<int, bool> papers = {1: false, 2: false, 3: false};
  Map<int, bool> engine = {1: false, 2: false, 3: false};

  void checkInterior(int checkNb) {
    interior[checkNb] = true;
    notifyListeners();
  }

  void unCheckInterior(int checkNb) {
    interior[checkNb] = false;
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
    notifyListeners();
  }

  void unCheckExterior(int checkNb) {
    exterior[checkNb] = false;
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
    notifyListeners();
  }

  void unCheckPapers(int checkNb) {
    papers[checkNb] = false;
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
    notifyListeners();
  }

  void unCheckEngine(int checkNb) {
    engine[checkNb] = false;
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
