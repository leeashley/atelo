import 'dart:io';
import 'package:atelo/Model/OperationSystem/MacSystem.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'package:atelo/Model/OperationSystem/WindowsSystem.dart';
import 'package:console/console.dart';

class SystemOperationFactory {
  
  OperationSystem identifySystemOperation(){
    if (Platform.isWindows) {
      WindowsSystem windows = WindowsSystem();
      return windows;
    } else if (Platform.isMacOS) {
      MacSystem macOs = MacSystem();
      return macOs;
    } /*else if (Platform.isLinux) {
        return OperationSystem.linux;
    } */else {
      Console.setTextColor(1);
      throw("Não foi possível detectador o sistema operacional.");
    }
  }
}
