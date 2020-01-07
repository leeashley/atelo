import 'dart:io';
import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:console/console.dart';
import 'package:process_run/process_run.dart';
import 'OperationSystem.dart';

class MacSystem extends OperationSystem {
  final String name = "macos";

  @override
  Future<void> setEnvironmentVariable(BaseLanguage language) async {
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=\\"\\\$PATH:$currentPath/flutter/bin\\"' ">> \$HOME/.zshrc"]);
    this.isCheckError(result, language);
    Console.setTextColor(2, bright: true);
    print(language.successfullyEnvironmentVariable);
    Console.resetAll();
    await flutterDoctor(language, false, startProgressText: "Baixando dependências do Flutter.\ne.g Dart SDK , Assests.", finishProgressText: "Dependências baixadas com sucesso.");
  }

  @override
  Future<void> flutterDoctor(BaseLanguage language, bool diagnostic, {String startProgressText = "Realizando diagnóstico.", String finishProgressText = "Diagnóstico:", bool verbose = false, bool stdoutRun = false}) async {
    Logger loggerProgress = Logger.standard();
    Progress progress = loggerProgress.progress('$startProgressText');
    String command = "source \$HOME/.zshrc && flutter doctor";
    if (diagnostic) command = "flutter doctor";
    await run('bash', ['-c', '$command'], runInShell: true, includeParentEnvironment: true, verbose: verbose, stdout: stdoutRun ? stdout : null).then((result) async {
      progress.finish();
      await this.isCheckError(result, language);
      Console.setTextColor(2, bright: true);
      print("\n$finishProgressText");
      Console.resetAll();
      if(diagnostic) print("${result.stdout.toString()}");
    }).catchError((err){
      progress.finish();
      throw (" Por favor, verifique a variável de ambiente.");
    });
  }
}