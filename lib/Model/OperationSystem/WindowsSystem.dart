import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'dart:io';
import 'package:cli_util/cli_logging.dart';
import 'package:console/console.dart';
import 'package:process_run/process_run.dart';

class WindowsSystem extends OperationSystem {
  final String name = "windows";

  @override
  Future<void> setEnvironmentVariable(BaseLanguage language) async{
    ProcessResult resultVar = Process.runSync('powershell.exe', ['Set-ItemProperty -path HKCU:${systemPathSeparator}Environment${systemPathSeparator} -Name Path -Value "\$((Get-ItemProperty -path HKCU:${systemPathSeparator}Environment${systemPathSeparator} -Name Path).Path);$currentPath${systemPathSeparator}flutter${systemPathSeparator}bin"'], runInShell: false);
    this.isCheckError(resultVar, language);
    Console.setTextColor(2, bright: true);
    print(language.successfullyEnvironmentVariable);
    Console.resetAll();
    await flutterDoctor(language, false);
  }

  @override
  Future<void> flutterDoctor(BaseLanguage language, bool diagnostic, {bool verbose = false, bool stdoutRun = false}) async {
    Logger loggerProgress = Logger.standard();
    String startingText = language.downloadingFlutterDependencies;
    String finishProgress = language.downloadedWithSuccess;
    if(diagnostic) {
      startingText = language.startingDiagnostic;
      finishProgress = language.finishDiagnostic;
      stdoutRun = true;
    };
    Progress progress = loggerProgress.progress(startingText);
    await run('powershell.exe', ['\$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")', ';' , 'flutter doctor'], runInShell: false, includeParentEnvironment: true, verbose: verbose, stdout: stdoutRun ? stdout : null).then((result) async {
      progress.finish();
      await this.isCheckError(result, language);
      Console.setTextColor(2, bright: true);
      print(finishProgress);
      Console.resetAll();
    }).catchError((err){
      progress.finish();
      throw (language.checkEnvironmentVariable);
    });
  }

}
