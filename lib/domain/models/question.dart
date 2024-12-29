abstract class Question {
  final String id;

  final String name;

  final String description;

  final String url;

  final String rank;

  Question({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.rank,
  });

  String get rightAnswer;

  List<String> get incorrectAnswers;
}
