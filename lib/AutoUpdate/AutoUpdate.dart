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
    print("- Checando se existe uma nova versão do Atelo.");
    Response response = await http.get('https://atelo.unicobit.com/$operationSystemName\_version.json');
    if(response.statusCode != 200){
      Console.setTextColor(1, bright: true);
      print("Não foi possível verificar. Códido do response: ${response.statusCode}.");
      Console.setTextColor(3, bright: false);
      return false;
    }
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

  updateAtelo(OperationSystem operationSystem, String ateloFile){
    //print("Atualizando o Atelo... " + urlForNewVersion + "Path destino: " + operationSystem.currentPath);
    final String separator = Platform.pathSeparator;
    final String ateloZip = "novo_atelo.zip";
    Process.runSync('curl', ['-o', "${operationSystem.currentPath}${separator}${ateloZip}",'$urlForNewVersion'], runInShell: true);
    if(operationSystem.name == "windows"){
      print("Extraindo atelo no windows.");
      Process.runSync('tar', ['-xvf', '${operationSystem.currentPath}${separator}${ateloZip}', '-C', '${operationSystem.currentPath}'], runInShell: false);
      Process.runSync('del', ['/f','${operationSystem.currentPath}${separator}${ateloZip}'], runInShell: true);
      Process.runSync('rename', ['${operationSystem.currentPath}${separator}atelo_win.exe', 'novo_${ateloFile}'], runInShell: true);
      print("Atelo atualizado!\nÉ recomendado encerrar e abrir o novo_${ateloFile}, ele está no mesmo diretório que o executável atual.");
    } else {
      print("Extraindo atelo no unix.");
      Process.runSync('unzip', ['-o', '${operationSystem.currentPath}${separator}${ateloZip}'], runInShell: false);
      Process.runSync('rm', ['-f', '${operationSystem.currentPath}${separator}${ateloZip}'], runInShell: false);
      Process.runSync('mv', ['${operationSystem.currentPath}${separator}atelo_${operationSystem.name}', '${operationSystem.currentPath}${separator}${ateloFile}']);
      print("Atelo atualizado!\nÉ recomendado encerrar essa sessão e executar novamente o ${ateloFile}");
    }
  }
}
