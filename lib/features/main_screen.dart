import 'package:flutter/material.dart';
import 'package:cresta_app/features/profile/profile_screen.dart';
import 'package:cresta_app/features/search/talent_search_screen.dart';
import 'package:cresta_app/main.dart';
import 'package:cresta_app/widgets/app_logo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    ProfileScreen(),
    TalentSearchScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _screens.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;

        if (isDesktop) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              backgroundColor: Theme.of(context).cardColor,
              title: Row(
                children: [
                  const AppLogo(height: 30, color: AppColors.lavandaSuave),
                  const SizedBox(width: 48),
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      labelColor: AppColors.lavandaSuave,
                      unselectedLabelColor: AppColors.grisMedio,
                      indicatorColor: AppColors.lavandaSuave,
                      indicatorWeight: 3,
                      onTap: (index) => setState(() => _selectedIndex = index),
                      tabs: const [
                        Tab(text: 'Mi Perfil'),
                        Tab(text: 'Buscar Talentos'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: _screens,
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: _screens.elementAt(_selectedIndex)),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Mi Perfil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  activeIcon: Icon(Icons.search),
                  label: 'Buscar',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.lavandaSuave,
              unselectedItemColor: AppColors.grisMedio,
              onTap: _onItemTapped,
            ),
          );
        }
      },
    );
  }
}