import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:platform/platform.dart';

class Janalytics {
  factory Janalytics() => _instance;

  final MethodChannel _channel;
  final Platform _platform;

  @visibleForTesting
  Janalytics.private(MethodChannel channel, Platform platform)
      : _channel = channel,
        _platform = platform;

  static final Janalytics _instance = new Janalytics.private(
      const MethodChannel('janalytics'),
      const LocalPlatform());

//  static const MethodChannel _channel =
//      const MethodChannel('janalytics');

//  static Future<String> get platformVersion async {
//    final String version = await _channel.invokeMethod('getPlatformVersion');
//    return version;
//  }

  void setup({String appKey,String channel}) {
    _channel.invokeMethod("setup",{"appKey":appKey,"channel":channel});
  }

  void setDebugMode(bool debug){
    _channel.invokeMethod(
        "setDebugMode",
        {"debug":debug}
    );
  }

  void initCrashHandler(){
    _channel.invokeMethod(
        "initCrashHandler"
    );
  }

  void stopCrashHandler(){
    _channel.invokeMethod(
        "stopCrashHandler"
    );
  }

  void onPageStart(String pageName){
    _channel.invokeMethod(
        "onPageStart",
        {"pageName":pageName}
    );
  }

  void onPageEnd(String pageName){
    _channel.invokeMethod(
        "onPageEnd",
        {"pageName":pageName}
    );
  }

  void onCountEvent(String eventId,
      {Map<String,String> extMap}){
    _channel.invokeMethod(
        "onCountEvent",
        {"eventId":eventId,"extMap":extMap}
    );
  }

  void onCalculateEvent(String eventId,
      double eventValue,
      {Map<String,String> extMap}){
    _channel.invokeMethod(
        "onCalculateEvent",
        {"eventId":eventId,"eventValue":eventValue,"extMap":extMap}
    );
  }

  void onLoginEvent(String loginMethod,
      bool loginSuccess,
      {Map<String,String> extMap}){
    _channel.invokeMethod(
        "onLoginEvent",
        {"loginMethod":loginMethod,"loginSuccess":loginSuccess,"extMap":extMap}
    );
  }

  void onRegisterEvent(String registerMethod,
      bool registerSuccess,
      {Map<String,String> extMap}){
    _channel.invokeMethod(
        "onRegisterEvent",
        {"registerMethod":registerMethod,"registerSuccess":registerSuccess,"extMap":extMap}
    );
  }

  void onBrowseEvent(String browseId,
      String browseName,
      String browseType,
      int browseDuration,
      {Map<String,String> extMap}){
    _channel.invokeMethod(
        "onBrowseEvent",
        {"browseId":browseId,"browseName":browseName,"browseType":browseType,"browseDuration":browseDuration,"extMap":extMap}
    );
  }

  void onPurchaseEvent(String purchaseGoodsid,
      String purchaseGoodsName,
      double purchasePrice,
      bool purchaseSuccess,
      Currency purchaseCurrency,
      String purchaseGoodsType,
      int purchaseGoodsCount,
      {Map<String,String> extMap}){
    _channel.invokeMethod(
        "onPurchaseEvent",{"purchaseGoodsid":purchaseGoodsid,"purchaseGoodsName":purchaseGoodsName,"purchasePrice":purchasePrice,"purchaseSuccess":purchaseSuccess
        ,"purchaseCurrency":purchaseCurrency.index,"purchaseGoodsType":purchaseGoodsType,"purchaseGoodsCount":purchaseGoodsCount,"extMap":extMap}
    );
  }

  void setAnalyticsReportPeriod(int period){
    _channel.invokeMethod(
        "setAnalyticsReportPeriod",{"period":period}
    );
  }

  Future<Map<dynamic,dynamic>> identifyAccount(
      String accountID,
      {int creationTime,
        String name,
        int sex,
        int paid,
        String birthdate,
        String phone,
        String email,
        String weiboID,
        String wechatID,
        String qqID,
        Map<String,String> extMap
      }) async{
    final Map<dynamic,dynamic> result = await
    _channel.invokeMethod("identifyAccount",
        {"accountID":accountID,"creationTime":creationTime,"name":name,"sex":sex,"paid":paid,"birthdate":birthdate,"phone":phone,"email":email,
          "weiboID":weiboID,"wechatID":wechatID,"qqID":qqID,"extMap":extMap}
          );
    return result;
  }

  Future<Map<dynamic, dynamic>> detachAccount() async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod("detachAccount");
    return result;
  }

}

enum Currency{
  CNY,
  USD
}
