//
//  NewsDetailViewController.m
//  DemoBM
//
//  Created by CPU11738 on 4/11/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
static NSString *cellID = @"NewsDetailCell";
static NSString *headerCellID = @"NewsDetailHeaderCell";
FormatString *calculateString ;
NSMutableDictionary *cellHeightDict;

@implementation NewsDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self tableView] registerClass:[NewsDetailCell class] forCellReuseIdentifier: cellID];
    [[self tableView] registerClass:[NewsDetailHeaderCell class] forCellReuseIdentifier: headerCellID];
    calculateString = [[FormatString alloc] init];
    cellHeightDict = [[NSMutableDictionary alloc] init];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NewsDetailCell *cell = (NewsDetailCell *) [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
//    if (!cell) {
//        NSArray *nib = [[NSBundle mainBundle]loadNibNamed: cellID owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//    }
//    cell.delegate = self;
//    cell.indexPath = indexPath;
//    [cell fillData: self.news];
    
    if (indexPath.row == 0) {
        return [self getHeaderCell:tableView :indexPath : self.news];
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
    NSString *valueCell = [cellHeightDict objectForKey: @"NewsDetailHeaderCell"];
    if (valueCell == nil) {
        cellHeight = 100;
    } else {
        cellHeight = [valueCell doubleValue];
    }
    [cell fillData:news :cellHeight];

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self calculateHeightForHeaderCell];
    }
    return 100;
}

- (float) calculateHeightForHeaderCell {
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: @"NewsDetailHeaderCell"];
    if (valueCell == nil) {
        CGFloat widthScreen  = [UIScreen mainScreen].bounds.size.width;
        float margin = 15;
        float maxWidth = widthScreen - margin*2;
        cellHeight = [calculateString heightForString: _news.title font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:24.0f] maxWidth:maxWidth ] ;
        NSLog(@"%f",cellHeight);
        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat:cellHeight];
        [cellHeightDict setValue: doubleValue forKey: headerCellID];
    } else {
        cellHeight = [valueCell doubleValue];
    }
    return cellHeight;
}


- (void)dataFillSuccess:(NSIndexPath *)indexPath {
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    [indexPaths addObject: indexPath];
    [self.tableView reloadRowsAtIndexPaths: indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
}

@end
