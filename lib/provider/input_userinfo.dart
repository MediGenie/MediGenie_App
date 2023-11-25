import 'package:flutter/material.dart';

class InputUserInfo with ChangeNotifier {
  String _firstName = "";
  String _lastName = "";
  int _genderIndex = 0;
  DateTime _birthDate = DateTime.now();
  DateTime _termsTime = DateTime.now();
  DateTime _policyTime = DateTime.now();

  String get firstName => _firstName;
  String get lastName => _lastName;
  int get genderIndex => _genderIndex;
  DateTime get birthDate => _birthDate;
  DateTime get termsTime => _termsTime;
  DateTime get policyTime => _policyTime;

  void setFirstName({required String firstName}) {
    _firstName = firstName;
    // notifyListeners();
  }

  void setLastName({required String lastName}) {
    _lastName = lastName;
    // notifyListeners();
  }

  void setGender({required int gender}) {
    _genderIndex = gender;
    // notifyListeners();
  }

  void setBirthDate({required DateTime birthDate}) {
    _birthDate = birthDate;
    // notifyListeners();
  }

  void setTermsTime({required DateTime termsTime}) {
    _termsTime = termsTime;
    // notifyListeners();
  }

  void setPolicyTime({required DateTime policyTime}) {
    _policyTime = policyTime;
    // notifyListeners();
  }

  void reset() {
    _firstName = "";
    _lastName = "";
    _genderIndex = 0;
    _birthDate = DateTime.now();
    _termsTime = DateTime.now();
    _policyTime = DateTime.now();
    // notifyListeners();
  }
}
