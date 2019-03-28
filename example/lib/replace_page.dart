import 'package:flutter/material.dart';
import 'event_fragment.dart';
import 'page_fragment.dart';
import 'package:janalytics/janalytics.dart';

class ReplacePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ReplaceState();
  }
}

class ReplaceState extends State<ReplacePage> {
  int  showIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ViewPageScreen'),
        backgroundColor: Color(0xff212121),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new IndexedStack(
              children: <Widget>[
                new Center(
                  child: new PageFragment(),
                ),
                new Center(
                  child: new EventFragment(),
                ),
              ],
            index: showIndex,
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    child: new FlatButton(
                        onPressed: onEventClick,
                        child: new Text("显示Event"),
                        color: Color(0xff585858),
                        highlightColor: Color(0xff888888),
                        splashColor: Color(0xff888888),
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                ),
                new Expanded(
                  child: new Container(
                    child: new FlatButton(
                        onPressed: onPageClick,
                        child: new Text("显示Page"),
                        color: Color(0xff585858),
                        highlightColor: Color(0xff888888),
                        splashColor: Color(0xff888888),
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
          )
        ],
      ),
      backgroundColor: Color(0xff303030),
    );
  }

  void onPageClick(){
    setState(() {
      if (showIndex == 1) {
        showIndex = 0;
        Janalytics janalytics = Janalytics();
        janalytics.onPageStart(widget.runtimeType.toString());
      }
    });
  }
  void onEventClick(){
    setState(() {
      if (showIndex == 0) {
        showIndex = 1;
        Janalytics janalytics = Janalytics();
        janalytics.onPageEnd(widget.runtimeType.toString());
      }
    });
  }
}