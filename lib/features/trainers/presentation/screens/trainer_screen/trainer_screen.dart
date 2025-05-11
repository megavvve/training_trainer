import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:training_trainer/constants/app_colors.dart';
import 'package:training_trainer/core/config/theme/cubit/theme_cubit.dart';
import 'package:training_trainer/core/di/injection_container.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';
import 'package:training_trainer/features/trainers/domain/repositories/trainiers_repository.dart';
import 'package:training_trainer/features/trainers/presentation/providers/trainers_bloc/trainers_bloc.dart';
import 'package:training_trainer/features/trainers/presentation/screens/trainer_screen/widget/trainer_card.dart';
import 'package:training_trainer/routing/app_routes.dart';
import 'package:training_trainer/uikit/appbars/big_app_bar.dart';
import 'package:training_trainer/uikit/modal/custom_modal_bottom_sheet.dart';

class TrainerScreen extends StatefulWidget {
  const TrainerScreen({super.key});

  @override
  State<TrainerScreen> createState() => _TrainerScreenState();
}

class _TrainerScreenState extends State<TrainerScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider<TrainersBloc>(
      create: (context) => TrainersBloc(repository: getIt<TrainersRepository>())
        ..add(LoadTrainers()),
      child: BlocBuilder<TrainersBloc, TrainersState>(
        builder: (context, state) {
          if (state is TrainersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TrainersLoadSuccess) {
            final brightness = context.watch<ThemeCubit>().state.brightness;
            List<Trainer> trainerList = 
                state.trainers.where((element) => element.questions.isNotEmpty).toList();

            return Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    title: BigAppBar(title: 'Главная',),
                    
                    pinned: true,
                    snap: false,
                    floating: true,
                    surfaceTintColor: Colors.transparent,
                   
                   
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                       
                    _buildSearchField(brightness, theme,context),
                
                _buildSortingRow(brightness, theme, context),
                 
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) =>
                          TrainerCard(trainer: trainerList[index]),
                      childCount: trainerList.length,
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height:30.h),),
                ],
              ),
              
              floatingActionButton: _buildFAB(brightness),
            );
          } else if (state is TrainersLoadFailure) {
            return Center(child: Text(state.error));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildSearchField(Brightness brightness, ThemeData theme,BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: brightness == Brightness.dark 
              ? colorForMaterialCardDark 
              : Colors.white,
          hintText: 'Поиск по названию...',
          prefixIcon: Icon(Icons.search, color: theme.hintColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        style: theme.textTheme.bodyMedium,
        onChanged: (value) {
        
          context.read<TrainersBloc>().add(SearchTrainers(query: value));
        },
      ),
    );
  }

  Widget _buildSortingRow(Brightness brightness, ThemeData theme, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Найдено элементов: ${context.read<TrainersBloc>().filteredTrainers.length}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: brightness == Brightness.dark 
                    ? Colors.white70 
                    : Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 36.h,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: brightness == Brightness.dark 
                    ? colorForButton 
                    : mainColorLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
              ),
              onPressed: () => _showSortingModal(context),
              icon: Icon(Icons.sort, size: 18.sp),
              label: Text(
                'Сортировка',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB(Brightness brightness) {
    return SizedBox(
      width: 60.w,
      height: 60.h,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () => context.push(AppRoutes.addTrainer),
          backgroundColor: brightness == Brightness.dark 
              ? colorForButton 
              : Colors.white,
          child: Icon(
            Icons.add,
            color: brightness == Brightness.dark 
                ? Colors.white 
                : Colors.blue,
          ),
        ),
      ),
    );
  }

  void _showSortingModal(BuildContext context) {
  showCustomBottomSheet(
    context: context,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            "Сортировать",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
          ),
        ),
        _buildSortOption('По названию (А-Я)', Icons.sort_by_alpha, 'title',context),
        _buildSortOption('По дате создания', Icons.date_range, 'createdAt',context),
        _buildSortOption('По количеству вопросов', Icons.format_list_numbered, 'questions',context),
        SizedBox(height: 16.h),
      ],
    ),
  );
}

Widget _buildSortOption(String title, IconData icon, String sortBy,BuildContext context) {
  return ListTile(
    leading: Icon(icon, size: 24.sp),
    title: Text(title, style: TextStyle(fontSize: 16.sp)),
    onTap: () {
      context.read<TrainersBloc>().add(SortTrainers(sortBy: sortBy));
      context.pop();  
    },
  );
}

}