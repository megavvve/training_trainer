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
  String get home => 'Главная';

  @override
  String get profile => 'Профиль';

  @override
  String get profileLabel => 'Ваш профиль';

  @override
  String get appSettings => 'Настройки приложения';

  @override
  String get settings => 'Настройки';

  @override
  String get signOut => 'Выйти';

  @override
  String get darkTheme => 'Темная тема';

  @override
  String get next => 'Далее';

  @override
  String get signIn => 'Войти';

  @override
  String get signUp => 'Зарегистрироваться';

  @override
  String get authHeadingSignUp => 'Регистрация';

  @override
  String get authHeadingSignIn => 'Вход';

  @override
  String get authSubtitleSignUp => 'Создайте аккаунт, чтобы начать обучение';

  @override
  String get authSubtitleSignIn => 'Войдите в свой аккаунт';

  @override
  String get forRegistration => 'для регистрации';

  @override
  String get forSignIn => 'для входа';

  @override
  String get invalidEmail => 'Некорректный email';

  @override
  String get emptyFields => 'Поля ввода не заполнены';

  @override
  String get userNotAuthenticated => 'Пользователь не аутентифицирован';

  @override
  String get unknownError => 'Неизвестная ошибка';

  @override
  String get accessForbidden => 'Доступ запрещен';

  @override
  String get resourceNotFound => 'Ресурс не найден';

  @override
  String get passwordRequirement =>
      'Пароль должен содержать минимум 8 символов, включая буквы и цифры';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт?';

  @override
  String get noAccount => 'Нет аккаунта?';

  @override
  String get emailLabel => 'почта';

  @override
  String get profileLoadError => 'Ошибка загрузки профиля';

  @override
  String get addTrainerError => 'Ошибка добавления тренажера';

  @override
  String get deleteTrainerError => 'Ошибка удаления тренажера';

  @override
  String get searchHint => 'Поиск по названию...';

  @override
  String foundElements(Object count) {
    return 'Найдено элементов: $count';
  }

  @override
  String get sorting => 'Сортировка';

  @override
  String get sortByTitle => 'По названию (А-Я)';

  @override
  String get sortByDate => 'По дате создания';

  @override
  String get sortByQuestions => 'По количеству вопросов';

  @override
  String get sort => 'Сортировать';

  @override
  String get createTrainer => 'Создание тренажера';

  @override
  String get mainInfo => 'Осн. инфо';

  @override
  String get addQuestions => 'Вопросы';

  @override
  String get keywordsTitle => 'Ключевые слова';

  @override
  String get preview => 'Просмотр';

  @override
  String get back => 'Назад';

  @override
  String get save => 'Сохранить';

  @override
  String get add => 'Добавить';

  @override
  String get question => 'Вопрос';

  @override
  String get start => 'Начать';

  @override
  String get continueText => 'Продолжить';

  @override
  String get check => 'Проверка';

  @override
  String get correct => 'Правильно!';

  @override
  String get error => 'Ошибка';

  @override
  String get cancel => 'Отмена';

  @override
  String get exit => 'Выйти';

  @override
  String get trainerTitle => 'Название тренажера';

  @override
  String get trainerDescription => 'Описание тренажера';

  @override
  String get timeLimit => 'Время на прохождение (минуты)';

  @override
  String get enterTitle => 'Введите название';

  @override
  String get enterTime => 'Введите время';

  @override
  String get correctAnswer => 'Правильный ответ';

  @override
  String get addQuestionBtn => 'Добавить вопрос';

  @override
  String get addedQuestions => 'Добавленные вопросы';

  @override
  String get trainingResult => 'Результат тренировки';

  @override
  String correctAnswersCount(Object count) {
    return 'Количество правильных ответов: $count';
  }

  @override
  String incorrectAnswersCount(Object count) {
    return 'Количество неправильных ответов: $count';
  }

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
}
