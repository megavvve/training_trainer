import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_trainer/domain/models/question.dart';
import 'package:training_trainer/domain/models/question_from_code_war.dart';
import 'package:training_trainer/domain/repositories/question_repo.dart';
import 'package:http/http.dart' as http;

class QuestionRepoImpl implements QuestionRepo {
  @override
  Future<QuestionFromCodeWars?> fetchQuestion() async {
    final response = await http.get(Uri.parse(
        'https://fakestoreapi.com/products/3'));
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return QuestionFromCodeWars.fromJson(data);

    } 
  }

  @override
  Future<List<Question>> fetchAllQuestions() {
   
    throw UnimplementedError();
  }
}
