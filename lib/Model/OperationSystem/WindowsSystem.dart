import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'dart:io';

class WindowsSystem extends OperationSystem {
  final String name = "windows";

  @override
  Future<void> setVariableEnvironment(BaseLanguage language) async{
    ProcessResult resultVar = Process.runSync('setx', ['Path', '%Path%;$currentPath\\flutter\\bin'], runInShell: false);
    this.isCheckError(resultVar, language);
  }
}