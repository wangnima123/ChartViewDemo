//
//  BTCKlineXAxisFormatter.h
//  CMBitCoinOnline
//
//  Created by wangze on 2018/1/24.
//  Copyright © 2018年 LeftH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Charts/Charts-Swift.h>

@interface BTCKlineXAxisFormatter : NSObject<IChartAxisValueFormatter>
@property (nonatomic, copy)NSArray *kLineList;
@end
