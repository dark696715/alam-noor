import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:provider/provider.dart';
import '../../services/progress_provider.dart';
import '../../theme/app_theme.dart';

class ExerciseScreen extends StatefulWidget {
  final Map<String, dynamic> activity;
  final Color worldColor;
  final String worldId;

  const ExerciseScreen({
    super.key,
    required this.activity,
    required this.worldColor,
    required this.worldId,
  });

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late ConfettiController _confettiController;
  int currentQuestion = 0;
  int score = 0;
  bool answered = false;
  int? selectedAnswer;
  bool finished = false;

  // Sample questions for demo
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'ما هو الحرف الأول من كلمة "كتاب"؟',
      'options': ['ك', 'ت', 'ا', 'ب'],
      'correct': 0,
      'emoji': '📚',
    },
    {
      'question': 'كم يساوي 2 + 3؟',
      'options': ['4', '5', '6', '7'],
      'correct': 1,
      'emoji': '🔢',
    },
    {
      'question': 'ما لون السماء في النهار؟',
      'options': ['أحمر', 'أخضر', 'أزرق', 'أصفر'],
      'correct': 2,
      'emoji': '🌤️',
    },
  ];

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _checkAnswer(int index) {
    if (answered) return;
    setState(() {
      selectedAnswer = index;
      answered = true;
      if (index == questions[currentQuestion]['correct']) {
        score += 5;
      }
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
          answered = false;
          selectedAnswer = null;
        });
      } else {
        setState(() => finished = true);
        _confettiController.play();
        // Save progress
        context.read<ProgressProvider>().completeExercise(
              widget.activity['id'] as String,
              stars: score,
            );
        context.read<ProgressProvider>().addStars(widget.worldId, score);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.activity['title'] as String),
        backgroundColor: widget.worldColor.withOpacity(0.1),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          if (!finished) _buildQuestionView(),
          if (finished) _buildResultView(),
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionView() {
    final q = questions[currentQuestion];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Progress
          Row(
            children: List.generate(questions.length, (i) {
              return Expanded(
                child: Container(
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: i <= currentQuestion
                        ? widget.worldColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          Text(
            'سؤال ${currentQuestion + 1} من ${questions.length}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),

          // Question card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: widget.worldColor.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  q['emoji'] as String,
                  style: const TextStyle(fontSize: 56),
                ),
                const SizedBox(height: 20),
                Text(
                  q['question'] as String,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95)),

          const SizedBox(height: 32),

          // Options
          ...List.generate(q['options'].length, (index) {
            final isCorrect = index == q['correct'];
            final isSelected = selectedAnswer == index;

            Color bgColor = Colors.white;
            Color borderColor = Colors.grey.shade200;
            Color textColor = AppColors.textPrimary;

            if (answered) {
              if (isCorrect) {
                bgColor = AppColors.success.withOpacity(0.15);
                borderColor = AppColors.success;
                textColor = AppColors.success;
              } else if (isSelected && !isCorrect) {
                bgColor = AppColors.error.withOpacity(0.15);
                borderColor = AppColors.error;
                textColor = AppColors.error;
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => _checkAnswer(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: borderColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: borderColor.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            String.fromCharCode(0x0660 + index + 1), // Arabic numbers
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        q['options'][index] as String,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const Spacer(),
                      if (answered && isCorrect)
                        const Icon(Icons.check_circle, color: AppColors.success),
                      if (answered && isSelected && !isCorrect)
                        const Icon(Icons.cancel, color: AppColors.error),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(delay: (80 * index).ms).slideX(begin: 0.08);
          }),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    final starsEarned = score;
    final isPerfect = score == questions.length * 5;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isPerfect ? '🎉' : '🌟',
              style: const TextStyle(fontSize: 80),
            ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
            const SizedBox(height: 24),
            Text(
              isPerfect ? 'ممتاز جداً!' : 'أحسنت!',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: widget.worldColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'لقد ربحت $starsEarned نجوم ⭐',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'النقاط: $score / ${questions.length * 5}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.worldColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  'العودة إلى العالم',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
