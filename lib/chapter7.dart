import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter/common.dart';

class Chapter7Route extends StatelessWidget {
  const Chapter7Route({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Chapter7Widget();
  }
}

class Chapter7Widget extends StatelessWidget {
  const Chapter7Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 7 Route'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                getRoute(context, 'Chapter 7 WillPopScope Widget',
                    'chapter_7/willpopscope_widget'),
                getRoute(context, 'Chapter 7 Theme Widget',
                    'chapter_7/theme_widget'),
                getRoute(context, 'Chapter 7 Value Listener Widget',
                    'chapter_7/value_listener_widget'),
                getRoute(context, 'Chapter 7 Update Widget',
                    'chapter_7/update_widget'),
                getRoute(context, 'Chapter 7 Dialog Widget',
                    'chapter_7/dialog_widget'),
                getRoute(context, 'Chapter 7 General Widget',
                    'chapter_7/general_widget'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Chapter7WillPopScopeWidget extends StatefulWidget {
  const Chapter7WillPopScopeWidget({Key? key}) : super(key: key);

  @override
  State<Chapter7WillPopScopeWidget> createState() =>
      _Chapter7WillPopScopeWidgetState();
}

showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey[300],
    textColor: Colors.black54,
    fontSize: 16.0,
  );
}

class _Chapter7WillPopScopeWidgetState
    extends State<Chapter7WillPopScopeWidget> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 7 WillPopScope Widget'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt!) >
                  const Duration(seconds: 1)) {
            showToast("??????????????????");
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              const Text('??????????????????'),
              ElevatedButton(
                onPressed: () {
                  showToast("??????????????????");
                },
                child: const Text("check"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InheritedProvider<T> extends InheritedWidget {
  const InheritedProvider({required this.data, required Widget child})
      : super(child: child);

  final T data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class ChangeNotifier implements Listenable {
  List listeners = [];

  @override
  void addListener(VoidCallback listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
  }

  void notifyListeners() {
    listeners.forEach((element) {
      element();
    });
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({Key? key, required this.data, required this.child});

  final Widget child;
  final T data;

  // FIXME: Not work
  // static T of<T>(BuildContext context) {
  //   final type = _typeOf<InheritedProvider<T>>();
  //   final provider =  context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
  //   return provider.data;
  // }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    //???????????????????????????model????????????notifyListeners??????????????????InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //???Provider?????????????????????????????????"=="?????????????????????????????????????????????????????????
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // ???model???????????????
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // ??????model????????????
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

class Chapter7ThemeWidget extends StatefulWidget {
  const Chapter7ThemeWidget({Key? key}) : super(key: key);

  @override
  State<Chapter7ThemeWidget> createState() => _Chapter7ThemeWidgetState();
}

class _Chapter7ThemeWidgetState extends State<Chapter7ThemeWidget> {
  var _themeColor = Colors.lime;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor,
        iconTheme: IconThemeData(color: _themeColor),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chapter 7 Color Theme'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text("Follow main theme."),
              ],
            ),
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(
                  color: Colors.black54,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("Always black54."),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(
              () {
                _themeColor =
                    _themeColor == Colors.lime ? Colors.cyan : Colors.lime;
              },
            );
          },
          child: const Icon(Icons.palette),
        ),
      ),
    );
  }
}

class Chapter7ValueListenerWidget extends StatefulWidget {
  const Chapter7ValueListenerWidget({Key? key}) : super(key: key);

  @override
  State<Chapter7ValueListenerWidget> createState() =>
      _Chapter7ValueListenerWidgetState();
}

class _Chapter7ValueListenerWidgetState
    extends State<Chapter7ValueListenerWidget> {
  // ??????????????????
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  static const double textScaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 7 Value listener Widget'),
      ),
      body: Center(
        // ??????_counter?????????
        child: ValueListenableBuilder<int>(
          builder: (BuildContext context, int value, Widget? child) {
            // ?????????_counter.value???????????????????????????????????????
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                child!,
                Text(
                  "$value times",
                  textScaleFactor: textScaleFactor,
                ),
              ],
            );
          },
          valueListenable: _counter,
          // ?????????????????????????????????child????????????
          child: const Text(
            'Clicked',
            textScaleFactor: textScaleFactor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _counter.value += 1;
        },
      ),
    );
  }
}

