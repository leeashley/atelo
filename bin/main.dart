import 'dart:io';
import 'package:atelo/Manager/OperationSystem/OperationSystemManager.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'package:console/console.dart';

main(List<String> arguments) {
  Console.init();
  Console.setBackgroundColor(0);
  Console.setTextColor(2, bright: true);
  print('- ATELO INICIADO -');
  OperationSystemManager systemManager = OperationSystemManager();
  try {
    OperationSystem operationSystem = systemManager.getCurrentOperationSystem();
    Console.setTextColor(3, bright: false);
    operationSystem.downloadFlutter();
    Console.setTextColor(3, bright: false);
    operationSystem.setVariableEnvironment();
    Console.setTextColor(6);
    print("Flutter instalado e configurado. Pressione ENTER para encerrar.");
    stdin.readLineSync();
  } catch (err) {
    Console.setTextColor(1);
    if (err.toString().contains("Could not resolve host")){
      stderr.writeln("Erro de conexão, por favor verifique sua internet:\n$err");
    } else {
      stderr.writeln("Ocorreu um erro:\n$err");
    }
    stdin.readLineSync();
  }
}
