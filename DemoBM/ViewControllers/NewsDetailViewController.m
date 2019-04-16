//
//  NewsDetailViewController.m
//  DemoBM
//
//  Created by CPU11738 on 4/11/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController () {
    FormatString *calculateString;
    NSMutableDictionary *cellHeightDict;
    DataSource *dataSource;
    UISwitch *switchBtn;
    Theme *theme;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
static NSString *cellID = @"NewsDetailCell";
static NSString *headerCellID = @"NewsDetailHeaderCell";
static NSString *publisherCellID = @"NewsDetailPublisherCell";
static NSString *descriptionCellID = @"NewsDetailDescriptionCell";
static NSString *thumbnailCellID = @"NewsDetailThumbnailCell";
static NSString *contentCellID = @"NewsDetailContentCell";
static NSString *bodyTextCellID = @"BodyTextCell";
static NSString *bodyImageCellID = @"BodyImageCell";
static NSString *relatedCellID = @"CustomCell";


@implementation NewsDetailViewController {
    Constant *constant;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    constant = Constant.new;
    [[self tableView] registerClass:[NewsDetailHeaderCell class] forCellReuseIdentifier: headerCellID];
    [[self tableView] registerClass:[NewsDetailPublisherCell class] forCellReuseIdentifier: publisherCellID];
    [[self tableView] registerClass:[NewsDetailDescriptionCell class] forCellReuseIdentifier: descriptionCellID];
    [[self tableView] registerClass:[NewsDetailThumbnailCell class] forCellReuseIdentifier: thumbnailCellID];
    [[self tableView] registerClass:[NewsDetailContentCell class] forCellReuseIdentifier: contentCellID];
    [[self tableView] registerClass:[BodyTextCell class] forCellReuseIdentifier: bodyTextCellID];
    [[self tableView] registerClass:[BodyImageCell class] forCellReuseIdentifier: bodyImageCellID];

    calculateString = [[FormatString alloc] init];
    cellHeightDict = [[NSMutableDictionary alloc] init];

    [self addSwitchBtn];
    [self fetchDataAPI];
}

- (void) fetchDataAPI {
    dataSource = [[DataSource alloc] init];
    dispatch_group_t serviceGroup = dispatch_group_create();
    
    dispatch_group_async(serviceGroup,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
        dispatch_group_enter(serviceGroup);
        [self->dataSource fetchNewsDetail:^(News * _Nonnull news, NSError * _Nonnull error) {
            self.news = news;
            dispatch_group_leave(serviceGroup);
        }];
    });
    
    dispatch_group_async(serviceGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_group_enter(serviceGroup);

        [self->dataSource fetchRelatedNews:^(NSMutableArray * _Nonnull arrayNews, NSError * _Nonnull error) {
            self.relatedNewsArray = arrayNews;
            dispatch_group_leave(serviceGroup);
        }];
    });
    
    dispatch_group_notify(serviceGroup,dispatch_get_main_queue(),^{
        [self.tableView reloadData];
    });
    
}

-(void) addSwitchBtn {
    switchBtn = [[UISwitch alloc] init];
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    theme = appDelegate.currentTheme;
    if (theme == appDelegate.darkTheme) {
        [switchBtn setOn:YES];
    } else {
        [switchBtn setOn:NO];
    }
    
    [switchBtn addTarget: self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *barItem = UIBarButtonItem.new;
    [barItem setCustomView:switchBtn];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: barItem, nil];
}

-(void) switchChange: (id) sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeTheme" object:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.relatedNewsArray.count > 0) {
        return 4 + self.news.body.count;
    }
    return 3 + self.news.body.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3 + self.news.body.count) {
        return self.relatedNewsArray.count;
    }
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
    } else {
        
        if (indexPath.section > 3 && indexPath.section < self.news.body.count + 3) {
            if ([self.news.body[indexPath.section - 4].type isEqual: @"text"]) {
                return [self getBodyTextCell:tableView :indexPath :self.news];
                
            } else if ([self.news.body[indexPath.section - 4].type isEqual: @"image"]) {
                return [self getBodyImageCell:tableView :indexPath :self.news];
            } else {
                return UITableViewCell.new;
            }
        } else {
            News *news = _relatedNewsArray[indexPath.row];
            return [self getRelatedCell:tableView :indexPath : news];
        }
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
        cellHeight = [self calculateHeightForHeaderCell];
    } else {
        cellHeight = [valueCell doubleValue];
    }
    [cell fillData:news :0];

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
        cellHeight = [self calculateHeightForDescriptionCell];
    } else {
        cellHeight = [valueCell doubleValue];
    }
    [cell fillData:news];
    
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

