//
//  ViewController.h
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/8/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "HotNewsCell.h"
#import "News.h"
#import "DataSource.h"
#import "TableMultiImageCell.h"
#import "NewsDetailViewController.h"
#import "FBNewsCell.h"

@interface TableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, HotNewsCellDelegate>

@property(strong, nonatomic)NSMutableArray *arrayNews;
@end

