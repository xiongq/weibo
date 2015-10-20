//
//  accountTool.m
//  weibo
//
//  Created by xiong on 15/9/18.
//  Copyright © 2015年 x. All rights reserved.
//
#define HWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
#import "accountTool.h"
//#import "account.h"
@implementation accountTool
/**
 *  存储账号
 *
 *  @param account 账号模型
 */
+(void)saveAccount:(account *)account{
    account.created_time = [NSDate date];
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];
}
/**
 *  返回账号信息
 *
 *  @return 账号
 */
+(account *)account{
    account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountPath];
    long long expires_in =[account.expires_in longLongValue];
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    NSDate *now = [NSDate date];
    /**
     *  如果expiresTime 《=now 代表过期
     *  NSOrderedDescending 降序  右边 》左边
     *  NSOrderedAscending  升序 右边 《 左边
     *  NSOrderedSame  一样 
     *  NSComparisonResult比较
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    return account;
}
@end
