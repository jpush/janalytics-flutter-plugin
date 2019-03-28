import 'package:flutter/material.dart';
import 'package:janalytics/janalytics.dart';

class PageFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PageFragmentState();
  }
}

class PageFragmentState extends State<PageFragment> with WidgetsBindingObserver{
  final Janalytics janalytics = new Janalytics();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: new Wrap(
          runSpacing: 20,
          children: <Widget>[
            new Container(
              width: double.infinity,
              child: new Text(
                "页面流统计测试",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
            ),
            new Text(
              "在路由的State的生命周期函数 initState 中和 AppLifecycleState.resumed 时调用 janalytics.onPageStart",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
            new Text(
              "在路由的State的生命周期函数 dispose 中和 AppLifecycleState.paused 时调用 janalytics.onPageEnd",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
      margin: EdgeInsets.all(40),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("page fragment initState");
    WidgetsBinding.instance.addObserver(this);
    janalytics.onPageStart(widget.runtimeType.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("page fragment dispose");
    WidgetsBinding.instance.removeObserver(this);
    janalytics.onPageEnd(widget.runtimeType.toString());
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print("page fragemnt didChangeAppLifecycleState ${state.toString()}");
    if(state == AppLifecycleState.resumed){
      janalytics.onPageStart(widget.runtimeType.toString());
    }else if(state == AppLifecycleState.paused){
      janalytics.onPageEnd(widget.runtimeType.toString());
    }

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("page fragment didChangeDependencies");
  }

  @override
  void didUpdateWidget(PageFragment oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("page fragment didUpdateWidget ");
  }
}
