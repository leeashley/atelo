import 'dart:io';

import 'package:console/console.dart';
import 'AteloMenu/MainMenu.dart';
import 'AutoUpdate/AutoUpdate.dart';
import 'Model/OperationSystem/OperationSystem.dart';

class Atelo {
  final String scriptName = Platform.script.toString().replaceAll(RegExp(r'([^/]+)/{1,}'), '');

  coreFunction(OperationSystem operationSystem) async {
    Console.init();
    //Console.setTextColor(2, bright: true);
    print('- ATELO INICIADO - v' + AutoUpdate().currentVersion.toString());
    MainMenu mainMenu = MainMenu();
    
    //Console.setTextColor(3, bright: false);
    String choice = mainMenu.mainChoice();
    switch (choice) {
      case "Instalar o Flutter (configurando a variável de ambiente).":
        await operationSystem.installationFlutter().then((isVoid) async {
          Console.setTextColor(2, bright: true);
          print("Flutter instalado e configurado.");
          Console.resetAll();
          await operationSystem.setVariableEnvironment().then((isVoid) {
            Console.setTextColor(2, bright: true);
            print("Variável de ambiente configurada.");
            bool close = mainMenu.choiceCloseAtelo();
            Console.resetAll();
            close ? null : coreFunction(operationSystem);
          }).catchError((err) {
            Console.setTextColor(1);
            print("Error na configuração da variável de ambiente.\n### Erro: ###\n" + err);
            Console.resetAll();
            bool close = mainMenu.choiceCloseAtelo();
            close ? null : coreFunction(operationSystem);
          });
        }).catchError((err){
          Console.setTextColor(1);
          print("Error na instalação do Flutter.\n### Erro: ###\n" + err);
          Console.resetAll();
          bool close = mainMenu.choiceCloseAtelo();
          close ? null : coreFunction(operationSystem);
        });;
      break;
      case "Verificar atualização do Atelo.":
        print("Verificando atualização...");
        await checkNewVersion(operationSystem);
        bool close = mainMenu.choiceCloseAtelo();
        Console.resetAll();
        close ? null : coreFunction(operationSystem);
        break;
      case "Limpar terminal.":
        print("\x1B[2J\x1B[0;0H");
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
