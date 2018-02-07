//
//  ViewController.m
//  RBChartsViewDemo
//
//  Created by wangze on 2018/2/7.
//  Copyright © 2018年 wangze. All rights reserved.
//

#import "ViewController.h"
#import "BTCMarketKLineInfoView.h"
#import "BTCFinanceDetailViewConst.h"
#import <MJExtension/MJExtension.h>

@interface ViewController ()
@property (nonatomic, strong)UIScrollView *contentScrollView;
@property (nonatomic, strong)BTCMarketKLineInfoView *marketKLineInfoView;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self buildUI];
    [self buildData];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildUI{
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, Main_Screen_Width, Main_Screen_Height - 20.0f)];
    self.contentScrollView.contentSize = CGSizeMake(Main_Screen_Width, kBTCMarketKLineViewH);
    [self.view addSubview:self.contentScrollView];
    self.marketKLineInfoView = [[BTCMarketKLineInfoView alloc] init];
    [self.contentScrollView addSubview:self.marketKLineInfoView];
}

- (void)buildData{
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"depth_list.json" ofType:nil];
    //加载JSON文件
    NSData *data1 = [NSData dataWithContentsOfFile:path1];
    //将JSON数据转为NSArray或NSDictionary
    NSDictionary *depthDict = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
    BTCDepthInfoParseModel *depthInfoParseModel = [BTCDepthInfoParseModel mj_objectWithKeyValues:depthDict];
    [depthInfoParseModel setDepthItemData:depthDict[@"data"][@"depth"]];
    [self.marketKLineInfoView reloadDepthData:depthInfoParseModel];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"k_line_data.json" ofType:nil];
    //加载JSON文件
    NSData *data2 = [NSData dataWithContentsOfFile:path2];
    //将JSON数据转为NSArray或NSDictionary
    NSDictionary *kLineDict = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
    BTCKLineInfoParseModel *klineInfoParseModel = [BTCKLineInfoParseModel mj_objectWithKeyValues:kLineDict];
    klineInfoParseModel.datas = [kLineDict objectForKey:@"data"];
    [self.marketKLineInfoView reloadKLineData:klineInfoParseModel.datas];
}

@end
