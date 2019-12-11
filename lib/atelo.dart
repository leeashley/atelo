import 'dart:io';

import 'package:console/console.dart';
import 'AteloMenu/MainMenu.dart';
import 'AutoUpdate/AutoUpdate.dart';
import 'Model/OperationSystem/OperationSystem.dart';

class Atelo {
  final String scriptName = Platform.script.toString().replaceAll(RegExp(r'([^/]+)/{1,}'), '');

  coreFunction(OperationSystem operationSystem) async {
    Console.init();
    Console.setTextColor(2, bright: true);
    print('- ATELO INICIADO -');
    MainMenu mainMenu = MainMenu();
    
    Console.setTextColor(3, bright: false);
    String choice = mainMenu.mainChoice();
    switch (choice) {
      case "Instalar o Flutter (configurando a variável de ambiente).":
        Console.setTextColor(3, bright: false);
        operationSystem.installationFlutter();
        print("Flutter instalado e configurado.");
        Console.setTextColor(3, bright: false);
        operationSystem.setVariableEnvironment();
        bool close = mainMenu.choiceCloseAtelo();
        Console.resetAll();
        close ? null : coreFunction(operationSystem);
        break;
      case "Verificar atualização do Atelo.":
        print("Verificando atualização...");
        await checkNewVersion(operationSystem);
        bool close = mainMenu.choiceCloseAtelo();
        Console.resetAll();
        close ? null : coreFunction(operationSystem);
        break;
      case "Limpar terminal.":
        print(Process.runSync("clear", [], runInShell: false).stdout);
        coreFunction(operationSystem);
        break;
      case "Sair.":
        break;
      default:
        coreFunction(operationSystem);
    }
    Console.setTextColor(6);
    Console.resetAll();
  }

  checkNewVersion(OperationSystem operationSystem) async {
    AutoUpdate autoUpdate = AutoUpdate();
    bool newVersion = await autoUpdate.checkUpdate(operationSystem.name);
    //print("Retorno do update: " + newVersion.toString());
    switch (newVersion) {
    case true:
      MainMenu mainMenu = MainMenu();
      Console.setTextColor(3, bright: false);
      bool confirmed = mainMenu.choiceUpdateAtelo();
      confirmed ? await autoUpdate.updateAtelo(operationSystem, scriptName) : null;
    break;
    default:
    }
  }
}
