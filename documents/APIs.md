[Common API](#common-api)

- [setup](#setup)
- [setDebugMode](#setDebugMode)
- [initCrashHandler](#initCrashHandler)
- [stopCrashHandler](#stopCrashHandler)
- [onPageStart](#onPageStart)
- [onPageEnd](#onPageEnd)
- [onCountEvent](#onCountEvent)
- [onCalculateEvent](#onCalculateEvent)
- [onLoginEvent](#onLoginEvent)
- [onRegisterEvent](#onRegisterEvent)
- [onBrowseEvent](onBrowseEvent)
- [onPurchaseEvent](#onPurchaseEvent)
- [setAnalyticsReportPeriod](#setanalyticsreportperiod)
- [identifyAccount](#identifyaccount)
- [detachAccount](#detachaccount)

#### setup

添加初始化方法，调用 setup 方法会执行两个操作：

- 初始化 JAnalytics SDK
- 将缓存的事件下发到 dart 环境中。

**注意：** 插件版本 >= 0.0.1 android 端支持在 setup 方法中动态设置 channel，动态设置的 channel 优先级比 manifestPlaceholders 中的 JPUSH_CHANNEL 优先级要高。另外 参数 appKey 只对 IOS 生效，android 设置 appKey 需要在 gradle 中配置。

```dart
Janalytics janalytics = new Janalytics();
janalytics.setup(
      appKey: "替换成你自己的 appKey",
      channel: "theChannel",
    );
```

#### setDebugMode

设置是否开启debug模式。true则会打印更多的日志信息

```dart
Janalytics janalytics = new Janalytics();
janalytics.setDebugMode(true);
```

#### initCrashHandler

开启crashlog日志上报

```dart
Janalytics janalytics = new Janalytics();
janalytics.initCrashHandler();
```

#### stopCrashHandler

关闭crashlog日志上报

```dart
Janalytics janalytics = new Janalytics();
janalytics.stopCrashHandler();
```

#### onPageStart

页面启动接口。在页面(widget state)的相关生命周期内调用，和onPageEnd需要成对调用，关于widget的不同情况下会对生命周期造成影响，详细请见说明

```dart
Janalytics janalytics = new Janalytics();
janalytics.onPageStart("your page name");
```

#### onPageEnd

页面结束接口。在页面(widget state)的相关生命周期内调用，和onPageStart需要成对调用，关于widget的不同情况下会对生命周期造成影响，详细请见说明

```dart
Janalytics janalytics = new Janalytics();
janalytics.onPageEnd("your page name");
```
关于页面流做如下说明：
1、开发者自己决定所显示的 Page 是否是一个页面。在相应的方法调用onPageStart和onPageEnd方法，并且需要是成对调用
相应的方法包括：initState()，dispose()，didChangeAppLifecycleState(AppLifecycleState state)
2、当页面中包含多个 Page，每个 Page 都需当做页面统计时，基于 Widget 的切换模式，提供以下建议
replace模式:这种模式使用 IndexedStack 切换 Page，需要在自己的控制代码中根据显示逻辑调用响应的nPageStart和onPageEnd。
show/hide模式:这种模式使用 Offstage 来控制 Page 是否显示在屏幕外边，调用方式同replace模式
viewpage模式：这种模式使用 PageView 切换，如果每次切换都是 build Page，则调用方式和 说明1 相同。如果是复用的Page，则调用方式通replace模式。

#### onCountEvent

计数事件模型，可以设置参数进行数据上报。

```dart
Janalytics janalytics = new Janalytics();
janalytics.onCountEvent(
        "test_countID ",  // 事件ID
        extMap: extraMap //添加自己的Extra 信息 Map<String,String>
    );
```

####  onCalculateEvent

计算事件模型，计算事件会通过相同的事件不同的值进行累加，可以设置参数进行数据上报。

```dart
Janalytics janalytics = new Janalytics();
janalytics.onCalculateEvent(
        "test_calculateID $",  // 事件ID
        1,   // 事件对应的值
        extMap: extraMap //添加自己的Extra 信息 Map<String,String>
    );
```

#### onLoginEvent

登录事件模型，可以设置参数进行数据上报。

```dart
Janalytics janalytics = new Janalytics();
janalytics.onLoginEvent(
        "testLoginMethod", // 登录方式
        true,// 是否登录成功
        extMap: extraMap  //添加自己的Extra 信息 Map<String,String>
    );
```

#### onRegisterEvent

注册事件模型，可以设置参数进行数据上报。

```dart
Janalytics janalytics = new Janalytics();
janalytics.onRegisterEvent(
        "testRegisterMethod", // 注册方式
        true,// 是否注册成功
        extMap: extraMap
    );
```

#### onBrowseEvent

浏览事件模型，可以设置参数进行数据上报。

```dart
Janalytics janalytics = new Janalytics();
janalytics.onBrowseEvent("test_browseID",//设置浏览内容id
        "深圳热点新闻",//设置浏览的内容的名称
        "news", //设置浏览的内容类型
        30,//设置浏览的内容时长,单位秒)
        extMap: extraMap
    );
```

#### onPurchaseEvent

购买事件模型，可以设置参数进行数据上报。

```dart
// 延时 3 秒后触发本地通知。
Janalytics janalytics = new Janalytics();
janalytics.onPurchaseEvent(
        "test_purchaseGoodsID", //商品ID
        "篮球", //商品名称
        300, //商品价格
        true, //商品购买是否成功
        Currency.CNY, //货币类型
        "sport",//商品类型
        1, // 商品数量
        extMap: extraMap);
```

#### setAnalyticsReportPeriod

设置统计上报的自动周期，未调用前默认即时上报

```dart
Janalytics janalytics = new Janalytics();
janalytics.setAnalyticsReportPeriod(60);
```

#### identifyAccount

开发者可以为用户增加账户信息，使统计数据可以以账户维度做统计分析 现开发的属性有：

|中文名	|英文名	|类型	|鉴权/备注|
|:-----:|:----:|:-----:|:-----:|
|账号ID	|accountID	|String	|
|账号创建时间|	creationTime	|long	|时间戳|
|姓名	|name|	String|	|
|性别	|sex	|int	|0未知 1男 2女/不能为其他数字，默认为0|
|是否付费	|paid	|int	|0未知 1是 2否/不能为其他数字，默认为0|
|出生年月	|birthdate	|long	|yyyyMMdd格式校验|
|手机号码	|phone|	String	|手机号码校验|
|电子邮件	|email|	String	|邮箱格式校验|
|新浪微博ID	|weiboID	|String|	|
|微信ID	|wechatID	|String	| |
|QQ ID|	qqID|	String| 	|
|自定义维度	|extra|	key-value	|key只能为字符串，value只能为字符串或数字类型或null类型； 当value设置为空类型时，将该key从服务器上删除 key不能使用极光内部namespace（符号$）|

**注意： iOS10+ 可以通过该方法来设置推送是否前台展示，是否触发声音，是否设置应用角标 badge**

```dart
Janalytics janalytics = new Janalytics();
janalytics.identifyAccount(accountId,creationTime: createTime,sex: sex,paid: paid,birthdate: birthdate,phone: phone,email: email,name: name,extMap: extMap).then((map){
      var code = map["code"];
      var msg = map["msg"];
      print("result code = $code   msg= $msg");
    });
```

#### detachAccount

解绑当前用户信息

```dart
Janalytics janalytics = new Janalytics();
janalytics.detachAccount().then((map){
      var code = map["code"];
      var msg = map["msg"];
      print("result code = $code   msg= $msg");
    });
```

#### 错误码

|code	|message	|备注|
|:-----:|:----:|:-----:|
|0|	调用成功	|
|1001 |	account_id can not be empty	|accountID为关键参数，不能填写null或""|
|1002	|detach failed because account_id is empty|	当前没有绑定accountID时调用了解绑接口|
|1003	|operation is too busy|	10s内请求频率不能超过30次|
|1004	|account_id is too long, please make it less than 255 characters|	accountID长度不能超过255字符|
|1005	|failed, please call JAnalyticsInterface.init(context) first|	SDK尚未初始化，应先调用init()方法|
|1101	|the value of $sex should be in [0,2]|	0未知 1男 2女/不能为其他数字，默认为0|
|1101	|the value of $birthdate should be date as yyyyMMdd	|yyyyMMdd格式校验|
|1101	|the value of $paid should be in [0,2]|	0未知 1是 2否/不能为其他数字，默认为0|
|1101	|the value of $phone is NOT a phone number|	电话号码格式校验（含国际号码）|
|1101	|the value of $email is NOT email address	|邮箱格式校验|
|1101	|the key={key} in extra is invalid	|自定义属性key不能为空，不能使用极光内部namespace(符号$)|
|1101	|the value of {key} in extra should be String or Number|	自定义属性value只能为字符串或数字类型或null类型|

