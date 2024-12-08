import 'package:flutter/material.dart';
import 'package:to_do_list/common_widgets/secondary_button.dart';
import 'package:to_do_list/data/models/task_priority.dart';

class PriorityItem extends StatelessWidget {
  const PriorityItem({
    required this.selectedTaskPriority,
    required this.taskPriorities,
    required this.onTaskPriorityChanged,
    super.key,
  });

  final TaskPriority? selectedTaskPriority;
  final List<TaskPriority> taskPriorities;
  final ValueChanged<TaskPriority> onTaskPriorityChanged;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = taskPriorities
        .asMap()
        .entries
        .map(
          (entry) => Expanded(
            child: Row(
              children: [
                SecondaryButton(
                  title: entry.value.title,
                  isSelected: selectedTaskPriority == entry.value,
                  color: entry.value.color,
                  onTap: () => onTaskPriorityChanged.call(entry.value),
                ),
                if (entry.key < taskPriorities.length - 1)
                  const SizedBox(width: 10),
              ],
            ),
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Priority',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        Row(children: children),
        const SizedBox(height: 8),
      ],
    );
  }
}
