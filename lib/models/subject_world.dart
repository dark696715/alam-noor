import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum GradeLevel {
  preparatory, // تحضيري
  grade1,
  grade2,
  grade3,
  grade4,
  grade5,
}

extension GradeLevelExt on GradeLevel {
  String get nameAr {
    switch (this) {
      case GradeLevel.preparatory:
        return 'السنة التحضيرية';
      case GradeLevel.grade1:
        return 'السنة الأولى';
      case GradeLevel.grade2:
        return 'السنة الثانية';
      case GradeLevel.grade3:
        return 'السنة الثالثة';
      case GradeLevel.grade4:
        return 'السنة الرابعة';
      case GradeLevel.grade5:
        return 'السنة الخامسة';
    }
  }

  String get shortName {
    switch (this) {
      case GradeLevel.preparatory:
        return 'تحضيري';
      case GradeLevel.grade1:
        return '1';
      case GradeLevel.grade2:
        return '2';
      case GradeLevel.grade3:
        return '3';
      case GradeLevel.grade4:
        return '4';
      case GradeLevel.grade5:
        return '5';
    }
  }
}

class SubjectWorld {
  final String id;
  final String nameAr;
  final String nameEn;
  final String description;
  final String icon;
  final Color color;
  final String imagePath;
  final List<GradeLevel> availableGrades;
  final int totalStars;
  final int earnedStars;
  final bool isUnlocked;

  const SubjectWorld({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.description,
    required this.icon,
    required this.color,
    required this.imagePath,
    required this.availableGrades,
    this.totalStars = 100,
    this.earnedStars = 0,
    this.isUnlocked = true,
  });

  double get progress => totalStars == 0 ? 0 : earnedStars / totalStars;

  SubjectWorld copyWith({int? earnedStars, bool? isUnlocked}) {
    return SubjectWorld(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      description: description,
      icon: icon,
      color: color,
      imagePath: imagePath,
      availableGrades: availableGrades,
      totalStars: totalStars,
      earnedStars: earnedStars ?? this.earnedStars,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}

class AppWorlds {
  static final List<SubjectWorld> all = [
    SubjectWorld(
      id: 'arabic',
      nameAr: 'عالم الحروف',
      nameEn: 'Arabic World',
      description: 'تعلم القراءة والكتابة والقصص الممتعة',
      icon: '📚',
      color: AppColors.arabicWorld,
      imagePath: 'assets/images/worlds/arabic.png',
      availableGrades: GradeLevel.values,
      totalStars: 120,
    ),
    SubjectWorld(
      id: 'math',
      nameAr: 'قلعة الأرقام',
      nameEn: 'Math Castle',
      description: 'مغامرات مع الأرقام والعمليات الحسابية',
      icon: '🔢',
      color: AppColors.mathWorld,
      imagePath: 'assets/images/worlds/math.png',
      availableGrades: GradeLevel.values,
      totalStars: 150,
    ),
    SubjectWorld(
      id: 'science',
      nameAr: 'مختبر العلوم',
      nameEn: 'Science Lab',
      description: 'تجارب علمية ممتعة واكتشافات',
      icon: '🔬',
      color: AppColors.scienceWorld,
      imagePath: 'assets/images/worlds/science.png',
      availableGrades: [
        GradeLevel.grade1,
        GradeLevel.grade2,
        GradeLevel.grade3,
        GradeLevel.grade4,
        GradeLevel.grade5,
      ],
      totalStars: 100,
    ),
    SubjectWorld(
      id: 'french',
      nameAr: 'مدينة الفرنسية',
      nameEn: 'French City',
      description: 'تعلم الفرنسية بطريقة ممتعة',
      icon: '🇫🇷',
      color: AppColors.frenchWorld,
      imagePath: 'assets/images/worlds/french.png',
      availableGrades: GradeLevel.values,
      totalStars: 110,
    ),
    SubjectWorld(
      id: 'islamic',
      nameAr: 'حديقة الإيمان',
      nameEn: 'Faith Garden',
      description: 'تعلم القيم والآيات والأدعية',
      icon: '🌙',
      color: AppColors.islamicWorld,
      imagePath: 'assets/images/worlds/islamic.png',
      availableGrades: GradeLevel.values,
      totalStars: 80,
    ),
    SubjectWorld(
      id: 'history',
      nameAr: 'رحلة التاريخ',
      nameEn: 'History Journey',
      description: 'اكتشف قصص الماضي والحضارات',
      icon: '🏛️',
      color: AppColors.historyWorld,
      imagePath: 'assets/images/worlds/history.png',
      availableGrades: [
        GradeLevel.grade3,
        GradeLevel.grade4,
        GradeLevel.grade5,
      ],
      totalStars: 70,
    ),
  ];
}
