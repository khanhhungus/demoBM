//
//  DataSource.m
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/9/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "DataSource.h"
#import "News.h"
#import "Image.h"
#import "Body.h"

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
//            if ([title isKindOfClass:NSString.class]) {
//                continue;
//            }
            if (!title) {
                continue;
            }
            News *news = [self parseData:newsDict];
            [arrayNews addObject:news];
        }
        completion(arrayNews,nil);
    }];
    [dataTask resume];
}

- (void) fetchNewsDetail:(void(^)(News *news, NSError *error)) completion {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://data.baomoi.com/api/v1.0/article/detail?apikey=ee7b8c7c7019f1b5c0674d41b125faf7&contentid=30328018&ctime=%20%20%201555056243&imgsize=a700x&sig=5ec74d4cc95d579bd3af24bd9a16bdd7&v=2.0"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSError *err;
        NSDictionary *dummyJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &err];
        NSDictionary *dataJSON = dummyJSON[@"data"];
        News *news = [self parseData:dataJSON];
        completion(news,nil);
    }];
    [dataTask resume];
}

- (void) fetchRelatedNews: (void(^)(NSMutableArray *arrayNews, NSError *error)) completion {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://data.baomoi.com/api/v1.0/article/related?apikey=ee7b8c7c7019f1b5c0674d41b125faf7&client_version=99.99.99&contentid=30368770&ctime=%20%20%201555409292&deviceName=iPhone7Plus&gy=402667000&imgsize=w300_r4x3&os=ios&sig=14ffa677e243a0c13924438107f1bdf2"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSError *err;
        NSDictionary *dummyJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &err];
        NSDictionary *dataJSON = dummyJSON[@"data"];
        NSArray *articlesJSON = dataJSON[@"articles"];
        
        NSMutableArray<News *> *arrayNews = NSMutableArray.new;
        for( NSDictionary *newsDict in articlesJSON) {
            NSString *title = newsDict[@"title"];
            if (!title) {
                continue;
            }
            News *news = [self parseData:newsDict];
            [arrayNews addObject:news];
        }
        completion(arrayNews,nil);
    }];
    [dataTask resume];
}

- (News *) parseData:(NSDictionary *)newsDict {
    NSString *title = newsDict[@"title"];
    NSString *publisher = newsDict[@"publisherName"];
    NSString *totalComments = newsDict[@"totalComments"];
    NSString *avatarURL = newsDict[@"avatarUrl"];
    NSNumber *date = newsDict[@"date"];
    NSString *description = newsDict[@"description"];
    NSString *publisherIcon = newsDict[@"publisherIcon"];
    NSString *contentID = newsDict[@"contentId"];
    
    News *news = News.new;
    news.contentID = contentID;
    news.title = title;
    news.desc = description;
    news.publisher = publisher;
    news.publisherIcon = publisherIcon;
    news.avatarURL = avatarURL;
    news.totalComments = totalComments;
    news.date = date;
    news.cellHeight = [[NSDictionary alloc] init];
    news.content = @"";
    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSMutableArray *imagesDict = newsDict[@"images"];
    for (NSDictionary *imageDict in imagesDict) {
        if ([imageDict isKindOfClass:NSDictionary.class]) {
            Image *image = Image.new;
            image.url = imageDict[@"url"];
            [images addObject:image];
        }
    }
    if (images.count > 0) {
        news.images = images;
    }
    
    NSDictionary *bodyArrayDict = newsDict[@"body"];
    if (bodyArrayDict) {
        NSMutableArray *arrayBody = [[NSMutableArray alloc] init];
        for (NSDictionary *bodyDict in bodyArrayDict) {
            if ([bodyDict isKindOfClass:NSDictionary.class]) {
                NSString *type = bodyDict[@"type"];
                NSString *content = bodyDict[@"content"];
                Body *body = [[Body alloc]init];
                body.content = content;
                body.type = type;
                [arrayBody addObject:body];
            }
        }
        news.body = arrayBody;
    }
    
    return news;
}

@end
