class Character {
  final String id;
  final String nameAr;
  final String nameEn;
  final String description;
  final String imagePath;
  final String colorHex;
  final bool isUnlocked;
  final int requiredStars;

  const Character({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.description,
    required this.imagePath,
    required this.colorHex,
    this.isUnlocked = false,
    this.requiredStars = 0,
  });

  Character copyWith({bool? isUnlocked}) {
    return Character(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      description: description,
      imagePath: imagePath,
      colorHex: colorHex,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      requiredStars: requiredStars,
    );
  }
}

class AppCharacters {
  static const List<Character> all = [
    Character(
      id: 'noor',
      nameAr: 'نور',
      nameEn: 'Noor',
      description: 'البطل الأساسي، شجاع وفضولي يحب التعلم!',
      imagePath: 'assets/images/characters/noor.png',
      colorHex: '#6C63FF',
      isUnlocked: true,
      requiredStars: 0,
    ),
    Character(
      id: 'lina',
      nameAr: 'لينا',
      nameEn: 'Lina',
      description: 'فتاة ذكية تحب القصص والحروف',
      imagePath: 'assets/images/characters/lina.png',
      colorHex: '#FF6B9D',
      isUnlocked: true,
      requiredStars: 0,
    ),
    Character(
      id: 'karim',
      nameAr: 'كريم',
      nameEn: 'Karim',
      description: 'مغامر يحب الأرقام والرياضيات',
      imagePath: 'assets/images/characters/karim.png',
      colorHex: '#4ECDC4',
      isUnlocked: false,
      requiredStars: 50,
    ),
    Character(
      id: 'sara',
      nameAr: 'سارة',
      nameEn: 'Sara',
      description: 'عالمة صغيرة تحب التجارب العلمية',
      imagePath: 'assets/images/characters/sara.png',
      colorHex: '#45B7D1',
      isUnlocked: false,
      requiredStars: 100,
    ),
    Character(
      id: 'youssef',
      nameAr: 'يوسف',
      nameEn: 'Youssef',
      description: 'فارس الحكمة، يحب التربية الإسلامية',
      imagePath: 'assets/images/characters/youssef.png',
      colorHex: '#98D8C8',
      isUnlocked: false,
      requiredStars: 150,
    ),
  ];
}
