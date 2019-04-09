//
//  DataSource.m
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/9/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "DataSource.h"
#import "News.h"

@implementation DataSource

-(void) fetchNewsData:(void(^)(NSMutableArray *arrayNews, NSError *error)) completion{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://data.baomoi.com/api/v2.0/article/byzone?apikey=ee7b8c7c7019f1b5c0674d41b125faf7&client_version=99.99.99&ctime=%20%20%201554714120&deviceName=iPhone7&gy=410437000&imgsize=a400&os=ios&session=aYR9.74788240.8.gSzASuFDteSJuAk3WytUXuFDteU3pTw7WZws7D_DteS&sig=f1d39b406e82f2e837d5cbdfc163064e&size=40&start=0&uid=792704069797727524&v=2.0&zone=c_0"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSError *err;
        NSDictionary *dummyJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &err];
        NSDictionary *dataJSON = dummyJSON[@"data"];
        NSArray *articlesJSON = dataJSON[@"articles"];
        
        NSMutableArray<News *> *arrayNews = NSMutableArray.new;
        for( NSDictionary *newsDict in articlesJSON) {
            NSString *title = newsDict[@"title"];
            NSString *publisher = newsDict[@"publisherName"];
            NSString *totalComments = newsDict[@"totalComments"];
            NSString *avatarURL = newsDict[@"avatarUrl"];
            NSNumber *date = newsDict[@"date"];
            News *news = News.new;
            news.title = title;
            news.publisher = publisher;
            news.avatarURL = avatarURL;
            news.totalComments = totalComments;
            news.date = date;            
            [arrayNews addObject:news];
        }
        completion(arrayNews,nil);
        
    }];
    
    [dataTask resume];
}
@end
