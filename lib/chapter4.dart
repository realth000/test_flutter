import 'package:flutter/material.dart';

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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, 'chapter_4/constraint_widget');
                  },
                  child: const Text('Constraint Widget'),
                ),
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
