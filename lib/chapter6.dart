import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/common.dart';

class Chapter6Route extends StatelessWidget {
  const Chapter6Route({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Chapter6Widget();
  }
}

class Chapter6Widget extends StatelessWidget {
  const Chapter6Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 6 Route'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                getRoute(context, 'Chapter 6 Silver Widget',
                    'chapter_6/silver_widget'),
                getRoute(context, 'Chapter 6 List View Widget',
                    'chapter_6/list_View_widget'),
                getRoute(context, "Chapter 6 Scroll Widget",
                    'chapter_6/scroll_widget'),
                getRoute(context, 'Chapter 6 Animated Widget',
                    'chapter_6/animated_widget'),
                getRoute(
                    context, 'Chapter 6 Grid Widget', 'chapter_6/grid_widget'),
                getRoute(
                    context, 'Chapter 6 Page Widget', 'chapter_6/page_widget'),
                getRoute(context, 'Chapter 6 Tab Bar Widget',
                    'chapter_6/tab_bar_widget'),
                getRoute(context, 'Chapter 6 Custom Widget',
                    'chapter_6/custom_widget'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Chapter6SliverWidget extends StatelessWidget {
  const Chapter6SliverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chapter 6 Silver Widget')),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                  .split("")
                  .map((c) => Text(
                        c,
                        textScaleFactor: 2.0,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class Chapter6ListViewWidget extends StatefulWidget {
  const Chapter6ListViewWidget({Key? key}) : super(key: key);

  @override
  State<Chapter6ListViewWidget> createState() => _Chapter6ListViewWidgetState();
}

class _Chapter6ListViewWidgetState extends State<Chapter6ListViewWidget> {
  int _currentIndex = 0;

  final List<Widget> _pages = <Widget>[
    ListView.builder(
      key: const PageStorageKey(0),
      itemCount: 100,
      itemExtent: 50.0,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('$index'),
        );
      },
    ),
    ListView.separated(
      key: const PageStorageKey(1),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('$index'),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return index % 2 == 0
            ? const Divider(
                color: Colors.blue,
              )
            : const Divider(
                color: Colors.green,
              );
      },
    ),
    _Chapter6ListViewWidgetEndless(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 6 List View Widget'),
      ),
      body: _pages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.one_k), label: 'ListView.builder'),
          BottomNavigationBarItem(
              icon: Icon(Icons.two_k), label: 'ListView.seperated'),
          BottomNavigationBarItem(
              icon: Icon(Icons.three_k), label: 'ListView.DELETE'),
        ],
      ),
    );
  }
}

class _Chapter6ListViewWidgetEndless extends StatefulWidget {
  @override
  State<_Chapter6ListViewWidgetEndless> createState() =>
      _Chapter6ListViewWidgetEndlessState();
}

class _Chapter6ListViewWidgetEndlessState
    extends State<_Chapter6ListViewWidgetEndless> {
  final _wordList = <String>["##loading##"];

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 1)).then((e) {
      setState(() {
        {
          _wordList.insertAll(_wordList.length - 1,
              generateWordPairs().take(7).map((e) => e.asCamelCase).toList());
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const ListTile(
          leading: Chip(
            label: Text('单词列表'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('单'),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: _wordList.length,
            itemBuilder: (BuildContext context, int index) {
              if (_wordList[index] == "##loading##") {
                if (_wordList.length - 1 < 50) {
                  _retrieveData();
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: const SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      "到头了 QAQ",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
              }
              return ListTile(
                title: Text(_wordList[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.blue,
              );
            },
          ),
        ),
      ],
    );
  }
}

class Chapter6ScrollWidget extends StatefulWidget {
  const Chapter6ScrollWidget({Key? key}) : super(key: key);

  @override
  State<Chapter6ScrollWidget> createState() => _Chapter6ScrollWidgetState();
}

class _Chapter6ScrollWidgetState extends State<Chapter6ScrollWidget> {
  final ScrollController _controller = ScrollController();
  bool showToTopButton = false;
  String _progress = "0%";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset < 200 && showToTopButton) {
        setState(() {
          showToTopButton = false;
        });
      } else if (_controller.offset >= 200 && !showToTopButton) {
        setState(() {
          showToTopButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 6 Scroll Widget'),
      ),
      body: Scrollbar(
        /* Add this controller to avoid the following error:
            ======== Exception caught by animation library =====================================================
            The following assertion was thrown while notifying status listeners for AnimationController:
            The Scrollbar's ScrollController has no ScrollPosition attached.
           According to: https://github.com/flutter/flutter/issues/97873#issuecomment-1147028359
         */
        controller: _controller,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            double p = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;
            setState(() {
              _progress =
                  "${(p * 100).toInt()}% ${notification.metrics.atEdge}";
            });
            return false;
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                itemCount: 100,
                itemExtent: 50.0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('$index'),
                  );
                },
                controller: _controller,
              ),
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.black54,
                child: Text(_progress),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: !showToTopButton
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(.0,
                    duration: const Duration(microseconds: 200),
                    curve: Curves.ease);
              }),
    );
  }
}

class Chapter6AnimatedWidget extends StatefulWidget {
  const Chapter6AnimatedWidget({Key? key}) : super(key: key);

  @override
  State<Chapter6AnimatedWidget> createState() => _Chapter6AnimatedWidgetState();
}

class _Chapter6AnimatedWidgetState extends State<Chapter6AnimatedWidget> {
  var data = <String>[];
  int counter = 3;
  final globalKey = GlobalKey<AnimatedListState>();

