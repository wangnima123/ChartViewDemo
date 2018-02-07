//
//  BTCDepthXAxisFormatter.h
//  CMBitCoinOnline
//
//  Created by wangze on 2018/1/26.
//  Copyright © 2018年 LeftH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Charts/Charts-Swift.h>
#import "BTCDepthInfoParseModel.h"

@interface BTCDepthXAxisFormatter : NSObject<IChartAxisValueFormatter>
@property(nonatomic, strong)BTCDepthDataItem *depthDataItem;
@end
