// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Training Trainer';

  @override
  String get authHeadingSignIn => 'С возвращением!';

  @override
  String get authHeadingSignUp => 'Создать аккаунт';

  @override
  String get authSubtitleSignIn => 'Войдите чтобы продолжить обучение';

  @override
  String get authSubtitleSignUp => 'Начните свой путь в обучении';

  @override
  String get usernameLabel => 'Имя пользователя';

  @override
  String get usernameHint => 'Придумайте имя пользователя';

  @override
  String get emailLabel => 'Эл. почта';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get passwordHint => 'Введите пароль';

  @override
  String get signIn => 'Войти';

  @override
  String get signUp => 'Регистрация';

  @override
  String get noAccount => 'Нет аккаунта? ';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт? ';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get invalidEmail => 'Пожалуйста, введите корректный email';

  @override
  String get invalidLogin => 'Логин должен содержать не менее 3 символов';

  @override
  String get invalidPassword => 'Пароль должен содержать не менее 6 символов';

  @override
  String get userNotAuthenticated => 'Пользователь не авторизован';

  @override
  String get createTrainer => 'Создать тренажер';

  @override
  String get mainInfo => 'Основная информация';

  @override
  String get modeStep => 'Режим';

  @override
  String get addQuestions => 'Вопросы';

  @override
  String get preview => 'Предпросмотр';

  @override
  String get next => 'Далее';

  @override
  String get back => 'Назад';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get exit => 'Выйти';

  @override
  String get trainerName => 'Название тренажера';

  @override
  String get trainerDescription => 'Описание';

  @override
  String get trainerTime => 'Время';

  @override
  String get trainingProcess => 'Процесс тренировки';

  @override
  String get selectAnswer => 'Выберите правильный ответ';

  @override
  String get confirmTitle => 'Закончить тренировку?';

  @override
  String get confirmContent => 'Убедитесь, что вы ответили на все вопросы';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get goodResult => 'Отличный результат!';

  @override
  String get normalResult => 'Можно лучше!';

  @override
  String get badResult => 'Сегодня не ваш день!';

  @override
  String get statRight => 'Верно';

  @override
  String get statWrong => 'Неверно';

  @override
  String get statUnanswered => 'Пропущено';

  @override
  String get congrats1 =>
      'Поздравляем! Вы успешно завершили тренажер. Продолжайте развиваться в выбранной области!';

  @override
  String get congrats2 =>
      'Отличная работа! Теперь у вас ещё больше знаний в вашем арсенале. Применяйте их с уверенностью!';

  @override
  String get congrats3 =>
      'Вы завершили тренажер. Не забывайте, что каждый вопрос - шаг к вашему успеху!';

  @override
  String get congrats4 =>
      'Браво! Теперь вы стали на шаг ближе к мастерству в этой области. Продолжайте в том же духе!';

  @override
  String get congrats5 =>
      'Тренажер пройден успешно! Ваши усилия приносят результаты. Уверены, что вы готовы к новым вызовам!';

  @override
  String get language => 'Язык';

  @override
  String get selectLanguage => 'Выберите язык';

  @override
  String get english => 'Английский';

  @override
  String get russian => 'Русский';

  @override
  String get cancelTrainingTitle => 'Прервать тренировку?';

  @override
  String get cancelTrainingContent => 'Весь прогресс будет потерян';

  @override
  String get ok => 'OK';

  @override
  String get wellDone => 'Молодец!';

  @override
  String get showCorrectAnswer => 'Посмотреть правильный ответ.';

  @override
  String get history => 'История';

  @override
  String get noHistoryYet => 'История пока пуста';

  @override
  String get noTrainersFound => 'Тренажеры не найдены';

  @override
  String get noTrainersHint =>
      'Попробуйте изменить поиск или создать новый тренажер';

  @override
  String foundTrainers(Object count) {
    return 'Найден $count тренажер';
  }

  @override
  String foundTrainersPlural(Object count) {
    return 'Найдено $count тренажеров';
  }

  @override
  String questionsCount(Object count) {
    return '$count вопросов';
  }

  @override
  String minutesShort(Object count) {
    return '$count мин';
  }

  @override
  String get rememberMe => 'Запомнить меня';

  @override
  String get questionCount => 'Количество вопросов';

  @override
  String get questionCountHint => 'Сколько вопросов сгенерировать?';

  @override
  String get describeTopic => 'Опишите тему';

  @override
  String get topicHint => 'Какой тренажер вы хотите создать?';

  @override
  String get generate => 'Сгенерировать';

  @override
  String get modeAutomatic => 'Автоматический';

  @override
  String get modeAutoDesc => 'Генерация вопросов через ИИ';

  @override
  String get modeManual => 'Ручной';

  @override
  String get modeManualDesc => 'Создание вопросов вручную';

  @override
  String get home => 'Главная';

  @override
  String get settings => 'Настройки';

  @override
  String get profile => 'Профиль';

  @override
  String get signOut => 'Выйти';

  @override
  String get darkTheme => 'Темная тема';

  @override
  String get appSettings => 'Настройки приложения';

  @override
  String get profileLoadError => 'Не удалось загрузить профиль';

  @override
  String get emptyFields => 'Пожалуйста, заполните все поля';

  @override
  String get enterTitle => 'Введите название тренажера';

  @override
  String get enterTime => 'Введите время в минутах';

  @override
  String get trainerTitle => 'Название тренажера';

  @override
  String get timeLimit => 'Ограничение времени';

  @override
  String get keywordsTitle => 'Ключевые слова';

  @override
  String get add => 'Добавить';

  @override
  String get question => 'Вопрос';

  @override
  String get correctAnswer => 'Правильный ответ';

  @override
  String get addQuestionBtn => 'Добавить вопрос';

  @override
  String get addedQuestions => 'Добавленные вопросы';

  @override
  String get searchHint => 'Поиск тренажеров...';

  @override
  String get sort => 'Сортировка';

  @override
  String get sorting => 'Сортировка';

  @override
  String get sortByTitle => 'По названию';

  @override
  String get sortByDate => 'По дате';

  @override
  String get sortByQuestions => 'По количеству вопросов';

  @override
  String get start => 'Начать';

  @override
  String get check => 'Проверить';

  @override
  String get continueText => 'Продолжить';

  @override
  String get correct => 'Верно!';

  @override
  String get error => 'Ошибка';

  @override
  String get resultDetail => 'Детали результата';

  @override
  String get greatJob => 'Отличная работа!';

  @override
  String get keepPracticing => 'Продолжайте тренироваться!';

  @override
  String get statCorrect => 'Верных';

  @override
  String get statTotal => 'Всего';

  @override
  String get backToHistory => 'Назад к истории';

  @override
  String get trainingResult => 'Результат тренировки';

  @override
  String correctAnswersCount(Object count) {
    return '$count верных';
  }

  @override
  String incorrectAnswersCount(Object count) {
    return '$count неверных';
  }

  @override
  String unansweredAnswersCount(Object count) {
    return '$count пропущено';
  }

  @override
  String get generatingStatus1 => 'Анализируем тему...';

  @override
  String get generatingStatus2 => 'Генерируем вопросы...';

  @override
  String get pleaseWait => 'Пожалуйста, подождите...';

  @override
  String get generatingStatus3 => 'Создаем варианты ответов...';

  @override
  String get generatingStatus4 => 'Формируем тренажер...';

  @override
  String get generatingStatus5 => 'Уже почти готово...';
}
