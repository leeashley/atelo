import 'dart:io';
import 'package:atelo/Manager/Language/LanguageManager.dart';
import 'package:atelo/Manager/OperationSystem/OperationSystemManager.dart';
import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'package:atelo/atelo.dart';
import 'package:console/console.dart';

main(List<String> arguments) async {
  OperationSystem operationSystem = OperationSystemManager().getCurrentOperationSystem();
  BaseLanguage language = LanguageManager().getCurrentLanguageSystem();
  Atelo atelo = Atelo();

  try {
    await atelo.checkNewVersion(operationSystem, language);
    atelo.coreFunction(operationSystem, language, firstTime: true);
  } catch (err) {
    Console.setTextColor(1);
    if (err.toString().contains("Could not resolve host")) {
      stderr.writeln("${language.connectionError}\n$err");
    } else {
      stderr.writeln("${language.occurredError}\n$err");
    }
    Console.resetAll();
    stdin.readLineSync();
  }
}
