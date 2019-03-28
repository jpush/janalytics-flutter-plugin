package com.jiguang.janalytics;

import android.content.Context;
import android.nfc.Tag;
import android.util.Log;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import cn.jiguang.analytics.android.api.Account;
import cn.jiguang.analytics.android.api.AccountCallback;
import cn.jiguang.analytics.android.api.BrowseEvent;
import cn.jiguang.analytics.android.api.CalculateEvent;
import cn.jiguang.analytics.android.api.CountEvent;
import cn.jiguang.analytics.android.api.LoginEvent;
import cn.jiguang.analytics.android.api.Currency;
import cn.jiguang.analytics.android.api.PurchaseEvent;
import cn.jiguang.analytics.android.api.RegisterEvent;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import cn.jiguang.analytics.android.api.JAnalyticsInterface;

/** JanalyticsPlugin */
public class JanalyticsPlugin implements MethodCallHandler {

    private Context context;
    private MethodChannel channel;
    private JanalyticsPlugin instance;
    private ArrayList<String> getRidCache;
    private boolean dartIsReady ;



    /** Plugin registration. */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "janalytics");
        channel.setMethodCallHandler(new JanalyticsPlugin(registrar,channel));
    }

    private JanalyticsPlugin(Registrar registrar, MethodChannel channel) {
        this.context = registrar.context();
        this.channel = channel;
//      this.callbackMap = new HashMap<>();
//      this.sequence = 0;
        this.getRidCache = new ArrayList<>();
        instance = this;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("setup")) {
            setup(call,result);
        } else if (call.method.equals("setDebugMode")){
            setDebugMode(call,result);
        } else if (call.method.equals("initCrashHandler")){
            initCrashHandler(call,result);
        } else if (call.method.equals("stopCrashHandler")){
            stopCrashHandler(call,result);
        } else if (call.method.equals("onPageStart")){
            onPageStart(call,result);
        } else if (call.method.equals("onPageEnd")){
            onPageEnd(call,result);
        } else if (call.method.equals("onCountEvent")){
            onCountEvent(call,result);
        } else if (call.method.equals("onCalculateEvent")){
            onCalculateEvent(call,result);
        } else if (call.method.equals("onLoginEvent")){
            onLoginEvent(call,result);
        }else if (call.method.equals("onRegisterEvent")){
            onRegisterEvent(call,result);
        }else if (call.method.equals("onBrowseEvent")){
            onBrowseEvent(call,result);
        }else if (call.method.equals("onPurchaseEvent")){
            onPurchaseEvent(call,result);
        }else if (call.method.equals("setAnalyticsReportPeriod")){
            setAnalyticsReportPeriod(call,result);
        }else if(call.method.equals("identifyAccount")){
            identifyAccount(call,result);
        }else if (call.method.equals("detachAccount")){
            detachAccount(call,result);
        }else {
            result.notImplemented();
        }
    }

    public void setup(MethodCall call,Result result){
        JAnalyticsInterface.init(context);     		// 初始化 JPush
        Object channelObj = call.argument("channel");
        if (channelObj != null){
            String channel = (String) channelObj;
            JAnalyticsInterface.setChannel(context,channel);
        }
        dartIsReady = true;
    }

    public void setDebugMode(MethodCall call,Result result){
        Object debugObj = call.argument("debug");
        if (debugObj == null){
            return;
        }
        boolean debug = (boolean) debugObj;
        JAnalyticsInterface.setDebugMode(debug);
    }

    public void initCrashHandler(MethodCall call,Result result){
        JAnalyticsInterface.initCrashHandler(context);
    }

    public void stopCrashHandler(MethodCall call,Result result){
        JAnalyticsInterface.stopCrashHandler(context);
    }

    public void onPageStart(MethodCall call,Result result){
        String pageName = call.argument("pageName");
        JAnalyticsInterface.onPageStart(context,pageName);
    }

    public void onPageEnd(MethodCall call,Result result){
        String pageName = call.argument("pageName");
        JAnalyticsInterface.onPageEnd(context,pageName);
    }

    public void onCountEvent(MethodCall call,Result result){
        String eventId = call.argument("eventId");
        Map<String,String> extMap = call.argument("extMap");
        CountEvent event = new CountEvent(eventId);
        if (extMap!=null){
            event.addExtMap(extMap);
        }
        JAnalyticsInterface.onEvent(context,event);
    }

    public void onCalculateEvent(MethodCall call,Result result){
        String eventId = call.argument("eventId");
        Object eventValueObj = call.argument("eventValue");
        if (eventValueObj == null){
            return;
        }
        double eventValue = (double) eventValueObj;
        Map<String,String> extMap = call.argument("extMap");
        CalculateEvent calculateEvent = new CalculateEvent(eventId,eventValue);
        if (extMap != null){
            calculateEvent.addExtMap(extMap);
        }
        JAnalyticsInterface.onEvent(context,calculateEvent);
    }

    public void onLoginEvent(MethodCall call,Result result){
        String loginMethod = call.argument("loginMethod");
        Object loginSuccessObj = call.argument("loginSuccess");
        if (loginSuccessObj == null){
            return;
        }
        boolean loginSuccess = (boolean) loginSuccessObj;
        Map<String,String> extMap = call.argument("extMap");
        LoginEvent loginEvent = new LoginEvent(loginMethod,loginSuccess);
        if (extMap != null){
            loginEvent.addExtMap(extMap);
        }
        JAnalyticsInterface.onEvent(context,loginEvent);
    }

    public void onRegisterEvent(MethodCall call,Result result){
        String registerMethod = call.argument("registerMethod");
        Object registerSuccessObj = call.argument("registerSuccess");
        if (registerSuccessObj == null){
            return;
        }
        boolean registerSuccess = (boolean) registerSuccessObj;
        Map<String,String> extMap = call.argument("extMap");
        RegisterEvent registerEvent = new RegisterEvent(registerMethod,registerSuccess);
        if (extMap != null){
            registerEvent.addExtMap(extMap);
        }
        JAnalyticsInterface.onEvent(context,registerEvent);
    }

    public void onBrowseEvent(MethodCall call,Result result){
        String browseId = call.argument("browseId");
        String browseName = call.argument("browseName");
        String browseType = call.argument("browseType");
        Object browseDurationObj = call.argument("browseDuration");
        if (browseDurationObj == null){
            return;
        }
        int browseDuration = (int) browseDurationObj;
        Map<String,String> extMap = call.argument("extMap");
        BrowseEvent browseEvent = new BrowseEvent(browseId,browseName,browseType,browseDuration);
        if (extMap != null){
            browseEvent.addExtMap(extMap);
        }
        JAnalyticsInterface.onEvent(context,browseEvent);
    }

    public void onPurchaseEvent(MethodCall call,Result result){
        String purchaseGoodsid = call.argument("purchaseGoodsid");
        String purchaseGoodsName = call.argument("purchaseGoodsName");
        Object purchasePriceObj = call.argument("purchasePrice");
        Object purchaseSuccessObj = call.argument("purchaseSuccess");
        Object purchaseCurrencyObj = call.argument("purchaseCurrency");
        Object purchaseGoodsCountObj = call.argument("purchaseGoodsCount");
        if (purchasePriceObj == null || purchaseSuccessObj == null || purchaseCurrencyObj == null || purchaseGoodsCountObj == null){
            return;
        }
        double purchasePrice = (double) purchasePriceObj;
        boolean purchaseSuccess = (boolean) purchaseSuccessObj;
        int purchaseCurrency = (int) purchaseCurrencyObj;
        String purchaseGoodsType = call.argument("purchaseGoodsType");
        int purchaseGoodsCount = (int) purchaseGoodsCountObj;
        Map<String,String> extMap = call.argument("extMap");
        PurchaseEvent purchaseEvent = new PurchaseEvent(purchaseGoodsid,purchaseGoodsName,purchasePrice,purchaseSuccess, Currency.values()[purchaseCurrency],purchaseGoodsType,purchaseGoodsCount);
        if (extMap != null){
            purchaseEvent.addExtMap(extMap);
        }
        JAnalyticsInterface.onEvent(context,purchaseEvent);
    }

    public void setAnalyticsReportPeriod(MethodCall call,Result result){
        Object periodObj = call.argument("period");
        if (periodObj == null){
            return;
        }
        int period = (int) periodObj;
        JAnalyticsInterface.setAnalyticsReportPeriod(context,period);
    }

    public void identifyAccount(MethodCall call, final Result result){
        String accountID = call.argument("accountID");
        if (accountID == null){
            return;
        }
        Object creationTimeObj = call.argument("creationTime");
        Object sexObj = call.argument("sex");
        Object paidObj = call.argument("paid");
        String name = call.argument("name");
        String birthdate = call.argument("birthdate");
        String phone = call.argument("phone");
        String email = call.argument("email");
        String weiboID = call.argument("weiboID");
        String wechatID = call.argument("wechatID");
        String qqID = call.argument("qqID");
        Map<String,String> extMap = call.argument("extMap");

        Account account = new Account(accountID);
        if (creationTimeObj != null){
            long creationTime ;
            if (creationTimeObj instanceof Long){
                creationTime = (long) creationTimeObj;
            }else{
                creationTime = (int)creationTimeObj;
            }
            account.setCreationTime(creationTime);        //账户创建的时间戳
        }
        if (sexObj != null){
            int sex = (int) sexObj;
            account.setSex(sex);
        }
        if (paidObj != null){
            int paid = (int) paidObj;
            account.setPaid(paid);
        }
        if (name != null){
            account.setName(name);
        }
        if (birthdate != null){
            account.setBirthdate(birthdate);       //"19880920"是yyyyMMdd格式的字符串
        }
        if (phone != null){
            account.setPhone(phone);
        }
        if (email != null){
            account.setEmail(email);
        }
        if (wechatID != null){
            account.setWeiboId(weiboID);
        }
        if (wechatID != null){
            account.setWechatId(wechatID);
        }
        if (qqID != null){
            account.setQqId(qqID);
        }
        if (extMap != null){
            Set<String> keys = extMap.keySet();
            for (String key : keys) {
                account.setExtraAttr(key,extMap.get(key));
            }
        }
        Log.d("shikk","account:"+account.toString());
        JAnalyticsInterface.identifyAccount(context, account, new AccountCallback() {
            @Override
            public void callback(int i, String s) {
                Map<String,Object> res = new HashMap<>();
                res.put("code",i);
                res.put("msg",s);
                result.success(res);
            }
        });


    }

    public void detachAccount(MethodCall call, final Result result){
        JAnalyticsInterface.detachAccount(context, new AccountCallback() {
            @Override
            public void callback(int i, String s) {
                Map<String,Object> res = new HashMap<>();
                res.put("code",i);
                res.put("msg",s);
                result.success(res);
            }
        });
    }

}
