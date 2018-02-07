//
//  BTCDepthXAxisFormatter.h
//  CMBitCoinOnline
//
//  Created by wangze on 2018/1/26.
//  Copyright © 2018年 LeftH. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BTCDepthXAxisFormatter.h"

@implementation BTCDepthXAxisFormatter

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    
    NSArray* reversedBids = [[[[NSMutableArray alloc] initWithArray:self.depthDataItem.bids] reverseObjectEnumerator] allObjects];
    NSString *priceStr = @"";
    if(value < reversedBids.count){
        priceStr = [[reversedBids objectAtIndex:value] price];
//        xValue = [CMFLCommonHelper correctChangePercentStr:priceStr];
    }else{
        priceStr = [[self.depthDataItem.asks objectAtIndex:(value - reversedBids.count)] price];
//        xValue = [CMFLCommonHelper correctChangePercentStr:priceStr];
    }
    return priceStr;
}

@end
