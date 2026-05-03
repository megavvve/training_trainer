// import 'package:training_trainer/core/network/rest_client.dart';
// import 'package:training_trainer/core/services/ai/ai_generator_interface.dart';

// class RestAIGenerator implements AIGenerator {
//   final RestClient _restClient;

//   RestAIGenerator(this._restClient);

//   @override
//   Future<void> initialize() async {
//     // No initialization needed for REST API
//   }

//   @override
//   Future<List<String>> generateWrongAnswers({
//     required String question,
//     required String correctAnswer,
//     int count = 3,
//   }) async {
//     final response = await _restClient.post(
//       '/ai/wrong-answers',
//       data: {
//         'question': question,
//         'correct_answer': correctAnswer,
//         'count': count,
//       },
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> wrongAnswers = response.data['wrong_answers'];
//       return wrongAnswers.cast<String>();
//     } else {
//       throw Exception('Failed to generate wrong answers');
//     }
//   }

//   @override
//   Future<List<String>> generateKeywords({
//     required String text,
//     int count = 5,
//   }) async {
//     final response = await _restClient.post(
//       '/ai/keywords',
//       data: {
//         'text': text,
//         'count': count,
//       },
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> keywords = response.data['keywords'];
//       return keywords.cast<String>();
//     } else {
//       throw Exception('Failed to generate keywords');
//     }
//   }

//   @override
//   void dispose() {
//     // No resources to dispose
//   }
// }
