//
//  BTCMarketKLineInfoView.m
//  CMBitCoinOnline
//
//  Created by wangze on 2018/1/23.
//  Copyright © 2018年 LeftH. All rights reserved.
//

#import "BTCMarketKLineInfoView.h"
#import "BTCFinanceDetailViewConst.h"
#import "BTCKlineXAxisFormatter.h"
//#import "BTCKlineYAxisFormatter.h"
#import <Charts/Charts-Swift.h>
//#import "BTCFinanceDetailButton.h"
#import "BTCDepthXAxisFormatter.h"
//#import "BTCMarketInfoParseModel.h"

@interface BTCMarketKLineInfoView()<ChartViewDelegate>
@property (nonatomic, strong)CombinedChartView      *combinedChartView;
@property (nonatomic, strong)BarChartView           *barChartView;
@property (nonatomic, strong)LineChartView          *depthChartView;
@property (nonatomic,   copy)NSArray<BTCKLineInfoCandleItem *> *klineList;
@property (nonatomic, strong)BTCDepthInfoParseModel *depthInfoParseModel;
@property (nonatomic, strong)UILabel                *depthTitleLabel;
@property (nonatomic, strong)UIView                 *btnBackGView;
@property (nonatomic, strong)UIImageView            *upArrowImageView;
@property (nonatomic, strong)UIImageView            *downArrowImageView;
@end

@implementation BTCMarketKLineInfoView

- (instancetype)init{
    
    self = [super init];
    if(self){
        //        self.didTouchLoadingViewHandler = loadingHandler;
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    
    self.klineList = @[];
    self.frame = CGRectMake(0.0f, 0.0f, Main_Screen_Width, kBTCMarketKLineViewH);
    self.backgroundColor = RGBCOLOR(39, 39, 39);
    [self setupCombinedChartView];
    [self setupBarChartsView];
    [self setupDepthChartsView];
}

- (void)setupDepthChartsView{
    
    self.depthTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.barChartView.frame), Main_Screen_Width, kBTCDepthHeightTitleH)];
    [self addSubview:self.depthTitleLabel];
    self.depthTitleLabel.text = [NSString stringWithFormat:@"     %@", @"depthChartView"];
    self.depthTitleLabel.backgroundColor = RGBCOLOR(33, 33, 33);
    [self.depthTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.depthTitleLabel setTextColor:[UIColor whiteColor]];
    
    self.depthChartView = [[LineChartView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.depthTitleLabel.frame), Main_Screen_Width, kBTCDepthHeight)];
    [self addSubview:self.depthChartView];
    
    //    self.depthChartView.delegate = self;
    self.depthChartView.chartDescription.enabled = NO;
    self.depthChartView.drawGridBackgroundEnabled = NO;
    self.depthChartView.pinchZoomEnabled = NO;
    self.depthChartView.scaleXEnabled = YES;
    self.depthChartView.scaleYEnabled = NO;
    self.depthChartView.maxVisibleCount = 0;
    self.depthChartView.legend.enabled = YES;
    self.depthChartView.legend.textColor = RGBCOLOR(135, 135, 135);
    self.depthChartView.backgroundColor = RGBCOLOR(39, 39, 39);
    [self.depthChartView setAutoScaleMinMaxEnabled:YES];
    self.depthChartView.doubleTapToZoomEnabled = NO;
    self.depthChartView.noDataText = @"";
    
    ChartXAxis *xAxis = self.depthChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.drawAxisLineEnabled = YES;
    xAxis.valueFormatter = [[BTCDepthXAxisFormatter alloc] init];
    xAxis.labelCount = 6;
    xAxis.axisLineWidth = 1.1/[UIScreen mainScreen].scale;
    xAxis.labelTextColor = RGBCOLOR(135, 135, 135);
    
    ChartYAxis *leftAxis = self.depthChartView.leftAxis;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawAxisLineEnabled = NO;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.axisLineWidth = 1.1/[UIScreen mainScreen].scale;
    leftAxis.axisLineColor = [UIColor grayColor];
    leftAxis.labelTextColor = RGBCOLOR(135, 135, 135);
    leftAxis.labelCount = 3;
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    self.depthChartView.rightAxis.enabled = NO;
}

