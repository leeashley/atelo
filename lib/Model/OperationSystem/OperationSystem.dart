import 'dart:io';
import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:console/console.dart';
import 'package:process_run/process_run.dart';

abstract class OperationSystem {
  final String currentPath = Directory.current.path;
  final String systemPathSeparator = Platform.pathSeparator;
  String name;

  Future<void> setEnvironmentVariable(BaseLanguage language);

  Future<void> flutterDoctor(BaseLanguage language, bool diagnostic, {bool verbose = false, bool stdoutRun = false});

  Future<void> installationFlutter(BaseLanguage language) async{
    Logger loggerProgress = Logger.standard();
    print("\x1B[2J\x1B[0;0H");
    Console.setTextColor(3, bright: false);
    Progress progress = loggerProgress.progress(language.downloadingFlutter);
    print("\r");
    ProcessResult downloadFlutter = await run('git', ['clone', '--branch', 'stable', 'https://github.com/flutter/flutter.git'], runInShell: true, verbose: true, commandVerbose: false);
    Console.setTextColor(2, bright: true);
    progress.finish(message: "\n${language.successfullyInstalledFlutter}");
    Console.resetAll();
    await this.isCheckError(downloadFlutter, language);
  }

  isCheckError(ProcessResult result, BaseLanguage language) {
    if(result.stderr != null && result.exitCode != 0){
      print("\x1B[2J\x1B[0;0H");
      print(language.exitCode + result.exitCode.toString());
      if (result.stderr.toString().contains("'flutter' is not recognized as an internal or external command"))throw (" Por favor, verifique a variável de ambiente INNER.".toString());
      result.stderr.toString().isNotEmpty ? throw (result.stderr) : throw (result.stdout);
    }
  }
}