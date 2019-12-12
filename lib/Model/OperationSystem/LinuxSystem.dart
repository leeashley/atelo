import 'dart:io';

import 'OperationSystem.dart';

class LinuxSystem extends OperationSystem {
  final String name = "linux";
  
  @override
  Future<void> setVariableEnvironment() async{
    print("Configurando variável de ambiente.");
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=\\"\\\$PATH:$currentPath/flutter/bin\\"' ">> \$HOME/.bashrc"]);
    await this.isCheckError(result);
  }
}