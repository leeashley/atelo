import "package:console/console.dart";

class MainMenu {
  
  String mainChoice(){
    var chooser = Chooser<String>(["Instalar o Flutter (configurando a variável de ambiente).", "Verificar atualização do Atelo.", "Sair."], message: "Selecione uma opção:");
    return chooser.chooseSync();
  }

  bool choiceCloseAtelo(){
    var chooser = Chooser<String>(["Voltar para o Menu Principal.", "Sair."], message: "Selecione uma opção:");
    var answer = chooser.chooseSync();
    switch (answer) {
      case "Voltar para o Menu Principal.":
        return false;
      break;
      case "Sair.":
        return true;
      break;
      default: return false;
    }
  }

  bool choiceUpdateAtelo(){
    var chooser = Chooser<String>(["SIM", "NÃO"], message: "Deseja atualizar o Atelo?");
    var answer = chooser.chooseSync();
    switch (answer) {
      case "SIM":
        return true;
      break;
      case "NÃO": return false;
      break;
      default: return false;
    }
  }
}