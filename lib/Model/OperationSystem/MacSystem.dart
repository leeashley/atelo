import 'dart:io';
import 'package:console/console.dart';
import 'package:process_run/process_run.dart';
import 'OperationSystem.dart';

class MacSystem extends OperationSystem {
  String currentPath = "";

  installationFlutter() async {
    print("Baixando o Flutter...");
    await run('curl', ['https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.9.1+hotfix.6-stable.zip', '--output', 'flutter.zip'], verbose: true, runInShell: true).then((result) {
      this.checkError(result, "Download do Flutter concluído.");
    });
    Console.setTextColor(3, bright: false);
    print("Extraindo...");
    ProcessResult result = Process.runSync('unzip', ['-oq', 'flutter.zip']);
    this.checkError(result, "Extração concluída.");
    this.currentPath = Directory.current.path;
  }

  setVariableEnvironment() async {
    print("Configurando variável de ambiente.");
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=\\"\\\$PATH:$currentPath/flutter/bin\\"' ">> \$HOME/.bash_profile"]);
    this.checkError(result, "Variável configurada.");
  }

  clearFlutterInstallationFiles(){
    ProcessResult result = Process.runSync('bash', ['-c', 'rm -f flutter.zip']);
    this.checkError(result);
  }
}