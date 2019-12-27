import 'dart:io';
import 'package:atelo/Model/Language/BaseLanguage.dart';
import 'package:atelo/Model/Language/EnglishLanguage.dart';
import 'package:atelo/Model/Language/PortugueseLanguage.dart';

class LanguageFactory {
  BaseLanguage identifyCurrentLanguage(){
     var localePlatform = Platform.localeName;
    if(localePlatform.contains("pt")){
      // TODO FAZER O RETORNO SER O LANGUAGE JSON
      PortugueseLanguage language = PortugueseLanguage();
      return language;
    } else {
      EnglishLanguage language = EnglishLanguage();
      return language;
    }
  }
}