//
//  ViewController.m
//  Shopping
//
//  Created by HZhenF on 17/4/5.
//  Copyright © 2017年 筝风放风筝. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"
#import "TGModel.h"
#import "TgCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define ScrollViewHeight ([UIScreen mainScreen].bounds.size.height - 20) * 0.2
#define scrollViewWidth [UIScreen mainScreen].bounds.size.width * 0.8

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *tgArray;

//@property(nonatomic,strong) HeaderView *headerView;

@end

@implementation ViewController

-(NSArray *)tgArray
{
    if (!_tgArray) {
        _tgArray = [TGModel modelArray];
    }
    return _tgArray;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.contentInset = UIEdgeInsetsMake(ScrollViewHeight + 30, 0, 0, 0);
        [self.view addSubview:_tableView];
    }
    return _tableView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, -ScrollViewHeight - 30, ScreenWidth, ScrollViewHeight +30)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    
    [self.tableView addSubview:headerView];
    
}



-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - tableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tgArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TgCell *cell = [TgCell cellInit:tableView];
    TGModel *model = self.tgArray[indexPath.row];
    cell.model = model;
    
    return cell;
}



@end
