import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      routes: {
        "chapter_3": (context) => Chapter3Route(),
        "/": (context) => MyHomePage(title: 'flutter demo home page'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _clearCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pressed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              RandomWordsWidget(),
              RouterTestRoute(),
              ElevatedButton(
                child: const Text("Open chapter 3 route ✌✌✌"),
                onPressed: () {
                  Navigator.pushNamed(context, "chapter_3");
                },
              )
            ],
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 80),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: "clearCounterButton",
                  onPressed: _clearCounter,
                  tooltip: 'Clear',
                  child: Icon(Icons.clear),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: "addCounterButton",
                onPressed: _incrementCounter,
                tooltip: 'Add',
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ));
  }
}

// 2.4.4
class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return TipRoute(text: "route chapter 2");
          }));
        },
        child: const Text("Open chapter 2 route✌✌"),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  String getTime() {
    return DateTime.now().toString().substring(0, 19);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 2 Route'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, getTime()),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 2.5.3
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Padding(
        padding: const EdgeInsets.all(8), child: Text("Random text=$wordPair"));
  }
}

// 3
class Chapter3Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chapter 3 Route'),
        ),
        body: Chapter3Widget());
  }
}

class Chapter3Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: Center(
        child: Column(
          children: <Widget>[
            Chapter3TextWidget(),
            Chapter3ButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class Chapter3TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          "Chapter 3.1.1-1",
          textAlign: TextAlign.left,
        ),
        Text(
          "Chapter 3.1.1-2 3.1415926535897 2.71828" * 2,
          textAlign: TextAlign.left,
          maxLines: 1,
        ),
        const Text(
          "Chapter 3.1.1-3",
          textAlign: TextAlign.left,
        ),
        const Text(
          "Chapter 3.1.1-4@r",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18,
            height: 1.2,
            fontFamily: "Consolas",
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dashed,
          ),
        )
      ],
    );
  }
}

class Chapter3ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              child: const Text("Elevated Button"),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.flight),
              onPressed: () {},
              label: const Text("Elevated Button With Icon"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Text Button"),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text("Text Button With Icon"),
              icon: const Icon(Icons.abc),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text("Outline Button"),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              label: const Text("Outline Button With Icon"),
              icon: const Icon(Icons.abc_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.ac_unit),
              tooltip: "Icon Button",
            )
          ],
        ),
      ),
    );
  }
}
