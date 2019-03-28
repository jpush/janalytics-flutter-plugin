import 'package:flutter/material.dart';
import 'package:janalytics/janalytics.dart';
import 'page_fragment.dart';
import 'event_fragment.dart';

class ViewPageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ViewPageState();
  }
}

class ViewPageState extends State<ViewPageScreen>
    with SingleTickerProviderStateMixin {

  Janalytics janalytics = new Janalytics();
  TabController mTabController;
  List<Tab> myTabs;
  PageController mPageViewController;

  @override
  void initState() {
    super.initState();
    mTabController = TabController(
      length: 2,
      vsync: this,
    );
    mTabController.addListener(() {
      //TabBar的监听
      if (mTabController.indexIsChanging) {
        //判断TabBar是否切换
//        onPageChange(mTabController.index, p: mPageController);
        mPageViewController.animateToPage(mTabController.index, duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    });
    myTabs = <Tab>[
      Tab(text: 'Pages'),
      Tab(text: 'Events'),
    ];

    mPageViewController = PageController(initialPage: 0);
  }

  @override
  void didUpdateWidget(ViewPageScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ViewPageScreen'),
        backgroundColor: Color(0xff212121),
      ),
      body: new Column(
        children: <Widget>[
          Container(
            color: new Color(0xff303030),
            height: 60.0,
            child: TabBar(
              controller: mTabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: myTabs,
            ),
          ),
          Expanded(child: PageView.builder(itemBuilder: buildPage,controller: mPageViewController,onPageChanged: onPageChanged,itemCount: 2,)),
        ],
      ),
      backgroundColor: Color(0xff303030),
    );
  }

  Widget buildPage(BuildContext context, int index) {
    if (index == 0) {
      return new PageFragment();
    } else {
      return new EventFragment();
    }
  }

  void onPageChanged(int page) {
    mTabController.animateTo(page,duration: Duration(milliseconds: 300),curve: Curves.ease);
  }

}
