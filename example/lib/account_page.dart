import 'package:flutter/material.dart';
import 'package:janalytics/janalytics.dart';
import 'demo_utils.dart';


class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AccountPageState();
  }
}

class AccountPageState extends State<AccountPage> {
  var controllerAccountID = new TextEditingController();
  var checkedCreateTime = false;
  var controllerCreateTime = new TextEditingController();
  var checkedSex = false;
  BuildContext ctx;

  var controllerSex = new TextEditingController();

  var checkedBirthdate = false;

  var controllerBirthdate = new TextEditingController();

  var checkedPaid = false;

  var controllerPaid = new TextEditingController();

  var checkedPhone = false;

  var controllerPhone = new TextEditingController();

  var checkedEmail = false;

  var controllerEmail = new TextEditingController();

  var checkedName = false;

  var controllerName = new TextEditingController();

  var checkedKey1 = false;

  var controllerKey1 = new TextEditingController();

  var controllerValue1 = new TextEditingController();

  var checkedKey2 = false;

  var controllerKey2 = new TextEditingController();

  var controllerValue2 = new TextEditingController();

  var controllerPeriod = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Account"),
        backgroundColor: Color(0xff212121),
      ),
      body: Builder(builder: (ctx){
        this.ctx = ctx;
        return new Column(
          children: <Widget>[
            new Text(
              "设置固定属性",
              style: TextStyle(color: Colors.grey),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Checkbox(
                    value: true,
                    activeColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置account_id",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerAccountID,
                    ),
                  ),
                  new Checkbox(
                    value: checkedCreateTime,
                    onChanged: (value) {
                      setState(() {
                        checkedCreateTime = !checkedCreateTime;
                      });
                    },
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置creation_time",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerCreateTime,
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Checkbox(
                    value: checkedSex,
                    onChanged: (value) {
                      setState(() {
                        checkedSex = !checkedSex;
                      });
                    },
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置sex",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerSex,
                    ),
                  ),
                  new Checkbox(
                    value: checkedBirthdate,
                    onChanged: (value) {
                      setState(() {
                        checkedBirthdate = !checkedBirthdate;
                      });
                    },
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置birthdate",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerBirthdate,
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Checkbox(
                    value: checkedPaid,
                    onChanged: (value) {
                      setState(() {
                        checkedPaid = !checkedPaid;
                      });
                    },
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置paid",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerPaid,
                    ),
                  ),
                  new Checkbox(
                    value: checkedPhone,
                    onChanged: (value) {
                      setState(() {
                        checkedPhone = !checkedPhone;
                      });
                    },
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置phone",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerPhone,
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Checkbox(
                    value: checkedEmail,
                    onChanged: (value) {
                      setState(() {
                        checkedEmail = !checkedEmail;
                      });
                    },
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置email",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerEmail,
                    ),
                  ),
                  new Checkbox(
                    value: checkedName,
                    onChanged: (value) {
                      setState(() {
                        checkedName = !checkedName;
                      });
                    },
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置name",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerName,
                    ),
                  ),
                ],
              ),
            ),
            new Text(
              "设置自定义属性",
              style: TextStyle(color: Colors.grey),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Checkbox(
                    value: checkedKey1,
                    onChanged: (value) {
                      setState(() {
                        checkedKey1 = !checkedKey1;
                      });
                    },
                  ),
                  new Text(
                    "移除  ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置key",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerKey1,
                    ),
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置value",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerValue1,
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Checkbox(
                    value: checkedKey2,
                    onChanged: (value) {
                      setState(() {
                        checkedKey2 = !checkedKey2;
                      });
                    },
                  ),
                  new Text(
                    "移除  ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置key",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerKey2,
                    ),
                  ),
                  new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "设置value",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                      controller: controllerValue2,
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Container(
                        child: FlatButton(
                          child: Text("IDENTIFY"),
                          onPressed: identifyAccount,
                          color: Color(0xff585858),
                          highlightColor: Color(0xff888888),
                          splashColor: Color(0xff888888),
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        ),
                        margin: EdgeInsets.all(10),
                      )
                  ),
                  new Expanded(
                      child: new Container(
                        child: FlatButton(
                          child: Text("DETACH"),
                          onPressed: detachAccount,
                          color: Color(0xff585858),
                          highlightColor: Color(0xff888888),
                          splashColor: Color(0xff888888),
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        ),
                        margin: EdgeInsets.all(10),
                      )
                  ),
                ],
              ),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Container(
                        child: TextField(
                          autofocus: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "周期单位秒",
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                          controller: controllerPeriod,
                        ),
                        margin: EdgeInsets.all(10),
                      )
                  ),
                  new Expanded(
                      child: new Container(
                        child: FlatButton(
                          child: Text("设置上报周期"),
                          onPressed: setAnalyticsReportPeriod,
                          color: Color(0xff585858),
                          highlightColor: Color(0xff888888),
                          splashColor: Color(0xff888888),
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        ),
                        margin: EdgeInsets.all(10),
                      )
                  ),
                ],
              ),
            ),
          ],
        );
      }
      ),
      backgroundColor: Color(0xff303030),
        resizeToAvoidBottomPadding: false,
    );
  }

  void identifyAccount(){
    var accountId = controllerAccountID.text;
    if(accountId == null){
      DemoUtils.showToast(ctx, "accountId 不能为空");
      return;
    }
    int createTime;
    if(checkedCreateTime){
      try{
        createTime = int.parse(controllerCreateTime.text);
      }on Exception{
        DemoUtils.showToast(ctx, "createTime should be int");
      }
    }
    int sex;
    if(checkedSex){
      try{
        sex = int.parse(controllerSex.text);
      }on Exception{
        DemoUtils.showToast(ctx, "sex should be int");
      }
    }
    String birthdate;
    if(checkedBirthdate){
      birthdate = controllerBirthdate.text;
    }
    int paid;
    if(checkedPaid){
      try{
        paid = int.parse(controllerPaid.text);
      }on Exception{
        DemoUtils.showToast(ctx, "paid should be int");
      }
    }
    String phone;
    if(checkedPhone){
      phone = controllerPhone.text;
    }
    String email;
    if(checkedEmail){
      email = controllerEmail.text;
    }
    String name;
    if(checkedName){
      name = controllerName.text;
    }
    Map<String,String> extMap = Map();
    String key1=  controllerKey1.text;
    if(key1!=null && key1.isNotEmpty){
      if(checkedKey1){
        extMap[key1] = null;
      }else{
        extMap[key1] = controllerValue1.text;
      }
    }

    String key2 = controllerKey2.text;
    if(key2!=null && key2.isNotEmpty){
      if(checkedKey2){
        extMap[key2] = null;
      }else{
        extMap[key2] = controllerValue2.text;
      }
    }
    Janalytics janalytics  = Janalytics();
    janalytics.identifyAccount(accountId,creationTime: createTime,sex: sex,paid: paid,birthdate: birthdate,phone: phone,email: email,name: name,extMap: extMap).then((map){
      var code = map["code"];
      var msg = map["msg"];
      print("result code = $code   msg= $msg");
      DemoUtils.showToast(ctx, "result code = $code   msg= $msg");
    });
  }

  void detachAccount(){
    Janalytics janalytics  = Janalytics();
    janalytics.detachAccount().then((map){
      var code = map["code"];
      var msg = map["msg"];
      print("result code = $code   msg= $msg");
      DemoUtils.showToast(ctx, "result code = $code   msg= $msg");
    });
  }

  void setAnalyticsReportPeriod(){
    String text = controllerPeriod.text;
    Janalytics janalytics  = Janalytics();
    try{
      int period = int.parse(text);
      janalytics.setAnalyticsReportPeriod(period);
    }on Exception {
      DemoUtils.showToast(ctx, "时长应当是整数");
    }catch (e){
      print("setAnalyticsReportPeriod error:  $e");
    }
  }
}

class Accout{

}
