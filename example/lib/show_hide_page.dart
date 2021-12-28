import 'package:flutter/material.dart';
import 'package:janalyticsplub/janalyticsplub.dart';

import 'event_fragment.dart';
import 'page_fragment.dart';

class ShowHidePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ShowHideState();
  }
}

class ShowHideState extends State<ShowHidePage> {
  bool showPageFlag = true;

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
            child: new Stack(
              children: <Widget>[
                new Offstage(
                  offstage: !showPageFlag,
                  child: new Center(
                    child: new PageFragment(),
                  ),
                ),
                new Offstage(
                  offstage: showPageFlag,
                  child: new EventFragment(),
                )
              ],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    child: new TextButton(
                      onPressed: onEventBtnClick,
                      child: new Text("显示Event"),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all(Color(0xff888888)),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff585858)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.fromLTRB(10, 10, 10, 10)),
                      ),
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                ),
                new Expanded(
                  child: new Container(
                    child: new TextButton(
                      onPressed: onPageBtnClick,
                      child: new Text("显示Page"),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all(Color(0xff888888)),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff585858)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.fromLTRB(10, 10, 10, 10)),
                      ),
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

  void onPageBtnClick() {
    setState(() {
      if (!showPageFlag) {
        showPageFlag = true;
        Janalytics janalytics = Janalytics();
        janalytics.onPageStart(widget.runtimeType.toString());
      }
    });
  }

  void onEventBtnClick() {
    setState(() {
      if (showPageFlag) {
        showPageFlag = false;
        Janalytics janalytics = Janalytics();
        janalytics.onPageEnd(widget.runtimeType.toString());
      }
    });
  }
}
