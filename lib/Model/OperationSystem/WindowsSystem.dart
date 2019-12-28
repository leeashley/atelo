import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'dart:io';

class WindowsSystem extends OperationSystem {
  final String name = "windows";

  @override
  Future<void> setVariableEnvironment(BaseLanguage language) async{

    ProcessResult resultVar = Process.runSync('powershell.exe', ['Set-ItemProperty -path HKCU:${pathSeparatorSystem}Environment${pathSeparatorSystem} -Name Path -Value "\$((Get-ItemProperty -path HKCU:${pathSeparatorSystem}Environment${pathSeparatorSystem} -Name Path).Path);$currentPath${pathSeparatorSystem}flutter${pathSeparatorSystem}bin"'], runInShell: false);
    this.isCheckError(resultVar, language);
  }
}
