
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/service_model.dart';
import '../common/custom_card.dart';

/// Main content area with responsive design (cleaned and consolidated)
class MainContentArea extends StatefulWidget {
  final bool isMobile;

  const MainContentArea({super.key, required this.isMobile});

  @override
  State<MainContentArea> createState() => _MainContentAreaState();
}

class _MainContentAreaState extends State<MainContentArea> {
  // Tab logic: highlight vs displayed to support sequential fade
  String _highlightTab = 'About';
  String _displayedTab = 'About';
  final List<String> _tabs = const ['About', 'Resume', 'Portfolio', 'Blog', 'Contact'];
  double _contentOpacity = 1.0;
  bool _isTransitioning = false;

  void _onTabSelected(String tab) {
    if (_highlightTab == tab && !_isTransitioning) return;
    setState(() => _highlightTab = tab);
    if (_displayedTab == tab) return; // already showing
    if (_isTransitioning) return; // avoid overlapping transitions
    // start fade out
    setState(() {
      _isTransitioning = true;
      _contentOpacity = 0.0;
    });
  }

  void _goToPortfolioTab() {
    setState(() {
      _highlightTab = 'Portfolio';
      _displayedTab = 'Portfolio';
    });
  }

  Widget _buildNavigationPills(bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _tabs.map((tab) {
          final selected = _highlightTab == tab;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ChoiceChip(
              label: Text(tab),
              selected: selected,
              onSelected: (_) => _onTabSelected(tab),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBelowContent(bool isMobile, String tab) {
    switch (tab) {
      case 'About':
        return _buildAboutBelowContent(isMobile);
      case 'Resume':
        return _buildResumeTab(isMobile);
      case 'Portfolio':
        return _buildComingSoon('Portfolio', isMobile);
      case 'Blog':
        return _buildComingSoon('Blog', isMobile);
      case 'Contact':
        return _buildComingSoon('Contact', isMobile);
      default:
        return _buildAboutBelowContent(isMobile);
    }
  }

  Widget _buildComingSoon(String title, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        CustomCard(
          backgroundColor: AppColors.surfaceVariant,
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Text(
            'Coming soon... stay tuned! ✨',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with underline
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Me',
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Container(
              width: 40,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingXLarge),
        Text(
          AppStrings.aboutDescription,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        Text(
          AppStrings.aboutCallToAction,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutBelowContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWhatImDoingSection(isMobile),
        const SizedBox(height: AppDimensions.paddingXXLarge),
        _buildSkillsSection(isMobile),
      ],
    );
  }

  Widget _buildWhatImDoingSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What I'm Doing",
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingXLarge),
        if (isMobile)
          Column(
            children: List.generate(ServiceModel.services.length, (i) => Padding(
              padding: EdgeInsets.only(bottom: i == ServiceModel.services.length - 1 ? 0 : AppDimensions.paddingMedium),
              child: _buildServiceCard(ServiceModel.services[i], isMobile),
            )),
          )
        else
          Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildServiceCard(ServiceModel.services[0], isMobile)),
                  const SizedBox(width: AppDimensions.paddingLarge),
                  Expanded(child: _buildServiceCard(ServiceModel.services[1], isMobile)),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingLarge),
              Row(
                children: [
                  Expanded(child: _buildServiceCard(ServiceModel.services[2], isMobile)),
                  const SizedBox(width: AppDimensions.paddingLarge),
                  Expanded(child: _buildServiceCard(ServiceModel.services[3], isMobile)),
                ],
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildServiceCard(ServiceModel service, bool isMobile) {
    return CustomCard(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      backgroundColor: AppColors.surfaceVariant,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: isMobile ? 50 : 60,
            height: isMobile ? 50 : 60,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: _getServiceIcon(service.title),
          ),
          SizedBox(width: isMobile ? AppDimensions.paddingMedium : AppDimensions.paddingLarge),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: isMobile ? AppDimensions.paddingXSmall : AppDimensions.paddingSmall),
                Text(
                  service.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: isMobile ? 1.4 : 2,
                    letterSpacing: isMobile ? 0.5 : 1.2,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getServiceIcon(String title) {
    switch (title) {
      case 'Flutter Mobile Apps':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/imgs/flutter.png', color: AppColors.accentDark, fit: BoxFit.contain),
        );
      case 'Native iOS Development':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/imgs/ios.png', color: AppColors.accentDark, fit: BoxFit.contain),
        );
      case 'SDK & Framework Development':
        return Icon(Icons.code_sharp, color: AppColors.accentDark, size: 35);
      case 'App Maintenance & Optimization':
        return Icon(Icons.security, color: AppColors.accentDark, size: 35);
      default:
        return Icon(Icons.apps, color: AppColors.accentDark, size: 30);
    }
  }

  Widget _buildSkillsSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingXLarge),
        if (isMobile)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSkillIcon('Flutter', AppColors.info),
                const SizedBox(width: AppDimensions.paddingMedium),
                _buildSkillIcon('Firebase', AppColors.accent),
                const SizedBox(width: AppDimensions.paddingMedium),
                _buildSkillIcon('Node.js', AppColors.success),
                const SizedBox(width: AppDimensions.paddingMedium),
                _buildSkillIcon('Design', AppColors.error),
              ],
            ),
          )
        else
          Row(
            children: [
              _buildSkillIcon('Flutter', AppColors.info),
              const SizedBox(width: AppDimensions.paddingLarge),
              _buildSkillIcon('Firebase', AppColors.accent),
              const SizedBox(width: AppDimensions.paddingLarge),
              _buildSkillIcon('Node.js', AppColors.success),
              const SizedBox(width: AppDimensions.paddingLarge),
              _buildSkillIcon('Design', AppColors.error),
            ],
          ),
        const SizedBox(height: AppDimensions.paddingLarge),
        Container(
          width: double.infinity,
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.7,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillIcon(String skill, Color color) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getSkillIcon(skill), color: color, size: 32),
          const SizedBox(height: 4),
          Text(skill, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary, fontSize: 9)),
        ],
      ),
    );
  }

  IconData _getSkillIcon(String skill) {
    switch (skill) {
      case 'Flutter':
        return Icons.flutter_dash;
      case 'Firebase':
        return Icons.whatshot;
      case 'Node.js':
        return Icons.code;
      case 'Design':
        return Icons.palette;
      default:
        return Icons.star;
    }
  }

  Widget _buildProjectsSection(bool isMobile) {
    final featured = [
      {
        'name': 'Talent View HRMS',
        'desc': 'HR management solution for attendance, leave, payroll, and employee data.',
        'link': 'https://play.google.com/store/apps/details?id=com.eplanet.talentview',
        'icon': 'assets/imgs/flutter.png',
      },
      {
        'name': 'Barnoli and Sons',
        'desc': 'Concrete Pumping app for scheduling and tracking services.',
        'link': 'https://play.google.com/store/apps/details?id=com.barnolinsons.app',
        'icon': 'assets/imgs/flutter.png',
      },
      {
        'name': 'OceanicView Mart',
        'desc': 'Classifieds marketplace app for buying, selling, and browsing products.',
        'link': 'https://apps.apple.com/us/app/oceanicview-mart/id6733253406',
        'icon': 'assets/imgs/ios.png',
      },
      {
        'name': 'Shifaam HealthApp',
        'desc': 'Digital health platform for appointments, medicines, and therapy.',
        'link': 'https://apps.apple.com/pk/app/shifaam-healthapp/id1500904139',
        'icon': 'assets/imgs/ios.png',
      },
    ];

    Widget projectCard(Map<String, String> p) {
      return CustomCard(
        backgroundColor: AppColors.surfaceVariant,
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: 16),
              child: p['icon'] != null ? Image.asset(p['icon']!, fit: BoxFit.contain) : Icon(Icons.apps, color: AppColors.accentDark, size: 32),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['name'] ?? '', style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(p['desc'] ?? '', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, fontSize: 13)),
                  if (p['link'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: InkWell(
                        onTap: () {}, // TODO: implement launch
                        child: Text(p['link']!, style: AppTextStyles.labelSmall.copyWith(color: AppColors.accent, decoration: TextDecoration.underline, fontSize: 12)),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Projects', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 24)),
        const SizedBox(height: AppDimensions.paddingLarge),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [for (final p in featured) ...[projectCard(p), const SizedBox(width: AppDimensions.paddingLarge)]],
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: AppColors.background, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('View More'),
            onPressed: _goToPortfolioTab,
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceSection(bool isMobile) {
    final experiences = [
      {
        'role': 'Senior Mobile Developer',
        'company': 'Eplanet Global',
        'period': '2023(Sep) - Present',
        'highlights': [
          'Native (Swift, SwiftUI, Objective‑C) and hybrid Flutter (BLoC) development',
          'End‑to‑end delivery across architecture, UI implementation, and API integration',
          'Performance optimization across multiple cross‑domain projects',
          'Several live projects shipped (see Projects section)'
        ],
      },
      {
        'role': 'Senior Mobile Developer',
        'company': 'Invision Custom Solutions',
        'period': '2021(Nov) - 2023(Sep)',
        'highlights': [
          'Joined as Native iOS Developer; promoted to Senior Mobile Developer after excelling on hybrid platform',
          'Designed, developed, maintained, and debugged native (Swift/Obj‑C) and Flutter apps',
          'Led Pillway migration from native iOS to Flutter, taking full ownership of hybrid development',
          'Delivered multiple cross‑domain projects end‑to‑end from architecture to deployment',
          'Implemented CI/CD with SonarQube quality gates and automated builds/deployments'
        ],
      },
      {
        'role': 'Mid‑Level iOS Developer',
        'company': 'LN Technologies',
        'period': '2020(Oct) - 2021(Nov)',
        'highlights': [
          'Maintained and enhanced ShareOne Credit Union applications',
          'Developed multiple iOS applications',
          'Responsible for designing, developing, maintaining, and troubleshooting iOS apps'
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Experience', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 24)),
        const SizedBox(height: AppDimensions.paddingLarge),
        ...experiences.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
          child: CustomCard(
            backgroundColor: AppColors.surfaceVariant,
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e['role'] as String, style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 18)),
                          const SizedBox(height: 4),
                          Text(e['company'] as String, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, fontSize: 14)),
                        ],
                      ),
                    ),
                    Text(e['period'] as String, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                ...((e['highlights'] as List<String>).map((h) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, size: 16, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(child: Text(h, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, fontSize: 14))),
                    ],
                  ),
                ))),
              ],
            ),
          ),
        ))
      ],
    );
  }

  Widget _buildResumeSkillsSection(bool isMobile) {
    final categories = [
      {
        'title': 'iOS Development',
        'items': [
          {'label': 'Swift', 'icon': Icons.bolt},
          {'label': 'SwiftUI', 'icon': Icons.layers},
          {'label': 'Objective‑C', 'icon': Icons.code},
          {'label': 'Core Data', 'icon': Icons.storage},
        ],
      },
      {
        'title': 'Cross‑Platform',
        'items': [
          {'label': 'Flutter', 'asset': 'assets/imgs/flutter.png'},
          {'label': 'BLoC', 'icon': Icons.account_tree},
          {'label': 'Dart', 'icon': Icons.developer_mode},
        ],
      },
    ];

    Widget item(Map<String, dynamic> s) {
      final label = s['label'] as String;
      final icon = s['icon'];
      final asset = s['asset'];
      Widget iconWidget;
      if (asset != null) {
        iconWidget = Padding(padding: const EdgeInsets.all(12.0), child: Image.asset(asset as String, fit: BoxFit.contain, color: AppColors.accentDark));
      } else if (icon != null && icon is IconData) {
        iconWidget = Icon(icon, color: AppColors.accentDark, size: 30);
      } else {
        iconWidget = Icon(Icons.star, color: AppColors.accentDark, size: 30);
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 72, height: 72, decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.08), borderRadius: BorderRadius.circular(16)), child: Center(child: iconWidget)),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary, fontSize: 12)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 24)),
        const SizedBox(height: AppDimensions.paddingLarge),
        ...categories.map((cat) => Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.paddingLarge),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(cat['title'] as String, style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 18)),
            const SizedBox(height: AppDimensions.paddingMedium),
            if (isMobile)
              SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [(cat['items'] as List).map((s) => item(s as Map<String, dynamic>)).toList()].expand((i) => i is Iterable ? i : [i]).toList()))
            else
              Wrap(spacing: AppDimensions.paddingLarge, runSpacing: AppDimensions.paddingLarge, children: [(cat['items'] as List).map((s) => item(s as Map<String, dynamic>)).toList()].expand((i) => i is Iterable ? i : [i]).toList()),
          ]),
        )),
      ],
    );
  }

  Widget _buildProfessionalStrengthsSection(bool isMobile) {
    final strengths = [
      'Strong adaptability and problem‑solving mindset',
      'Collaborative team player with leadership experience',
      'Innovative thinker with solid work ethic and delivery focus',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Professional Strengths', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 24)),
        const SizedBox(height: AppDimensions.paddingLarge),
        Wrap(spacing: AppDimensions.paddingLarge, runSpacing: AppDimensions.paddingLarge, children: strengths.map((h) => CustomCard(backgroundColor: AppColors.surfaceVariant, padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge, vertical: AppDimensions.paddingMedium), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.verified, color: Colors.green, size: 18), const SizedBox(width: 8), Text(h, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, fontSize: 14))]))).toList()),
      ],
    );
  }

  Widget _buildHighlightsSection(bool isMobile) {
    final highlights = ['100k+ total app downloads', 'Featured on Product Hunt', 'Top-rated freelancer (5.0⭐)'];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Highlights', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 24)), const SizedBox(height: AppDimensions.paddingLarge), Wrap(spacing: AppDimensions.paddingLarge, runSpacing: AppDimensions.paddingLarge, children: highlights.map((h) => CustomCard(backgroundColor: AppColors.surfaceVariant, padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge, vertical: AppDimensions.paddingMedium), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.star, color: Colors.amber, size: 18), const SizedBox(width: 8), Text(h, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, fontSize: 14))]))).toList())]);
  }

  Widget _buildViewAllProjectsCard(bool isMobile) {
    return CustomCard(
      backgroundColor: AppColors.accent.withOpacity(0.08),
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Explore my work', style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 18)), const SizedBox(height: 6), Text('Dive into case studies, design systems, and shipped apps.', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, fontSize: 14))]),
          ),
          const SizedBox(width: AppDimensions.paddingLarge),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: AppColors.background, padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge, vertical: AppDimensions.paddingSmall), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusLarge))),
            onPressed: () => _onTabSelected('Portfolio'),
            child: const Text('View all projects'),
          )
        ],
      ),
    );
  }

  Widget _buildCertificationsSection(bool isMobile) {
    final certs = [
      {'name': 'iOS Development', 'issuer': 'AXIOM ENTERPRISES', 'year': '2018'},
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Certifications', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 24)), const SizedBox(height: AppDimensions.paddingLarge), Wrap(spacing: AppDimensions.paddingLarge, runSpacing: AppDimensions.paddingLarge, children: certs.map((c) => CustomCard(backgroundColor: AppColors.surfaceVariant, padding: const EdgeInsets.all(AppDimensions.paddingLarge), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.workspace_premium, color: Colors.orange, size: 20), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(c['name'] as String, style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 16)), const SizedBox(height: 2), Text('${c['issuer']} • ${c['year']}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, fontSize: 14))])]))).toList())]);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: isMobile ? double.infinity : 1000.w,
      margin: EdgeInsets.only(left: 0, top: AppDimensions.paddingLarge, right: isMobile ? 0 : AppDimensions.paddingLarge, bottom: AppDimensions.paddingLarge),
      decoration: BoxDecoration(color: AppColors.disabled, borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge), boxShadow: [BoxShadow(color: AppColors.primaryDark.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8))]),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? AppDimensions.paddingLarge : AppDimensions.paddingXXLarge),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildNavigationPills(isMobile),
          const SizedBox(height: AppDimensions.paddingXXLarge),
          _buildAboutSection(isMobile),
          const SizedBox(height: AppDimensions.paddingXXLarge),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            opacity: _contentOpacity,
            onEnd: () {
              if (_contentOpacity == 0.0) {
                setState(() {
                  _displayedTab = _highlightTab;
                  _contentOpacity = 1.0;
                  _isTransitioning = false;
                });
              }
            },
            child: _buildBelowContent(isMobile, _displayedTab),
          ),
        ]),
      ),
    );
  }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/service_model.dart';
