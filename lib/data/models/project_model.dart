/// Project model representing portfolio projects
class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String shortDescription;
  final List<String> images;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final ProjectCategory category;
  final DateTime createdAt;
  final bool isFeatured;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.images,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.playStoreUrl,
    this.appStoreUrl,
    required this.category,
    required this.createdAt,
    this.isFeatured = false,
  });

  // Static data for projects
  static final List<ProjectModel> projects = [
    ProjectModel(
      id: '1',
      title: 'E-Commerce Mobile App',
      shortDescription: 'Complete shopping app with payment integration',
      description: 'A full-featured e-commerce mobile application built with Flutter. Features include user authentication, product catalog, shopping cart, payment integration with Stripe, order tracking, and admin panel.',
      images: [
        'assets/images/projects/ecommerce_1.jpg',
        'assets/images/projects/ecommerce_2.jpg',
        'assets/images/projects/ecommerce_3.jpg',
      ],
      technologies: ['Flutter', 'Firebase', 'Stripe', 'REST API'],
      githubUrl: 'https://github.com/aakash/ecommerce-app',
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.example.ecommerce',
      category: ProjectCategory.mobile,
      createdAt: DateTime(2024, 1, 15),
      isFeatured: true,
    ),
    ProjectModel(
      id: '2',
      title: 'Portfolio Website',
      shortDescription: 'Responsive portfolio website with modern design',
      description: 'A responsive portfolio website built with Flutter Web. Features include smooth animations, responsive design, contact form, blog integration, and SEO optimization.',
      images: [
        'assets/images/projects/portfolio_1.jpg',
        'assets/images/projects/portfolio_2.jpg',
      ],
      technologies: ['Flutter Web', 'Firebase Hosting', 'HTML/CSS'],
      githubUrl: 'https://github.com/aakash/portfolio',
      liveUrl: 'https://aakashrajbanshi.dev',
      category: ProjectCategory.web,
      createdAt: DateTime(2024, 3, 10),
      isFeatured: true,
    ),
    ProjectModel(
      id: '3',
      title: 'Task Management App',
      shortDescription: 'Collaborative task management with real-time sync',
      description: 'A collaborative task management application with real-time synchronization. Features include team collaboration, task assignment, progress tracking, notifications, and offline capability.',
      images: [
        'assets/images/projects/taskapp_1.jpg',
        'assets/images/projects/taskapp_2.jpg',
      ],
      technologies: ['Flutter', 'Firebase', 'Cloud Firestore', 'FCM'],
      githubUrl: 'https://github.com/aakash/task-manager',
      category: ProjectCategory.mobile,
      createdAt: DateTime(2024, 2, 20),
    ),
    ProjectModel(
      id: '4',
      title: 'Weather App',
      shortDescription: 'Beautiful weather app with forecasts',
      description: 'A beautiful weather application with current conditions and forecasts. Features include location-based weather, 7-day forecast, weather maps, and customizable themes.',
      images: [
        'assets/images/projects/weather_1.jpg',
      ],
      technologies: ['Flutter', 'OpenWeather API', 'Location Services'],
      githubUrl: 'https://github.com/aakash/weather-app',
      category: ProjectCategory.mobile,
      createdAt: DateTime(2024, 4, 5),
    ),
  ];

  // Get featured projects
  static List<ProjectModel> getFeaturedProjects() {
    return projects.where((project) => project.isFeatured).toList();
  }

  // Get projects by category
  static List<ProjectModel> getProjectsByCategory(ProjectCategory category) {
    return projects.where((project) => project.category == category).toList();
  }

  // Get recent projects
  static List<ProjectModel> getRecentProjects({int limit = 6}) {
    final sortedProjects = List<ProjectModel>.from(projects);
    sortedProjects.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedProjects.take(limit).toList();
  }
}

/// Project categories
enum ProjectCategory {
  mobile('Mobile Apps'),
  web('Web Development'),
  uiux('UI/UX Design'),
  backend('Backend');

  const ProjectCategory(this.displayName);
  final String displayName;
}
