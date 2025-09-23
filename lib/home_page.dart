import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/mainview/main_view.dart';
import 'package:portfolio/sidebar/left_sidebar.dart';
import 'package:portfolio/sidebar/right_sidebar.dart';
import 'package:portfolio/utils/texts/app_text.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imgs/bg.jpg'), // Path to your image
                fit: BoxFit.cover, // Ensures the image covers the entire screen
              ),
            ),
          ),
          // Scrollable Content
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.subHeader(text: 'Portfolio'),
                      AppText.subHeader(text: 'data'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120.0).r,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return StickySidebar(child: LeftSidebar());
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: MainView(),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return StickySidebar(child: RightSidebar());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StickySidebar extends StatelessWidget {
  final Widget child;

  const StickySidebar({required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        // Logic to keep sidebar fixed when it reaches the top
        return false;
      },
      child: child,
    );
  }
}
