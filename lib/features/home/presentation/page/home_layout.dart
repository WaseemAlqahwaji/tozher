import 'package:flutter/material.dart';
import 'package:tozher/features/auth/presentation/pages/auth_profile_page.dart';
import 'package:tozher/features/goals/presentation/pages/goals_page.dart';
import 'package:tozher/features/home/presentation/page/home_page.dart';
import 'package:tozher/features/search/presentation/page/search_page.dart';
import 'package:tozher/generated/l10n.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late PageController pageController;
  int _currentIndex = 0;
  final _profileKey = GlobalKey<AuthProfilePageState>();

  @override
  void initState() {
    pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Tozher")),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: strings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: strings.search,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt_outlined),
            label: strings.goals,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: strings.profile,
          ),
        ],
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
          if (value == 3) {
            _profileKey.currentState?.reloadData();
          }
        },
      ),
      body: Center(
        child: PageView(
          controller: pageController,
          children: [
            HomePage(),
            SearchPage(),
            GoalsPage(),
            AuthProfilePage(key: _profileKey),
          ],
          onPageChanged: (value) {
            setState(() {
              _currentIndex = value;
            });
            // Reload profile data when switching to profile tab
            if (value == 3) {
              _profileKey.currentState?.reloadData();
            }
          },
        ),
      ),
    );
  }
}
