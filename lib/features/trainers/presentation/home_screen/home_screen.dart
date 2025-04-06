import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/core/config/theme/app_colors.dart';
import 'package:training_trainer/core/config/routing/app_routes.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/presentation/home_screen/widgets/full_screen_trainer_card.dart';
import 'package:training_trainer/features/trainers/presentation/home_screen/widgets/trainer_card.dart';

class HomeScreen extends StatefulWidget {
  final List<Trainer> trainers;

  const HomeScreen({super.key, required this.trainers});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isCompactMode = true;
  final PageController _pageController = PageController();
  List<Trainer> _filteredTrainers = [];

  @override
  void initState() {
    super.initState();
    _filteredTrainers = widget.trainers;
  }

  void _toggleViewMode() {
    setState(() {
      _isCompactMode = !_isCompactMode;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  FloatingActionButton(
                      onPressed: () =>  context.push(AppRoutes.addTrainer),
                      // backgroundColor: brightness == Brightness.dark
                      //     ? colorForButton
                      //     : Colors.white,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        // color: brightness == Brightness.dark
                        //     ? Colors.white
                        //     : Colors.blue,
                        color: Colors.blue,
                      ),
                    ),
                  
      backgroundColor: AppColors.lightBackground,
      body: GestureDetector(
        onScaleUpdate: (details) {
          if (details.scale < 1) {
            // Уменьшение (переход в компактный режим)
            if (!_isCompactMode) {
              _toggleViewMode();
            }
          } else if (details.scale > 1) {
            // Увеличение (переход в полный экран)
            if (_isCompactMode) {
              _toggleViewMode();
            }
          }
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _isCompactMode ? _buildCompactView() : _buildFullScreenView(),
        ),
      ),
    );
  }

  Widget _buildCompactView() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.lightBackground,
            centerTitle: true,
            pinned: true,
            expandedHeight: 25.0.h,
            title: Text("Главная")),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final trainer = _filteredTrainers[index];
              return TrainerCard(trainer: trainer);
            },
            childCount: _filteredTrainers.length,
          ),
        ),
      ],
    );
  }

  Widget _buildFullScreenView() {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemCount: _filteredTrainers.length,
      itemBuilder: (context, index) {
        final trainer = _filteredTrainers[index];
        return FullScreenTrainerCard(trainer: trainer);
      },
    );
  }
}
