//
//  BTCKlineXAxisFormatter.m
//  CMBitCoinOnline
//
//  Created by wangze on 2018/1/24.
//  Copyright © 2018年 LeftH. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BTCKlineXAxisFormatter.h"
#import "BTCKLineInfoParseModel.h"

@implementation BTCKlineXAxisFormatter

-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    
    if(value >= self.kLineList.count) return @"";
    BTCKLineInfoCandleItem *candleItem = [self.kLineList objectAtIndex:(int)value];
    NSTimeInterval timeInterval = [candleItem.timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
        NSString *dateStr = [formatter stringFromDate:date];
        if([dateStr isEqualToString:@"00:00"]){
            formatter.dateFormat = @"MM-dd";
            dateStr = [formatter stringFromDate:date];
        }
        return dateStr;
}

@end
