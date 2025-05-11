import 'package:training_trainer/features/trainers/domain/entities/question.dart';
import 'package:json_annotation/json_annotation.dart';
part 'trainer.g.dart';
@JsonSerializable()
class Trainer {
  final String id;
  final String userId;
  final double starCount;
  final int timeRequiredInSeconds;
  final String title;
  final List<Question> questions;
  final List<String> keywords;
  final String description;
  final DateTime createdAt;

  Trainer({
    required this.id,
    required this.starCount,
    required this.userId,
    required this.timeRequiredInSeconds,
    required this.title,
    this.questions = const [],
    this.keywords = const [],
    required this.description,
    DateTime? createdAt,
  })  : createdAt = createdAt ?? DateTime.now();
   factory Trainer.fromJson(Map<String, dynamic> json) => _$TrainerFromJson(json);

  /// Connect the generated [_$TrainerToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TrainerToJson(this);
  
  
  static List<Trainer> testTrainers = [
  Trainer(
    id: '1',
    starCount: 4.5,
    userId: 'user1',
    timeRequiredInSeconds: 300,
    title: 'Основы Dart',
    description: 'Изучите базовые концепции языка Dart для Flutter-разработки',
    keywords: ['программирование', 'Dart', 'новичкам'],
    questions: [
      Question(
        id: "1",
        textQuestion: 'Что такое Null Safety в Dart?',
        answers: [
          'Система типов, предотвращающая null-ошибки',
          'Способ ускорения работы приложения',
          'Метод сжатия данных'
        ],
        rightAnswer: "Что такое Null Safety в Dart?",
      ),
    ],
  ),
  Trainer(
    id: '2',
    starCount: 4.8,
    userId: 'user2',
    timeRequiredInSeconds: 420,
    title: 'Flutter Widgets',
    description: 'Освойте основные виджеты Flutter и их композицию',
    keywords: ['Flutter', 'UI', 'виджеты'],
    questions: [
       Question(
        id: "1",
        textQuestion: 'Что такое Null Safety в Dart?',
        answers: [
          'Система типов, предотвращающая null-ошибки',
          'Способ ускорения работы приложения',
          'Метод сжатия данных'
        ],
        rightAnswer: "Что такое Null Safety в Dart?",
      ),
    ],
  ),
  Trainer(
    id: '3',
    starCount: 4.2,
    userId: 'user3',
    timeRequiredInSeconds: 600,
    title: 'Работа с API',
    description: 'Научитесь делать HTTP-запросы и работать с REST API',
    keywords: ['сеть', 'HTTP', 'JSON'],
    questions: [
      Question(
        id: "1",
        textQuestion: 'Что такое Null Safety в Dart?',
        answers: [
          'Система типов, предотвращающая null-ошибки',
          'Способ ускорения работы приложения',
          'Метод сжатия данных'
        ],
        rightAnswer: "Что такое Null Safety в Dart?",
      ),
    ],
  ),
  Trainer(
    id: '4',
    starCount: 4.7,
    userId: 'user4',
    timeRequiredInSeconds: 480,
    title: 'State Management',
    description: 'Изучите различные подходы к управлению состоянием',
    keywords: ['BLoC', 'Provider', 'Riverpod'],
    questions: [
    Question(
        id: "1",
        textQuestion: 'Что такое Null Safety в Dart?',
        answers: [
          'Система типов, предотвращающая null-ошибки',
          'Способ ускорения работы приложения',
          'Метод сжатия данных'
        ],
        rightAnswer: "Что такое Null Safety в Dart?",
      ),
    ],
  ),
  Trainer(
    id: '5',
    starCount: 4.9,
    userId: 'user5',
    timeRequiredInSeconds: 720,
    title: 'Анимации в Flutter',
    description: 'Создавайте плавные и красивые анимации',
    keywords: ['анимации', 'UI', 'движение'],
    questions: [
     Question(
        id: "1",
        textQuestion: 'Что такое Null Safety в Dart?',
        answers: [
          'Система типов, предотвращающая null-ошибки',
          'Способ ускорения работы приложения',
          'Метод сжатия данных'
        ],
        rightAnswer: "Что такое Null Safety в Dart?",
      ),
    ],
  ),
  Trainer(
    id: '6',
    starCount: 4.3,
    userId: 'user6',
    timeRequiredInSeconds: 360,
    title: 'Тестирование приложений',
    description: 'Научитесь писать unit и widget тесты',
    keywords: ['тесты', 'качество', 'unit'],
    questions: [
       Question(
        id: "1",
        textQuestion: 'Что такое Null Safety в Dart?',
        answers: [
          'Система типов, предотвращающая null-ошибки',
          'Способ ускорения работы приложения',
          'Метод сжатия данных'
        ],
        rightAnswer: "Что такое Null Safety в Dart?",
      ),
    ],
  ),
];
Trainer copyWith({
    String? id,
    String? userId,
    double? starCount,
    int? timeRequiredInSeconds,
    String? title,
    List<Question>? questions,
    List<String>? keywords,
    String? description,
    DateTime? createdAt,
  }) {
    return Trainer(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      starCount: starCount ?? this.starCount,
      timeRequiredInSeconds: timeRequiredInSeconds ?? this.timeRequiredInSeconds,
      title: title ?? this.title,
      questions: questions ?? this.questions,
      keywords: keywords ?? this.keywords,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  }
  