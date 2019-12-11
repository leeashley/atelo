import 'dart:io';
import 'OperationSystem.dart';

class MacSystem extends OperationSystem {
  final String name = "macos";

  @override
  setVariableEnvironment() {
    print("Configurando variável de ambiente.");
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=\\"\\\$PATH:$currentPath/flutter/bin\\"' ">> \$HOME/.bash_profile"]);
    this.checkError(result, "Variável configurada.");
  }
}