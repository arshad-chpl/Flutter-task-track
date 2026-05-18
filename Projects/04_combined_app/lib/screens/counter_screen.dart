import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _incrementCounter() {
    if (_counter < 5) {
      setState(() => _counter++);
    } else {
      _showMessage('Maximum limit reached!');
    }
  }

  void _decrementCounter() {
    if (_counter > -5) {
      setState(() => _counter--);
    } else {
      _showMessage('Minimum limit reached!');
    }
  }

  void _resetCounter() {
    setState(() => _counter = 0);
    _showMessage('Counter Reset');
  }

  String get status {
    if (_counter > 0) return "Positive";
    if (_counter < 0) return "Negative";
    return "Zero";
  }

  Color get statusColor {
    if (_counter > 0) return Colors.green;
    if (_counter < 0) return Colors.red;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 139, 201, 249),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF5C6BC0),
        centerTitle: true,
        title: const Text(
          "Counter",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              status,
              style: TextStyle(
                fontSize: 22,
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                FloatingActionButton(
                  heroTag: 'minus',
                  onPressed: _decrementCounter,
                  child: const Icon(Icons.remove),
                ),

                const SizedBox(width: 15),

                FloatingActionButton(
                  heroTag: 'reset',
                  onPressed: _resetCounter,
                  backgroundColor: Colors.orange,
                  child: const Icon(Icons.refresh),
                ),

                const SizedBox(width: 15),

                FloatingActionButton(
                  heroTag: 'add',
                  onPressed: _incrementCounter,
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Limit: -5 to +5',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}