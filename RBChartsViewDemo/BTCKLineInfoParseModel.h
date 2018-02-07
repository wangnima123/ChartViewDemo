//
//Created by ESJsonFormatForMac on 18/01/24.
//

#import <Foundation/Foundation.h>
//#import "CMFLBaseParseModel.h"

@class BTCKLineInfoCandleItem;
@interface BTCKLineInfoParseModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSArray *datas;

@property (nonatomic, copy) NSString *code;

@end

@interface BTCKLineInfoCandleItem : NSObject
@property (nonatomic, strong)NSString *timeStamp;
@property (nonatomic, strong)NSString *open;
@property (nonatomic, strong)NSString *high;
@property (nonatomic, strong)NSString *low;
@property (nonatomic, strong)NSString *close;
@property (nonatomic, strong)NSString *volume;
@end
