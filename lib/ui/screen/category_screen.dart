import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pd_app/ui/theme/theme.dart';
import 'package:pd_app/ui/widgets/button.dart';
import 'package:pd_app/ui/widgets/category_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: const Padding(
          padding: EdgeInsets.only(top: 16.0, left: 30.0, right: 12.0,),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    CategoryItem(
                      icon: Icons.school,
                      color: Colors.blue,
                      text: 'Education',
                    ),
                    CategoryItem(
                      icon: Icons.health_and_safety,
                      color: Colors.green,
                      text: 'Health',
                    ),
                  ],
                ),
                Row(
                  children: [
                    CategoryItem(
                      icon: Icons.work,
                      color: Colors.orange,
                      text: 'Work',
                    ),
                    CategoryItem(
                      icon: Icons.sports_soccer,
                      color: Colors.blue,
                      text: 'Sports',
                    ),
                  ],
                ),
                Row(
                  children: [
                    CategoryItem(
                      icon: Icons.music_note,
                      color: Colors.purple,
                      text: 'Music',
                    ),
                    CategoryItem(
                      icon: Icons.travel_explore,
                      color: Colors.red,
                      text: 'Travel',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}


_appBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: context.theme.colorScheme.background,
    title: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category',
                style: headingStyle
              ),
            ],
          ),
          MyButton(
            label: 'Back',
            color: Get.isDarkMode ? white : primaryClr,
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
    ),
  );
}