- (void)setupBarChartsView{
    
    self.barChartView = [[BarChartView alloc] initWithFrame:CGRectMake(0.0f, kBTCMarketSelectTimeViewH + kBTCMarketKLineView1H + 6.0f, Main_Screen_Width, kBTCMarketKLineView2H)];
    [self addSubview:self.barChartView];
    self.barChartView.delegate = self;
    [self.barChartView setAutoScaleMinMaxEnabled:YES];
    self.barChartView.scaleYEnabled = NO;
    self.barChartView.scaleXEnabled = YES;
    self.barChartView.chartDescription.enabled = NO;
    self.barChartView.maxVisibleCount = 0;
    self.barChartView.rightAxis.enabled = NO;
    self.barChartView.leftAxis.drawAxisLineEnabled = NO;
    self.barChartView.leftAxis.labelPosition = YAxisLabelPositionInsideChart;
    self.barChartView.leftAxis.labelTextColor = RGBCOLOR(135, 135, 135);
    self.barChartView.leftAxis.labelCount = 1;
    self.barChartView.leftAxis.drawGridLinesEnabled = YES;
    self.barChartView.leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    self.barChartView.xAxis.drawAxisLineEnabled = YES;
    self.barChartView.xAxis.labelPosition = XAxisLabelPositionTopInside;
    self.barChartView.xAxis.drawGridLinesEnabled = NO;
    self.barChartView.xAxis.labelTextColor = [UIColor clearColor];
    self.barChartView.legend.enabled = NO;
    self.barChartView.drawGridBackgroundEnabled = NO;
    self.barChartView.drawBordersEnabled = NO;
    self.barChartView.dragEnabled = YES;
    [self.barChartView setScaleEnabled:YES];
    self.barChartView.pinchZoomEnabled = NO;
    self.barChartView.doubleTapToZoomEnabled = NO;
    self.barChartView.noDataText = @"";
}

- (void)setupCombinedChartView{
    
    self.combinedChartView = [[CombinedChartView alloc] initWithFrame:CGRectMake(0.0f, kBTCMarketSelectTimeViewH + 12.0f, Main_Screen_Width, kBTCMarketKLineView1H)];
    
    [self addSubview:self.combinedChartView];
    self.combinedChartView.delegate = self;
    self.combinedChartView.chartDescription.enabled = NO;
    self.combinedChartView.drawGridBackgroundEnabled = NO;
    self.combinedChartView.pinchZoomEnabled = NO;
    self.combinedChartView.scaleXEnabled = YES;
    self.combinedChartView.scaleYEnabled = NO;
    self.combinedChartView.maxVisibleCount = 0;
    self.combinedChartView.chartDescription.enabled = NO;
    self.combinedChartView.legend.enabled = NO;
    self.combinedChartView.legend.textColor = RGBCOLOR(135, 135, 135);
    self.combinedChartView.backgroundColor = RGBCOLOR(39, 39, 39);
    [self.combinedChartView setAutoScaleMinMaxEnabled:YES];
    self.combinedChartView.doubleTapToZoomEnabled = NO;
    self.combinedChartView.noDataText = @"";
    
    ChartXAxis *xAxis = self.combinedChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.drawAxisLineEnabled = YES;
    xAxis.valueFormatter = [[BTCKlineXAxisFormatter alloc] init];
    xAxis.labelCount = 5;
    xAxis.axisLineWidth = 1.1/[UIScreen mainScreen].scale;
    xAxis.labelTextColor = RGBCOLOR(135, 135, 135);
    
    ChartYAxis *leftAxis = self.combinedChartView.leftAxis;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawAxisLineEnabled = NO;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.axisLineWidth = 1.1/[UIScreen mainScreen].scale;
    leftAxis.axisLineColor = [UIColor grayColor];
    leftAxis.labelTextColor = RGBCOLOR(135, 135, 135);
    leftAxis.labelCount = 3;
    leftAxis.labelPosition = YAxisLabelPositionInsideChart;
    //    leftAxis.valueFormatter = [[BTCKlineYAxisFormatter alloc] init];
    
    ChartYAxis *rightAxis = self.combinedChartView.rightAxis;
    rightAxis.enabled = NO;
}

- (void)reloadKLineData:(NSArray<BTCKLineInfoCandleItem *> *)klineList{
    
    if(klineList.count > 0){
        self.klineList = klineList;
        [self fillKlineView];
        [self fillBarView];
    }
}

