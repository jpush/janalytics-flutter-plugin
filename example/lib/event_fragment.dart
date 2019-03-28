import 'package:flutter/material.dart';
import 'demo_utils.dart';
import 'package:janalytics/janalytics.dart';

class EventFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EventPageState();
  }
}

class EventPageState extends State<EventFragment> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
        child: Container(
      margin: EdgeInsets.all(20),
      child: new Column(
        children: <Widget>[
          DemoUtils.createButton("登录事件", () {
            DemoUtils.onLoginEvent();
            DemoUtils.showToast(context, "统计登录事件");
          }),
          DemoUtils.createButton("注册事件", () {
            DemoUtils.onRegisterEvent();
            DemoUtils.showToast(context, "统计注册事件");
          }),
          DemoUtils.createButton("购买事件", () {
            DemoUtils.onPurchaseEvent();
            DemoUtils.showToast(context, "统计购买事件");
          }),
          DemoUtils.createButton("浏览事件", () {
            DemoUtils.onBrowseEvent();
            DemoUtils.showToast(context, "统计浏览事件");
          }),
          DemoUtils.createButton("计算事件", () {
            DemoUtils.onCalculateEvent();
            DemoUtils.showToast(context, "统计计算事件");
          }),
          DemoUtils.createButton("计数事件", () {
            DemoUtils.onCountEvent();
            DemoUtils.showToast(context, "统计计数事件");
          }),
        ],
      ),
    ));
  }
}
