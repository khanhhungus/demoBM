//
//  TableViewController.m
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/8/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "TableViewController.h"


@interface TableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewController

@synthesize arrayNews;
static NSString *multiImageCellID = @"TableMultiImageCell";
static NSString *normalNewsCellID = @"CustomCell";
static NSString *hotNewsCellID = @"HotNewsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataSource *dataSource = [[DataSource alloc] init];
    [dataSource fetchNewsData:^(NSMutableArray * _Nonnull arrayNews, NSError * _Nonnull error) {
        self.arrayNews = arrayNews;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [[self tableView] registerClass:[TableMultiImageCell class] forCellReuseIdentifier: multiImageCellID];
    [[self tableView] registerClass:[HotNewsCell class] forCellReuseIdentifier: hotNewsCellID];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayNews.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    News *news = arrayNews[indexPath.row];
    return [self getTableViewCell:news :tableView :indexPath];
}

-(UITableViewCell *) getTableViewCell: (News *) news :(UITableView *) tableView :(NSIndexPath *) indexPath {
    
    if (indexPath.row % 5 == 0) {
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
    cell.delegate = self;
    cell.indexPath = indexPath;
    [cell fillData:news];
    return cell;
}

- (void)dataFillSuccess:(NSIndexPath *)indexPath {
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    [indexPaths addObject: indexPath];
    [self.tableView reloadRowsAtIndexPaths: indexPaths withRowAnimation:UITableViewRowAnimationFade];
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    News *news = arrayNews[indexPath.row];
    if (indexPath.row % 5 == 0) {
        HotNewsCell *cell = (HotNewsCell *)[tableView dequeueReusableCellWithIdentifier: hotNewsCellID];
        float heightThumbnail = cell.thumbnailImageView.frame.size.height;
        float titleThumbnail = cell.titleLabel.frame.size.height;
        float heightDescription = cell.descriptionLabel.frame.size.height;
        float heightSource = cell.sourceLabel.frame.size.height;
        
        return heightThumbnail + titleThumbnail + heightDescription + heightSource + 15*3;
    }
    if (news.images.count > 2) {

        NSString *multiCellID = @"TableMultiImageCell";
        TableMultiImageCell *cell = (TableMultiImageCell *)[tableView dequeueReusableCellWithIdentifier: multiCellID];
        UILabel *titleLabel = cell.titleLabel;
        float titleLabelHeight = titleLabel.frame.size.height;
        UIImageView *imageView = cell.imageView1;
        float imageHeight = imageView.frame.size.height;
        UILabel *sourceLabel = cell.sourceLabel;
        float sourceLabelHeight = sourceLabel.frame.size.height;
        
        return titleLabelHeight + imageHeight + sourceLabelHeight + 15;

    } else {
        return UITableViewAutomaticDimension;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    NewsDetailViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewsDetailViewController"];
    viewController.news = arrayNews[indexPath.row];
    [self.navigationController pushViewController:viewController animated:true];
}


@end
