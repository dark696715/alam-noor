import 'package:flutter/foundation.dart';
import '../models/character.dart';
import '../models/subject_world.dart';
import '../models/user_progress.dart';

class ProgressProvider extends ChangeNotifier {
  UserProgress? _progress;

  UserProgress? get progress => _progress;
  bool get isInitialized => _progress != null;

  void initialize({
    required String childName,
    required GradeLevel grade,
    required Character character,
  }) {
    _progress = UserProgress(
      childName: childName,
      selectedGrade: grade,
      selectedCharacter: character,
    );
    notifyListeners();
  }

  void addStars(String worldId, int stars) {
    if (_progress == null) return;

    final current = _progress!.starsPerWorld[worldId] ?? 0;
    final newMap = Map<String, int>.from(_progress!.starsPerWorld);
    newMap[worldId] = current + stars;

    _progress = _progress!.copyWith(
      totalStars: _progress!.totalStars + stars,
      starsPerWorld: newMap,
    );
    notifyListeners();
  }

  void completeExercise(String exerciseId, {int stars = 5}) {
    if (_progress == null) return;
    if (_progress!.completedExercises.contains(exerciseId)) return;

    final list = List<String>.from(_progress!.completedExercises)..add(exerciseId);
    _progress = _progress!.copyWith(
      completedExercises: list,
      totalStars: _progress!.totalStars + stars,
    );
    notifyListeners();
  }

  void unlockCharacter(String characterId) {
    if (_progress == null) return;
    if (_progress!.unlockedCharacters.contains(characterId)) return;

    final list = List<String>.from(_progress!.unlockedCharacters)..add(characterId);
    _progress = _progress!.copyWith(unlockedCharacters: list);
    notifyListeners();
  }

  void changeCharacter(Character character) {
    if (_progress == null) return;
    _progress = _progress!.copyWith(selectedCharacter: character);
    notifyListeners();
  }

  void updateStreak() {
    if (_progress == null) return;
    final now = DateTime.now();
    final last = _progress!.lastPlayedDate;

    int newStreak = 1;
    if (last != null) {
      final diff = now.difference(last).inDays;
      if (diff == 1) {
        newStreak = _progress!.dailyStreak + 1;
      } else if (diff == 0) {
        newStreak = _progress!.dailyStreak;
      }
    }

    _progress = _progress!.copyWith(
      dailyStreak: newStreak,
      lastPlayedDate: now,
    );
    notifyListeners();
  }
}