import '../common/custom_card.dart';

/// Main content area with responsive design
class MainContentArea extends StatefulWidget {
  final bool isMobile;

  const MainContentArea({super.key, required this.isMobile});

  @override
  State<MainContentArea> createState() => _MainContentAreaState();
}

class _MainContentAreaState extends State<MainContentArea> {
  Widget _buildProjectsSection(bool isMobile) {
    // Featured projects (2 Flutter, 2 iOS)
    final featured = [
      {
        'name': 'Talent View HRMS',
        'desc': 'HR management solution for attendance, leave, payroll, and employee data.',
        'link': 'https://play.google.com/store/apps/details?id=com.eplanet.talentview',
        'icon': 'assets/imgs/flutter.png',
      },
      {
        'name': 'Barnoli and Sons',
        'desc': 'Concrete Pumping app for scheduling and tracking services.',
        'link': 'https://play.google.com/store/apps/details?id=com.barnolinsons.app',
        'icon': 'assets/imgs/flutter.png',
      },
      {
        'name': 'OceanicView Mart',
        'desc': 'Classifieds marketplace app for buying, selling, and browsing products.',
        'link': 'https://apps.apple.com/us/app/oceanicview-mart/id6733253406',
        'icon': 'assets/imgs/ios.png',
      },
      {
        'name': 'Shifaam HealthApp',
        'desc': 'Digital health platform for appointments, medicines, and therapy.',
        'link': 'https://apps.apple.com/pk/app/shifaam-healthapp/id1500904139',
        'icon': 'assets/imgs/ios.png',
      },
    ];

    Widget projectCard(Map<String, String> p) {
      return CustomCard(
        backgroundColor: AppColors.surfaceVariant,
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: 16),
              child: p['icon'] != null
                  ? Image.asset(p['icon']!, fit: BoxFit.contain)
                  : Icon(Icons.apps, color: AppColors.accentDark, size: 32),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['name'] ?? '',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p['desc'] ?? '',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  if (p['link'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: InkWell(
                        onTap: () {}, // TODO: implement launch
                        child: Text(
                          p['link']!,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.accent,
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final p in featured) ...[
                projectCard(p),
                const SizedBox(width: AppDimensions.paddingLarge),
              ]
            ],
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.background,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('View More'),
            onPressed: _goToPortfolioTab,
          ),
        ),
      ],
    );
  }
  void _goToPortfolioTab() {
    setState(() {
      _highlightTab = 'Portfolio';
      _displayedTab = 'Portfolio';
    });
  }
  // Tab logic: highlight vs displayed to support sequential fade
  String _highlightTab = 'About';
  String _displayedTab = 'About';
  final List<String> _tabs = const ['About', 'Resume', 'Portfolio', 'Blog', 'Contact'];
  double _contentOpacity = 1.0;
  bool _isTransitioning = false;

  void _onTabSelected(String tab) {
    if (_highlightTab == tab && !_isTransitioning) return;
    setState(() => _highlightTab = tab);
    if (_displayedTab == tab) return; // already showing
    if (_isTransitioning) return; // avoid overlapping transitions
    // start fade out
    setState(() {
      _isTransitioning = true;
      _contentOpacity = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: isMobile ? double.infinity : 1000.w,
      margin: EdgeInsets.only(
        left: 0,
        top: AppDimensions.paddingLarge,
        right: isMobile ? 0 : AppDimensions.paddingLarge,
        bottom: AppDimensions.paddingLarge,
      ),
      decoration: BoxDecoration(
        color: AppColors.disabled,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? AppDimensions.paddingLarge : AppDimensions.paddingXXLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNavigationPills(isMobile),
            const SizedBox(height: AppDimensions.paddingXXLarge),
            _buildAboutSection(isMobile),
            const SizedBox(height: AppDimensions.paddingXXLarge),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              opacity: _contentOpacity,
              onEnd: () {
                if (_contentOpacity == 0.0) {
                  setState(() {
                    _displayedTab = _highlightTab;
                    _contentOpacity = 1.0;
                  });
                }
              },
              child: _buildBelowContent(isMobile, _displayedTab),
            ),
          ],
        ),
      ),
    );

  Widget _buildBelowContent(bool isMobile, String tab) {
    switch (tab) {
      case 'About':
        return _buildAboutBelowContent(isMobile);
      case 'Resume':
        return _buildResumeTab(isMobile);
      case 'Portfolio':
        return _buildComingSoon('Portfolio', isMobile);
      case 'Blog':
        return _buildComingSoon('Blog', isMobile);
      case 'Contact':
        return _buildComingSoon('Contact', isMobile);
      default:
        return _buildAboutBelowContent(isMobile);
    }
  }

  Widget _buildComingSoon(String title, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        CustomCard(
          backgroundColor: AppColors.surfaceVariant,
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Text(
            'Coming soon... stay tuned! ✨',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutBelowContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWhatImDoingSection(isMobile),
        const SizedBox(height: AppDimensions.paddingXXLarge),
        _buildSkillsSection(isMobile),
      ],
    );
  }

  Widget _buildResumeTab(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildExperienceSection(isMobile),
        const SizedBox(height: AppDimensions.paddingXXLarge),
        _buildResumeSkillsSection(isMobile),
  const SizedBox(height: AppDimensions.paddingXXLarge),
  _buildProfessionalStrengthsSection(isMobile),
  const SizedBox(height: AppDimensions.paddingXXLarge),
  _buildCertificationsSection(isMobile),
        const SizedBox(height: AppDimensions.paddingXXLarge),
        _buildProjectsSection(isMobile),
        const SizedBox(height: AppDimensions.paddingXXLarge),
        _buildHighlightsSection(isMobile),
        const SizedBox(height: AppDimensions.paddingXXLarge),
        _buildViewAllProjectsCard(isMobile),
      ],
    );
  }

  Widget _buildAboutSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with underline
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Me',
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 24
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Container(
              width: 40,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingXLarge),
        
        // Description
        Text(
          AppStrings.aboutDescription,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
            fontSize:  16
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        
        Text(
          AppStrings.aboutCallToAction,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
            fontSize:   16
          ),
        ),
      ],
    );
  }

  Widget _buildWhatImDoingSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What I'm Doing",
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24
          ),
        ),
        const SizedBox(height: AppDimensions.paddingXLarge),
        
        if (isMobile) 
          // Mobile: Single column layout
          Column(
            children: [
              _buildServiceCard(ServiceModel.services[0], isMobile),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildServiceCard(ServiceModel.services[1], isMobile),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildServiceCard(ServiceModel.services[2],isMobile),
              const SizedBox(height: AppDimensions.paddingMedium),
              _buildServiceCard(ServiceModel.services[3],isMobile),
            ],
          )
        else
          // Desktop: Two-column layout
          Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildServiceCard(ServiceModel.services[0], isMobile)),
                  const SizedBox(width: AppDimensions.paddingLarge),
                  Expanded(child: _buildServiceCard(ServiceModel.services[1], isMobile)),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingLarge),
              
              Row(
                children: [
                  Expanded(child: _buildServiceCard(ServiceModel.services[2], isMobile)),
                  const SizedBox(width: AppDimensions.paddingLarge),
                  Expanded(child: _buildServiceCard(ServiceModel.services[3], isMobile)),
                ],
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildServiceCard(ServiceModel service, bool isMobile) {
    return CustomCard(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      backgroundColor: AppColors.surfaceVariant,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: isMobile ? 50 : 60,
            height: isMobile ? 50 : 60,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child:_getServiceIcon(service.title)
          ),
          SizedBox(width: isMobile ? AppDimensions.paddingMedium : AppDimensions.paddingLarge),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize:  18
                  ),
                ),
                SizedBox(height: isMobile ? AppDimensions.paddingXSmall : AppDimensions.paddingSmall),
                Text(
                  service.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: isMobile ? 1.4 : 2,
                    letterSpacing: isMobile ? 0.5 : 1.2,
                    fontSize: 14
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24
          ),
        ),
        const SizedBox(height: AppDimensions.paddingXLarge),
        
        if (isMobile)
          // Mobile: Horizontal scrollable skills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSkillIcon('Flutter', AppColors.info),
                const SizedBox(width: AppDimensions.paddingMedium),
                _buildSkillIcon('Firebase', AppColors.accent),
                const SizedBox(width: AppDimensions.paddingMedium),
                _buildSkillIcon('Node.js', AppColors.success),
                const SizedBox(width: AppDimensions.paddingMedium),
                _buildSkillIcon('Design', AppColors.error),
                const SizedBox(width: AppDimensions.paddingMedium),
                _buildSkillIcon('React', AppColors.info),
                const SizedBox(width: AppDimensions.paddingMedium),
                _buildSkillIcon('Python', AppColors.success),
              ],
            ),
          )
        else
          // Desktop: Regular row
          Row(
            children: [
              _buildSkillIcon('Flutter', AppColors.info),
              const SizedBox(width: AppDimensions.paddingLarge),
              _buildSkillIcon('Firebase', AppColors.accent),
              const SizedBox(width: AppDimensions.paddingLarge),
              _buildSkillIcon('Node.js', AppColors.success),
              const SizedBox(width: AppDimensions.paddingLarge),
              _buildSkillIcon('Design', AppColors.error),
            ],
          ),
        
        const SizedBox(height: AppDimensions.paddingLarge),
        
        // Progress bar (decorative)
        Container(
          width: double.infinity,
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.7,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillIcon(String skill, Color color) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getSkillIcon(skill),
            color: color,
            size: 32,
          ),
          const SizedBox(height: 4),
          Text(
            skill,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _getServiceIcon(String title) {
    switch (title) {
      case 'Flutter Mobile Apps':
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/imgs/flutter.png',color: AppColors.accentDark,fit: BoxFit.contain),
        );
      case 'Native iOS Development':
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/imgs/ios.png',color: AppColors.accentDark, fit: BoxFit.contain,),
        );
      case 'SDK & Framework Development':
        return  Icon( Icons.code_sharp,color: AppColors.accentDark,size: 35,);
      case 'App Maintenance & Optimization':
        return Icon( Icons.security,color: AppColors.accentDark,size: 35,);
      default:
        return Icon( Icons.security,color: AppColors.accentDark,size: 35,);
    }
  }

  IconData _getSkillIcon(String skill) {
    switch (skill) {
      case 'Flutter':
        return Icons.flutter_dash;
      case 'Firebase':
        return Icons.whatshot;
      case 'Node.js':
        return Icons.code;
      case 'Design':
        return Icons.palette;
      default:
        return Icons.star;
    }
  }
}

  // ...existing code...
  Widget _buildExperienceSection(bool isMobile) {
    final experiences = [
      {
        'role': 'Senior Mobile Developer',
        'company': 'Eplanet Global',
        'period': '2023(Sep) - Present',
        'highlights': [
          'Native (Swift, SwiftUI, Objective‑C) and hybrid Flutter (BLoC) development',
          'End‑to‑end delivery across architecture, UI implementation, and API integration',
          'Performance optimization across multiple cross‑domain projects',
          'Several live projects shipped (see Projects section)'
        ],
      },
      {
        'role': 'Senior Mobile Developer',
        'company': 'Invision Custom Solutions',
        'period': '2021(Nov) - 2023(Sep)',
        'highlights': [
          'Joined as Native iOS Developer; promoted to Senior Mobile Developer after excelling on hybrid platform',
          'Designed, developed, maintained, and debugged native (Swift/Obj‑C) and Flutter apps',
          'Led Pillway migration from native iOS to Flutter, taking full ownership of hybrid development',
          'Delivered multiple cross‑domain projects end‑to‑end from architecture to deployment',
          'Implemented CI/CD with SonarQube quality gates and automated builds/deployments'
        ],
      },
      {
        'role': 'Mid‑Level iOS Developer',
        'company': 'LN Technologies',
        'period': '2020(Oct) - 2021(Nov)',
        'highlights': [
          'Maintained and enhanced ShareOne Credit Union applications',
          'Developed multiple iOS applications',
          'Responsible for designing, developing, maintaining, and troubleshooting iOS apps'
        ],
      },
      // ...you can keep or remove prior roles below as needed
      {
        'role': 'Senior Flutter Developer',
        'company': 'Freelance / Remote',
        'period': '2022 — Present',
        'highlights': [
          'Built and shipped 10+ production apps',
          'Architected scalable modular codebases',
          'CI/CD pipelines and performance tuning',
        ],
      },
      {
        'role': 'Mobile Developer',
        'company': 'Tech Studio',
        'period': '2020 — 2022',
        'highlights': [
          'Led cross-platform app initiatives',
          'Integrated analytics and A/B testing',
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        ...experiences.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
              child: CustomCard(
                backgroundColor: AppColors.surfaceVariant,
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e['role'] as String,
                                style: AppTextStyles.titleMedium.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                e['company'] as String,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          e['period'] as String,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    ...((e['highlights'] as List<String>).map((h) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle, size: 16, color: Colors.green),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  h,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )))
                  ],
                ),
              ),
            ))
      ],
    );
  }

  Widget _buildResumeSkillsSection(bool isMobile) {
    // Category -> list of skills with icon/asset
    final categories = [
      {
        'title': 'iOS Development',
        'items': [
          {'label': 'Swift', 'icon': Icons.bolt},
          {'label': 'SwiftUI', 'icon': Icons.layers},
          {'label': 'Objective‑C', 'icon': Icons.code},
          {'label': 'Core Data', 'icon': Icons.storage},
          {'label': 'GCD', 'icon': Icons.sync_alt},
          {'label': 'Xcode', 'icon': Icons.laptop_mac},
          {'label': 'Memory Mgmt', 'icon': Icons.memory},
          {'label': 'SDK Dev (PodSpec)', 'icon': Icons.extension},
        ],
      },
      {
        'title': 'Cross‑Platform',
        'items': [
          {'label': 'Flutter', 'asset': 'assets/imgs/flutter.png'},
          {'label': 'BLoC', 'icon': Icons.account_tree},
          {'label': 'RxDart', 'icon': Icons.waves},
          {'label': 'Provider', 'icon': Icons.handshake},
          {'label': 'GetX', 'icon': Icons.architecture},
          {'label': 'Dart', 'icon': Icons.developer_mode},
        ],
      },
      {
        'title': 'Architecture & Tools',
        'items': [
          {'label': 'MVC', 'icon': Icons.account_tree_outlined},
          {'label': 'MVVM', 'icon': Icons.hub},
          {'label': 'Git', 'icon': Icons.merge_type},
          {'label': 'Alamofire', 'icon': Icons.cloud_sync},
          {'label': 'Firebase', 'icon': Icons.local_fire_department},
        ],
      },
      {
        'title': 'UI/UX',
        'items': [
          {'label': 'User‑friendly', 'icon': Icons.emoji_people},
          {'label': 'Scalable', 'icon': Icons.scale},
          {'label': 'Performant', 'icon': Icons.speed},
        ],
      },
    ];

    Widget item(Map<String, dynamic> s) {
      final label = s['label'] as String;
      final icon = s['icon'];
      final asset = s['asset'];
      Widget iconWidget;
      if (asset != null) {
        iconWidget = Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(asset as String, fit: BoxFit.contain, color: AppColors.accentDark),
        );
      } else if (icon != null && icon is IconData) {
        iconWidget = Icon(icon, color: AppColors.accentDark, size: 30);
      } else {
        iconWidget = Icon(Icons.star, color: AppColors.accentDark, size: 30);
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(child: iconWidget),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        ...categories.map((cat) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cat['title'] as String,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  if (isMobile)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final s in (cat['items'] as List)) ...[
                            item(s as Map<String, dynamic>),
                            const SizedBox(width: AppDimensions.paddingLarge),
                          ]
                        ],
                      ),
                    )
                  else
                    Wrap(
                      spacing: AppDimensions.paddingLarge,
                      runSpacing: AppDimensions.paddingLarge,
                      children: [
                        for (final s in (cat['items'] as List)) item(s as Map<String, dynamic>),
                      ],
                    )
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildProfessionalStrengthsSection(bool isMobile) {
    final strengths = [
      'Strong adaptability and problem‑solving mindset',
      'Collaborative team player with leadership experience',
      'Innovative thinker with solid work ethic and delivery focus',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Professional Strengths',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        Wrap(
          spacing: AppDimensions.paddingLarge,
          runSpacing: AppDimensions.paddingLarge,
          children: strengths
              .map((h) => CustomCard(
                    backgroundColor: AppColors.surfaceVariant,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingLarge,
                      vertical: AppDimensions.paddingMedium,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified, color: Colors.green, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          h,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }

  Widget _buildHighlightsSection(bool isMobile) {
    final highlights = [
      '100k+ total app downloads',
      'Featured on Product Hunt',
      'Top-rated freelancer (5.0⭐)',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Highlights',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        Wrap(
          spacing: AppDimensions.paddingLarge,
          runSpacing: AppDimensions.paddingLarge,
          children: highlights
              .map((h) => CustomCard(
                    backgroundColor: AppColors.surfaceVariant,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingLarge,
                      vertical: AppDimensions.paddingMedium,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          h,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }

  Widget _buildViewAllProjectsCard(bool isMobile) {
    return CustomCard(
      backgroundColor: AppColors.accent.withOpacity(0.08),
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore my work',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Dive into case studies, design systems, and shipped apps.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimensions.paddingLarge),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.background,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingSmall,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              ),
            ),
            onPressed: () => _onTabSelected('Portfolio'),
            child: const Text('View all projects'),
          )
        ],
      ),
    );
  }
}

  Widget _buildCertificationsSection(bool isMobile) {
    final certs = [
      {
        'name': 'iOS Development',
        'issuer': 'AXIOM ENTERPRISES',
        'year': '2018',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Certifications',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        Wrap(
          spacing: AppDimensions.paddingLarge,
          runSpacing: AppDimensions.paddingLarge,
          children: certs
              .map((c) => CustomCard(
                    backgroundColor: AppColors.surfaceVariant,
                    padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.workspace_premium, color: Colors.orange, size: 20),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c['name'] as String,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${c['issuer']} • ${c['year']}',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}
