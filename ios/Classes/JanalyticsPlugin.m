#import "JanalyticsPlugin.h"

@interface NSError (FlutterError)
@property(readonly, nonatomic) FlutterError *flutterError;
@end

@implementation NSError (FlutterError)
- (FlutterError *)flutterError {
    return [FlutterError errorWithCode:[NSString stringWithFormat:@"Error %d", (int)self.code]
                               message:self.domain
                               details:self.localizedDescription];
}
@end


@implementation JanalyticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"janalytics"
                                     binaryMessenger:[registrar messenger]];
    JanalyticsPlugin* instance = [[JanalyticsPlugin alloc] init];
    instance.channel = channel;
    [registrar addApplicationDelegate: instance];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"setup" isEqualToString:call.method]) {
        [self setup:call result:result];
    }else if([@"setDebugMode" isEqualToString:call.method]){
        [self setDebugMode:call result:result];
    }else if([@"initCrashHandler" isEqualToString:call.method]){
        [self initCrashHandler:call result:result];
    }else if([@"stopCrashHandler" isEqualToString:call.method]){
        [self stopCrashHandler:call result:result];
    }else if([@"onPageStart" isEqualToString:call.method]){
        [self onPageStart:call result:result];
    }else if([@"onPageEnd" isEqualToString:call.method]){
        [self onPageEnd:call result:result];
    }else if([@"onCountEvent" isEqualToString:call.method]){
        [self onCountEvent:call result:result];
    }else if([@"onCalculateEvent" isEqualToString:call.method]){
        [self onCalculateEvent:call result:result];
    }else if([@"onLoginEvent" isEqualToString:call.method]){
        [self onLoginEvent:call result:result];
    }else if([@"onRegisterEvent" isEqualToString:call.method]){
        [self onRegisterEvent:call result:result];
    }else if([@"onBrowseEvent" isEqualToString:call.method]){
        [self onBrowseEvent:call result:result];
    }else if([@"onPurchaseEvent" isEqualToString:call.method]){
        [self onPurchaseEvent:call result:result];
    }else if([@"setAnalyticsReportPeriod" isEqualToString:call.method]){
        [self setAnalyticsReportPeriod:call result:result];
    }else if([@"identifyAccount" isEqualToString:call.method]){
        [self identifyAccount:call result:result];
    }else if([@"detachAccount" isEqualToString:call.method]){
        [self detachAccount:call result:result];
    }else {
        result(FlutterMethodNotImplemented);
    }
}

- (void) setup:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    NSString *appKey = arguments[@"appKey"];
    NSString *channel = arguments[@"channel"];
    JANALYTICSLaunchConfig *config = [[JANALYTICSLaunchConfig alloc] init];
    config.appKey = appKey;
    config.channel = channel;
    [JANALYTICSService setupWithConfig:config];
}

-(void) setDebugMode:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    id debug = arguments[@"debug"];
    if (debug) {
        [JANALYTICSService setDebug:YES];
    } else {
        [JANALYTICSService setDebug:NO];
    }
}

-(void) initCrashHandler:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    [JANALYTICSService crashLogON];
}

-(void) stopCrashHandler:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    
}

-(void) onPageStart:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    NSString *pageName = arguments[@"pageName"];
    [JANALYTICSService startLogPageView:pageName];
}

-(void) onPageEnd:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    NSString *pageName = arguments[@"pageName"];
    [JANALYTICSService stopLogPageView:pageName];
}

-(void) onCountEvent:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    id eventId = arguments[@"eventId"];
    NSDictionary *extMap = arguments[@"extMap"];
    JANALYTICSCountEvent * event = [[JANALYTICSCountEvent alloc] init];
    event.eventID = eventId;
    if(![extMap isKindOfClass:[NSNull class]]){
        event.extra = extMap;
    }
    [JANALYTICSService eventRecord:event];
}

-(void) onCalculateEvent:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    id eventId = arguments[@"eventId"];
    id eventValue = arguments[@"eventValue"];
    NSDictionary *extMap = arguments[@"extMap"];
    JANALYTICSCalculateEvent * event = [[JANALYTICSCalculateEvent alloc] init];
    event.eventID = eventId;
    event.value = [eventValue doubleValue];
    if (![extMap isKindOfClass:[NSNull class]]) {
        event.extra = extMap;
    }
    
    [JANALYTICSService eventRecord:event];
}

-(void) onLoginEvent:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    NSString *loginMethod = arguments[@"loginMethod"];
    id loginSuccess = arguments[@"loginSuccess"];
    NSDictionary *extMap = arguments[@"extMap"];
    JANALYTICSLoginEvent * event = [[JANALYTICSLoginEvent alloc] init];
    event.method = loginMethod;
    NSLog(@"loginSuccess   %@ ",loginSuccess);
    if (![loginSuccess isKindOfClass:[NSNull class]]) {
        NSLog(@"loginSuccess");
        event.success = [loginSuccess boolValue];
    }
    if(![extMap isKindOfClass:[NSNull class]]){
        event.extra = extMap;
    }
    
    [JANALYTICSService eventRecord:event];
}

-(void) onRegisterEvent:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    NSString *registerMethod = arguments[@"registerMethod"];
    NSNumber *registerSuccess = arguments[@"registerSuccess"];
    NSDictionary *extMap = arguments[@"extMap"];
    JANALYTICSRegisterEvent * event = [[JANALYTICSRegisterEvent alloc] init];
    event.method = registerMethod;
    if (![registerSuccess isKindOfClass:[NSNull class]]) {
        event.success = [registerSuccess boolValue];
    }
    if (![extMap isKindOfClass:[NSNull class]]) {
        event.extra = extMap;
    }
    [JANALYTICSService eventRecord:event];
}

