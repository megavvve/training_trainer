import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_trainer/domain/models/question.dart';
import 'package:training_trainer/presentation/bloc/question_list_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Тренажеры"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'dsds',
        onPressed: () {
          context.read<QuestionListBloc>().add(LoadQuestionsEvent());
        },
        child: const Icon(Icons.refresh),
      ),
      body: BlocBuilder<QuestionListBloc, QuestionListState>(
        builder: (context, state) {
          if (state is QuestionListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuestionListLoadedState) {
            return ListView.builder(
              itemCount: state.questions.length,
              itemBuilder: (context, index) {
                final question = state.questions[index];
                return ListTile(
                  title: Text(question.name),
                  subtitle: Text(question.description),
                );
              },
            );
          } else if (state is QuestionListErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(child: Text("Неизвестное состояние"));
          }
        },
      ),
    );
  }
}