  Widget buildAddButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        data.add('${WordPair.random()}');
        globalKey.currentState!.insertItem(data.length - 1);
        data.add('${WordPair.random()}');
        globalKey.currentState!.insertItem(data.length - 1);
        data.add('${WordPair.random()}');
        globalKey.currentState!.insertItem(data.length - 1);
      },
    );
  }

  Widget buildItem(context, index) {
    String s = data[index];
    return ListTile(
      key: ValueKey(s),
      title: Text(s),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onDelete(context, index),
      ),
    );
  }

  void onDelete(context, index) {
    String s = data.removeAt(index);
    globalKey.currentState!.removeItem(index,
        (BuildContext context, Animation<double> animation) {
      return FadeTransition(
        opacity: animation,
        child: ListTile(
          title: Text(s),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < counter; i++) {
      data.add('${WordPair.random()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 6 Anitamted Widget'),
      ),
      body: AnimatedList(
        key: globalKey,
        initialItemCount: data.length,
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: buildItem(context, index),
          );
        },
      ),
      floatingActionButton: buildAddButton(),
    );
  }
}

class Chapter6GridWidget extends StatefulWidget {
  const Chapter6GridWidget({Key? key}) : super(key: key);

  @override
  State<Chapter6GridWidget> createState() => _Chapter6GridWidgetState();
}

class _Chapter6GridWidgetState extends State<Chapter6GridWidget> {
  int _index = 0;
  final List<Widget> _pages = <Widget>[
    GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2.0,
      children: const <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    ),
    GridView.extent(
      maxCrossAxisExtent: 60.0,
      childAspectRatio: 2.0,
      children: const <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    ),
    _Chapter6GridWidgetBuilder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 6 Grid Widget'),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.one_k), label: 'GridView.count'),
          BottomNavigationBarItem(
              icon: Icon(Icons.two_k), label: 'GridView.extent'),
          BottomNavigationBarItem(
              icon: Icon(Icons.three_k), label: 'GridView.builder'),
        ],
      ),
    );
  }
}

class _Chapter6GridWidgetBuilder extends StatefulWidget {
  @override
  State<_Chapter6GridWidgetBuilder> createState() =>
      _Chapter6GridWidgetBuilderState();
}

class _Chapter6GridWidgetBuilderState extends State<_Chapter6GridWidgetBuilder>
    with AutomaticKeepAliveClientMixin {
  final List<IconData> _icons = [];

  void _retrievedIcons() {
    // FIXME: Delay not work?
    Future.delayed(const Duration(microseconds: 20000)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast,
        ]);
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _retrievedIcons();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.0,
      ),
      itemCount: _icons.length,
      itemBuilder: (context, index) {
        if (index == _icons.length - 1 && _icons.length < 30) {
          _retrievedIcons();
        }
        return Icon(_icons[index]);
      },
    );
  }
}

class Chapter6PageViewWidget extends StatefulWidget {
  const Chapter6PageViewWidget({Key? key}) : super(key: key);

  @override
  State<Chapter6PageViewWidget> createState() => _Chapter6PageViewWidgetState();
}

class _Chapter6PageViewWidgetState extends State<Chapter6PageViewWidget> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (int i = 0; i < 6; i++) {
      children.add(Page(text: '$i'));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 6 Page View'),
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        children: children,
      ),
    );
  }
}

// Tab 页面
class Page extends StatefulWidget {
  const Page({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(child: Text("${widget.text}", textScaleFactor: 5));
  }
}

/*
  Helper:
 */
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({
    Key? key,
    this.keepAlive = true,
    required this.child,
  }) : super(key: key);
  final bool keepAlive;
  final Widget child;

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}

class Chapter6TabBarWidget extends StatefulWidget {
  const Chapter6TabBarWidget({Key? key}) : super(key: key);

  @override
  State<Chapter6TabBarWidget> createState() => _Chapter6TabBarWidgetState();
}

class _Chapter6TabBarWidgetState extends State<Chapter6TabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabs = ["AAA", "BBB", "CCC"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chapter 6 Tab Bar Widget'),
          bottom: TabBar(
            controller: _tabController,
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabs.map(
            (e) {
              return KeepAliveWrapper(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    e,
                    textScaleFactor: 5,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class Chapter6CustomWidget extends StatefulWidget {
  const Chapter6CustomWidget({Key? key}) : super(key: key);

  @override
  State<Chapter6CustomWidget> createState() => _Chapter6CustomWidgetState();
}

class _Chapter6CustomWidgetState extends State<Chapter6CustomWidget> {
  int _currentIndex = 0;

  static Widget _getListView() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (_, index) => ListTile(
        title: Text('$index'),
      ),
    );
  }

  final List<Widget> _pages = <Widget>[
    Column(
      children: [
        Expanded(child: _getListView()),
        const Divider(
          color: Colors.red,
        ),
        Expanded(child: _getListView()),
      ],
    ),
    buildTwoSliverList(),
  ];

  static Widget buildTwoSliverList() {
    var listView = SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => ListTile(
            title: Text('$index'),
          ),
          childCount: 10,
        ),
        itemExtent: 56);
    return CustomScrollView(
      slivers: [
        listView,
        listView,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 6 Custom Widget'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.one_k), label: 'Bad Example'),
          BottomNavigationBarItem(icon: Icon(Icons.two_k), label: '2'),
          BottomNavigationBarItem(icon: Icon(Icons.three_k), label: '3'),
        ],
      ),
    );
  }
}
