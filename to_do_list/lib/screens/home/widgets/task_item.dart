import 'package:flutter/material.dart';
import 'package:to_do_list/data/models/task_priority.dart';
import 'package:to_do_list/data/models/task_status.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_icons.dart';
import '../../../data/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    required this.taskModel,
    required this.onStatusChanged,
    super.key,
  });

  final TaskModel taskModel;
  final ValueChanged<TaskStatus> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.hex181818,
      ),
      child: Row(
        children: [
          Container(
            width: 15,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              color: taskModel.priority.color,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  taskModel.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Image.asset(AppIcons.calendar, width: 15),
                    const SizedBox(width: 7),
                    Text(
                      taskModel.displayDate,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (taskModel.taskStatus == TaskStatus.complete) {
                onStatusChanged.call(TaskStatus.incomplete);
              } else {
                onStatusChanged.call(TaskStatus.complete);
              }
            },
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                taskModel.taskStatus.icon,
                width: 26,
                height: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
