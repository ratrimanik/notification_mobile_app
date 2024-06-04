import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pd_app/controllers/task_controller.dart';
import 'package:pd_app/models/task.dart';
import 'package:pd_app/services/notification_services.dart';
import 'package:pd_app/services/theme_services.dart';
import 'package:pd_app/ui/theme/theme.dart';
import 'package:pd_app/ui/widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestAndroidPermissions();
    setState(() {
      print("I am here");
    });
  }

  @override
  Widget build(BuildContext context) {
    _taskController.getTasks();
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addDateBar(),
          const SizedBox(
            height: 10,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];

              bool shouldShowTask = task.repeat == 'Daily' ||
                  task.date == DateFormat.yMd().format(_selectedDate);

              if (shouldShowTask) {
                try {
                  // Assuming startTime is in format like "01:30 AM" or "09:05"
                  String startTime = task.startTime.toString().trim();

                  // Handle both "hh:mm a" and "HH:mm" formats
                  DateTime date;
                  if (startTime.contains("AM") || startTime.contains("PM")) {
                    date = DateFormat.jm().parse(startTime);
                  } else {
                    date = DateFormat("HH:mm").parse(startTime);
                  }

                  String myTime = DateFormat("HH:mm").format(date);
                  int hour = int.parse(myTime.split(":")[0]);
                  int minutes = int.parse(myTime.split(":")[1]);
                  notifyHelper.scheduledNotification(hour, minutes, task);
                } catch (e) {
                  print("Error parsing startTime: ${task.startTime}, Error: $e");
                }

                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }
        );
      }),
    );
  }



  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(
          top: 4,
        ),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
            ),
            const Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    },
                    clr: primaryClr,
                    context: context,
                  ),
            _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context,
            ),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              clr: Colors.red[300]!,
              isClose: true,
              context: context,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today",
            style: headingStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              dayTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              monthTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;

                });
              },
            ),
          ),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: subHeadingStyle,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ThemeService().switchTheme();
                  notifyHelper.displayNotification(
                    title: "Theme Changed",
                    body: Get.isDarkMode
                        ? "Activated Light Theme"
                        : "Activated Dark Theme",
                  );
                  // notifyHelper.scheduledNotification();
                },
                child: Icon(
                  Icons.search_outlined,
                  size: 24,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              GestureDetector(
                onTap: () {
                  ThemeService().switchTheme();
                  notifyHelper.displayNotification(
                    title: "Theme Changed",
                    body: Get.isDarkMode
                        ? "Activated Light Theme"
                        : "Activated Dark Theme",
                  );
                  notifyHelper.scheduledNotification();
                },
                child: Icon(
                  Get.isDarkMode
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight_round,
                  size: 20,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}