// TO DO - FAZER A CHAMADA PARA O FACTORY, PEGAR A CLASSE E RETORNA-LA
import 'package:atelo/Factory/SystemOperation/SystemOperationFactory.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';

class OperationSystemManager {

  OperationSystem getCurrentOperationSystem(){
    SystemOperationFactory SOFactory = SystemOperationFactory();
    return SOFactory.identifySystemOperation();
  }
}