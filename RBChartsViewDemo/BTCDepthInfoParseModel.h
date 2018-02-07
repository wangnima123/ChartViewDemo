//
//Created by ESJsonFormatForMac on 18/01/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "CMFLBaseParseModel.h"

@class BTCDepthDataItem, BTCDepthItem, BTCTickerItem, BTCPriceItem, BTCDepthItem;

@interface BTCDepthInfoParseModel : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) BTCDepthDataItem *data;

@property (nonatomic,   copy) NSString *msg;

- (void)setDepthItemData:(NSDictionary *)dict;

@end

@interface BTCDepthDataItem : NSObject

@property (nonatomic, strong) NSArray<BTCDepthItem *> *asks;

@property (nonatomic, strong) NSArray<BTCDepthItem *> *bids;

@property (nonatomic, strong) BTCTickerItem *ticker;
@end


@interface BTCDepthItem : NSObject
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *volume;
@end


@interface BTCTickerItem : NSObject

@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, strong) BTCPriceItem *high;

@property (nonatomic, assign) CGFloat vol;

@property (nonatomic, strong) BTCPriceItem *buy;

@property (nonatomic, strong) BTCPriceItem *last;

@property (nonatomic, strong) BTCPriceItem *sell;

@property (nonatomic, strong) BTCPriceItem *low;

@end

