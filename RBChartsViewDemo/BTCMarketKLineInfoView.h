//
//  BTCMarketKLineInfoView.h
//  CMBitCoinOnline
//
//  Created by wangze on 2018/1/23.
//  Copyright © 2018年 LeftH. All rights reserved.
//

//typedef NS_ENUM(NSUInteger, BTCKLineType) {
//    BTCKLineType_1m,
//    BTCKLineType_15m,
//    BTCKLineType_1h,
//    BTCKLineType_4h,
//    BTCKLineType_1d,
//};

// 颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#import <UIKit/UIKit.h>
#import "BTCDepthInfoParseModel.h"
#import "BTCKLineInfoParseModel.h"
//#import "BTCFinanceChooseDetailTimeView.h"
//#import "BTCFinanceChartLoadingView.h"

typedef void(^BTCDidChangeTheGapTimeHandler)(void);

@interface BTCMarketKLineInfoView : UIView
@property (nonatomic, copy)BTCDidChangeTheGapTimeHandler didChangeTheGapTimeHandler;
//- (void)hideKlineTitleView:(BOOL)isToHide;
//- (void)hideDepthTitleView:(BOOL)isToHide;
- (void)reloadKLineData:(NSArray<BTCKLineInfoCandleItem *> *)klineList;
- (void)reloadDepthData:(BTCDepthInfoParseModel *)depthInfoParseModel;
//- (void)isToHideKlineLoadingView:(BOOL)isToHide andTitle:(NSString *)title;
//- (void)isToHideDepthLoadingView:(BOOL)isToHide andTitle:(NSString *)title;
//- (instancetype)initWithLoadingHandler:(BTCDidTouchLoadingViewHandler)loadingHandler;
@end
