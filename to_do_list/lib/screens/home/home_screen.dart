import 'package:flutter/material.dart';
import 'package:to_do_list/data/models/task_model.dart';
import 'package:to_do_list/data/models/task_priority.dart';
import 'package:to_do_list/data/models/task_status.dart';
import 'package:to_do_list/screens/home/widgets/add_button.dart';
import 'package:to_do_list/screens/home/widgets/header_item.dart';
import 'package:to_do_list/screens/home/widgets/home_app_bar.dart';
import 'package:to_do_list/screens/home/widgets/progress_item.dart';
import 'package:to_do_list/screens/home/widgets/search_field.dart';
import 'package:to_do_list/screens/home/widgets/task_item.dart';
import 'package:to_do_list/screens/new_task/new_task_screen.dart';

import '../../constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tasks = <TaskModel>[
    TaskModel(
      id: 1,
      name: 'Mobile App Research',
      description: 'Mobile App Research',
      startTime: TimeOfDay.now(),
      endTime: TimeOfDay.now(),
      date: DateTime.now(),
      priority: TaskPriority.high,
      taskStatus: TaskStatus.complete,
    ),
    TaskModel(
      id: 2,
      name: 'Prepare Wireframe for Main Flow',
      description: 'Prepare Wireframe for Main Flow',
      startTime: TimeOfDay.now(),
      endTime: TimeOfDay.now(),
      date: DateTime.now(),
      priority: TaskPriority.medium,
      taskStatus: TaskStatus.complete,
    ),
    TaskModel(
      id: 3,
      name: 'Prepare Screens',
      description: 'Prepare Screens',
      startTime: TimeOfDay.now(),
      endTime: TimeOfDay.now(),
      date: DateTime.now(),
      priority: TaskPriority.low,
      taskStatus: TaskStatus.incomplete,
    ),
    TaskModel(
      id: 4,
      name: 'Mobile App Research',
      description: 'Mobile App Research',
      startTime: TimeOfDay.now(),
      endTime: TimeOfDay.now(),
      date: DateTime.now().add(const Duration(days: 1)),
      priority: TaskPriority.high,
      taskStatus: TaskStatus.complete,
    ),
    TaskModel(
      id: 5,
      name: 'Prepare Wireframe for Main Flow',
      description: 'Prepare Wireframe for Main Flow',
      startTime: TimeOfDay.now(),
      endTime: TimeOfDay.now(),
      date: DateTime.now().add(const Duration(days: 1)),
      priority: TaskPriority.medium,
      taskStatus: TaskStatus.complete,
    ),
    TaskModel(
      id: 6,
      name: 'Prepare Screens',
      description: 'Prepare Screens',
      startTime: TimeOfDay.now(),
      endTime: TimeOfDay.now(),
      date: DateTime.now().add(const Duration(days: 1)),
      priority: TaskPriority.low,
      taskStatus: TaskStatus.incomplete,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final todayTasks = tasks.where((task) {
      return DateUtils.isSameDay(
        task.date,
        DateTime.now(),
      );
    }).toList();

    final tomorrowTasks = tasks.where((task) {
      return DateUtils.isSameDay(
        task.date,
        DateTime.now().add(
          const Duration(days: 1),
        ),
      );
    }).toList();

    final numberOfCompletedTodayTask = todayTasks.where((task) {
      return task.taskStatus == TaskStatus.complete;
    }).length;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.hex020206,
        appBar: HomeAppBar(
          onSearchChanged: (value) {
            debugPrint("Search text changed: $value");
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  child: SearchField(
                    hintText: "Search Task Here",
                    onChanged: (value) {
                      debugPrint("Search text changed: $value");
                    },
                  ),
                ),
                const HeaderItem(title: 'Progress'),
                ProgressItem(
                  numberOfCompletedTask: numberOfCompletedTodayTask,
                  numberOfTasks: todayTasks.length,
                ),
                const HeaderItem(title: "Today's Task"),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel: todayTasks[index],
                      onStatusChanged: (taskStatus) {
                        final taskIndex = tasks.indexWhere(
                          (e) => e.id == todayTasks[index].id,
                        );
                        setState(() {
                          tasks[taskIndex] = todayTasks[index]
                              .copyWith(taskStatus: taskStatus);
                        });
                      },
                    );
                  },
                  itemCount: todayTasks.length,
                  shrinkWrap: true,
                ),
                const HeaderItem(title: "Tomorrow Task"),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel: tomorrowTasks[index],
                      onStatusChanged: (taskStatus) {
                        final taskIndex = tasks.indexWhere(
                          (e) => e.id == tomorrowTasks[index].id,
                        );
                        setState(() {
                          tasks[taskIndex] = tomorrowTasks[index]
                              .copyWith(taskStatus: taskStatus);
                        });
                      },
                    );
                  },
                  itemCount: tomorrowTasks.length,
                  shrinkWrap: true,
                ),
                const SizedBox(
                  height: 110,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: AddButton(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const NewTaskScreen();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
