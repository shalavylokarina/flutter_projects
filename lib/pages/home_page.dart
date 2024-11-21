import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lab2/object/task.dart';
import 'package:lab2/repository/task_repository.dart';
import 'package:lab2/repository/impl/task_repository_impl.dart';


final TaskRepository _taskRepository = TaskRepositoryImpl();


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool _isConnected = true;

  @override
  void initState() {
    super.initState();

    _connectivity = Connectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isConnected = (result != ConnectivityResult.none);
      });
      if (_isConnected) {
        _fetchTasks();
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

 Future<void> _fetchTasks() async {
  final List<Task> fetchedTasks = await _taskRepository.fetchTasks();
  setState(() {
    tasks = fetchedTasks;
  });
}

Future<void> _addTask(String taskName) async {
  await _taskRepository.addTask(taskName);
  await _fetchTasks();
}

void _deleteTask(String id) async {
  await _taskRepository.deleteTask(id);
  setState(() {
    tasks.removeWhere((task) => task.id == id);
  });

  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddTaskDialog(context),
          ),
        ],
      ),
      body: _isConnected
          ? ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(tasks[index].id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    _deleteTask(tasks[index].id);
                  },
                  child: ListTile(
                    title: TextFormField(
                      initialValue: tasks[index].name,
                      onChanged: (value) {
                        setState(() {
                          tasks[index].name = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Task Name',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: 10,
                        ),
                      ),
                    ),
                    trailing: Checkbox(
                      value: tasks[index].completed,
                      onChanged: (value) {
                        setState(() {
                          tasks[index].completed = value ?? false;
                        });
                      },
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                'No Internet Connection',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

  void _showAddTaskDialog(BuildContext context) {
    String newTaskName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextFormField(
            onChanged: (value) {
              newTaskName = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Task Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addTask(newTaskName);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

