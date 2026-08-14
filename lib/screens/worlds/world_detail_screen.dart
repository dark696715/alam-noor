import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../models/subject_world.dart';
import '../../services/progress_provider.dart';
import '../../theme/app_theme.dart';
import '../exercises/exercise_screen.dart';

class WorldDetailScreen extends StatelessWidget {
  final SubjectWorld world;

  const WorldDetailScreen({super.key, required this.world});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>().progress;
    final grade = progress?.selectedGrade ?? GradeLevel.grade1;

    // Sample activities for demonstration
    final activities = _getSampleActivities(world.id, grade);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App bar with world color
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: world.color,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                world.nameAr,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      world.color,
                      world.color.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    world.icon,
                    style: const TextStyle(fontSize: 80),
                  ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                ),
              ),
            ),
          ),

          // Description
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    world.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 20),
                  // Progress
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: world.progress,
                            backgroundColor: world.color.withOpacity(0.15),
                            valueColor: AlwaysStoppedAnimation(world.color),
                            minHeight: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${(world.progress * 100).toInt()}%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: world.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'الأنشطة والتمارين',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),

          // Activities list
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final activity = activities[index];
                  return _ActivityCard(
                    activity: activity,
                    worldColor: world.color,
                    index: index,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ExerciseScreen(
                            activity: activity,
                            worldColor: world.color,
                            worldId: world.id,
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: activities.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSampleActivities(
      String worldId, GradeLevel grade) {
    // Demo content - in real app this comes from a database / JSON
    switch (worldId) {
      case 'arabic':
        return [
          {
            'id': 'ar_1',
            'title': 'تعلم الحروف',
            'subtitle': 'اكتب وردد الحروف الهجائية',
            'emoji': '🔤',
            'type': 'interactive',
            'stars': 10,
            'duration': '5 دقائق',
          },
          {
            'id': 'ar_2',
            'title': 'قصة الأرنب الذكي',
            'subtitle': 'قصة تفاعلية مصورة',
            'emoji': '📖',
            'type': 'story',
            'stars': 15,
            'duration': '8 دقائق',
          },
          {
            'id': 'ar_3',
            'title': 'كلمات متقاطعة',
            'subtitle': 'كوّن كلمات من الحروف',
            'emoji': '🧩',
            'type': 'game',
            'stars': 12,
            'duration': '6 دقائق',
          },
          {
            'id': 'ar_4',
            'title': 'فيديو: قواعد بسيطة',
            'subtitle': 'درس مرئي ممتع',
            'emoji': '🎬',
            'type': 'video',
            'stars': 8,
            'duration': '4 دقائق',
          },
        ];
      case 'math':
        return [
          {
            'id': 'math_1',
            'title': 'العد حتى 20',
            'subtitle': 'تعلم العد بطريقة ممتعة',
            'emoji': '🔢',
            'type': 'interactive',
            'stars': 10,
            'duration': '5 دقائق',
          },
          {
            'id': 'math_2',
            'title': 'جمع الأرقام',
            'subtitle': 'تمارين جمع تفاعلية',
            'emoji': '➕',
            'type': 'exercise',
            'stars': 15,
            'duration': '7 دقائق',
          },
          {
            'id': 'math_3',
            'title': 'لعبة الذاكرة الحسابية',
            'subtitle': 'طابق العمليات مع النتائج',
            'emoji': '🧠',
            'type': 'game',
            'stars': 12,
            'duration': '6 دقائق',
          },
        ];
      default:
        return [
          {
            'id': '${worldId}_1',
            'title': 'درس تفاعلي',
            'subtitle': 'ابدأ التعلم الآن',
            'emoji': '✨',
            'type': 'interactive',
            'stars': 10,
            'duration': '5 دقائق',
          },
          {
            'id': '${worldId}_2',
            'title': 'فيديو تعليمي',
            'subtitle': 'شاهد وتعلم',
            'emoji': '🎬',
            'type': 'video',
            'stars': 8,
            'duration': '4 دقائق',
          },
          {
            'id': '${worldId}_3',
            'title': 'تمرين سريع',
            'subtitle': 'اختبر معلوماتك',
            'emoji': '📝',
            'type': 'exercise',
            'stars': 12,
            'duration': '6 دقائق',
          },
        ];
    }
  }
}

class _ActivityCard extends StatelessWidget {
  final Map<String, dynamic> activity;
  final Color worldColor;
  final int index;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.activity,
    required this.worldColor,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 3,
        shadowColor: worldColor.withOpacity(0.15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: worldColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      activity['emoji'] as String,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['title'] as String,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activity['subtitle'] as String,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.star_rounded,
                              size: 16, color: Colors.amber.shade600),
                          const SizedBox(width: 4),
                          Text(
                            '${activity['stars']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.amber.shade700,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.timer_outlined,
                              size: 15, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            activity['duration'] as String,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: worldColor,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: (70 * index).ms).slideX(begin: 0.05);
  }
}
