import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'browse.dart';
import 'list.dart';
import 'setting.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final PageController _pageController = PageController();
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Image.asset(
            'assets/images/muvee.png',
            width: 18.w,
          ),
          actions: [
            IconButton(
              icon: LineIcon(
                LineIcons.cog,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ),
                );
              },
            ),
            SizedBox(width: 5.w),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (value) {
            setState(() {
              _selectedPage = value;
            });
          },
          children: const [
            BrowsePage(),
            ListPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          unselectedItemColor: Colors.white38,
          onTap: (value) {
            setState(() {
              _pageController.jumpToPage(value);
              _selectedPage = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: LineIcon(LineIcons.search),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: LineIcon(LineIcons.list),
              label: 'List',
            ),
          ],
        ),
      ),
    );
  }
}
