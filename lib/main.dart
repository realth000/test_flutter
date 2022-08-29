import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'chapter4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      routes: {
        "chapter_3": (context) => const Chapter3Route(),
        "chapter_4": (context) => const Chapter4Route(),
        "chapter_4/constraint_widget": (context) =>
            const Chapter4ConstraintsWidget(),
        "/": (context) => const _MyHomePage(title: 'flutter demo home page'),
      },
    );
  }
}

class _MyHomePage extends StatefulWidget {
  const _MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
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
              const RandomWordsWidget(),
              const RouterTestRoute(),
              ElevatedButton(
                child: const Text("Open chapter 3 route ✌✌✌"),
                onPressed: () {
                  Navigator.pushNamed(context, "chapter_3");
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "chapter_4");
                },
                child: const Text("Open chapter 4 route ✌✌✌✌"),
              ),
            ],
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: "clearCounterButton",
                  onPressed: _clearCounter,
                  tooltip: 'Clear',
                  child: const Icon(Icons.clear),
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
  const RouterTestRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const TipRoute(text: "route chapter 2");
          }));
        },
        child: const Text("Open chapter 2 route✌✌"),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  const TipRoute({
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
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, getTime()),
                child: const Text("返回"),
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
  const RandomWordsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Padding(
        padding: const EdgeInsets.all(8), child: Text("Random text=$wordPair"));
  }
}

// 3
class Chapter3Route extends StatelessWidget {
  const Chapter3Route({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chapter 3 Route'),
        ),
        body: const Chapter3Widget());
  }
}

class Chapter3Widget extends StatelessWidget {
  const Chapter3Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      // padding: const EdgeInsets.all(18),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const Chapter3TextWidget(),
              const Chapter3ButtonWidget(),
              const Chapter3IconWidget(),
              Chapter3SwitchWidget(),
              Chapter3TextFieldWidget(),
              Chapter3ProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class Chapter3TextWidget extends StatelessWidget {
  const Chapter3TextWidget({Key? key}) : super(key: key);

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
  const Chapter3ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
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

class Chapter3IconWidget extends StatelessWidget {
  const Chapter3IconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Center(
        child: Column(
          children: <Widget>[
            const Image(
              image: AssetImage('assets/images/1finger.png'),
              width: 30,
            ),
            const Image(
              image: NetworkImage(
                  'https://avatars.githubusercontent.com/u/59462104?v=4'),
              width: 30,
            ),
            Image.network(
              'https://avatars.githubusercontent.com/u/59462104?v=4',
              width: 60,
            ),
            const Icon(
              Icons.fingerprint,
              color: Colors.red,
            ),
            const Icon(
              _Chapger3MyIcons.data1,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class _Chapger3MyIcons {
  static const IconData data1 = IconData(
    0xf89b,
    fontFamily: 'fontawesome',
    matchTextDirection: true,
  );
}

class Chapter3SwitchWidget extends StatefulWidget {
  const Chapter3SwitchWidget({Key? key}) : super(key: key);

  @override
  _SwitchAndCheckBoxTestRouteState createState() =>
      _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState extends State<Chapter3SwitchWidget> {
  bool _switchSelected = true;
  bool _checkboxSelected = true;
  String switchState = 'closed';
  String checkboxState = 'closed';

  void updateSwitch() {
    setState(() {
      switchState = _switchSelected ? 'opened' : 'closed';
      checkboxState = _checkboxSelected ? 'opened' : 'closed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Switch(
                  value: _switchSelected,
                  onChanged: (value) {
                    setState(() {
                      _switchSelected = value;
                      updateSwitch();
                    });
                  },
                ),
                Text(
                  switchState,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  value: _checkboxSelected,
                  tristate: false,
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        _checkboxSelected = false;
                      } else {
                        _checkboxSelected = value;
                      }
                      updateSwitch();
                    });
                  },
                ),
                Text(
                  checkboxState,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Chapter3TextFieldWidget extends StatefulWidget {
  const Chapter3TextFieldWidget({Key? key}) : super(key: key);

  @override
  _Chapter3TextFieldWidgetState createState() =>
      _Chapter3TextFieldWidgetState();
}

class _Chapter3TextFieldWidgetState extends State<Chapter3TextFieldWidget> {
  String _accountString = '';
  String _passwordString = '';
  bool _loggedin = false;
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  void _updateAccount(String account) {
    setState(() {
      _accountString = account;
    });
  }

  void _updatePassword(String password) {
    setState(() {
      _passwordString = password;
    });
  }

  @override
  void initState() {
    // FIXME: Why must call super.initState here, as build function does not need it.
    super.initState();
    _accountController.addListener(() {
      _updateAccount(_accountController.text);
    });
    _passwordController.addListener(() {
      _updatePassword(_passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: "Account",
              hintText: "Username or email",
              prefixIcon: Icon(Icons.person),
            ),
            controller: _accountController,
            validator: (v) {
              return v!.trim().isNotEmpty ? null : 'User can not be empty';
            },
          ),
          Text("acount=$_accountString"),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Your password",
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
            controller: _passwordController,
            validator: (v) {
              return v!.trim().length > 5 ? null : 'Password should > 5';
            },
          ),
          Text("password=$_passwordString"),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _loggedin =
                            (_formKey.currentState as FormState).validate();
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(18),
                      child: Text('ok'),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text("loggedin=$_loggedin"),
        ],
      ),
    );
  }
}

class Chapter3ProgressIndicator extends StatefulWidget {
  @override
  _Chapter3ProgressIndicatorState createState() =>
      _Chapter3ProgressIndicatorState();
}

class _Chapter3ProgressIndicatorState extends State<Chapter3ProgressIndicator> {
  bool _running = true;
  double _value = 0;
  Timer? _timer;

  void _updateValue(Timer timer) {
    setState(() {
      print("Update value on" + DateTime.now().toString().substring(0, 19));
      _value += 0.1;
      if (_value >= 1) {
        _value -= 1;
      }
    });
  }

  _Chapter3ProgressIndicatorState() {
    _timer = Timer.periodic(const Duration(seconds: 1), _updateValue);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 10,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.lime),
                value: _value,
              ),
            ),
            SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.lime),
                value: _value,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _running = !_running;
                if (!_running) {
                  _timer?.cancel();
                } else {
                  // TODO: Restart timer?
                }
              },
              child: const Text('control'),
            ),
          ],
        ),
      ),
    );
  }
}

/*
   ABCDEFGHIJKLMNOPQRSTUVWXYZ
   abcdefghijklmnopqrstuvwxyz
   0123456789
   oOiIl1
   ~!@#$%^&*()

 */
