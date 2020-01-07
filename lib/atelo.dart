import 'dart:io';
import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:console/console.dart';
import 'AteloMenu/MainMenu.dart';
import 'AutoUpdate/AutoUpdate.dart';
import 'Model/OperationSystem/OperationSystem.dart';

class Atelo {
  final String scriptName = Platform.script.toString().replaceAll(RegExp(r'([^/]+)/{1,}'), '');

  coreFunction(OperationSystem operationSystem, BaseLanguage language, {bool firstTime = false}) async {
    Console.init();
    if(!firstTime){
      print("\x1B[2J\x1B[0;0H");
    }
    //Console.setTextColor(2, bright: true);
    //const option1 = language.menuOptions()['installFlutter'];
    print(language.headerMenu + AutoUpdate().currentVersion.toString());
    MainMenu mainMenu = MainMenu();
    //Console.setTextColor(3, bright: false);
    String choice = mainMenu.mainChoice(language);
    if(choice == language.installFlutter){
      await operationSystem.installationFlutter(language).then((isVoid) async {
        //Console.setTextColor(2, bright: true);
        //print(language.successfullyInstalledFlutter);
        //Console.resetAll();
        print(language.settingEnvironmentVariable);
        await operationSystem.setEnvironmentVariable(language).then((isVoid) {
          bool close = mainMenu.choiceCloseAtelo(language);
          if (!close) coreFunction(operationSystem, language);
        }).catchError((err) {
          Console.setTextColor(1);
          print("\n"+language.environmentVariableError + err);
          Console.resetAll();
          bool close = mainMenu.choiceCloseAtelo(language);
          if (!close) coreFunction(operationSystem, language);
        });
      }).catchError((err){
        Console.setTextColor(1);
        print(language.flutterInstallationError + err);
        Console.resetAll();
        bool close = mainMenu.choiceCloseAtelo(language);
        if (!close) coreFunction(operationSystem, language);
      });;
    } else if (choice == "Diagnóstico (Variável do Flutter precisa estar configurada)."){
      print("\x1B[2J\x1B[0;0H");
      await operationSystem.flutterDoctor(language, true).then((_){
        Console.setTextColor(1, bright: true);
        print('P.S. - Pontos de atenção: começam [!] ou !.\nPontos positivos: começam com [√].\nPontos faltantes: iniciam com X.');
        Console.resetAll();
        bool close = mainMenu.choiceCloseAtelo(language);
        close ? null : coreFunction(operationSystem, language);
      }).catchError((err){
        Console.setTextColor(1);
        print(language.occurredError + err.toString());
        Console.resetAll();
        bool close = mainMenu.choiceCloseAtelo(language);
        if (!close) coreFunction(operationSystem, language);
      });
    } else if (choice == language.checkForAteloUpdate) {
      print(language.checkingUpdate);
      await checkNewVersion(operationSystem, language);
      bool close = mainMenu.choiceCloseAtelo(language);
      Console.resetAll();
      if (!close) coreFunction(operationSystem, language);
      //coreFunction(operationSystem, language);
    } else if (choice == language.clearTerminal){
      print("\x1B[2J\x1B[0;0H");
      coreFunction(operationSystem, language);
    }
    Console.setTextColor(6);
    Console.resetAll();
  }

  checkNewVersion(OperationSystem operationSystem, BaseLanguage language) async {
    AutoUpdate autoUpdate = AutoUpdate();
    bool newVersion = await autoUpdate.checkUpdate(operationSystem.name, language);
    switch (newVersion) {
      case true:
        MainMenu mainMenu = MainMenu();
        Console.setTextColor(3, bright: false);
        bool confirmed = mainMenu.choiceUpdateAtelo(language);
        if (confirmed) await autoUpdate.updateAtelo(operationSystem, scriptName, language);
        break;
      default:
    }
  }
}