-(void) onBrowseEvent:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    NSString *browseId = arguments[@"browseId"];
    NSString *browseName = arguments[@"browseName"];
    NSString *browseType = arguments[@"browseType"];
    NSNumber *browseDuration = arguments[@"browseDuration"];
    NSDictionary *extMap = arguments[@"extMap"];
    JANALYTICSBrowseEvent * event = [[JANALYTICSBrowseEvent alloc] init];
    event.name = browseName;
    event.type = browseType;
    event.contentID =browseId;
    if (![browseDuration isKindOfClass:[NSNull class]]) {
        event.duration = [browseDuration longValue];
    }
    if (![extMap isKindOfClass:[NSNull class]]) {
        event.extra = extMap;
    }
    [JANALYTICSService eventRecord:event];
}

-(void) onPurchaseEvent:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    NSString *purchaseGoodsid = arguments[@"purchaseGoodsid"];
    NSString *purchaseGoodsName = arguments[@"purchaseGoodsName"];
    NSNumber *purchasePrice = arguments[@"purchasePrice"];
    NSNumber *purchaseSuccess = arguments[@"purchaseSuccess"];
    NSNumber *purchaseCurrency = arguments[@"purchaseCurrency"];
    NSNumber *purchaseGoodsCount = arguments[@"purchaseGoodsCount"];
    NSString *purchaseGoodsType = arguments[@"purchaseGoodsType"];
    NSDictionary *extMap = arguments[@"extMap"];
    JANALYTICSPurchaseEvent * event = [[JANALYTICSPurchaseEvent alloc] init];
    if (![purchaseSuccess isKindOfClass:[NSNull class]]) {
        event.success = [purchaseSuccess boolValue];
    }
    if (![purchasePrice isKindOfClass:[NSNull class]]) {
        event.price = [purchasePrice doubleValue];
    }
    
    event.goodsName = purchaseGoodsName;
    event.goodsType = purchaseGoodsType;
    if (![purchaseGoodsCount isKindOfClass:[NSNull class]]) {
        event.quantity = [purchaseGoodsCount intValue];
    }
    event.goodsID = purchaseGoodsid;
    if(![purchaseCurrency isKindOfClass:[NSNull class]]){
        if ([purchaseCurrency intValue] == 0) {
            event.currency = JANALYTICSCurrencyCNY;
        }else{
            event.currency = JANALYTICSCurrencyUSD;
        }
    }
    if (![extMap isKindOfClass:[NSNull class]]) {
        event.extra = extMap;
    }
    [JANALYTICSService eventRecord:event];
}

-(void) setAnalyticsReportPeriod:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    NSNumber *period = arguments[@"period"];
    if (![period isKindOfClass:[NSNull class]] ) {
        [JANALYTICSService setFrequency:[period intValue]];
    }
    
}

-(void)identifyAccount:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    NSDictionary *arguments = call.arguments;
    NSString  *accountID = arguments[@"accountID"];
    NSNumber  *creationTime = arguments[@"creationTime"];
    NSNumber  *sex = arguments[@"sex"];
    NSNumber  *paid = arguments[@"paid"];
    NSString  *name = arguments[@"name"];
    NSString  *birthdate = arguments[@"birthdate"];
    NSString  *phone = arguments[@"phone"];
    NSString  *email = arguments[@"email"];
    NSString  *weiboID = arguments[@"weiboID"];
    NSString  *wechatID = arguments[@"wechatID"];
    NSString  *qqID = arguments[@"qqID"];
    NSDictionary  *extMap = arguments[@"extMap"];
    JANALYTICSUserInfo * userinfo = [[JANALYTICSUserInfo alloc] init];
    userinfo.accountID = accountID;
    if (![creationTime isKindOfClass:[NSNull class]]) {
        userinfo.creationTime = [creationTime longValue];
    }
    if (![sex isKindOfClass:[NSNull class]]) {
        userinfo.sex = [sex intValue];
    }
    if (![paid isKindOfClass:[NSNull class]]) {
        userinfo.paid = [paid intValue];
    }
    if (![email isKindOfClass:[NSNull class]] ) {
        userinfo.email = email;
    }
    if (![name isKindOfClass:[NSNull class]]) {
        userinfo.name = name;
    }
    if (![phone isKindOfClass:[NSNull class]]) {
        userinfo.phone = phone;
    }
    if (![birthdate isKindOfClass:[NSNull class]]) {
        userinfo.birthdate = birthdate;
    }
    if (![weiboID isKindOfClass:[NSNull class]]) {
        userinfo.weiboID = weiboID;
    }
    if (![wechatID isKindOfClass:[NSNull class]]) {
        userinfo.wechatID = wechatID;
    }
    if (![qqID isKindOfClass:[NSNull class]]) {
        userinfo.qqID = qqID;
    }
    if (![extMap isKindOfClass:[NSNull class]]) {
        NSArray *keys = [extMap allKeys];
        if (keys!=nil) {
            for (int i = 0; i<keys.count; i++) {
                NSString *key = keys[i];
                id value = [extMap objectForKey:key];
                if ([value isKindOfClass:[NSNull class]]) {
                    value = @"";
                }
                [userinfo setExtraObject:value forKey:key];
            }
        }
        
    }

    [JANALYTICSService identifyAccount:userinfo with:^(NSInteger err, NSString *msg) {
        
        reslut(@{@"code":@(err),@"msg":(msg?:@"")});
        
    }];
    
    
}

-(void)detachAccount:(FlutterMethodCall*)call result:(FlutterResult)reslut{
    [JANALYTICSService detachAccount:^(NSInteger err, NSString *msg) {
        
        reslut(@{@"code":@(err),@"msg":(msg?:@"")});
     
    }];
}

@end
