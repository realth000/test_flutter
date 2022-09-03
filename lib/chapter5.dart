import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/common.dart';

class Chapter5Route extends StatelessWidget {
  const Chapter5Route({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Chapter5Widget();
  }
}

class Chapter5Widget extends StatelessWidget {
  const Chapter5Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 5 Route'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                getRoute(context, 'Chapter 5 Padding Widget',
                    'chapter_5/padding_widget'),
                getRoute(context, 'Chapter 5 Decorated Widget',
                    'chapter_5/decorated_widget'),
                getRoute(context, 'Chapter 5 Transform Widget',
                    'chapter_5/transform_widget'),
                getRoute(context, 'Chapter 5 Container Widget',
                    'chapter_5/container_widget'),
                getRoute(
                    context, 'Chapter 5 Clip Widget', 'chapter_5/clip_widget'),
                getRoute(context, 'Chapter 5 Fitted Widget',
                    'chapter_5/fitted_widget'),
                getRoute(context, 'Chapter 5 Scaffold Widget',
                    'chapter_5/scaffold_widget'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Chapter5PaddingWidget extends StatelessWidget {
  const Chapter5PaddingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 5 Padding Widget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                color: Colors.red,
                child: const Text('<-first->'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                color: Colors.green,
                child: const Text('<-Second->'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                color: Colors.blue,
                child: const Text("<-Third->"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Container(
                color: Colors.yellow,
                child: const Text("<-Fourth->"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Container(
                color: Colors.brown,
                child: const Text("<-Fifth->"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Chapter5DecorateWidget extends StatelessWidget {
  const Chapter5DecorateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 5 Decorated Widget'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange.shade700]),
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text(
                  'Login1',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.red, Colors.orange.shade700]),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.green,
                    offset: Offset(5.0, 2.0),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text(
                  'Login2',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange.shade700]),
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text(
                  'Login3',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Chapter5TransformWidget extends StatelessWidget {
  const Chapter5TransformWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 5 Transform Widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.black,
              child: Transform(
                alignment: Alignment.topRight,
                transform: Matrix4.skewY(0.3),
                child: Container(
                  padding: const EdgeInsets.all(18.0),
                  color: Colors.deepOrange,
                  child: const Text('A Transform!!!'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Container(
                color: Colors.black,
                child: Transform.translate(
                  offset: const Offset(10.0, 20.0),
                  child: Container(
                    padding: const EdgeInsets.all(18.0),
                    color: Colors.deepOrange,
                    child: const Text('B Transform!!!'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Container(
                color: Colors.black,
                child: Transform.rotate(
                  angle: math.pi / 10,
                  child: Container(
                    padding: const EdgeInsets.all(18.0),
                    color: Colors.deepOrange,
                    child: const Text('C Transform!!!'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Container(
                color: Colors.black,
                child: Transform.rotate(
                  angle: math.pi / 10,
                  child: Container(
                    color: Colors.deepOrange,
                    child: const RotatedBox(
                      quarterTurns: 1,
                      child: Text('D Transform!!!'),
                    ),
                  ),
                ),
              ),
            ),
            const Text("EEE"),
          ],
        ),
      ),
    );
  }
}

class Chapter5ContainerWidget extends StatelessWidget {
  const Chapter5ContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 5 Container Widget'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 50.0, left: 120.0),
            constraints:
                const BoxConstraints.tightFor(width: 200.0, height: 150.0),
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.red, Colors.orange],
                center: Alignment.topLeft,
                radius: .98,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                ),
              ],
            ),
            transform: Matrix4.rotationZ(.2),
            alignment: Alignment.center,
            child: const Text(
              "5.20",
              style: TextStyle(color: Colors.white, fontSize: 40.0),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.orange),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            color: Colors.orange,
            child: const Text('Hello world margin'),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            color: Colors.orange,
            child: const Text('Hello world padding'),
          )
        ],
      ),
    );
  }
}

class Chapter5ClipWidget extends StatelessWidget {
  const Chapter5ClipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget pic = Image.network(
        'https://avatars.githubusercontent.com/u/59462104?v=4',
        width: 60.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 5 Clip Widget'),
      ),
      body: Column(
        children: <Widget>[
          pic,
          ClipOval(
            child: pic,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ],
      ),
    );
  }
}

class Chapter5FittedWidget extends StatelessWidget {
  const Chapter5FittedWidget({Key? key}) : super(key: key);

  Widget wRow(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text(text), Text(text), Text(text)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 5 Fitted widget'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                FittedBox(child: wRow(' 90000000000000000 ')),
                wRow(' 800 '),
                FittedBox(child: wRow(' 800 ')),
              ]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: e,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Chapter5ScaffoldWidget extends StatefulWidget {
  const Chapter5ScaffoldWidget({Key? key}) : super(key: key);

  @override
  _Chapter5ScaffoldWidgetState createState() => _Chapter5ScaffoldWidgetState();
}

class _Chapter5ScaffoldWidgetState extends State<Chapter5ScaffoldWidget> {
  int _currentIndex = 0;

  void _setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 5 Scaffold Widget'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      drawer: Drawer(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 38),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ClipOval(
                        child: Image.network(
                          'https://avatars.githubusercontent.com/u/59462104?v=4',
                          width: 60,
                        ),
                      ),
                    ),
                    const Text(
                      'TEST FLUTTER',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.add),
                      title: Text('Add'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.arrow_back),
                      title: const Text('Return'),
                      onTap: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('chapter_5'));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: 'BUSINESS'),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: 'BUSINESS'),
        ],
        currentIndex: _currentIndex,
        onTap: _setCurrentIndex,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
