//
//  WBSQL.h
//  weibo
//
//  Created by xiong on 15/10/15.
//  Copyright © 2015年 x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBSQL : NSObject
+(NSArray *)statusWithParams:(NSDictionary *)params;
+(void)saveStatues:(NSArray *)statuses;
@end