- (void)reloadDepthData:(BTCDepthInfoParseModel *)depthInfoParseModel{
    
    self.depthInfoParseModel = depthInfoParseModel;
    [self fillDepthView];
}

- (void)fillDepthView{
    
    LineChartData *data = [[LineChartData alloc] init];
    BOOL needNotify = NO;
    NSArray<BTCDepthItem *> *bidlist = self.depthInfoParseModel.data.bids;
    NSArray<BTCDepthItem *> *asklist = self.depthInfoParseModel.data.asks;
    
    if(bidlist.count || asklist.count){
        BTCDepthXAxisFormatter *depthXAxisFormatter = (BTCDepthXAxisFormatter *)self.depthChartView.xAxis.valueFormatter;
        depthXAxisFormatter.depthDataItem = self.depthInfoParseModel.data;
    }
    if(bidlist.count > 0){
        
        NSArray* reversedArray = [[[[NSMutableArray alloc] initWithArray:bidlist] reverseObjectEnumerator] allObjects];
        
        BOOL bidNeedNotify = [self needNotifyDataWithDepthViewWithBidList:reversedArray andAskList:asklist atIndex:0 withData:data];
        needNotify = bidNeedNotify||needNotify;
    }
    if(asklist.count > 0){
        BOOL askNeedNotify = [self needNotifyDataWithDepthViewWithBidList:bidlist andAskList:asklist atIndex:1 withData:data];
        needNotify = askNeedNotify||needNotify;
    }
    [data setValueFont:[UIFont systemFontOfSize:8.f]];//文字字体
    [data setValueTextColor:[UIColor whiteColor]];//文字颜色
    self.depthChartView.data = data;
    //    [self.depthChartView animateWithYAxisDuration:1.0f];
    if(needNotify)[self.depthChartView notifyDataSetChanged];
}

//卖
- (BOOL)needNotifyDataWithDepthViewWithBidList:(NSArray<BTCDepthItem *> *)bids andAskList:(NSArray<BTCDepthItem *> *)asks atIndex:(NSInteger)index withData:(LineChartData *)chartData{
    
    NSArray<BTCDepthItem *> *depthList = [[NSArray<BTCDepthItem *> alloc] init];
    if(index == 0){
        depthList = bids;
    }else{
        depthList = asks;
    }
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < depthList.count; i++) {
        
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:index?(i + bids.count):i y:[[depthList[i] volume] doubleValue]];
        [yVals addObject:entry];
    }
    
    LineChartDataSet *set1 = nil;
    // 待会加回来
    //    if (self.depthChartView.data.dataSetCount ==  2) {
    //
    //        set1 = (LineChartDataSet *)self.depthChartView.data.dataSets[index];
    //        set1.values = yVals;
    //        [self.depthChartView.data notifyDataChanged];
    //        return YES;
    //
    //    }else{
    
    //创建LineChartDataSet对象
    set1 = [[LineChartDataSet alloc] initWithValues:yVals label:index?@"asks":@"bids"];
    //设置折线的样式
    set1.drawIconsEnabled = NO;
    set1.formLineWidth = 1.1;//折线宽度
    set1.formSize = 13.0;
    set1.drawValuesEnabled = YES;//是否在拐点处显示数据
    //        set1.valueColors = @[[UIColor whiteColor]];//折线拐点处显示数据的颜色
    [set1 setColor:index?RGBCOLOR(110, 203, 254):RGBCOLOR(247, 217, 86)];//折线颜色
    //折线拐点样式
    set1.drawCirclesEnabled = NO;//是否绘制拐点
    //第二种填充样式:渐变填充
    set1.drawFilledEnabled = YES;//是否填充颜色
    set1.fillAlpha = 0.6f;//透明度
    set1.fillColor = index?RGBCOLOR(110, 203, 254):RGBCOLOR(247, 217, 86);
    //点击选中拐点的交互样式
    set1.highlightEnabled = NO;//选中拐点,是否开启高亮效果(显示十字线)
    set1.highlightColor = RGBCOLOR(125, 125, 125);//点击选中拐点的十字线的颜色
    set1.highlightLineWidth = 1.1/[UIScreen mainScreen].scale;//十字线宽度
    set1.highlightLineDashLengths = @[@5, @5];//十字线的虚线样式
    
    //将 LineChartDataSet 对象放入数组中
    //        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    //        [dataSets addObject:set1];
    
    //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
    //        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    [chartData addDataSet:set1];
    return NO;
    //    }
}

