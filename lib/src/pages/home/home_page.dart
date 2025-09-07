import 'package:flutter/material.dart';
import 'package:testeapp/src/pages/home/home_controller.dart';
import 'package:testeapp/src/widgets/task.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;

  const HomePage({required this.controller, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Tarefas"),
            Spacer(),
            StreamBuilder(
                stream: widget.controller.taskCompletionToTotalRatioStream,
                builder: (context, snapshot) => Text(snapshot.requireData))
          ]),
        ),
        body: StreamBuilder(
            stream: widget.controller.tasksStream,
            builder: (context, snapshot) {
              final tasks = snapshot.requireData;
              return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) =>
                      TaskTile(tasks[index], onToggle: (id) async {
                        await widget.controller.toggle(id: id);
                      }));
            }));
  }

  @override
  void dispose() {
    widget.controller.close();
    super.dispose();
  }
}
