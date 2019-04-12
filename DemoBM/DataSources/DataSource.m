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
            news.content = @"Lê Dương Bảo Lâm được biết đến là diễn viên hài có tiếng tại khu vực phía Nam, nổi lên từ danh hiệu quán quân Cười xuyên Việt. Tuy nhiên, thời gian gần đây anh liên tục vướng phải ồn ào không hay, nổi bật là phát ngôn muốn mang trẻ cơ nhỡ về.Đặc biệt, đoạn clip ghi lại cảnh Bảo Lâm dùng tiếng Việt để miệt thị màu da một nhân viên bán hàng người nước ngoài khiến nhiều người bất bình. Nam diễn viên gọi người bán hàng là con quỷ. Những anti-fan chửi bới nặng lời, cho rằng tôi miệt thì người da màu thì có giải thích đến mấy họ cũng chẳng buồn hiểu. Vậy nên kệ đi. Tôi chỉ nói một lần duy nhất, tôi và những người bạn đến Ấn Độ hành hương, trao quà từ thiện. Những câu nói vui vẻ cũng giống như cách tôi trò chuyện khi livestream. Tất cả là giao tiếp giữa con người với con người.";
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
            [arrayNews addObject:news];
        }
        
        completion(arrayNews,nil);
        
    }];
    
    [dataTask resume];
}
@end
