//  HeaderView.m
//  Shopping
//
//  Created by HZhenF on 17/4/7.
//  Copyright © 2017年 筝风放风筝. All rights reserved.
//

#import "HeaderView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define scrollViewWidth [UIScreen mainScreen].bounds.size.width * 0.8
#define ScrollViewHeight ([UIScreen mainScreen].bounds.size.height - 20) * 0.2


@implementation HeaderView

#pragma mark - lazy load


-(NSMutableArray *)tgModel
{
    if (!_tgModel) {
        _tgModel = [NSMutableArray array];
    }
    return _tgModel;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        //创建布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //布局内容大小
        layout.itemSize = CGSizeMake(scrollViewWidth, ScrollViewHeight);
        //行距
        layout.minimumLineSpacing = 0;
        //每一列的距离
        layout.minimumInteritemSpacing = 0;
        //布局滚动的方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //创建UICollectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake((ScreenWidth - scrollViewWidth) * 0.5, 0, scrollViewWidth, CGRectGetHeight(self.frame) - 30) collectionViewLayout:layout];
        //是否分页
        _collectionView.pagingEnabled = YES;
        //水平和竖直方向是否显示滚动条
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:_collectionView];
        [self addView];
    }
    return _collectionView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self pictureLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.pageControl.numberOfPages = 5;
        [self myTimer];
    }
    return self;
}



#pragma UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tgModel.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    imageView.image = self.tgModel[indexPath.row];
    [cell.contentView addSubview:imageView];
    return cell;
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.myTimer invalidate];
    self.myTimer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self myTimer];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //page第一个点是0
    self.pageControl.currentPage = (self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5)/self.collectionView.bounds.size.width;
}

-(void)addView
{
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.collectionView.frame) + 5, ScreenWidth - 10, 1)];
        topLine.backgroundColor = [UIColor grayColor];
        [self addSubview:topLine];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.collectionView.frame), CGRectGetMaxY(topLine.frame) + 5, 100, 10)];
        label.text = @"猜你喜欢";
        label.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:label];
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(label.frame) + 5, ScreenWidth - 10, 1)];
        bottom.backgroundColor = [UIColor grayColor];
        self.myFrame = bottom.frame;
        [self addSubview:bottom];
}

-(NSTimer *)myTimer
{
    if (!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
    return _myTimer;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.collectionView.frame.origin.x, CGRectGetMaxY(self.collectionView.frame) - 29, CGRectGetWidth(self.collectionView.frame), 29)];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.backgroundColor = [UIColor whiteColor];
        _pageControl.alpha = 0.5;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

//布局5个图片
-(void)pictureLayout
{
    for (int i = 0; i < 5; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ad_%02d.png", i ]];
        [self.tgModel addObject:imageView.image];
    }
}

//自动到下一页
-(void)nextPage
{
    NSInteger currentPage = self.pageControl.currentPage;
    currentPage ++;
    if (currentPage == 5) {
        currentPage = 0;
    }
    [self.collectionView setContentOffset:CGPointMake(currentPage * scrollViewWidth, 0) animated:YES];
}


@end
