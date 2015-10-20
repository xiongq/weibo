//
//  WBSQL.m
//  weibo
//
//  Created by xiong on 15/10/15.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBSQL.h"
#import "FMDB.h"


@implementation WBSQL
static FMDatabase *_db;
+(void)initialize{
    //打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,  YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    //创建表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status(id integer PRIMARY KEY,status blob NOT NULL,idstr text NOT NULL);"];

}
+(NSArray *)statusWithParams:(NSDictionary *)params{
    NSString *sql = nil;
    if (params[@"since_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;",params[@"since_id"]];
    }else if (params[@"max_id"]){
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20;",params[@"max_id"]];
    }else{
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status ORDER BY idstr DESC LIMIT 20;"];
    }
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *array = [NSMutableArray new];
    while (set.next) {
        NSData *data = [set objectForColumnName:@"status"];
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:dic];
    }
    return array;
}
+(void)saveStatues:(NSArray *)statuses{
    for (NSDictionary *status in statuses) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_status(status,idstr) VALUES (%@,%@);",data,status[@"idstr"]];
    }

}
@end
