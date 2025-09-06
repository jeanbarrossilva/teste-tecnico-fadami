import 'package:flutter/material.dart';
import 'package:testeapp/src/domain/todo.dart';

class TaskTile extends StatefulWidget {
  final Todo task;

  const TaskTile(this.task, {super.key});

  @override
  State<StatefulWidget> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(widget.task.title,
            style: (ListTileTheme.of(context).titleTextStyle ?? TextStyle())
                .apply(
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
        leading: Checkbox(
            value: widget.task.isCompleted,
            onChanged: (value) {
              setState(() {
                if (value == null) return;
                widget.task.toggle();
              });
            }),
        onTap: () {
          setState(widget.task.toggle);
        },
      );
}
