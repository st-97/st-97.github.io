/// Skill model representing technical skills
class SkillModel {
  final String name;
  final String iconPath;
  final int proficiency; // 1-100
  final String category;

  const SkillModel({
    required this.name,
    required this.iconPath,
    required this.proficiency,
    required this.category,
  });

  // Static data for skills
  static const List<SkillModel> skills = [
    // Mobile Development
    SkillModel(
      name: 'Flutter',
      iconPath: 'assets/icons/flutter.svg',
      proficiency: 95,
      category: 'Mobile',
    ),
    SkillModel(
      name: 'Dart',
      iconPath: 'assets/icons/dart.svg',
      proficiency: 90,
      category: 'Mobile',
    ),
    SkillModel(
      name: 'Firebase',
      iconPath: 'assets/icons/firebase.svg',
      proficiency: 85,
      category: 'Backend',
    ),
    
    // Web Development
    SkillModel(
      name: 'HTML/CSS',
      iconPath: 'assets/icons/html.svg',
      proficiency: 88,
      category: 'Web',
    ),
    SkillModel(
      name: 'JavaScript',
      iconPath: 'assets/icons/javascript.svg',
      proficiency: 82,
      category: 'Web',
    ),
    
    // Backend
    SkillModel(
      name: 'Node.js',
      iconPath: 'assets/icons/nodejs.svg',
      proficiency: 80,
      category: 'Backend',
    ),
    SkillModel(
      name: 'MongoDB',
      iconPath: 'assets/icons/mongodb.svg',
      proficiency: 78,
      category: 'Backend',
    ),
    
    // Tools & Others
    SkillModel(
      name: 'Git',
      iconPath: 'assets/icons/git.svg',
      proficiency: 85,
      category: 'Tools',
    ),
    SkillModel(
      name: 'AWS',
      iconPath: 'assets/icons/aws.svg',
      proficiency: 75,
      category: 'Cloud',
    ),
  ];

  // Get skills by category
  static List<SkillModel> getSkillsByCategory(String category) {
    return skills.where((skill) => skill.category == category).toList();
  }

  // Get all categories
  static List<String> getCategories() {
    return skills.map((skill) => skill.category).toSet().toList();
  }
}
