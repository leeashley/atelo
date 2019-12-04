import 'dart:io';

import 'OperationSystem.dart';

class LinuxSystem extends OperationSystem {
  String currentPath = "";

  @override
  installationFlutter() {
    print("Baixando o Flutter...");
    ProcessResult downloadFlutter = Process.runSync('git', ['clone', '--branch', 'stable', 'https://github.com/flutter/flutter.git']);
    this.checkError(downloadFlutter, "Download do Flutter concluído.");
    this.currentPath = Directory.current.path;
  }

  @override
  setVariableEnvironment() {
    print("Configurando variável de ambiente.");
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=\\"\\\$PATH:$currentPath/flutter/bin\\"' ">> \$HOME/.bashrc"]);
    this.checkError(result, "Variável configurada.");
  }

   @override
  clearFlutterInstallationFiles() {
    // TODO: implement clearFlutterInstallationFiles
    return null;
  }

}