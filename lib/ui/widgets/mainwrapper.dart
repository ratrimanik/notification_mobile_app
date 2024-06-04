import 'package:flutter/material.dart';
import 'package:pd_app/ui/screen/add_task_screen.dart';
import 'package:pd_app/ui/screen/category_screen.dart';
import 'package:pd_app/ui/screen/home_screen.dart';
import 'package:pd_app/ui/theme/theme.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Icon(Icons.featured_play_list_rounded, size: 150),
    const AddTaskScreen(),
    const CategoryScreen(),
    const Icon(Icons.account_circle_rounded, size: 150),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: orangeClr,
            indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
        child: NavigationBar(
          height: 80,
          backgroundColor: const Color(0XFF5A55CB),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Colors.grey),
              selectedIcon: Icon(Icons.home_rounded, color: Colors.white),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.done_all_outlined, color: Colors.grey),
              selectedIcon: Icon(Icons.done_all, color: Colors.white),
              label: 'Completed',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_circle_outlined, color: Colors.grey),
              selectedIcon: Icon(Icons.add_circle, color: Colors.white),
              label: 'Add Task',
            ),
            NavigationDestination(
              icon: Icon(Icons.folder_copy_outlined, color: Colors.grey),
              selectedIcon: Icon(Icons.folder_copy, color: Colors.white),
              label: 'Category',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle_outlined, color: Colors.grey),
              selectedIcon: Icon(Icons.account_circle, color: Colors.white),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
