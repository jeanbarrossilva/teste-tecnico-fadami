import 'package:flutter/material.dart';
import 'package:testeapp/src/domain/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> tasks = [
    Todo(title: "Habilitar a interação com o checkbox"),
    Todo(title: "Implementar ListView na lista de tarefas"),
    Todo(title: "Na classe Todo, implementar metodo para inverter o status atual da tarefa"),
    Todo(title: "Na classe Todo, implementar o factory fromMap() para instanciar o objeto a partir de um Map<String, dynamic>"),
    Todo(title: "Customizar item que esteja concluído"),
    Todo(title: "Adicionar um contador de tarefas. Ex.: 3/10"),
    Todo(title: "Abstrair a tarefa para um Widget reutilizável no arquivo /src/widgets/task.dart"),
    Todo(title: "Utilize a classe HiveRepository para salvar o estado da lista de tarefas no dispositivo"),
    Todo(title: "Ao reiniciar o app o estado da lista salvo deve ser retomado"),
    Todo(title: "Instalar e configurar o GetX no projeto"),
    Todo(title: "Refatorar o app.dart, home_page.dart e task.dart para usar GetX"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas")),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(tasks.length, (index) {
            final item = tasks[index];

            return ListTile(
              title: Text(item.title),
              leading: Checkbox(value: item.isCompleted, onChanged: (value) {}),
              onTap: () {
                setState(() {
                  if (item.isCompleted) {
                    item.uncomplete();
                  } else {
                    item.complete();
                  }
                });
              },
            );
          }),
        ),
      ),
    );
  }
}
