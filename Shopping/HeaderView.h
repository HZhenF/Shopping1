//
//  HeaderView.h
//  Shopping
//
//  Created by HZhenF on 17/4/7.
//  Copyright © 2017年 筝风放风筝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGModel.h"


@interface HeaderView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UIView *view;

@property(nonatomic,strong) NSTimer *myTimer;

@property(nonatomic,strong) UIPageControl *pageControl;

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray *tgModel;

@property(nonatomic,assign) CGRect myFrame;



@end