- (UITableViewCell *) getBodyTextCell: (UITableView *)tableView :(NSIndexPath *) indexPath :(News *) news {
    BodyTextCell *cell = (BodyTextCell *) [tableView dequeueReusableCellWithIdentifier: bodyTextCellID forIndexPath:indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed: bodyTextCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Body *body = self.news.body[indexPath.section - 4];
    [cell fillData:body];
    return cell;
}

- (UITableViewCell *) getBodyImageCell: (UITableView *)tableView :(NSIndexPath *) indexPath :(News *) news {
    BodyImageCell *cell = (BodyImageCell *) [tableView dequeueReusableCellWithIdentifier: bodyImageCellID forIndexPath:indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed: bodyImageCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.thumbnailImageView.image = [UIImage imageNamed:@"grayBackground.png"];
    Body *body = self.news.body[indexPath.section - 4];
    [cell fillData:body];
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

- (UITableViewCell *) getRelatedCell: (UITableView *)tableView :(NSIndexPath *) indexPath :(News *) news {
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier: relatedCellID];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:relatedCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell fillData:news];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self calculateRowHeight:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self calculateRowHeight:indexPath];
}

- (float) calculateRowHeight:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self calculateHeightForHeaderCell];
    } else if (indexPath.section == 1) {
        return 25;
    } else if (indexPath.section == 2) {
        return [self calculateHeightForDescriptionCell];
    } else if (indexPath.section == 3) {
        return 190;
    } else {
        if (indexPath.section > 3 && indexPath.section < self.news.body.count + 3) {
            if ([self.news.body[indexPath.section - 4].type isEqual: @"text"]) {
                Body *body = self.news.body[indexPath.section - 4];
                return [self calculateHeightForBodyTextCell:body.content];
            } else {
                return 190;
            }
        } else {
            return UITableViewAutomaticDimension;
        }
    }
}

- (float) calculateHeightForHeaderCell {
//    float cellHeight = 0;
//    NSString *valueCell = [cellHeightDict objectForKey: headerCellID];
//    if (valueCell == nil) {
        float cellHeight = [calculateString heightForString: self.news.title font:[constant fontMedium:26] maxWidth:constant.maxWidth] ;
//        NSLog(@"%f",cellHeight);
//        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat:cellHeight];
//        [cellHeightDict setValue: doubleValue forKey: headerCellID];
//    } else {
//        cellHeight = [valueCell doubleValue];
//    }
    return cellHeight;
}

- (float) calculateHeightForDescriptionCell {
//    float cellHeight = 0;
//    NSString *valueCell = [cellHeightDict objectForKey: descriptionCellID];
//    if (valueCell == nil) {
        float cellHeight = [calculateString heightForString: self.news.desc font:[constant fontMedium:22] maxWidth:constant.maxWidth ] ;
//        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat:cellHeight];
//        [cellHeightDict setValue: doubleValue forKey: descriptionCellID];
//    } else {
//        cellHeight = [valueCell doubleValue];
//    }
    return cellHeight;
}

- (float) calculateHeightForContentCell {
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: contentCellID];
    if (valueCell == nil) {
        cellHeight = [calculateString heightForString: _news.content font:[constant fontNormal:22] maxWidth:constant.maxWidth] ;
        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat:cellHeight];
        [cellHeightDict setValue: doubleValue forKey: contentCellID];
    } else {
        cellHeight = [valueCell doubleValue];
    }
    return cellHeight + 30;
}

- (float) calculateHeightForBodyTextCell :(NSString *) content {
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: content];
    if (valueCell == nil) {
        NSString *convertText = [calculateString convertHTML:content];
        cellHeight = [calculateString heightForString: convertText font:[constant fontNormal:22] maxWidth:constant.maxWidth] ;
        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat:cellHeight];
        [cellHeightDict setValue: doubleValue forKey: content];
    } else {
        cellHeight = [valueCell doubleValue];
    }
    return cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < self.news.body.count + 3) {
        return constant.margin;
    } else {
        return 30;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    if (section < self.news.body.count + 3) {
        return v;
    } else {
        float heightText = [constant heightForOneLine:[constant fontMedium:16]];
        AppLabel *titleLb = [[AppLabel alloc] initWithFrame:CGRectMake(constant.margin, constant.margin, constant.maxWidth, heightText)];
        titleLb.text =  @"Tin Khác";
        titleLb.textColor = theme.secondaryLabelColor;
        titleLb.font = [constant fontMedium:16];
        [v addSubview:titleLb];
        return v;
    }

}

@end
