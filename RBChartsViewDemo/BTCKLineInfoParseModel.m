//
//Created by ESJsonFormatForMac on 18/01/24.
//

#import "BTCKLineInfoParseModel.h"
#import <MJExtension/MJExtension.h>

@implementation BTCKLineInfoParseModel
MJExtensionLogAllProperties
- (void)setDatas:(NSArray<BTCKLineInfoCandleItem *> *)datas{
    
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    for(NSArray *candleList in datas){
        BTCKLineInfoCandleItem *candleItem = [[BTCKLineInfoCandleItem alloc] init];
        NSNumber *timeStamp = [candleList objectAtIndex:0];
        
        candleItem.timeStamp = [NSString stringWithFormat:@"%ld", (long)(timeStamp.doubleValue/1000)];
        candleItem.open = [candleList objectAtIndex:1];
        candleItem.high = [candleList objectAtIndex:2];
        candleItem.low = [candleList objectAtIndex:3];
        candleItem.close = [candleList objectAtIndex:4];
        candleItem.volume = [candleList objectAtIndex:5];
        [dataList addObject:candleItem];
    }
    _datas = dataList?:@[];
}

@end

@implementation BTCKLineInfoCandleItem
MJExtensionLogAllProperties
@end

