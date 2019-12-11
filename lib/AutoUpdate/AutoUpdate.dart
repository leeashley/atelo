import 'dart:convert';
import 'dart:io';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'package:console/console.dart';
import 'package:http/http.dart';
import 'package:version/version.dart';
import 'package:http/http.dart' as http;

class AutoUpdate {
  static AutoUpdate _instance;
  factory AutoUpdate({String url}){
    _instance ??= AutoUpdate._internalConstructor(url);
    return _instance;
  }
  AutoUpdate._internalConstructor(this.urlForNewVersion);

  // ATRIBUTES
  final Version currentVersion = Version(0, 0, 1);
  String urlForNewVersion = "";

  // METHODS
  checkUpdate(String operationSystemName) async {
    print("Checando se existe uma versão atualizada.");
    Response response = await http.get('https://atelo.unicobit.com/$operationSystemName\_version.json');
    //print("URL PESQUISADA: " + 'https://atelo.unicobit.com/$operationSystemName\_version.json');
    Map<String, dynamic> ateloVersion = jsonDecode(response.body);
    this.urlForNewVersion = ateloVersion['URL'];
    final Version lastVersion = Version.parse(ateloVersion['version']);
    if (currentVersion < lastVersion) {
      Console.setTextColor(1, bright: true);
      print("Existe uma nova versão do Atelo.");
      return true;
    } else {
      Console.setTextColor(2, bright: true);
      print("Atelo atualizado.");
      return false;
    }
  }

  updateAtelo(OperationSystem operationSystem){
    print("Atualizando o Atelo... " + urlForNewVersion);

    ProcessResult downloadAtelo = Process.runSync('curl', ['-C', '-', '-o', "${operationSystem.currentPath}/atelo.zip",'$urlForNewVersion'], runInShell: true);
    if(operationSystem.name == "windows"){
      print("Extraindo atelo no windows.");
      Process.runSync('tar', ['-xvf', '${operationSystem.currentPath}/atelo.zip', '-C', '${operationSystem.currentPath}'], runInShell: false);
    } else {
      print("Extraindo atelo no unix.");
      Process.runSync('unzip', ['-o', '${operationSystem.currentPath}/atelo.zip', '-d', '${operationSystem.currentPath}'], runInShell: false);
    }
    print("Download do atelo, STDOUT " + downloadAtelo.stdout + "ERRO: " + downloadAtelo.stderr);
  }

}
