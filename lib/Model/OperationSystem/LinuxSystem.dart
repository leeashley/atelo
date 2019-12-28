import 'dart:io';

import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:process_run/process_run.dart';

import 'OperationSystem.dart';

class LinuxSystem extends OperationSystem {
  final String name = "linux";
  
  @override
  Future<void> setEnvironmentVariable(BaseLanguage language) async{
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=\\"\\\$PATH:$currentPath/flutter/bin\\"' ">> \$HOME/.bashrc"]);
    await this.isCheckError(result, language);
  }

  @override
  Future<void> executeFlutterDoctor(BaseLanguage language) async {
    print("Executando o Flutter Doctor.");
    print("Talvez demore alguns minutos pois é a primeira vez executando o Flutter, ele baixa alguns componentes restantes.");
    ProcessResult result = await run("./flutter", ['doctor'], verbose: true,  workingDirectory: "${currentPath}${systemPathSeparator}flutter${systemPathSeparator}bin", runInShell: true);
    await this.isCheckError(result, language);
  }
}