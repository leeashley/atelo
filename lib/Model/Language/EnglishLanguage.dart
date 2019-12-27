import 'package:atelo/Model/Language/BaseLanguage.dart';

class EnglishLanguage extends BaseLanguage {
  // MenuOptions
  final String installFlutter =  "Install Flutter (with environment variable)";
  final String exit = "Exit.";
  final String selectAnOption = "Select an option: ";
  final String headerMenu = "- ATELO STARTED - v";
  final String clearTerminal = "Clear terminal.";
  final String checkForAteloUpdate = "Check for Atelo update.";
  final String backToMainMenu = "Back to main menu.";
  final String yes = "YES.";
  final String no = "NO.";
  final String choiceUpdateAtelo = "Do you want to update the Atelo? ";

  // UpdateMessages
  final String checkingNewVersion = "- Checking if there is a new version of Atelo.";
  final String verificationSuccess = "There is a new version of Atelo.";
  final String checkingUpdate = "Checking update...";
  final String updatedAtelo = "Atelo updated.";
  final String updatingAtelo = "Updating the Atelo...";
  final String extractingAteloWin = "Extracting Atelo in windows.";
  final String extractingAteloLinux = "Extracting Atelo in unix.";
  final String successfullyUpdatedWin = "Atelo updated! It is recomended to terminate the current Atelo and open a new executable updated.\nThe new Atelo executable is in the same directory as the current executable with the name:";
  final String successfullyUpdated = "Atelo updated! It is recomended to terminate the Atelo and open again.";
  final String newAteloWin = "new_";
  final String successfullyInstalledFlutter = "Flutter instaled successfully.";
  final String successfullyEnvironmentVariable = "Environment variable configured.";
  final String settingEnvironmentVariable = "Configuring environment variable.";
  final String downloadingFlutter = "Downloading Flutter...";

  // ErrorMessages
  final String connectionError = "Connection error, please check your internet:";
  final String unableVerifyUpdate = "Unable to verify. Response Code: ";
  final String unableVerifyUpdateGeneric = "Unable to verify if there is a new version of Atelo. Please try again later.";
  final String occurredError = "An error has ocurred:";
  final String environmentVariableError = "Error setting environment variable.\\n### Error: ###\\n";
  final String flutterInstallationError = "Flutter installation error.\\n### Error: ###\\n";
  final String exitCode = "Exit code: ";

}