class Chapter7UpdateWidget extends StatefulWidget {
  const Chapter7UpdateWidget({Key? key}) : super(key: key);

  @override
  State<Chapter7UpdateWidget> createState() => _Chapter7UpdateWidgetState();
}

class _Chapter7UpdateWidgetState extends State<Chapter7UpdateWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List _tabs = ['FutureBuilder', 'StreamBuilder'];

  static Future<String> mockNetworkData() async {
    return Future.delayed(const Duration(seconds: 2), () => "xxx");
  }

  static Stream<int> streamCounter() {
    return Stream.periodic(const Duration(seconds: 1), (i) {
      return i;
    });
  }

  final List<Widget> _pages = <Widget>[
    Center(
      child: FutureBuilder<String>(
        future: mockNetworkData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('ERROR: ${snapshot.error}');
            } else {
              return Text('SUCCESS: ${snapshot.data}');
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    ),
    Center(
      child: StreamBuilder<int>(
        stream: streamCounter(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('No valid stream');
            case ConnectionState.waiting:
              return const Text('Stream is waiting...');
            case ConnectionState.active:
              return Text('Stream is activated: ${snapshot.data}');
            case ConnectionState.done:
              return const Text('Stream was finished');
          }
        },
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chapter 7 Update Widget'),
          bottom: TabBar(
            controller: _tabController,
            tabs: _tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _pages,
        ),
      ),
    );
  }
}

class Chapter7DialogWidget extends StatelessWidget {
  const Chapter7DialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<int?> _showModalBottomSheet() {
      return showModalBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("$index"),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 7 Dialog Widget'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                bool? _delete = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Alert dialog"),
                      content: const Text('This is an alert dialog'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
                if (_delete == null) {
                  showToast("???????????????");
                } else {
                  showToast("????????????");
                }
              },
              child: const Text('alert dialog'),
            ),
            ElevatedButton(
              onPressed: () async {
                int? i = await showDialog<int>(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text("????????????????????????"),
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 1);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Text('1'),
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 2);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Text('2'),
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 3);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Text('3'),
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 4);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Text('4'),
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 5);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Text('5'),
                          ),
                        ),
                      ],
                    );
                  },
                );
                if (i != null) {
                  showToast('??????: $i');
                } else {
                  showToast('????????????');
                }
              },
              child: const Text('Select'),
            ),
            ElevatedButton(
              onPressed: () async {
                int? i = await showDialog<int>(
                  context: context,
                  builder: (BuildContext context) {
                    var child = Column(
                      children: <Widget>[
                        const ListTile(title: Text("?????????")),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 30,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text("$index"),
                                onTap: () => Navigator.of(context).pop(index),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                    return Dialog(child: child);
                  },
                );
                if (i != null) {
                  showToast('??????: $i');
                } else {
                  showToast('????????????');
                }
              },
              child: const Text('Select view'),
            ),
            ElevatedButton(
              onPressed: () async {
                bool? _withTree = false;
                bool? _delete = await showCustomDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('??????'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('???????????????'),
                            Row(
                              children: <Widget>[
                                const Text("????????????????????????"),
                                Builder(
                                  builder: (BuildContext context) {
                                    return Checkbox(
                                      value: _withTree,
                                      onChanged: (value) {
                                        (context as Element).markNeedsBuild();
                                        _withTree = value;
                                      },
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('??????'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('??????'),
                          ),
                        ],
                      );
                    });
                if (_delete == null) {
                  showToast("???????????????");
                } else {
                  if (_withTree != null && _withTree == true) {
                    showToast("????????????????????????????????????");
                  } else {
                    showToast("????????????");
                  }
                }
              },
              child: const Text('??????????????????'),
            ),
            ElevatedButton(
              onPressed: () async {
                int? type = await _showModalBottomSheet();
                if (type != null) {
                  showToast("????????? $type");
                }
              },
              child: const Text("????????????????????????"),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return UnconstrainedBox(
                      constrainedAxis: Axis.vertical,
                      child: SizedBox(
                        width: 280,
                        child: AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              CircularProgressIndicator(),
                              Padding(
                                padding: EdgeInsets.only(top: 18),
                                child: Text("????????????"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text("??????loading"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
  ThemeData? theme,
}) {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return Theme(
              data: theme,
              child: pageChild,
            );
          },
        ),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87,
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

class Chapter7GeneralWidget extends StatelessWidget {
  const Chapter7GeneralWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
