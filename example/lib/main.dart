import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pulltorefresh Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Pull Refresh'),
          ),
          body: PullListView()),
    );
  }
}

class PullListView extends StatefulWidget {
  @override
  _PullListViewState createState() => new _PullListViewState();
}

class _PullListViewState extends State<PullListView> {
  RefreshController _refreshController;
  List<Widget> data = [];
  void _getDatas() {
    for (int i = 0; i < 14; i++) {
      data.add(new Card(
        margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
        child: new Center(
          child: new Text('Data $i'),
        ),
      ));
    }
  }

  void enterRefresh() {
    _refreshController.requestRefresh(true);
  }

  void _onOffsetCallback(bool isUp, double offset) {
    // if you want change some widgets state ,you should rewrite the callback
  }

  @override
  void initState() {
    // TODO: implement initState
    _getDatas();
    _refreshController = new RefreshController();
    super.initState();
  }

  Widget _headerCreate(BuildContext context, int mode) {
    return new ClassicIndicator(
        mode: mode,
//        idleIcon: new Container(),
        idleText: "加载更多",
        refreshingText: "下拉刷新",
        completeText: '刷新完成',
        releaseText: '释放刷新哦');
  }

  void _onRefresh(up) {
    if (up)
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        data.add(new Card(
          margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
          child: new Center(
            child: new Text('Data '),
          ),
        ));

//        _refreshController.scrollTo(_refreshController.scrollController.offset + 100.0);
        _refreshController.sendBack(true, RefreshStatus.completed);
        setState(() {});
      });
    else {
      new Future.delayed(const Duration(milliseconds: 2009)).then((val) {
        data.add(new Card(
          margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
          child: new Center(
            child: new Text('Data '),
          ),
        ));
        setState(() {});
        _refreshController.sendBack(false, RefreshStatus.idle);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new SmartRefresher(
            headerBuilder: _headerCreate,
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onOffsetChange: _onOffsetCallback,
            child: new ListView.builder(
              reverse: true,
              itemExtent: 100.0,
              itemCount: data.length,
              itemBuilder: (context, index) => new Item(),
            )));
  }
}

class Item extends StatefulWidget {
  @override
  _ItemState createState() => new _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: new Center(
        child: new Text('Data'),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose item");
    super.dispose();
  }
}
