import 'dart:io';
import 'package:console/console.dart';

abstract class OperationSystem {
  final String currentPath = Directory.current.path;
  String name;

  Future<void> setVariableEnvironment();
  
  Future<void> installationFlutter() async{
    Console.setTextColor(3, bright: false);
    print("Baixando o Flutter...");
    Console.resetAll();
    ProcessResult downloadFlutter = Process.runSync('git', ['clone', '--branch', 'stable', 'https://github.com/flutter/flutter.git'], runInShell: true);
    await this.isCheckError(downloadFlutter);
  }

  isCheckError(ProcessResult result) {
    if(result.stderr != null && result.exitCode != 0){
      print("código de saída: " + result.exitCode.toString());
      throw (result.stderr);
    }
  }
}