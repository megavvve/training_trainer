import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/features/questions/data/models/repositories/question_repo_impl.dart';
import 'package:training_trainer/features/questions/presentation/bloc/question_list_bloc.dart';
import 'package:training_trainer/core/utils/routing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final f = await Firebase.initializeApp();
  print(f.name);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuestionListBloc(
            questionRepo: QuestionRepoImpl(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            initialRoute: '/',
            routes: routes,
          );
        },
      ),
    );
  }
}
