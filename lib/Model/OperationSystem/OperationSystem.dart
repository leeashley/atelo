import 'dart:io';
import 'package:console/console.dart';

abstract class OperationSystem {
  final String currentPath = Platform.script.toString().replaceFirst("file://", "").replaceAll(RegExp(r'/([^/]+)$'), '');
  String name;

  setVariableEnvironment();
  
  installationFlutter(){
    print("Baixando o Flutter...");
    ProcessResult downloadFlutter = Process.runSync('git', ['clone', '--branch', 'stable', 'https://github.com/flutter/flutter.git'], runInShell: true);
    this.checkError(downloadFlutter, "Download do Flutter concluído.");
    //this.currentPath = Directory.current.path;
  }

  checkError(ProcessResult result, [String successMessage]){
    if(result.stderr == null || result.exitCode == 0){
      Console.setTextColor(2);
      successMessage.isNotEmpty ? print("$successMessage") : null;
    } else {
      throw(result.stderr.toString());
    }
  }
}