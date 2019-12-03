import 'dart:io';

import 'package:console/console.dart';

abstract class OperationSystem {
  String name;

  downloadFlutter();
  setVariableEnvironment();
  checkError(ProcessResult result, String successMessage){
    if(result.stderr == null || result.exitCode == 0){
      Console.setTextColor(2);
      print("$successMessage");
    } else {
      throw(result.stderr.toString());
    }
  }
}