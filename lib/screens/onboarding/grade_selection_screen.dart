import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/subject_world.dart';
import '../../theme/app_theme.dart';
import 'character_selection_screen.dart';

class GradeSelectionScreen extends StatefulWidget {
  const GradeSelectionScreen({super.key});

  @override
  State<GradeSelectionScreen> createState() => _GradeSelectionScreenState();
}

class _GradeSelectionScreenState extends State<GradeSelectionScreen> {
  GradeLevel? selectedGrade;

  final List<Map<String, dynamic>> grades = [
    {
      'level': GradeLevel.preparatory,
      'emoji': '🌱',
      'color': const Color(0xFF4ADE80),
      'subtitle': 'اكتشف الحروف والأرقام',
    },
    {
      'level': GradeLevel.grade1,
      'emoji': '📘',
      'color': const Color(0xFF60A5FA),
      'subtitle': 'بداية رحلة التعلم',
    },
    {
      'level': GradeLevel.grade2,
      'emoji': '📗',
      'color': const Color(0xFF34D399),
      'subtitle': 'نطور مهاراتنا',
    },
    {
      'level': GradeLevel.grade3,
      'emoji': '📙',
      'color': const Color(0xFFFBBF24),
      'subtitle': 'نصبح أكثر ذكاءً',
    },
    {
      'level': GradeLevel.grade4,
      'emoji': '📕',
      'color': const Color(0xFFF472B6),
      'subtitle': 'نتحدى أنفسنا',
    },
    {
      'level': GradeLevel.grade5,
      'emoji': '👑',
      'color': const Color(0xFFA78BFA),
      'subtitle': 'أبطال المعرفة',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('اختر مستواك'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Text(
              'في أي سنة دراسية أنت؟',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: grades.length,
              itemBuilder: (context, index) {
                final item = grades[index];
                final level = item['level'] as GradeLevel;
                final isSelected = selectedGrade == level;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedGrade = level),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (item['color'] as Color).withOpacity(0.15)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: isSelected
                              ? item['color'] as Color
                              : Colors.grey.shade200,
                          width: isSelected ? 2.5 : 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? (item['color'] as Color).withOpacity(0.25)
                                : Colors.black.withOpacity(0.04),
                            blurRadius: isSelected ? 16 : 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: (item['color'] as Color).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                item['emoji'] as String,
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  level.nameAr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? item['color'] as Color
                                            : AppColors.textPrimary,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['subtitle'] as String,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle_rounded,
                              color: item['color'] as Color,
                              size: 28,
                            ),
                        ],
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: (80 * index).ms)
                    .slideX(begin: 0.1, end: 0);
              },
            ),
          ),
          // Continue button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: selectedGrade == null
                    ? null
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CharacterSelectionScreen(
                              selectedGrade: selectedGrade!,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  'التالي',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
