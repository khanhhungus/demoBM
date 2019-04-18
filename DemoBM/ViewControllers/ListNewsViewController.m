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
static NSString *feedArticleNewsCellID = @"FeedArticleNewsCell";
static NSString *feedDoubleImageNewsCellID = @"FeedDoubleImageNewsCell";
static NSString *feedTripleImageNewsCellID = @"FeedTripleImageNewsCell";


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
    [tableView registerClass:[FeedArticleNewsCell class] forCellReuseIdentifier: feedArticleNewsCellID];
    [tableView registerClass:[FeedDoubleImageNewsCell class] forCellReuseIdentifier: feedDoubleImageNewsCellID];
    [tableView registerClass:[FeedTripleImageNewsCell class] forCellReuseIdentifier: feedTripleImageNewsCellID];

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
    
    if (indexPath.section%3 == 0){
        return [self getFeedArticleNewsCell:news :tableView :indexPath];
    }
    
    switch (news.images.count) {
        case 0:
            return [self getFeedSingleImageNewsCell:news :tableView :indexPath];
        case 1:
            return [self getFeedSingleImageNewsCell:news :tableView :indexPath];
        case 2:
            return [self getFeedDoubleImageNewsCell:news :tableView :indexPath];
        case 3:
            return [self getFeedTripleImageNewsCell:news :tableView :indexPath];
        default:
            return [self getFeedFourNewsCell:news :tableView :indexPath];
            break;
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

-(UITableViewCell *) getFeedDoubleImageNewsCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {
    FeedDoubleImageNewsCell *cell = (FeedDoubleImageNewsCell *)[tableView dequeueReusableCellWithIdentifier: feedDoubleImageNewsCellID forIndexPath: indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:feedDoubleImageNewsCellID owner:self options:nil];
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

-(UITableViewCell *) getFeedTripleImageNewsCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {
    FeedTripleImageNewsCell *cell = (FeedTripleImageNewsCell *)[tableView dequeueReusableCellWithIdentifier: feedTripleImageNewsCellID forIndexPath: indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:feedTripleImageNewsCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell fillData:news];
    return cell;
}

-(UITableViewCell *) getFeedArticleNewsCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {
    FeedArticleNewsCell *cell = (FeedArticleNewsCell *)[tableView dequeueReusableCellWithIdentifier: feedArticleNewsCellID forIndexPath: indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:feedArticleNewsCellID owner:self options:nil];
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
    if (indexPath.section % 3 == 0){
        return [self calculateFeedArticleNewsHeightCell:news];
    }
    
    switch (news.images.count) {
        case 0:
            return [self calculateFeedSingleImageNewsHeightCell:news];
        case 1:
            return [self calculateFeedSingleImageNewsHeightCell:news];
        case 2:
            return [self calculateFeedDoubleImageNewsHeightCell:news];
        case 3:
            return [self calculateFeedTripleImageNewsHeightCell:news];
        default:
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

- (float) calculateFeedDoubleImageNewsHeightCell:(News *)news {
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
        
        float widthImage = (constant.maxWidth - constant.spacing)/ 2 ;
        float heightDoubleImage = widthImage*1.3;
        float heightForTitleDescView = heightTitle + heightDescription;
        float heightFooterView = [constant heightForOneLine: [constant fontNormal:14]];
        cellHeight = heightForTitleDescView + heightFooterView + publisherIconHeight + heightDoubleImage + constant.spacing*4;
        
    } else {
        cellHeight = [valueCell doubleValue];
    }
    
    return cellHeight;
}

- (float) calculateFeedTripleImageNewsHeightCell:(News *)news {
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
        
        float widthImage = (constant.maxWidth - constant.spacing)/ 2 ;
        float heightDoubleImage = widthImage*1.3;
        float heightForTitleDescView = heightTitle + heightDescription;
        float heightFooterView = [constant heightForOneLine: [constant fontNormal:14]];
        cellHeight = heightForTitleDescView + heightFooterView + publisherIconHeight + heightDoubleImage*2 + constant.spacing*4;
        
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

- (float) calculateFeedArticleNewsHeightCell:(News *)news {
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
        float heightArticleView = 75;
        float heightForTitleDescView = heightTitle + heightDescription;
        float heightFooterView = [constant heightForOneLine: [constant fontNormal:14]];
        
        cellHeight = heightForTitleDescView + heightFooterView + publisherIconHeight + heightArticleView + constant.spacing*4;
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
