import 'dart:io';

import 'OperationSystem.dart';

class LinuxSystem extends OperationSystem {
  final String name = "linux";
  
  @override
  setVariableEnvironment() {
    print("Configurando variável de ambiente.");
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=\\"\\\$PATH:$currentPath/flutter/bin\\"' ">> \$HOME/.bashrc"]);
    this.checkError(result, "Variável configurada.");
  }
}