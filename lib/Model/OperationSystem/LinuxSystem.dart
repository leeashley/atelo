import 'dart:io';

import 'OperationSystem.dart';

class LinuxSystem extends OperationSystem {
  String currentPath = Platform.script.toString().replaceFirst("file://", "").replaceAll(RegExp(r'/([^/]+)$'), '');
  final String name = "linux";
  
  @override
  setVariableEnvironment() {
    print("Configurando variável de ambiente.");
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=\\"\\\$PATH:$currentPath/flutter/bin\\"' ">> \$HOME/.bashrc"]);
    this.checkError(result, "Variável configurada.");
  }
}