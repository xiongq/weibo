//
//  account.h
//  weibo
//
//  Created by xiong on 15/9/7.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface account : NSObject<NSCoding>
/**用于调用access_token，接口授权后的access_token */
@property(copy, nonatomic) NSString *access_token;
/** access_token生命周期*/
@property(copy, nonatomic) NSString *expires_in;
/**用户uid */
@property(copy, nonatomic) NSString *uid;
/**用户name */
@property(copy, nonatomic) NSString *name;
/**	access token的创建时间 */
@property (nonatomic, strong) NSDate *created_time;

+(instancetype)accountWithDict:(NSDictionary *)dict;
@end
