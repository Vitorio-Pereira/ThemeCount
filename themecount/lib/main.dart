import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  void _toggleTheme() async {
    setState(() {
      _themeMode == ThemeMode.light
          ? _themeMode = ThemeMode.dark
          : _themeMode = ThemeMode.light;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', _themeMode.name);
  }

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('theme');
    if (value != null) {
      setState(() {
        _themeMode = ThemeMode.values.byName(value);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThemeCount',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      darkTheme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _themeMode,
      home: MyHomePage(title: 'ThemeCount', onToggleTheme: _toggleTheme),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.onToggleTheme,
  });

  final VoidCallback onToggleTheme;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }

  void _decrementCounter() async {
    setState(() {
      _counter--;
    });
    await _saveCounter();
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await _saveCounter();
  }

  void _resetCounter() async {
    setState(() {
      _counter = 0;
    });
    await _saveCounter();
  }

  void _loadCounter() async {
    var prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt('counter');
    if (value != null) {
      setState(() {
        _counter = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: const Icon(Icons.brightness_6),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _counter > 0 ? _resetCounter : null,
            tooltip: 'Reset',
            child: const Icon(Icons.restart_alt),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _counter > 0 ? _decrementCounter : null,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
