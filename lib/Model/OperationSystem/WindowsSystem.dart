import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'dart:io';

class WindowsSystem extends OperationSystem {

  @override
  setVariableEnvironment(){
    print("Configurando variável de ambiente.");
    // C:\>setx /m PATH "C:\myfolder;%PATH%"
    // Executando o variável PATH eFortamando a variável Path
   // ProcessResult resultPath = Process.runSync('echo', ['%PATH%'], runInShell: true);
    //var userPath = resultPath.stdout.toString().split('"')[0];
    // Salvando a variável do Flutter no User Environment
    ProcessResult resultVar = Process.runSync('setx', ['Path', '%Path%;$currentPath\\flutter\\bin'], runInShell: false);
    this.checkError(resultVar, "Variável configurada com sucesso.");
  }
}