import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/responsive/responsive_helper.dart';
import '../components/navigation/navigation_bar.dart' as nav;

/// Main app layout with navigation and content area
class AppLayout extends StatefulWidget {
  final Widget child;
  final int selectedIndex;
  final Function(int) onNavigationChanged;

  const AppLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
    required this.onNavigationChanged,
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isScrolled = _scrollController.offset > 50;
    if (isScrolled != _isScrolled) {
      setState(() => _isScrolled = isScrolled);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background gradient
          _buildBackground(),
          
          // Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Navigation bar
              SliverAppBar(
                expandedHeight: AppDimensions.navBarHeight,
                floating: true,
                pinned: true,
                snap: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: nav.NavigationBar(
                    selectedIndex: widget.selectedIndex,
                    onItemSelected: widget.onNavigationChanged,
                    isScrolled: _isScrolled,
                  ),
                ),
              ),
              
              // Main content
              SliverToBoxAdapter(
                child: widget.child,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.primaryGradient,
        ),
      ),
    );
  }
}

/// Section layout wrapper for consistent spacing
class SectionLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool addTopPadding;
  final bool addBottomPadding;

  const SectionLayout({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.addTopPadding = true,
    this.addBottomPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding ?? _getDefaultPadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.maxContentWidth,
          ),
          child: child,
        ),
      ),
    );
  }

  EdgeInsetsGeometry _getDefaultPadding(BuildContext context) {
    final horizontalPadding = ResponsiveHelper.responsive(
      context,
      mobile: AppDimensions.paddingLarge,
      tablet: AppDimensions.paddingXLarge,
      desktop: AppDimensions.paddingXXLarge,
    );

    return EdgeInsets.fromLTRB(
      horizontalPadding,
      addTopPadding ? AppDimensions.paddingXXLarge : 0,
      horizontalPadding,
      addBottomPadding ? AppDimensions.paddingXXLarge : 0,
    );
  }
}

/// Card grid layout for responsive grid display
class CardGridLayout extends StatelessWidget {
  final List<Widget> children;
  final int? crossAxisCount;
  final double? childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsetsGeometry? padding;

  const CardGridLayout({
    super.key,
    required this.children,
    this.crossAxisCount,
    this.childAspectRatio,
    this.crossAxisSpacing = AppDimensions.paddingMedium,
    this.mainAxisSpacing = AppDimensions.paddingMedium,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final columns = crossAxisCount ?? ResponsiveHelper.responsiveGridColumns(context);
    
    if (ResponsiveHelper.isMobile(context)) {
      return Column(
        children: children.map((child) => Padding(
          padding: EdgeInsets.only(bottom: mainAxisSpacing),
          child: child,
        )).toList(),
      );
    }

    return GridView.builder(
      padding: padding,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: childAspectRatio ?? 1.0,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}

/// Two column layout for desktop views
class TwoColumnLayout extends StatelessWidget {
  final Widget leftChild;
  final Widget rightChild;
  final double leftFlex;
  final double rightFlex;
  final double spacing;
  final bool stackOnMobile;

  const TwoColumnLayout({
    super.key,
    required this.leftChild,
    required this.rightChild,
    this.leftFlex = 1,
    this.rightFlex = 1,
    this.spacing = AppDimensions.paddingXLarge,
    this.stackOnMobile = true,
  });

  @override
  Widget build(BuildContext context) {
    if (stackOnMobile && ResponsiveHelper.isMobile(context)) {
      return Column(
        children: [
          leftChild,
          SizedBox(height: spacing),
          rightChild,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: leftFlex.toInt(),
          child: leftChild,
        ),
        SizedBox(width: spacing),
        Expanded(
          flex: rightFlex.toInt(),
          child: rightChild,
        ),
      ],
    );
  }
}