- (void)fillBarView{

    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.klineList.count; i++) {
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:[self.klineList[i] volume].doubleValue];
        [yVals addObject:entry];
    }
    
    BarChartDataSet *set1 = nil;
    // 待会加回来
    //    if(self.barChartView.data.dataSetCount > 0){
    //        BarChartData *data = (BarChartData *)self.barChartView.data;
    //        set1 = (BarChartDataSet *)data.dataSets[0];
    //        set1.values = yVals;
    //        [self.barChartView.data notifyDataChanged];
    //        [self.barChartView notifyDataSetChanged];
    //    }else{
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    set1 = [[BarChartDataSet alloc] initWithValues:yVals];
    //    set1.barBorderWidth = 0.0;//柱形之间的间隙占整个柱形(柱形+间隙)的比例
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    
    [set1 setColors:[self getBarColors]];//设置柱形图颜色
    //将BarChartDataSet对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set1];
    self.barChartView.data = data;
    [self.barChartView setVisibleXRangeMaximum:50.0f];
    [self.barChartView moveViewToX:self.klineList.count-1];
    
    CGAffineTransform srcMatrix = self.combinedChartView.viewPortHandler.touchMatrix;
    [self.barChartView.viewPortHandler refreshWithNewMatrix:srcMatrix
                                                      chart:self.barChartView
                                                 invalidate:YES];
    
}

- (NSArray *)getBarColors{
    
    NSMutableArray *colorList = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.klineList.count; i++){
        BTCKLineInfoCandleItem *candleItem = [self.klineList objectAtIndex:i];
        if(candleItem.close.doubleValue - candleItem.open.doubleValue >= 0){
            [colorList addObject:RGBCOLOR(118, 167, 1)];
        }else{
            [colorList addObject:RGBCOLOR(221, 7, 113)];
        }
    }
    return colorList;
}

- (void)fillKlineView{
    
    
    [self.combinedChartView.viewPortHandler setMaximumScaleX:1.5f];
    
    //    [self.combinedChartView.viewPortHandler setMaximumScaleX:10.0f];
    
    BTCKlineXAxisFormatter *formatter = (BTCKlineXAxisFormatter *)self.combinedChartView.xAxis.valueFormatter;
    formatter.kLineList = self.klineList;
    // 待会加回来
    //    if(self.combinedChartView.combinedData.dataSetCount > 0){
    //
    //        if(self.combinedChartView.combinedData.lineData.dataSets.count == 1){
    //            [self updateM5LineData];
    //        }else if (self.combinedChartView.combinedData.lineData.dataSets.count == 2){
    //            [self updateM5LineData];
    //            [self updateM10LineData];
    //        }else if (self.combinedChartView.combinedData.lineData.dataSets.count == 3){
    //            [self updateM5LineData];
    //            [self updateM10LineData];
    //            [self updateM20LineData];
    //        }
    //
    //        if(self.combinedChartView.combinedData.lineData.dataSets.count > 0) [self.combinedChartView.combinedData.lineData notifyDataChanged];
    //        if(self.combinedChartView.combinedData.candleData.dataSets.count > 0){
    //            [self updateCandleData];
    //            [self.combinedChartView.combinedData.candleData notifyDataChanged];
    //        }
    //        [self.combinedChartView notifyDataSetChanged];
    //    }else{
    CombinedChartData *combinedData = [[CombinedChartData alloc] init];
    combinedData.lineData = [self generateLineData];
    combinedData.candleData = [self generateCandleData];
    self.combinedChartView.data = combinedData;
    //    [self.combinedChartView animateWithXAxisDuration:1.0f];
    //    }
    [self.combinedChartView setVisibleXRangeMaximum:50.0f];
    [self.combinedChartView moveViewToX:self.klineList.count-1];
    
    CGAffineTransform srcMatrix = self.barChartView.viewPortHandler.touchMatrix;
    [self.combinedChartView.viewPortHandler refreshWithNewMatrix:srcMatrix
                                                           chart:self.combinedChartView
                                                      invalidate:YES];
    
}

