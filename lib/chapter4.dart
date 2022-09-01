import 'package:flutter/material.dart';

import 'common.dart';

class Chapter4Route extends StatelessWidget {
  const Chapter4Route({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Chapter4Widget();
  }
}

class Chapter4Widget extends StatelessWidget {
  const Chapter4Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 4 Route'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                getRoute(context, 'Chapter 4 Constraint Widget',
                    'chapter_4/constraint_widget'),
                getRoute(context, 'Chapter 4 Row Column Widget',
                    'chapter_4/row_column_widget'),
                getRoute(
                    context, 'Chapter 4 Flex Widget', 'chapter_4/flex_widget'),
                getRoute(
                    context, 'Chapter 4 Wrap Widget', 'chapter_4/wrap_widget'),
                getRoute(context, 'Chapter 4 Cascade Widget',
                    'chapter_4/cascade_widget'),
                getRoute(context, 'Chapter 4 Layout Widget',
                    'chapter_4/layout_widget'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Chapter4ConstraintsWidget extends StatefulWidget {
  const Chapter4ConstraintsWidget({Key? key}) : super(key: key);

  @override
  Chapter4ConstraintsWidgetState createState() =>
      Chapter4ConstraintsWidgetState();
}

class Chapter4ConstraintsWidgetState extends State<Chapter4ConstraintsWidget> {
  Widget getBox = const DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 4 Constraint Widget'),
      ),
      body: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 50.0,
            ),
            child: Container(
              height: 5.0,
              child: getBox,
            ),
          ),
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: getBox,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 60, minHeight: 60),
            child: UnconstrainedBox(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 100,
                  minHeight: 100,
                ),
                child: getBox,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Chapter4LinearWidget extends StatefulWidget {
  const Chapter4LinearWidget({Key? key}) : super(key: key);

  @override
  Chapter4LinearWidgetState createState() => Chapter4LinearWidgetState();
}

class Chapter4LinearWidgetState extends State<Chapter4LinearWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 4 Linear Widget'),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Container(
                color: Colors.red,
                child: const Text(
                  " hello world ",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              Container(
                color: Colors.green,
                child: const Text(" I am Jack "),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Container(
                color: Colors.red,
                child: const Text(
                  " hello world ",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              Container(
                color: Colors.green,
                child: const Text(" I am Jack "),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Container(
                color: Colors.red,
                child: const Text(
                  " hello world ",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              Container(
                color: Colors.green,
                child: const Text(" I am Jack "),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Container(
                color: Colors.red,
                child: const Text(
                  " hello world ",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              Container(
                color: Colors.green,
                child: const Text(" I am Jack "),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Chapter4FlexWidget extends StatelessWidget {
  const Chapter4FlexWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flex widget'),
      ),
      body: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: 30,
                  color: Colors.red,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 30,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 100,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 30,
                      color: Colors.red,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 30,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Chapter4WrapWidget extends StatelessWidget {
  const Chapter4WrapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 4 Wrap Widget'),
      ),
      body: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        children: const <Widget>[
          Chip(
            label: Text('aaa'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('A'),
            ),
          ),
          Chip(
            label: Text('bbb'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('B'),
            ),
          ),
          Chip(
            label: Text('ccc'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('C'),
            ),
          ),
          Chip(
            label: Text('ddd'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('D'),
            ),
          ),
        ],
      ),
    );
  }
}

class Chapter4CascadeWidget extends StatelessWidget {
  const Chapter4CascadeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 4 Cascade Widget'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              color: Colors.red,
              child: const Text('container 1'),
            ),
            Positioned(
              left: 18.0,
              child: Container(
                color: Colors.green,
                child: const Text('left: 18.0'),
              ),
            ),
            Positioned(
              right: 18.0,
              child: Container(
                color: Colors.blue,
                child: const Text('right: 18.0'),
              ),
            ),
            Positioned(
              top: 18.0,
              child: Container(
                color: Colors.yellow,
                child: const Text('top: 18.0'),
              ),
            ),
            Positioned(
              bottom: 18.0,
              child: Container(
                color: Colors.orange,
                child: const Text('bottom: 18.0'),
              ),
            ),
            Align(
              alignment:
                  Alignment(Alignment.center.x + 0.2, Alignment.center.y + 0.2),
              child: Container(
                color: Colors.brown,
                child: const Text('container 2'),
              ),
            ),
            Align(
              alignment: const FractionalOffset(0.2, 0.2),
              child: Container(
                color: Colors.deepPurple,
                child: const Text('container 3'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RepeatWidget extends StatelessWidget {
  final List<Widget> children = const <Widget>[
    Text("a"),
    Text("aa"),
    Text("aaa"),
    Text("aaaa"),
    Text("aaaaa"),
    Text("aaaaaa"),
    Text("aaaaaaa"),
    Text("aaaaaaaa"),
    Text("aaaaaaaaa"),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 200) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          );
        } else {
          var c = <Widget>[];
          for (var i = 0; i < children.length; i++) {
            if (i + 1 < children.length) {
              c.add(Row(
                children: [children[i], const Text(" <-> "), children[i + 1]],
              ));
            } else {
              c.add(Row(
                children: [children[i]],
              ));
            }
          }
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: c,
          );
        }
      },
    );
  }
}

class Chapter4LayoutBuilderWidget extends StatelessWidget {
  const Chapter4LayoutBuilderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 4 Layout Widget'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 199,
            child: _RepeatWidget(),
          ),
          _RepeatWidget(),
        ],
      ),
    );
  }
}
