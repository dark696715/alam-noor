import 'character.dart';
import 'subject_world.dart';

class UserProgress {
  final String childName;
  final GradeLevel selectedGrade;
  final Character selectedCharacter;
  final int totalStars;
  final int totalKeys;
  final Map<String, int> starsPerWorld; // worldId -> stars
  final List<String> unlockedCharacters;
  final List<String> completedExercises;
  final int dailyStreak;
  final DateTime? lastPlayedDate;

  UserProgress({
    required this.childName,
    required this.selectedGrade,
    required this.selectedCharacter,
    this.totalStars = 0,
    this.totalKeys = 0,
    Map<String, int>? starsPerWorld,
    List<String>? unlockedCharacters,
    List<String>? completedExercises,
    this.dailyStreak = 0,
    this.lastPlayedDate,
  })  : starsPerWorld = starsPerWorld ?? {},
        unlockedCharacters = unlockedCharacters ?? ['noor', 'lina'],
        completedExercises = completedExercises ?? [];

  UserProgress copyWith({
    String? childName,
    GradeLevel? selectedGrade,
    Character? selectedCharacter,
    int? totalStars,
    int? totalKeys,
    Map<String, int>? starsPerWorld,
    List<String>? unlockedCharacters,
    List<String>? completedExercises,
    int? dailyStreak,
    DateTime? lastPlayedDate,
  }) {
    return UserProgress(
      childName: childName ?? this.childName,
      selectedGrade: selectedGrade ?? this.selectedGrade,
      selectedCharacter: selectedCharacter ?? this.selectedCharacter,
      totalStars: totalStars ?? this.totalStars,
      totalKeys: totalKeys ?? this.totalKeys,
      starsPerWorld: starsPerWorld ?? this.starsPerWorld,
      unlockedCharacters: unlockedCharacters ?? this.unlockedCharacters,
      completedExercises: completedExercises ?? this.completedExercises,
      dailyStreak: dailyStreak ?? this.dailyStreak,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
    );
  }

  String get title {
    if (totalStars >= 500) return 'أسطورة المعرفة';
    if (totalStars >= 300) return 'حكيم صغير';
    if (totalStars >= 150) return 'فارس العلم';
    if (totalStars >= 50) return 'مستكشف';
    return 'مبتدئ شجاع';
  }
}
