import 'dart:io';
import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:console/console.dart';
import 'package:process_run/process_run.dart';
import 'OperationSystem.dart';

class LinuxSystem extends OperationSystem {
  final String name = "linux";

  @override
  Future<void> setEnvironmentVariable(BaseLanguage language) async{
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=\\"\\\$PATH:$currentPath/flutter/bin\\"' ">> \$HOME/.xprofile"]);
    await this.isCheckError(result, language);
    Console.setTextColor(2, bright: true);
    print(language.successfullyEnvironmentVariable);
    Console.resetAll();
    await flutterDoctor(language, false, startProgressText: "Baixando dependências do Flutter.\ne.g Dart SDK , Assests.", finishProgressText: "Dependências baixadas com sucesso.");
  }

  @override
  Future<void> flutterDoctor(BaseLanguage language, bool diagnostic, {String startProgressText = "Realizando diagnóstico.", String finishProgressText = "Diagnóstico:", bool verbose = false, bool stdoutRun = false}) async {
    Logger loggerProgress = Logger.standard();
    String startingText = language.downloadingFlutterDependencies;
    String finishProgress = language.downloadedWithSuccess;
    if(diagnostic) {
      startingText = language.startingDiagnostic;
      finishProgress = language.finishDiagnostic;
    };
    Progress progress = loggerProgress.progress(startingText);
    String command = "source ~/.xprofile && flutter doctor";
    await run('bash', ['-c', '$command'], runInShell: true , includeParentEnvironment: true).then((result) async {
      progress.finish();
      await this.isCheckError(result, language);
      Console.setTextColor(2, bright: true);
      print(finishProgress);
      Console.resetAll();
      if (diagnostic) print("${result.stdout.toString()}");
    }).catchError((err){
      progress.finish();
      throw (language.checkEnvironmentVariable);
    });
  }
}