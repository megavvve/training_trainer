import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:training_trainer/features/trainers/domain/entities/trainer.dart';

class HomeScreen extends StatefulWidget {
  final List<Trainer> trainers;

  const HomeScreen({super.key, required this.trainers});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isCompactMode = true;
  final TextEditingController _searchController = TextEditingController();
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

  void _filterTrainers(String query) {
    setState(() {
      _filteredTrainers = widget.trainers.where((trainer) {
        return trainer.title.toLowerCase().contains(query.toLowerCase()) ||
            trainer.keywords.any((keyword) =>
                keyword.toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }

  Widget _buildCompactView() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 50.0.h,
          flexibleSpace: FlexibleSpaceBar(
            title: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск тренажеров...',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white.withOpacity(0.9),
              ),
              onChanged: _filterTrainers,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final trainer = _filteredTrainers[index];
              return _TrainerCard(trainer: trainer);
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
        return _FullScreenTrainerCard(trainer: trainer);
      },
    );
  }
}

class _TrainerCard extends StatelessWidget {
  final Trainer trainer;

  const _TrainerCard({required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 15.h),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200.w,
                  child: Text(
                    trainer.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Chip(
                  label: Text('${trainer.timeRequiredInSeconds ~/ 60} мин'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0.w,
              children: trainer.keywords
                  .map(
                    (keyword) => Chip(
                      label: Text(keyword),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            Text(
              trainer.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text('${trainer.starCount.toStringAsFixed(1)}/5.0'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FullScreenTrainerCard extends StatelessWidget {
  final Trainer trainer;

  const _FullScreenTrainerCard({required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade800, Colors.blue.shade200],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              trainer.title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.sp),
              ),
              child: Center(
                child: Text(
                  '${trainer.questions.length} вопросов',
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12.0.w,
              children: [
                Column(
                  children: [
                    Icon(Icons.timer, color: Colors.white, size: 32.h),
                    Text(
                      '${trainer.timeRequiredInSeconds ~/ 60} мин',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 32.h),
                    Text(
                      trainer.starCount.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
              ),
              onPressed: () {},
              child: Text(
                'Начать тренировку',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
