import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
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
      backgroundColor: Colors.lightBlueAccent,

      appBar: AppBar(
        title: Text('Counter App'),
        centerTitle: true,
      ),

      body: Center(
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Positioned(
              left: 500,
              child: Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 10),

            Text(
              status,
              style: TextStyle(
                fontSize: 22,
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                FloatingActionButton(
                  heroTag: 'minus',
                  onPressed: _decrementCounter,
                  child: Icon(Icons.remove),
                ),

                SizedBox(width: 15),

                FloatingActionButton(
                  heroTag: 'reset',
                  onPressed: _resetCounter,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.refresh),
                ),

                SizedBox(width: 15),

                FloatingActionButton(
                  heroTag: 'add',
                  onPressed: _incrementCounter,
                  child: Icon(Icons.add),
                ),
              ],
            ),

            SizedBox(height: 20),

            Text(
              'Limit: -5 to +5',
              style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 34,
              ),
            ),
          ],
        ),
      ),
    );
  }
}