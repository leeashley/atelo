import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:cli_menu/cli_menu.dart';
import "package:console/console.dart";

class MainMenu {

  String mainChoice(BaseLanguage language){
    print(language.selectAnOption);
    var chooser = Menu([language.installFlutter, 'Diagnóstico (Variável do Flutter precisa estar configurada).',language.checkForAteloUpdate, language.clearTerminal, language.exit]);
    return chooser.choose().toString();
  }

  bool choiceCloseAtelo(BaseLanguage language){
    print(language.selectAnOption);
    var chooser = Menu([language.backToMainMenu, language.exit]);
    String answer = chooser.choose().toString();
    if(answer == language.backToMainMenu){
      return false;
    } else if (answer == language.exit){
      return true;
    } else {
      return false;
    }
  }

  bool choiceUpdateAtelo(BaseLanguage language){
    print(language.choiceUpdateAtelo);
    var chooser = Menu([language.yes, language.no]);
    String answer = chooser.choose().toString();
    if(answer == language.yes){
      return true;
    } else {
      return false;
    }
  }
}