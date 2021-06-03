import 'package:flutter/material.dart';
import 'package:flutter_demo/services/Api.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

class ControllerGlobaux extends ControllerMVC {
  factory ControllerGlobaux() {
    if (_this == null) _this = ControllerGlobaux._();
    return _this!;
  }

  static ControllerGlobaux? _this;

  ControllerGlobaux._();

  /// Allow for easy access to 'the Controller' throughout the application.
  static ControllerGlobaux? get con => _this;

  void supprimerGlobaux() {}

  void changerPourc(int numU, int pourc) {
    changerPourcGlobal(numU, pourc);
  }
}
