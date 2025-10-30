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
  title: 'Flutter Mobile Apps',
  description: 'Cross-platform mobile app development with high performance and pixel-perfect UI, leveraging Flutter and Dart. Experienced in BLoC architecture, real-time integrations, and module embedding within native iOS apps.',
  iconPath: 'assets/icons/mobile.svg',
  technologies: ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'BLoC', 'RxDart'],
),

ServiceModel(
  title: 'Native iOS Development',
  description: 'End-to-end iOS app development using Swift, SwiftUI, and Objective-C with Clean Architecture and MVVM. Expert in SDK creation, method channeling, Parental Control (MDM), and ScreenTime API integrations.',
  iconPath: 'assets/icons/ios.svg',
  technologies: ['Swift', 'Objective-C', 'SwiftUI', 'Combine', 'Xcode', 'Clean Architecture'],
),

ServiceModel(
  title: 'SDK & Framework Development',
  description: 'Building reusable iOS SDKs (PodSpec-based) and frameworks for scalable app integrations. Experience in developing custom modules for enterprise and fintech clients with secure and optimized architecture.',
  iconPath: 'assets/icons/sdk.svg',
  technologies: ['CocoaPods', 'Swift Package Manager', 'Modular Architecture', 'CI/CD'],
),

ServiceModel(
  title: 'Enterprise & MDM Solutions',
  description: 'Specialized in secure enterprise app development with Parental Control and MDM profiles. Focused on compliance, ScreenTime API, and high-performance solutions tailored for corporate environments.',
  iconPath: 'assets/icons/enterprise.svg',
  technologies: ['MDM', 'ScreenTime API', 'Security Frameworks', 'HealthKit', 'Apple Watch'],
),

ServiceModel(
  title: 'App Maintenance & Optimization',
  description: 'Comprehensive maintenance, refactoring, and performance optimization for live apps. Focus on enhancing user experience, stability, and feature expansion across App Store-deployed products.',
  iconPath: 'assets/icons/maintenance.svg',
  technologies: ['Instruments', 'Crashlytics', 'Firebase Analytics', 'CI/CD', 'App Store Connect'],
),

  ];
}
