import 'dart:convert';
import 'dart:io';
import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'package:console/console.dart';
import 'package:version/version.dart';
import 'package:http/http.dart';

class AutoUpdate {
  static AutoUpdate _instance;
  factory AutoUpdate({String url}){
    _instance ??= AutoUpdate._internalConstructor(url);
    return _instance;
  }
  AutoUpdate._internalConstructor(this.urlForNewVersion);

  // ATRIBUTES
  final Version currentVersion = Version(0, 2, 0);
  String urlForNewVersion = "";

  // METHODS
  checkUpdate(String operationSystemName, BaseLanguage language) async {
    Console.setTextColor(3, bright: false);
    print(language.checkingNewVersion);
    Console.resetAll();
    await get('https://atelo.unicobit.com/$operationSystemName\_version.json').then((response) {
      if (response.statusCode != 200) {
        Console.setTextColor(1, bright: true);
        print("${language.unableVerifyUpdate} ${response.statusCode}.");
        Console.setTextColor(3, bright: false);
        return false;
      }
      Map<String, dynamic> ateloVersion = jsonDecode(response.body);
      this.urlForNewVersion = ateloVersion['URL'];
      final Version lastVersion = Version.parse(ateloVersion['version']);
      if (currentVersion < lastVersion) {
        Console.setTextColor(1, bright: true);
        print("${language.verificationSuccess}");
        Console.resetAll();
        return true;
      } else {
        print("${language.updatedAtelo}");
        Console.resetAll();
        sleep(Duration(seconds: 2));
        print("\x1B[2J\x1B[0;0H");
        return false;
      }
    }).catchError((error) {
      Console.setTextColor(1, bright: true);
      print("${language.unableVerifyUpdate}");
      Console.resetAll();
      return false;
    });
  }

  updateAtelo(OperationSystem operationSystem, String ateloFile, BaseLanguage language){
    print(language.updatingAtelo);
    final String separator = Platform.pathSeparator;
    final String ateloZip = "novo_atelo.zip";
    Process.runSync('curl', ['-o', "${operationSystem.currentPath}${separator}${ateloZip}",'$urlForNewVersion'], runInShell: true);
    if(operationSystem.name == "windows"){
      print(language.extractingAteloWin);
      Process.runSync('tar', ['-xvf', '${operationSystem.currentPath}${separator}${ateloZip}', '-C', '${operationSystem.currentPath}'], runInShell: false);
      Process.runSync('del', ['/f','${operationSystem.currentPath}${separator}${ateloZip}'], runInShell: true);
      Process.runSync('rename', ['${operationSystem.currentPath}${separator}atelo_win.exe', '${language.newAteloWin}${ateloFile}'], runInShell: true);
      print("${language.successfullyUpdatedWin} ${language.newAteloWin}${ateloFile}");
    } else {
      print(language.extractingAteloLinux);
      Process.runSync('unzip', ['-o', '${operationSystem.currentPath}${separator}${ateloZip}'], runInShell: false);
      Process.runSync('rm', ['-f', '${operationSystem.currentPath}${separator}${ateloZip}'], runInShell: false);
      Process.runSync('mv', ['${operationSystem.currentPath}${separator}atelo_${operationSystem.name}', '${operationSystem.currentPath}${separator}${ateloFile}']);
      print(language.successfullyUpdated);
    }
  }
}
