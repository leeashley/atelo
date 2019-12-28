import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'dart:io';

class WindowsSystem extends OperationSystem {
  final String name = "windows";

  @override
  Future<void> setEnvironmentVariable(BaseLanguage language) async{

    ProcessResult resultVar = Process.runSync('powershell.exe', ['Set-ItemProperty -path HKCU:${systemPathSeparator}Environment${systemPathSeparator} -Name Path -Value "\$((Get-ItemProperty -path HKCU:${systemPathSeparator}Environment${systemPathSeparator} -Name Path).Path);$currentPath${systemPathSeparator}flutter${systemPathSeparator}bin"'], runInShell: false);
    this.isCheckError(resultVar, language);
  }
}
