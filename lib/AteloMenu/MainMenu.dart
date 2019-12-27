import 'package:atelo/Model/Language/BaseLanguage.dart';
import "package:console/console.dart";

class MainMenu {
  
  String mainChoice(BaseLanguage language){
    var chooser = Chooser<String>([language.installFlutter, language.checkForAteloUpdate, language.clearTerminal, language.exit], message: language.selectAnOption);
    return chooser.chooseSync();
  }

  bool choiceCloseAtelo(BaseLanguage language){
    var chooser = Chooser<String>([language.backToMainMenu, language.exit], message: language.selectAnOption);
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

  bool choiceUpdateAtelo(BaseLanguage language){
    var chooser = Chooser<String>(["${language.yes}", "${language.no}"], message: "${language.choiceUpdateAtelo}");
    var answer = chooser.chooseSync();
    if(answer == language.yes){
      return true;
    } else {
      return false;
    }
  }
}