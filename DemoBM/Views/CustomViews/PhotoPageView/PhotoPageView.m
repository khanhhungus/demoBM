//
//  PhotoPageView.m
//  DemoBM
//
//  Created by CPU11738 on 4/19/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "PhotoPageView.h"

@implementation PhotoPageView {
    Constant *constant;
    float heightScrollView;
    UIPageControl *pageControl;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initLayout];
    }
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int pageIndex = round(scrollView.contentOffset.x/constant.maxWidth);
    pageControl.currentPage = pageIndex;
}

-(void) initLayout {
    constant = Constant.new;
    heightScrollView = constant.maxWidth*0.7;

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, constant.maxWidth, heightScrollView)];
    _scrollView.delegate = self;
    _scrollView.layer.cornerRadius = 5;
    _scrollView.clipsToBounds = true;
    [_scrollView setScrollEnabled:YES];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [self addSubview:_scrollView];

    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_scrollView.center.x, heightScrollView + constant.spacing, 50, 10)];
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = UIColor.lightGrayColor;
    pageControl.currentPageIndicatorTintColor = UIColor.blueColor;
    [self addSubview:pageControl];
    _heightView = heightScrollView + 10;
}

- (void)fillData:(News *)news {
    float x = 0;
    pageControl.numberOfPages = news.images.count;
    for(Image *image in news.images) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, constant.maxWidth, heightScrollView)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:image.url] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
        [_scrollView addSubview:imageView];
        x = imageView.frame.origin.x + constant.maxWidth;
    }
    [_scrollView setContentSize:CGSizeMake(x+15, heightScrollView)];

}
@end
