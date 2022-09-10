import 'package:flutter/material.dart';
import 'package:test_flutter/common.dart';

class Chapter8Route extends StatelessWidget {
  const Chapter8Route({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 8 widget'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                getRoute(context, 'Chapter 8 Listener Widget',
                    'chapter_8/listener_widget'),
                getRoute(context, 'Chapter 8 Gesture Widget',
                    'chapter_8/gesture_widget'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Chapter8ListenerWidget extends StatefulWidget {
  const Chapter8ListenerWidget({Key? key}) : super(key: key);

  @override
  State<Chapter8ListenerWidget> createState() => _Chapter8ListenerWidgetState();
}

class _Chapter8ListenerWidgetState extends State<Chapter8ListenerWidget> {
  String _state = "";
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 8 Listener Widget'),
      ),
      body: Listener(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text(
            "$_state:${_event?.localPosition ?? ''}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        onPointerDown: (PointerDownEvent event) {
          setState(() {
            _state = "Down";
            _event = event;
          });
        },
        onPointerMove: (PointerMoveEvent event) {
          setState(() {
            _state = "Move";
            _event = event;
          });
        },
        onPointerUp: (PointerUpEvent event) {
          setState(() {
            _state = "Up";
            _event = event;
          });
        },
      ),
    );
  }
}

class Chapter8GestureWidget extends StatefulWidget {
  const Chapter8GestureWidget({Key? key}) : super(key: key);

  @override
  State<Chapter8GestureWidget> createState() => _Chapter8GestureWidgetState();
}

class _Chapter8GestureWidgetState extends State<Chapter8GestureWidget>
    with SingleTickerProviderStateMixin {
  _Chapter8GestureWidgetState() {
    _pages = <Widget>[
      Center(
        // https://github.com/flutter/flutter/issues/23454
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            child: Text(
              "($_operation)($_left,$_top)",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          onTap: () {
            updateText("Tap!");
          },
          onDoubleTap: () {
            updateText("Double Tap!!");
          },
          onLongPress: () {
            updateText("Long Press");
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.all(50),
        child: Center(
          child: GestureDetector(
            child: const CircleAvatar(
              child: Text('A'),
            ),
            onPanDown: (DragDownDetails e) {
              print('down!');
            },
            onPanUpdate: (DragUpdateDetails e) {
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              print(e.velocity);
            },
          ),
        ),
      ),
      // FIXME: Not working
      Center(
        child: GestureDetector(
          child: Image(
            image: const AssetImage("assets/images/59462104.jpg"),
            width: _picWidth,
          ),
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              _picWidth = 200 * details.scale.clamp(.8, 10.0);
            });
          },
        ),
      ),
    ];
  }

  int _index = 0;
  String _operation = "Test Gesture";
  double _top = 0.0;
  double _left = 0.0;
  double _picWidth = 200.0;
  List<Widget> _pages = <Widget>[];

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 8 Gesture Widget'),
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.one_k), label: '点击'),
          BottomNavigationBarItem(icon: Icon(Icons.two_k), label: '拖动'),
          BottomNavigationBarItem(icon: Icon(Icons.three_k), label: '缩放'),
        ],
      ),
    );
  }
}
