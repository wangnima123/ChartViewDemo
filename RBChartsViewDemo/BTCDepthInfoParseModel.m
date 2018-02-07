//
//Created by ESJsonFormatForMac on 18/01/25.
//

#import "BTCDepthInfoParseModel.h"
#import <MJExtension/MJExtension.h>

@implementation BTCDepthInfoParseModel
MJExtensionLogAllProperties
- (void)setDepthItemData:(NSDictionary *)dict{
    
    //买方价格
    NSMutableArray *askList = [[NSMutableArray alloc] init];
    NSArray *asks = dict[@"asks"];
    for(int i = 0; i < asks.count; i++){
        BTCDepthItem *depthItem = [[BTCDepthItem alloc] init];
        depthItem.price = [NSString stringWithFormat:@"%f", [asks[i][0] doubleValue]];
        depthItem.volume = [NSString stringWithFormat:@"%f", [asks[i][1] doubleValue]];
        [askList addObject:depthItem];
    }
    self.data.asks = askList;
    
    //卖方价格
    NSMutableArray *bidList = [[NSMutableArray alloc] init];
    NSArray *bids = dict[@"bids"];
    for(int i = 0; i < bids.count; i++){
        BTCDepthItem *depthItem = [[BTCDepthItem alloc] init];
        depthItem.price = [NSString stringWithFormat:@"%f", [bids[i][0] doubleValue]];
        depthItem.volume = [NSString stringWithFormat:@"%f", [bids[i][1] doubleValue]];
        [bidList addObject:depthItem];
    }
    self.data.bids = bidList;
}

@end

@implementation BTCDepthDataItem
MJExtensionLogAllProperties
+ (NSArray *)mj_ignoredPropertyNames{
    return @[@"depth"];
}

@end

@implementation BTCDepthItem
MJExtensionLogAllProperties
@end


@implementation BTCTickerItem
MJExtensionLogAllProperties
@end



