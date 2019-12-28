import 'dart:io';
import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:console/console.dart';
import 'package:process_run/process_run.dart';

abstract class OperationSystem {
  final String currentPath = Directory.current.path;
  final String systemPathSeparator = Platform.pathSeparator;
  String name;

  Future<void> setEnvironmentVariable(BaseLanguage language);
  
  Future<void> installationFlutter(BaseLanguage language) async{
    print("\x1B[2J\x1B[0;0H");
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