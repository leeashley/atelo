import 'package:atelo/Model/Language/BaseLanguage.dart';

class PortugueseLanguage extends BaseLanguage {
  // MenuOptions
  final String installFlutter = "Instalar o Flutter (configurando a variável de ambiente).";
  final String exit = "Sair.";
  final String yes = "SIM";
  final String no = "NÃO";
  final String choiceUpdateAtelo = "Deseja atualizar o Atelo? ";
  final String checkForAteloUpdate = "Verificar atualização do Atelo.";
  final String clearTerminal = "Limpar terminal.";
  final String backToMainMenu = "Voltar para o Menu Principal.";
  final String selectAnOption = "Selecione uma opção: ";
  final String headerMenu = "ATELO INICIADO - v";

  // UpdateMessages
  final String checkingNewVersion = "- Checando se existe uma nova versão do Atelo.";
  final String verificationSuccess = "Existe uma nova versão do Atelo.";
  final String checkingUpdate = "Verificando atualização...";
  final String updatedAtelo = "Atelo atualizado.";
  final String updatingAtelo ="Atualizando o Atelo...";
  final String extractingAteloWin ="Extraindo Atelo no windows.";
  final String extractingAteloLinux = "Extraindo atelo no unix.";
  final String successfullyUpdatedWin = "Atelo atualizado! É recomendado encerrar o Atelo atual e abrir o novo executável atualizado.\nO novo executável de Atelo está no mesmo diretório que o executável atual com o seguinte nome:";
  final String successfullyUpdated = "Atelo atualizado! É recomendado encerrar o Atelo e abri-lo novamente.";
  final String newAteloWin = "novo_";
  final String successfullyInstalledFlutter = "Flutter instalado com sucesso.";
  final String successfullyEnvironmentVariable = "Variável de ambiente configurada.";
  final String settingEnvironmentVariable = "Configurando variável de ambiente.";
  final String downloadingFlutter = "Baixando o Flutter...";

  // ErrorMessages
  final String connectionError ="Erro de conexão, por favor verifique sua internet:";
  final String unableVerifyUpdate = "Não foi possível verificar. Códido do response: ";
  final String unableVerifyUpdateGeneric = "Não foi possível verificar se existe uma nova versão do Atelo. Por favor tente novamente depois.";
  final String occurredError = "Ocorreu um erro:";
  final String environmentVariableError = "Error na configuração da variável de ambiente.\\n### Erro: ###\\n";
  final String flutterInstallationError = "Error na instalação do Flutter.\\n### Erro: ###\\n";
  final String exitCode = "Código de saída: ";
} 