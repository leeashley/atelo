import 'dart:io';
import 'package:atelo/Manager/OperationSystem/OperationSystemManager.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'package:atelo/atelo.dart';
import 'package:console/console.dart';

main(List<String> arguments) async {
  OperationSystemManager systemManager = OperationSystemManager();
  OperationSystem operationSystem = systemManager.getCurrentOperationSystem();
  Atelo atelo = Atelo();
  print("PATH ATUAL: " + operationSystem.currentPath);
  Console.setTextColor(3, bright: false);
  await atelo.checkNewVersion(operationSystem);

  try {
    atelo.coreFunction(operationSystem);
  } catch (err) {
    Console.setTextColor(1);
    if (err.toString().contains("Could not resolve host")) {
      stderr.writeln("Erro de conexão, por favor verifique sua internet:\n$err");
    } else {
      stderr.writeln("Ocorreu um erro:\n$err");
    }
    Console.resetAll();
    stdin.readLineSync();
  }
}
