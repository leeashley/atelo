import 'dart:io';
import 'package:console/console.dart';

abstract class OperationSystem {

  installationFlutter();

  setVariableEnvironment();

  clearFlutterInstallationFiles();

  checkError(ProcessResult result, [String successMessage]){
    if(result.stderr == null || result.exitCode == 0){
      Console.setTextColor(2);
      successMessage.isNotEmpty ? print("$successMessage") : null;
    } else {
      throw(result.stderr.toString());
    }
  }
}