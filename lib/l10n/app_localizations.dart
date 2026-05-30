import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Training Trainer'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @profileLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Profile'**
  String get profileLabel;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @authHeadingSignUp.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get authHeadingSignUp;

  /// No description provided for @authHeadingSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authHeadingSignIn;

  /// No description provided for @authSubtitleSignUp.
  ///
  /// In en, this message translates to:
  /// **'Create an account to start learning'**
  String get authSubtitleSignUp;

  /// No description provided for @authSubtitleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account'**
  String get authSubtitleSignIn;

  /// No description provided for @forRegistration.
  ///
  /// In en, this message translates to:
  /// **'for registration'**
  String get forRegistration;

  /// No description provided for @forSignIn.
  ///
  /// In en, this message translates to:
  /// **'for sign in'**
  String get forSignIn;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @emptyFields.
  ///
  /// In en, this message translates to:
  /// **'Input fields are not filled'**
  String get emptyFields;

  /// No description provided for @userNotAuthenticated.
  ///
  /// In en, this message translates to:
  /// **'User is not authenticated'**
  String get userNotAuthenticated;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @accessForbidden.
  ///
  /// In en, this message translates to:
  /// **'Access forbidden'**
  String get accessForbidden;

  /// No description provided for @resourceNotFound.
  ///
  /// In en, this message translates to:
  /// **'Resource not found'**
  String get resourceNotFound;

  /// No description provided for @passwordRequirement.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 8 characters, including letters and numbers'**
  String get passwordRequirement;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get emailLabel;

  /// No description provided for @profileLoadError.
  ///
  /// In en, this message translates to:
  /// **'Profile load error'**
  String get profileLoadError;

  /// No description provided for @addTrainerError.
  ///
  /// In en, this message translates to:
  /// **'Error adding trainer'**
  String get addTrainerError;

  /// No description provided for @deleteTrainerError.
  ///
  /// In en, this message translates to:
  /// **'Error deleting trainer'**
  String get deleteTrainerError;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by title...'**
  String get searchHint;

  /// No description provided for @foundElements.
  ///
  /// In en, this message translates to:
  /// **'Found elements: {count}'**
  String foundElements(Object count);

  /// No description provided for @sorting.
  ///
  /// In en, this message translates to:
  /// **'Sorting'**
  String get sorting;

  /// No description provided for @sortByTitle.
  ///
  /// In en, this message translates to:
  /// **'By title (A-Z)'**
  String get sortByTitle;

  /// No description provided for @sortByDate.
  ///
  /// In en, this message translates to:
  /// **'By creation date'**
  String get sortByDate;

  /// No description provided for @sortByQuestions.
  ///
  /// In en, this message translates to:
  /// **'By number of questions'**
  String get sortByQuestions;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @createTrainer.
  ///
  /// In en, this message translates to:
  /// **'Create Trainer'**
  String get createTrainer;

  /// No description provided for @mainInfo.
  ///
  /// In en, this message translates to:
  /// **'Main Info'**
  String get mainInfo;

  /// No description provided for @addQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get addQuestions;

  /// No description provided for @keywordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Keywords'**
  String get keywordsTitle;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @trainerTitle.
  ///
  /// In en, this message translates to:
  /// **'Trainer Title'**
  String get trainerTitle;

  /// No description provided for @trainerDescription.
  ///
  /// In en, this message translates to:
  /// **'Trainer Description'**
  String get trainerDescription;

  /// No description provided for @timeLimit.
  ///
  /// In en, this message translates to:
  /// **'Time limit (minutes)'**
  String get timeLimit;

  /// No description provided for @enterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter title'**
  String get enterTitle;

  /// No description provided for @enterTime.
  ///
  /// In en, this message translates to:
  /// **'Enter time'**
  String get enterTime;

  /// No description provided for @correctAnswer.
  ///
  /// In en, this message translates to:
  /// **'Correct Answer'**
  String get correctAnswer;

  /// No description provided for @addQuestionBtn.
  ///
  /// In en, this message translates to:
  /// **'Add Question'**
  String get addQuestionBtn;

  /// No description provided for @addedQuestions.
  ///
  /// In en, this message translates to:
  /// **'Added Questions'**
  String get addedQuestions;

  /// No description provided for @trainingResult.
  ///
  /// In en, this message translates to:
  /// **'Training Result'**
  String get trainingResult;

  /// No description provided for @correctAnswersCount.
  ///
  /// In en, this message translates to:
  /// **'Number of correct answers: {count}'**
  String correctAnswersCount(Object count);

  /// No description provided for @incorrectAnswersCount.
  ///
  /// In en, this message translates to:
  /// **'Number of incorrect answers: {count}'**
  String incorrectAnswersCount(Object count);

  /// No description provided for @congrats1.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You have successfully completed the trainer. Keep growing in your chosen field!'**
  String get congrats1;

  /// No description provided for @congrats2.
  ///
  /// In en, this message translates to:
  /// **'Great job! Now you have even more knowledge in your arsenal. Apply it with confidence!'**
  String get congrats2;

  /// No description provided for @congrats3.
  ///
  /// In en, this message translates to:
  /// **'You have completed the trainer. Don\'t forget that every question is a step towards your success!'**
  String get congrats3;

  /// No description provided for @congrats4.
  ///
  /// In en, this message translates to:
  /// **'Bravo! Now you are one step closer to mastery in this field. Keep it up!'**
  String get congrats4;

  /// No description provided for @congrats5.
  ///
  /// In en, this message translates to:
  /// **'Trainer completed successfully! Your efforts are bringing results. We are sure you are ready for new challenges!'**
  String get congrats5;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// No description provided for @cancelTrainingTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel training?'**
  String get cancelTrainingTitle;

  /// No description provided for @cancelTrainingContent.
  ///
  /// In en, this message translates to:
  /// **'All progress will be lost'**
  String get cancelTrainingContent;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @wellDone.
  ///
  /// In en, this message translates to:
  /// **'Well done!'**
  String get wellDone;

  /// No description provided for @showCorrectAnswer.
  ///
  /// In en, this message translates to:
  /// **'See the correct answer.'**
  String get showCorrectAnswer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
