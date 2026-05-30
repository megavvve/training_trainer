// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Training Trainer';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get profileLabel => 'Your Profile';

  @override
  String get appSettings => 'App Settings';

  @override
  String get settings => 'Settings';

  @override
  String get signOut => 'Sign Out';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get next => 'Next';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get authHeadingSignUp => 'Registration';

  @override
  String get authHeadingSignIn => 'Sign In';

  @override
  String get authSubtitleSignUp => 'Create an account to start learning';

  @override
  String get authSubtitleSignIn => 'Sign in to your account';

  @override
  String get forRegistration => 'for registration';

  @override
  String get forSignIn => 'for sign in';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get emptyFields => 'Input fields are not filled';

  @override
  String get userNotAuthenticated => 'User is not authenticated';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get accessForbidden => 'Access forbidden';

  @override
  String get resourceNotFound => 'Resource not found';

  @override
  String get passwordRequirement =>
      'Password must contain at least 8 characters, including letters and numbers';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get emailLabel => 'email';

  @override
  String get profileLoadError => 'Profile load error';

  @override
  String get addTrainerError => 'Error adding trainer';

  @override
  String get deleteTrainerError => 'Error deleting trainer';

  @override
  String get searchHint => 'Search by title...';

  @override
  String foundElements(Object count) {
    return 'Found elements: $count';
  }

  @override
  String get sorting => 'Sorting';

  @override
  String get sortByTitle => 'By title (A-Z)';

  @override
  String get sortByDate => 'By creation date';

  @override
  String get sortByQuestions => 'By number of questions';

  @override
  String get sort => 'Sort';

  @override
  String get createTrainer => 'Create Trainer';

  @override
  String get mainInfo => 'Main Info';

  @override
  String get addQuestions => 'Questions';

  @override
  String get keywordsTitle => 'Keywords';

  @override
  String get preview => 'Preview';

  @override
  String get back => 'Back';

  @override
  String get save => 'Save';

  @override
  String get add => 'Add';

  @override
  String get question => 'Question';

  @override
  String get start => 'Start';

  @override
  String get continueText => 'Continue';

  @override
  String get check => 'Check';

  @override
  String get correct => 'Correct!';

  @override
  String get error => 'Error';

  @override
  String get cancel => 'Cancel';

  @override
  String get exit => 'Exit';

  @override
  String get trainerTitle => 'Trainer Title';

  @override
  String get trainerDescription => 'Trainer Description';

  @override
  String get timeLimit => 'Time limit (minutes)';

  @override
  String get enterTitle => 'Enter title';

  @override
  String get enterTime => 'Enter time';

  @override
  String get correctAnswer => 'Correct Answer';

  @override
  String get addQuestionBtn => 'Add Question';

  @override
  String get addedQuestions => 'Added Questions';

  @override
  String get trainingResult => 'Training Result';

  @override
  String correctAnswersCount(Object count) {
    return 'Number of correct answers: $count';
  }

  @override
  String incorrectAnswersCount(Object count) {
    return 'Number of incorrect answers: $count';
  }

  @override
  String get congrats1 =>
      'Congratulations! You have successfully completed the trainer. Keep growing in your chosen field!';

  @override
  String get congrats2 =>
      'Great job! Now you have even more knowledge in your arsenal. Apply it with confidence!';

  @override
  String get congrats3 =>
      'You have completed the trainer. Don\'t forget that every question is a step towards your success!';

  @override
  String get congrats4 =>
      'Bravo! Now you are one step closer to mastery in this field. Keep it up!';

  @override
  String get congrats5 =>
      'Trainer completed successfully! Your efforts are bringing results. We are sure you are ready for new challenges!';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get russian => 'Russian';

  @override
  String get cancelTrainingTitle => 'Cancel training?';

  @override
  String get cancelTrainingContent => 'All progress will be lost';

  @override
  String get ok => 'OK';

  @override
  String get wellDone => 'Well done!';

  @override
  String get showCorrectAnswer => 'See the correct answer.';
}