- (void)updateCandleData{
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.klineList.count; i++){
        
        BTCKLineInfoCandleItem *candleItem = [self.klineList objectAtIndex:i];
        NSLog(@"%@", candleItem.timeStamp);
        [yVals1 addObject:[[CandleChartDataEntry alloc] initWithX:i shadowH:candleItem.high.doubleValue shadowL:candleItem.low.doubleValue open:candleItem.open.doubleValue close:candleItem.close.doubleValue]];
    }
    
    if(self.combinedChartView.data.dataSetCount > 0){
        CandleChartData *data = (CandleChartData *)self.combinedChartView.data;
        CandleChartDataSet *set1 = (CandleChartDataSet *)data.dataSets[0];
        set1.values = yVals1;
        [self.combinedChartView.data notifyDataChanged];
        [self.combinedChartView notifyDataSetChanged];
    }
}

- (void)updateM5LineData{
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSArray *closePriceM5List = [self getClosePriceList:5];
    for(int index = 0; index < closePriceM5List.count; index++){
        [yVals addObject:[[ChartDataEntry alloc] initWithX:index+4 y:[[closePriceM5List objectAtIndex:index] doubleValue]]];
    }
    
    
    LineChartData *data = (LineChartData *)self.combinedChartView.combinedData.lineData;
    LineChartDataSet *set1 = (LineChartDataSet *)data.dataSets[0];
    set1.values = yVals;
}

- (void)updateM10LineData{
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSArray *closePriceM5List = [self getClosePriceList:10];
    for(int index = 0; index < closePriceM5List.count; index++){
        [yVals addObject:[[ChartDataEntry alloc] initWithX:index+9 y:[[closePriceM5List objectAtIndex:index] doubleValue]]];
    }
    
    LineChartData *data = (LineChartData *)self.combinedChartView.combinedData.lineData;
    LineChartDataSet *set1 = (LineChartDataSet *)data.dataSets[1];
    set1.values = yVals;
}

- (void)updateM20LineData{
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSArray *closePriceM5List = [self getClosePriceList:20];
    for(int index = 0; index < closePriceM5List.count; index++){
        [yVals addObject:[[ChartDataEntry alloc] initWithX:index+19 y:[[closePriceM5List objectAtIndex:index] doubleValue]]];
    }
    
    
    LineChartData *data = (LineChartData *)self.combinedChartView.combinedData.lineData;
    LineChartDataSet *set1 = (LineChartDataSet *)data.dataSets[2];
    set1.values = yVals;
}

- (LineChartData *)generateLineData{
    
    LineChartDataSet *set_M5 = [self getM5LineChartViewSet];
    LineChartDataSet *set_M10 = [self getM10LineChartViewSet];
    LineChartDataSet *set_M20 = [self getM20LineChartViewSet];
    LineChartData *data = [[LineChartData alloc] initWithDataSets:@[set_M5, set_M10, set_M20]];
    return data;
}

- (CandleChartData *)generateCandleData{
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.klineList.count; i++){
        
        BTCKLineInfoCandleItem *candleItem = [self.klineList objectAtIndex:i];
        NSLog(@"%@", candleItem.timeStamp);
        [yVals1 addObject:[[CandleChartDataEntry alloc] initWithX:i shadowH:candleItem.high.doubleValue shadowL:candleItem.low.doubleValue open:candleItem.open.doubleValue close:candleItem.close.doubleValue]];
    }
    CandleChartDataSet *set1 = [[CandleChartDataSet alloc] initWithValues:yVals1 label:@"k line"];
    [set1 setShadowColorSameAsCandle:YES];
    set1.highlightEnabled = NO;
    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:[UIColor colorWithWhite:80/255.f alpha:1.f]];
    set1.drawIconsEnabled = NO;
    set1.shadowWidth = 0.7;
    set1.decreasingColor = RGBCOLOR(221, 7, 113);
    set1.decreasingFilled = YES;
    set1.increasingColor = RGBCOLOR(118, 167, 0);
    set1.increasingFilled = YES;
    set1.neutralColor = RGBCOLOR(118, 167, 0);
    CandleChartData *data = [[CandleChartData alloc] initWithDataSet:set1];
    return data;
}

