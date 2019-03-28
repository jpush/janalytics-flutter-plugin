#import <Flutter/Flutter.h>
// 引入JAnalytics功能所需头文件
#import "JANALYTICSService.h"
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface JanalyticsPlugin : NSObject<FlutterPlugin>
@property FlutterMethodChannel *channel;
@end
