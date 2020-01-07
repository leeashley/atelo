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
    await flutterDoctor(language, false, startProgressText: "Baixando dependências do Flutter.\ne.g Dart SDK , Assests.", finishProgressText: "Dependências baixadas com sucesso.");
  }

  @override
  Future<void> flutterDoctor(BaseLanguage language, bool diagnostic, {String startProgressText = "Realizando diagnóstico.", String finishProgressText = "\nDiagnóstico realizado.", bool verbose = false, bool stdoutRun = false}) async {
    Logger loggerProgress = Logger.standard();
    Progress progress = loggerProgress.progress('$startProgressText');
    if(diagnostic) stdoutRun = true;
    await run('refreshenv && flutter doctor', [''], runInShell: true, includeParentEnvironment: true, verbose: verbose, stdout: stdoutRun ? stdout : null).then((result) async {
      progress.finish();
      await this.isCheckError(result, language);
      Console.setTextColor(2, bright: true);
      print("${finishProgressText}");
      Console.resetAll();
    }).catchError((err){
      progress.finish();
      throw (" Por favor, verifique a variável de ambiente.");
    });
  }

}
