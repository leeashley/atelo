import 'package:atelo/Model/OperationSystem/OperationSystem.dart';
import 'dart:io';

class WindowsSystem extends OperationSystem {
  String currentPath = "";

  downloadFlutter() {
    print("Baixando o Flutter...");
    ProcessResult downloadFlutter = Process.runSync('git', ['clone', '--branch', 'stable', 'https://github.com/flutter/flutter.git']);
    this.checkError(downloadFlutter, "Download do Flutter concluído.");
    currentPath = Directory.current.path;
  }

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