- (LineChartDataSet *)getM5LineChartViewSet{
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSArray *closePriceM5List = [self getClosePriceList:5];
    for(int index = 0; index < closePriceM5List.count; index++){
        [yVals addObject:[[ChartDataEntry alloc] initWithX:index+4 y:[[closePriceM5List objectAtIndex:index] doubleValue]]];
    }
    
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:yVals label:@"M5"];
    [self configLineSets:set];
    [set setColor:[UIColor colorWithRed:119/255.f green:206/255.f blue:254/255.f alpha:1.f]];
    set.fillColor = [UIColor colorWithRed:119/255.f green:206/255.f blue:254/255.f alpha:1.f];
    return set;
}

- (LineChartDataSet *)getM10LineChartViewSet{
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSArray *closePriceM10List = [self getClosePriceList:10];
    for(int index = 0; index < closePriceM10List.count; index++){
        [yVals addObject:[[ChartDataEntry alloc] initWithX:index+9 y:[[closePriceM10List objectAtIndex:index] doubleValue]]];
    }
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:yVals label:@"M10"];
    [self configLineSets:set];
    [set setColor:[UIColor colorWithRed:132/255.f green:80/255.f blue:240/255.f alpha:1.f]];
    set.fillColor = [UIColor colorWithRed:132/255.f green:80/255.f blue:240/255.f alpha:1.f];
    return set;
}

- (LineChartDataSet *)getM20LineChartViewSet{
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSArray *closePriceM20List = [self getClosePriceList:20];
    for(int index = 0; index < closePriceM20List.count; index++){
        [yVals addObject:[[ChartDataEntry alloc] initWithX:index+19 y:[[closePriceM20List objectAtIndex:index] doubleValue]]];
    }
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:yVals label:@"M20"];
    [self configLineSets:set];
    [set setColor:[UIColor colorWithRed:249/255.f green:237/255.f blue:81/255.f alpha:1.f]];
    set.fillColor = [UIColor colorWithRed:249/255.f green:237/255.f blue:81/255.f alpha:1.f];
    return set;
}

- (NSArray *)getClosePriceList:(NSInteger)days{
    
    NSInteger dayValue = days - 1;
    NSMutableArray *closePriceList = [[NSMutableArray alloc] init];
    for(NSInteger i = self.klineList.count - 1; i >= 0; i--){
        if(i - dayValue < 0) break;
        double allClosePriceDouble = 0.0;
        for(NSInteger j = i-dayValue; j<= i; j++){
            BTCKLineInfoCandleItem *candleItem = [self.klineList objectAtIndex:j];
            allClosePriceDouble += candleItem.close.doubleValue;
        }
        NSString *closePriceStr = [NSString stringWithFormat:@"%f", allClosePriceDouble/days];
        [closePriceList insertObject:closePriceStr atIndex:0];
    }
    return closePriceList;
}

- (void)configLineSets:(LineChartDataSet *)set{
    
    set.lineWidth = 1.0f;
    set.highlightEnabled = NO;
    set.mode = LineChartModeCubicBezier;
    set.drawValuesEnabled = NO;
    set.axisDependency = AxisDependencyLeft;
    set.drawCirclesEnabled = NO;
}

#pragma mark -
#pragma mark report GapTimeSelect Event
- (void)reportGapTimeSelectEvent:(NSInteger)tag{
    
}

#pragma mark -
#pragma mark ChartView Delegate
- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight {
    
}

- (void)chartScaled:(ChartViewBase *)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY {
    
    CGAffineTransform srcMatrix = chartView.viewPortHandler.touchMatrix;
    [self.combinedChartView.viewPortHandler refreshWithNewMatrix:srcMatrix
                                                           chart:self.combinedChartView
                                                      invalidate:YES];
    [self.barChartView.viewPortHandler refreshWithNewMatrix:srcMatrix
                                                      chart:self.barChartView
                                                 invalidate:YES];
}

- (void)chartTranslated:(ChartViewBase *)chartView dX:(CGFloat)dX dY:(CGFloat)dY {
    
    CGAffineTransform srcMatrix = chartView.viewPortHandler.touchMatrix;
    [self.combinedChartView.viewPortHandler refreshWithNewMatrix:srcMatrix
                                                           chart:self.combinedChartView
                                                      invalidate:YES];
    [self.barChartView.viewPortHandler refreshWithNewMatrix:srcMatrix
                                                      chart:self.barChartView
                                                 invalidate:YES];
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView {
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
