import 'dart:io';
import 'OperationSystem.dart';

class MacSystem extends OperationSystem {
  //String currentPath = Platform.script.toString().replaceFirst("file://", "").replaceAll(RegExp(r'/([^/]+)$'), '');
  final String name = "macos";

  @override
  Future<void> setVariableEnvironment() async {
    print("Configurando variável de ambiente.");
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=\\"\\\$PATH:$currentPath/flutter/bin\\"' ">> \$HOME/.bash_profile"]);
    this.isCheckError(result);
  }
}