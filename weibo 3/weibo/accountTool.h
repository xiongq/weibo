//
//  accountTool.h
//  weibo
//
//  Created by xiong on 15/9/18.
//  Copyright © 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "account.h"
@class account;
@interface accountTool : NSObject
+(void)saveAccount:(account *)account;
+(account *)account;
@end
