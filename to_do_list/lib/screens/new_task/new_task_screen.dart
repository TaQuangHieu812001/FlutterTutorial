import 'package:flutter/material.dart';
import 'package:to_do_list/common_widgets/primary_app_bar.dart';
import 'package:to_do_list/common_widgets/primary_button.dart';
import 'package:to_do_list/data/models/task_priority.dart';
import 'package:to_do_list/screens/new_task/widgets/input_field.dart';
import 'package:to_do_list/screens/new_task/widgets/priority_item.dart';
import 'package:to_do_list/screens/new_task/widgets/time_picker.dart';

import '../../constants/app_colors.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});
  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TaskPriority? selectedTaskPriority;

  TimeOfDay? startTime;
  TimeOfDay? endTime;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.hex020206,
        appBar: PrimaryAppBar(
          title: 'Create new task',
          onBack: () {
            Navigator.of(context).pop();
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Schedule",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InputField(
                  hintText: "Name",
                  maxLines: 1,
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 16,
                ),
                InputField(
                  hintText: "Description",
                  maxLines: 4,
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TimePicker(
                        title: 'Start Time',
                        onTimeChanged: (time) {
                          setState(() {
                            startTime = time;
                          });
                        },
                        time: startTime ?? TimeOfDay.now(),
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Expanded(
                      child: TimePicker(
                        time: endTime ?? TimeOfDay.now(),
                        title: 'End Time',
                        onTimeChanged: (time) {
                          setState(() {
                            endTime = time;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                PriorityItem(
                  selectedTaskPriority: selectedTaskPriority,
                  taskPriorities: TaskPriority.values,
                  onTaskPriorityChanged: (taskPriority) {
                    setState(() {
                      selectedTaskPriority = taskPriority;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                PrimaryButton(
                  title: 'Create Task',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
