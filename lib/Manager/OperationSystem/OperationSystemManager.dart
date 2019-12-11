import 'package:atelo/Factory/SystemOperation/SystemOperationFactory.dart';
import 'package:atelo/Model/OperationSystem/OperationSystem.dart';

class OperationSystemManager {

  OperationSystem getCurrentOperationSystem(){
    SystemOperationFactory SOFactory = SystemOperationFactory();
    return SOFactory.identifySystemOperation();
  }
}