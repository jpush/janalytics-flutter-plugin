import 'package:flutter/material.dart';
import 'dart:async';
import 'package:package_info/package_info.dart';
import 'viewpage.dart';
import 'demo_utils.dart';
import 'package:janalytics/janalytics.dart';
import 'show_hide_page.dart';
import 'replace_page.dart';
import 'account_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: HomeActivity(),
    );
  }
}

class HomeActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeActivityState();
  }
}

class HomeActivityState extends State<HomeActivity>
    with WidgetsBindingObserver {
  String debugLabel = 'Unknown';
  final Janalytics janalytics = new Janalytics();
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // 页面统计事件，在需要统计页面的dispose方法里调用onPageEnd
    janalytics.onPageEnd(widget.runtimeType.toString());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    janalytics.setup(appKey: "f93ce12e20d3706233e52a5b", channel: "devloper-default"); // 初始化sdk
    janalytics.setDebugMode(true); // 打开调试模式
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // 页面统计事件，在initState方法中调用onPageStart
    janalytics.onPageStart(widget.runtimeType.toString());

    try {
      PackageInfo info = await PackageInfo.fromPlatform();
      String appInfo =
          '应用名: ${info.appName}\n包名:${info.packageName}\n版本:${info.version}';
      setState(() {
        debugLabel = appInfo;
      });
    } on Exception catch (e) {
      print('init error:$e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print("page fragemnt didChangeAppLifecycleState");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          backgroundColor: Color(0xff212121),
        ),
        body: Builder(builder: (BuildContext context) {
          return new Container(
            padding: EdgeInsets.all(20),
            child: new Column(
              children: <Widget>[
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: new Text(
                    "$debugLabel\n ",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                DemoUtils.createButton("统计示例(ViewPage)", () {
                  Navigator.push(context, new MaterialPageRoute(builder: (ctx) {
                    return new ViewPageScreen();
                  }));
                }),
                DemoUtils.createButton("统计示例(Show/Hide)", () {
                  Navigator.push(context, new MaterialPageRoute(builder: (ctx) {
                    return new ShowHidePage();
                  }));
                }),
                DemoUtils.createButton("统计示例(Replace)", () {
                  Navigator.push(context, new MaterialPageRoute(builder: (ctx) {
                    return new ReplacePage();
                  }));
                }),
                DemoUtils.createButton("统计示例（账号）", () {
                  Navigator.push(context, new MaterialPageRoute(builder: (ctx) {
                    return new AccountPage();
                  }));
                }),
              ],
            ),
          );
        }),
        backgroundColor: Color(0xff303030),
      ),
    );
  }
}
