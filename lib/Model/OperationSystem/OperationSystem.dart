import 'dart:io';
import 'package:atelo/Manager/Language/LanguageManager.dart';
import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:console/console.dart';

abstract class OperationSystem {
  final String currentPath = Directory.current.path;
  //final BaseLanguage language = LanguageManager().getCurrentLanguageSystem();
  String name;

  Future<void> setVariableEnvironment(BaseLanguage language);
  
  Future<void> installationFlutter(BaseLanguage language) async{
    Console.setTextColor(3, bright: false);
    print(language.downloadingFlutter);
    Console.resetAll();
    ProcessResult downloadFlutter = Process.runSync('git', ['clone', '--branch', 'stable', 'https://github.com/flutter/flutter.git'], runInShell: true);
    await this.isCheckError(downloadFlutter, language);
  }

  isCheckError(ProcessResult result, BaseLanguage language) {
    if(result.stderr != null && result.exitCode != 0){
      print(language.exit + result.exitCode.toString());
      throw (result.stderr);
    }
  }
}