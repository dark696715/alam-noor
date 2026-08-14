import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../models/character.dart';
import '../../models/subject_world.dart';
import '../../services/progress_provider.dart';
import '../../theme/app_theme.dart';
import '../home/home_screen.dart';

class CharacterSelectionScreen extends StatefulWidget {
  final GradeLevel selectedGrade;

  const CharacterSelectionScreen({
    super.key,
    required this.selectedGrade,
  });

  @override
  State<CharacterSelectionScreen> createState() =>
      _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen> {
  Character? selectedCharacter;
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableCharacters =
        AppCharacters.all.where((c) => c.isUnlocked).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('اختر بطلك'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
            child: Column(
              children: [
                Text(
                  'من سيكون رفيقك في المغامرة؟',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Name input
                TextField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                  decoration: InputDecoration(
                    hintText: 'اكتب اسمك هنا...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: availableCharacters.length,
              itemBuilder: (context, index) {
                final character = availableCharacters[index];
                final isSelected = selectedCharacter?.id == character.id;
                final color = Color(
                  int.parse(character.colorHex.replaceFirst('#', '0xFF')),
                );

                return GestureDetector(
                  onTap: () => setState(() => selectedCharacter = character),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: isSelected ? color.withOpacity(0.15) : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isSelected ? color : Colors.grey.shade200,
                        width: isSelected ? 3 : 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? color.withOpacity(0.3)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: isSelected ? 16 : 8,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Avatar circle
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: color,
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              character.id == 'noor'
                                  ? '🌟'
                                  : character.id == 'lina'
                                      ? '🌸'
                                      : character.id == 'karim'
                                          ? '⚔️'
                                          : character.id == 'sara'
                                              ? '🔬'
                                              : '🌙',
                              style: const TextStyle(fontSize: 42),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          character.nameAr,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isSelected ? color : AppColors.textPrimary,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            character.description,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 12,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: (100 * index).ms)
                    .scale(begin: const Offset(0.9, 0.9));
              },
            ),
          ),
          // Start button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: (selectedCharacter == null ||
                        _nameController.text.trim().isEmpty)
                    ? null
                    : () {
                        final name = _nameController.text.trim();
                        context.read<ProgressProvider>().initialize(
                              childName: name,
                              grade: widget.selectedGrade,
                              character: selectedCharacter!,
                            );

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                          (route) => false,
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
                  'انطلق في المغامرة! 🚀',
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
