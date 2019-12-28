import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'dart:io';

import 'package:process_run/process_run.dart';

class WindowsSystem extends OperationSystem {
  final String name = "windows";

  @override
  Future<void> setEnvironmentVariable(BaseLanguage language) async{

    ProcessResult resultVar = Process.runSync('powershell.exe', ['Set-ItemProperty -path HKCU:${systemPathSeparator}Environment${systemPathSeparator} -Name Path -Value "\$((Get-ItemProperty -path HKCU:${systemPathSeparator}Environment${systemPathSeparator} -Name Path).Path);$currentPath${systemPathSeparator}flutter${systemPathSeparator}bin"'], runInShell: false);
    this.isCheckError(resultVar, language);
  }

  @override
  Future<void> executeFlutterDoctor(BaseLanguage language) async {
    print("Executando o Flutter Doctor.");
    print("Talvez demore alguns minutos pois é a primeira vez executando o Flutter, ele baixa alguns componentes restantes.");
    ProcessResult result = await run("flutter", ['doctor'], verbose: true,  workingDirectory: "${currentPath}${systemPathSeparator}flutter${systemPathSeparator}bin", runInShell: true);
    await this.isCheckError(result, language);
  }
}
