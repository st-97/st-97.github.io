/// Service model representing what I do sections
class ServiceModel {
  final String title;
  final String description;
  final String iconPath;
  final List<String> technologies;

  const ServiceModel({
    required this.title,
    required this.description,
    required this.iconPath,
    this.technologies = const [],
  });

  // Static data for services
  static const List<ServiceModel> services = [
    ServiceModel(
      title: 'Mobile Apps',
      description: 'Professional development of applications for Android and iOS.',
      iconPath: 'assets/icons/mobile.svg',
      technologies: ['Flutter', 'Dart', 'Firebase', 'REST APIs'],
    ),
    ServiceModel(
      title: 'Web Development',
      description: 'High-quality development of sites at the professional level.',
      iconPath: 'assets/icons/web.svg',
      technologies: ['Flutter Web', 'HTML/CSS', 'JavaScript', 'Responsive Design'],
    ),
    ServiceModel(
      title: 'UI/UX Design',
      description: 'The most modern and high-quality design made at a professional level.',
      iconPath: 'assets/icons/design.svg',
      technologies: ['Figma', 'Adobe XD', 'Material Design', 'Human Interface'],
    ),
    ServiceModel(
      title: 'Backend Development',
      description: 'High-performance backend services designed for scalability and seamless user experience.',
      iconPath: 'assets/icons/backend.svg',
      technologies: ['Node.js', 'MongoDB', 'AWS', 'Docker'],
    ),
  ];
}
