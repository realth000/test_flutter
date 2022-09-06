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
            showToast("再按一次退出");
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              const Text('连续两次退出'),
              ElevatedButton(
                onPressed: () {
                  showToast("再按一次退出");
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
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
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
  // 值变化时通知
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  static const double textScaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 7 Value listener Widget'),
      ),
      body: Center(
        // 接受_counter的通知
        child: ValueListenableBuilder<int>(
          builder: (BuildContext context, int value, Widget? child) {
            // 只有当_counter.value变化时会被调用（重新构建）
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
          // 不需要变化的子组件通过child保存缓存
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
                  showToast("删除已取消");
                } else {
                  showToast("删除成功");
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
                      title: const Text("标题！！！！！！"),
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
                  showToast('选了: $i');
                } else {
                  showToast('啥也没选');
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
                        ListTile(title: const Text("请选择")),
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
                  showToast('选了: $i');
                } else {
                  showToast('啥也没选');
                }
              },
              child: const Text('Select view'),
            ),
          ],
        ),
      ),
    );
  }
}
