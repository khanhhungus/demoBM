//
//  ListNewsViewController.m
//  DemoBM
//
//  Created by CPU11738 on 4/17/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "ListNewsViewController.h"

@interface ListNewsViewController () {
    Constant *constant;
    TitleDescriptionView *titleView;
    FormatString *formatString;
    NSMutableDictionary *cellHeightDict;
}

@end

@implementation ListNewsViewController {
    UITableView *tableView;
}
static NSString *feedSingleImageNewsCellID = @"FeedSingleImageNewsCell";
static NSString *feedFourImageNewsCellID = @"FeedFourImageNewsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTableView];
    
    constant = Constant.new;
    formatString = FormatString.new;

}

- (void) addTableView {
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[FeedSingleImageNewsCell class] forCellReuseIdentifier: feedSingleImageNewsCellID];
    [tableView registerClass:[FeedFourImageNewsCell class] forCellReuseIdentifier: feedFourImageNewsCellID];

    [self.view addSubview:tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listNews.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    News *news = self.listNews[indexPath.section];
    return [self getTableViewCell:news :tableView :indexPath];
}

-(UITableViewCell *) getTableViewCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {
    
    if (news.images.count<3) {
        return [self getFeedSingleImageNewsCell:news :tableView :indexPath];
    } else {
        return [self getFeedFourNewsCell:news :tableView :indexPath];
    }

}

-(UITableViewCell *) getFeedSingleImageNewsCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {
    FeedSingleImageNewsCell *cell = (FeedSingleImageNewsCell *)[tableView dequeueReusableCellWithIdentifier: feedSingleImageNewsCellID forIndexPath: indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:feedSingleImageNewsCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell fillData:news];
    return cell;
}

-(UITableViewCell *) getFeedFourNewsCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {
    FeedFourImageNewsCell *cell = (FeedFourImageNewsCell *)[tableView dequeueReusableCellWithIdentifier: feedFourImageNewsCellID forIndexPath: indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:feedFourImageNewsCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell fillData:news];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self calculateRowHeight:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self calculateRowHeight:indexPath];
}

- (float) calculateRowHeight:(NSIndexPath *)indexPath  {
    News *news = self.listNews[indexPath.section];
    if (news.images.count < 3) {
        return [self calculateFeedSingleImageNewsHeightCell:news];

    } else {
        return [self calculateFeedFourImageNewsHeightCell:news];
    }
}


- (float) calculateFeedSingleImageNewsHeightCell:(News *)news {
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: news.contentID];
    if (valueCell == nil) {
        float publisherIconHeight = 35;
        float heightTitle = [formatString heightForString:news.title font: [constant fontMedium: 16.0f] maxWidth: constant.maxWidth];
        float heightDescMax = [constant heightForOneLine:[constant fontNormal: 14.0f]] * 3;
        float heightDescription = [formatString heightForString:news.desc font: [constant fontNormal: 14.0f] maxWidth: constant.maxWidth];
        if (heightDescription > heightDescMax){
            heightDescription = heightDescMax;
        }
        float heightSingleImage = 190;
        float heightForTitleDescView = heightTitle + heightDescription;
        float heightFooterView = [constant heightForOneLine: [constant fontNormal:14]];
        cellHeight = heightForTitleDescView + heightFooterView + publisherIconHeight + heightSingleImage + constant.spacing*4;
    
    } else {
        cellHeight = [valueCell doubleValue];

    }

    return cellHeight;
}

- (float) calculateFeedFourImageNewsHeightCell:(News *)news {
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: news.contentID];
    if (valueCell == nil) {
        float publisherIconHeight = 35;
        float heightTitle = [formatString heightForString:news.title font: [constant fontMedium: 16.0f] maxWidth: constant.maxWidth];
        float heightDescMax = [constant heightForOneLine:[constant fontNormal: 14.0f]] * 3;
        float heightDescription = [formatString heightForString:news.desc font: [constant fontNormal: 14.0f] maxWidth: constant.maxWidth];
        if (heightDescription > heightDescMax){
            heightDescription = heightDescMax;
        }
        
        float widthItem = (constant.maxWidth - constant.spacing*2)/ 3 ;
        float heightImages = 190 + widthItem + constant.spacing;
        
        float heightForTitleDescView = heightTitle + heightDescription;
        float heightFooterView = [constant heightForOneLine: [constant fontNormal:14]];
        
        cellHeight = heightForTitleDescView + heightFooterView + publisherIconHeight + heightImages + constant.spacing*4;
        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat:cellHeight];
        [cellHeightDict setValue: doubleValue forKey: news.contentID];
    } else {
        cellHeight = [valueCell doubleValue];

    }
    
    
    return cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

@end
