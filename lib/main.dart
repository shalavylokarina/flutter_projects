import 'package:flutter/material.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магічний Лічильник',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Магічний Лічильник'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  int _counter = 0;
  String _message = '';
  Color _backgroundColor = Colors.white;

  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  void _processInput() {
    setState(() {
      final input = _textController.text.trim().toLowerCase();
      if (input == 'expecto patronum') {
        _counter = 0;
        _message = 'Лічильник обнулено!Патронус відганяє всі числа!';
      } else if (input == 'alohomora') {
        _counter *= 2;
        _message = 'Лічильник подвоєно!';
      } else if (input == 'colovaria') {
        _backgroundColor = _colors[_counter % _colors.length];
        _message = 'Змінено колір фону!';
      } else {
        final number = int.tryParse(input);
        if (number != null) {
          _counter += number;
          _message = 'Додано $number до лічильника.';
        } else {
          _counter++;
          _message = 'Невідома команда. Лічильник збільшено на 1.';
        }
      }
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        color: _backgroundColor,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Поточне значення:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Введіть число або магічне слово',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => _processInput(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _processInput,
              child: const Text('Виконати магію'),
            ),
            const SizedBox(height: 20),
            Text(
              _message,
              style: const TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}