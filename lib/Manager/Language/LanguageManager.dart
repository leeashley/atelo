import 'package:atelo/Factory/Language/LanguageFactory.dart';
import 'package:atelo/Model/Language/BaseLanguage.dart';

class LanguageManager {

  BaseLanguage getCurrentLanguageSystem(){
    LanguageFactory currentLanguage = LanguageFactory();
    return currentLanguage.identifyCurrentLanguage();
  }
}