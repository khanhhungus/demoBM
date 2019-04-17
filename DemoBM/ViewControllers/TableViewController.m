//
//  TableViewController.m
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/8/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "TableViewController.h"


@interface TableViewController () {
    NSMutableDictionary *cellHeightDict;
    FormatString *formatString ;
    Constant *constant;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end



@implementation TableViewController

@synthesize arrayNews;
static NSString *multiImageCellID = @"TableMultiImageCell";
static NSString *normalNewsCellID = @"CustomCell";
static NSString *hotNewsCellID = @"HotNewsCell";
static NSString *fbNewsCellID = @"FBNewsCell";
- (IBAction)barBtnTapped:(id)sender {
    ListNewsViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ListNewsViewController"];
    viewController.listNews = self.arrayNews;
    [self.navigationController pushViewController:viewController animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    constant = [[Constant alloc] init];
    DataSource *dataSource = [[DataSource alloc] init];
    [dataSource fetchNewsData:^(NSMutableArray * _Nonnull arrayNews, NSError * _Nonnull error) {
        self.arrayNews = arrayNews;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [[self tableView] registerClass:[TableMultiImageCell class] forCellReuseIdentifier: multiImageCellID];
    [[self tableView] registerClass:[HotNewsCell class] forCellReuseIdentifier: hotNewsCellID];
    [[self tableView] registerClass:[FBNewsCell class] forCellReuseIdentifier: fbNewsCellID];

    self.tableView.separatorColor = UIColor.clearColor;

    cellHeightDict = [[NSMutableDictionary alloc] init];
    formatString = [[FormatString alloc] init];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arrayNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    News *news = arrayNews[indexPath.section];
    return [self getTableViewCell:news :tableView :indexPath];
}

-(UITableViewCell *) getTableViewCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {
    
    if (indexPath.section % 3 == 0) {
        return [self getFBNewsCell:news :tableView :indexPath];
    }
    if (indexPath.section % 5 == 0) {
        return [self getHotNewsCell:news :tableView :indexPath];
    }
    
    if ( news.images.count > 2 ) {
        return [self getMultiImageCell:news :tableView :indexPath];
    } else {
        return [self getNormalCell:news :tableView :indexPath];
    }
}

-(UITableViewCell *) getMultiImageCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {    
    TableMultiImageCell *cell = (TableMultiImageCell *)[tableView dequeueReusableCellWithIdentifier:multiImageCellID];
    if (cell == nil) {
        cell = [[TableMultiImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:multiImageCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillData:news];
    
    
    return cell;
}

-(UITableViewCell *) getNormalCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier: normalNewsCellID];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:normalNewsCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell fillData:news];
    return cell;
}

-(UITableViewCell *) getHotNewsCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {
    HotNewsCell *cell = (HotNewsCell *)[tableView dequeueReusableCellWithIdentifier: hotNewsCellID forIndexPath: indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:hotNewsCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell fillData:news];
    return cell;
}

-(UITableViewCell *) getFBNewsCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {
    FBNewsCell *cell = (FBNewsCell *)[tableView dequeueReusableCellWithIdentifier: fbNewsCellID forIndexPath: indexPath];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:fbNewsCellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell fillData:news];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    News *news = arrayNews[indexPath.section];
    if (indexPath.section % 3 == 0) {
        return [self calculateHeightForFBNewsCell:news];
    }
    if (indexPath.section % 5 == 0) {
        return [self calculateHeightForHotNewsCell:news];
    }
    if (news.images.count > 2) {
        return [self calculateHeightForMultiImageCell:news];
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (float) calculateHeightForHotNewsCell:(News *) news {
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: news.contentID];
    if (valueCell == nil) {
        float titleHeight = [formatString heightForString: news.title font:[constant fontMedium: 22.0f] maxWidth: constant.maxWidth];
        float publisherHeight = [formatString heightForString: @"Bao moi" font:[constant fontNormal: 14.0f] maxWidth:constant.maxWidth];
        float heightDescMax = [constant heightForOneLine:[constant fontNormal: 14.0f]] * 3;
        float heightDescription = [formatString heightForString:news.desc font: [constant fontNormal: 14.0f] maxWidth: constant.maxWidth];
        if (heightDescription > heightDescMax){
            heightDescription = heightDescMax;
        }
        
        float imageHeight = 190;
        cellHeight = titleHeight + imageHeight + heightDescription+ publisherHeight + constant.spacing*3;
        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat:cellHeight];
        [cellHeightDict setValue: doubleValue forKey: news.contentID];
    } else {
        cellHeight = [valueCell doubleValue];
    }
    return cellHeight;
}

- (float) calculateHeightForFBNewsCell:(News *) news {
    float cellHeight = 0;
    NSString *valueCell = [cellHeightDict objectForKey: news.contentID];
    if (valueCell == nil) {
        
        float heightTitle = [formatString heightForString:news.title font: [constant fontMedium: 16.0f] maxWidth: constant.maxWidth];
        
        float heightDescMax = [constant heightForOneLine:[constant fontNormal: 14.0f]] * 3;
        float heightDescription = [formatString heightForString:news.desc font: [constant fontNormal: 14.0f] maxWidth: constant.maxWidth];
        if (heightDescription > heightDescMax){
            heightDescription = heightDescMax;
        }
        float imageHeight = 190;
        float publisherImgViewHeight = 35;
        float commentLbHeight = 18;
        cellHeight = heightTitle + imageHeight + heightDescription + publisherImgViewHeight + commentLbHeight + constant.spacing*4;
        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat:cellHeight];
        [cellHeightDict setValue: doubleValue forKey: news.contentID];
    } else {
        cellHeight = [valueCell doubleValue];
    }
    return cellHeight;
}

- (float) calculateHeightForMultiImageCell:(News *)news {
    float cellHeight = 0;

    NSString *valueCell = [cellHeightDict objectForKey: news.contentID];
    if (valueCell == nil) {
        float titleHeight = [formatString heightForString: news.title font:[constant fontMedium:16.0f] maxWidth: constant.maxWidth];
        float imageHeight = 75;
        float publisherHeight = [formatString heightForString: @"VietnamNet" font:[constant fontNormal:14.0f] maxWidth:constant.maxWidth];
        
        cellHeight = titleHeight + imageHeight + publisherHeight + constant.spacing * 2;
        NSNumber *doubleValue = [[NSNumber alloc] initWithFloat: cellHeight];
        [cellHeightDict setValue: doubleValue forKey: news.contentID];
    } else {
        cellHeight = [valueCell doubleValue];
    }
    
    return cellHeight;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsDetailViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewsDetailViewController"];
    viewController.news = arrayNews[indexPath.section];
    [self.navigationController pushViewController:viewController animated:true];
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
