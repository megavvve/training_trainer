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
  String get authHeadingSignIn => 'Welcome back!';

  @override
  String get authHeadingSignUp => 'Create an account';

  @override
  String get authSubtitleSignIn => 'Log in to continue your learning';

  @override
  String get authSubtitleSignUp => 'Start your learning journey';

  @override
  String get usernameLabel => 'Username';

  @override
  String get usernameHint => 'Create a username';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get invalidLogin => 'Login must be at least 3 characters';

  @override
  String get invalidPassword => 'Password must be at least 6 characters';

  @override
  String get userNotAuthenticated => 'User is not authenticated';

  @override
  String get createTrainer => 'Create trainer';

  @override
  String get mainInfo => 'Main info';

  @override
  String get modeStep => 'Mode';

  @override
  String get addQuestions => 'Questions';

  @override
  String get preview => 'Preview';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get exit => 'Exit';

  @override
  String get trainerName => 'Trainer name';

  @override
  String get trainerDescription => 'Description';

  @override
  String get trainerTime => 'Time';

  @override
  String get trainingProcess => 'Training process';

  @override
  String get selectAnswer => 'Select the correct answer';

  @override
  String get confirmTitle => 'Finish the training?';

  @override
  String get confirmContent =>
      'Make sure you have answered all the questions before finishing';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get goodResult => 'Great result!';

  @override
  String get normalResult => 'You can do better!';

  @override
  String get badResult => 'That is not your day!';

  @override
  String get statRight => 'Right';

  @override
  String get statWrong => 'Wrong';

  @override
  String get statUnanswered => 'Unanswered';

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

  @override
  String get history => 'History';

  @override
  String get noHistoryYet => 'No history yet';

  @override
  String get noTrainersFound => 'No trainers found';

  @override
  String get noTrainersHint =>
      'Try adjusting your search or create a new trainer';

  @override
  String foundTrainers(Object count) {
    return 'Found $count trainer';
  }

  @override
  String foundTrainersPlural(Object count) {
    return 'Found $count trainers';
  }

  @override
  String questionsCount(Object count) {
    return '$count questions';
  }

  @override
  String minutesShort(Object count) {
    return '$count min';
  }

  @override
  String get rememberMe => 'Remember me';

  @override
  String get questionCount => 'Number of questions';

  @override
  String get questionCountHint => 'How many questions to generate?';

  @override
  String get describeTopic => 'Describe the topic';

  @override
  String get topicHint => 'What trainer do you want to create?';

  @override
  String get generate => 'Generate';

  @override
  String get modeAutomatic => 'Automatic';

  @override
  String get modeAutoDesc => 'Generate questions via AI';

  @override
  String get modeManual => 'Manual';

  @override
  String get modeManualDesc => 'Create questions yourself';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get profile => 'Profile';

  @override
  String get signOut => 'Sign Out';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get appSettings => 'App Settings';

  @override
  String get profileLoadError => 'Failed to load profile';

  @override
  String get emptyFields => 'Please fill in all fields';

  @override
  String get enterTitle => 'Enter trainer title';

  @override
  String get enterTime => 'Enter time in minutes';

  @override
  String get trainerTitle => 'Trainer Title';

  @override
  String get timeLimit => 'Time Limit';

  @override
  String get keywordsTitle => 'Keywords';

  @override
  String get add => 'Add';

  @override
  String get question => 'Question';

  @override
  String get correctAnswer => 'Correct Answer';

  @override
  String get addQuestionBtn => 'Add Question';

  @override
  String get addedQuestions => 'Added Questions';

  @override
  String get searchHint => 'Search trainers...';

  @override
  String get sort => 'Sort';

  @override
  String get sorting => 'Sorting';

  @override
  String get sortByTitle => 'By title';

  @override
  String get sortByDate => 'By date';

  @override
  String get sortByQuestions => 'By questions count';

  @override
  String get start => 'Start';

  @override
  String get check => 'Check';

  @override
  String get continueText => 'Continue';

  @override
  String get correct => 'Correct!';

  @override
  String get error => 'Error';

  @override
  String get resultDetail => 'Result Details';

  @override
  String get greatJob => 'Great job!';

  @override
  String get keepPracticing => 'Keep practicing!';

  @override
  String get statCorrect => 'Correct';

  @override
  String get statTotal => 'Total';

  @override
  String get backToHistory => 'Back to history';

  @override
  String get trainingResult => 'Training Result';

  @override
  String correctAnswersCount(Object count) {
    return '$count correct';
  }

  @override
  String incorrectAnswersCount(Object count) {
    return '$count incorrect';
  }

  @override
  String unansweredAnswersCount(Object count) {
    return '$count unanswered';
  }

  @override
  String get generatingStatus1 => 'Analyzing the topic...';

  @override
  String get generatingStatus2 => 'Generating questions...';

  @override
  String get pleaseWait => 'Please wait...';

  @override
  String get generatingStatus3 => 'Creating answer options...';

  @override
  String get generatingStatus4 => 'Building the trainer...';

  @override
  String get generatingStatus5 => 'Almost there...';
}
