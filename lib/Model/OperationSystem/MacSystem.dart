import 'dart:io';
import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:console/console.dart';
import 'package:process_run/process_run.dart';
import 'OperationSystem.dart';

class MacSystem extends OperationSystem {
  final String name = "macos";
  final String shellFile = Platform.environment['SHELL'].split('/')[2];

  @override
  Future<void> setEnvironmentVariable(BaseLanguage language) async {
    String envVariableFile = shellFile.contains("bash") ? ".bash_profile" : ".${shellFile}rc";
    ProcessResult result = Process.runSync('bash', ['-c' , 'echo export PATH=$systemPathSeparator"\$PATH:$currentPath${systemPathSeparator}flutter${systemPathSeparator}bin"' ">> \$HOME${systemPathSeparator}$envVariableFile"]);
    this.isCheckError(result, language);
    Console.setTextColor(2, bright: true);
    print(language.successfullyEnvironmentVariable);
    Console.resetAll();
    await flutterDoctor(language, false);
  }

  @override
  Future<void> flutterDoctor(BaseLanguage language, bool diagnostic, {bool verbose = false, bool stdoutRun = false}) async {
    Logger loggerProgress = Logger.standard();
    String envVariableFile = shellFile.contains("bash") ? ".bash_profile" : ".${shellFile}rc";
    String command = "source \$HOME/$envVariableFile && flutter doctor";
    String startingText = language.downloadingFlutterDependencies;
    String finishProgress = language.downloadedWithSuccess;
    if (diagnostic) {
      startingText = language.startingDiagnostic;
      finishProgress = language.finishDiagnostic;
    }
    Progress progress = loggerProgress.progress(startingText);
    await run('bash', ['-c', '$command'], runInShell: true, includeParentEnvironment: true, verbose: verbose, stdout: stdoutRun ? stdout : null).then((result) async {
      progress.finish();
      await this.isCheckError(result, language);
      Console.setTextColor(2, bright: true);
      print(finishProgress);
      Console.resetAll();
      if(diagnostic) print("${result.stdout.toString()}");
    }).catchError((err){
      progress.finish();
      throw (language.checkEnvironmentVariable);
    });
  }
}