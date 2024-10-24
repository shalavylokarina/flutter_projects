import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List<String> tasks = [
    'Task 1',
    'Task 2',
    'Task 3',
    'Task 4',
  ];
  List<bool> taskCompleted = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                tasks.add('New Task ${tasks.length + 1}');
                taskCompleted.add(false);
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              tasks[index],
              style: TextStyle(
                fontSize: screenSize.width * 0.04,
              ),
            ),
            value: taskCompleted[index],
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  taskCompleted[index] = value;
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
        child: const Icon(Icons.person),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}