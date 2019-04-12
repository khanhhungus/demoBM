//
//  NewsDetailViewController.m
//  DemoBM
//
//  Created by CPU11738 on 4/11/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController () {
    float margin;
    float maxWidth;
    FormatString *calculateString;
    NSMutableDictionary *cellHeightDict;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
static NSString *cellID = @"NewsDetailCell";
static NSString *headerCellID = @"NewsDetailHeaderCell";
static NSString *publisherCellID = @"NewsDetailPublisherCell";
static NSString *descriptionCellID = @"NewsDetailDescriptionCell";
static NSString *thumbnailCellID = @"NewsDetailThumbnailCell";
static NSString *contentCellID = @"NewsDetailContentCell";



@implementation NewsDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat widthScreen  = [UIScreen mainScreen].bounds.size.width;
    maxWidth = widthScreen - margin*2;
    [[self tableView] registerClass:[NewsDetailCell class] forCellReuseIdentifier: cellID];
    [[self tableView] registerClass:[NewsDetailHeaderCell class] forCellReuseIdentifier: headerCellID];
    [[self tableView] registerClass:[NewsDetailPublisherCell class] forCellReuseIdentifier: publisherCellID];
    [[self tableView] registerClass:[NewsDetailDescriptionCell class] forCellReuseIdentifier: descriptionCellID];
    [[self tableView] registerClass:[NewsDetailThumbnailCell class] forCellReuseIdentifier: thumbnailCellID];
    [[self tableView] registerClass:[NewsDetailContentCell class] forCellReuseIdentifier: contentCellID];

    calculateString = [[FormatString alloc] init];
    cellHeightDict = [[NSMutableDictionary alloc] init];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return [self getHeaderCell:tableView :indexPath : self.news];
    } else if (indexPath.section == 1) {
        return [self getPublisherCell:tableView :indexPath : self.news];
    } else if (indexPath.section == 2) {
        return [self getDescriptionCell:tableView :indexPath : self.news];
    } else if (indexPath.section == 3) {
        return [self getThumbnailCell:tableView :indexPath : self.news];
    } else if (indexPath.section == 4) {
        return [self getContentCell:tableView :indexPath : self.news];
    } else {
        return UITableViewCell.new;
    }
}

- (UITableViewCell *) getHeaderCell: (UITableView *)tableView :(NSIndexPath *) indexPath :(News *) news {
    NewsDetailHeaderCell *cell = (NewsDetailHeaderCell *) [tableView dequeueReusableCellWithIdentifier: headerCellID forIndexPath:indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed: headerCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: headerCellID];
    if (valueCell == nil) {
        cellHeight = 100;
    } else {
        cellHeight = [valueCell doubleValue];
    }
    [cell fillData:news :cellHeight];

    return cell;
}

- (UITableViewCell *) getDescriptionCell: (UITableView *)tableView :(NSIndexPath *) indexPath :(News *) news {
    NewsDetailDescriptionCell *cell = (NewsDetailDescriptionCell *) [tableView dequeueReusableCellWithIdentifier: descriptionCellID forIndexPath:indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed: descriptionCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: descriptionCellID];
    if (valueCell == nil) {
        cellHeight = 100;
    } else {
        cellHeight = [valueCell doubleValue];
    }
    [cell fillData:news :cellHeight];
    
    return cell;
}


- (UITableViewCell *) getPublisherCell: (UITableView *)tableView :(NSIndexPath *) indexPath :(News *) news {
    NewsDetailPublisherCell *cell = (NewsDetailPublisherCell *) [tableView dequeueReusableCellWithIdentifier: publisherCellID forIndexPath:indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed: publisherCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell fillData:news];
    return cell;
}

- (UITableViewCell *) getThumbnailCell: (UITableView *)tableView :(NSIndexPath *) indexPath :(News *) news {
    NewsDetailThumbnailCell *cell = (NewsDetailThumbnailCell *) [tableView dequeueReusableCellWithIdentifier: thumbnailCellID forIndexPath:indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed: thumbnailCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell fillData:news];
    return cell;
}

- (UITableViewCell *) getContentCell: (UITableView *)tableView :(NSIndexPath *) indexPath :(News *) news {
    NewsDetailContentCell *cell = (NewsDetailContentCell *) [tableView dequeueReusableCellWithIdentifier: contentCellID forIndexPath:indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed: contentCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: contentCellID];
    if (valueCell == nil) {
        cellHeight = 100;
    } else {
        cellHeight = [valueCell doubleValue];
    }
    [cell fillData:news :cellHeight];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self calculateHeightForHeaderCell];
    } else if (indexPath.section == 1) {
        return 25;
    } else if (indexPath.section == 2) {
        return [self calculateHeightForDescriptionCell];
    } else if (indexPath.section == 3) {
        return 190;
    } else if (indexPath.section == 4) {
        return [self calculateHeightForContentCell];
    }
        
    return 100;
}

- (float) calculateHeightForHeaderCell {
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: headerCellID];
    if (valueCell == nil) {
        cellHeight = [calculateString heightForString: _news.title font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:26.0f] maxWidth:maxWidth ] ;
        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat:cellHeight];
        [cellHeightDict setValue: doubleValue forKey: headerCellID];
    } else {
        cellHeight = [valueCell doubleValue];
    }
    return cellHeight;
}

- (float) calculateHeightForDescriptionCell {
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: descriptionCellID];
    if (valueCell == nil) {
        cellHeight = [calculateString heightForString: _news.desc font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f] maxWidth:maxWidth ] ;
        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat:cellHeight];
        [cellHeightDict setValue: doubleValue forKey: descriptionCellID];
    } else {
        cellHeight = [valueCell doubleValue];
    }
    return cellHeight;
}

- (float) calculateHeightForContentCell {
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: contentCellID];
    if (valueCell == nil) {
        cellHeight = [calculateString heightForString: _news.content font:[UIFont fontWithName:@"HelveticaNeue" size:22.0f] maxWidth:maxWidth ] ;
        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat:cellHeight];
        [cellHeightDict setValue: doubleValue forKey: contentCellID];
    } else {
        cellHeight = [valueCell doubleValue];
    }
    return cellHeight + 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

- (void)dataFillSuccess:(NSIndexPath *)indexPath {
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    [indexPaths addObject: indexPath];
    [self.tableView reloadRowsAtIndexPaths: indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
}

@end
