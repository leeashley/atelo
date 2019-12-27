import 'dart:io';

import 'package:atelo/Model/Language/BaseLanguage.dart';

import 'OperationSystem.dart';

class LinuxSystem extends OperationSystem {
  final String name = "linux";
  
  @override
  Future<void> setVariableEnvironment(BaseLanguage language) async{
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=\\"\\\$PATH:$currentPath/flutter/bin\\"' ">> \$HOME/.bashrc"]);
    await this.isCheckError(result, language);
  }
}