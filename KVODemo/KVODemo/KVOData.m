//
//  KVOData.m
//  KVODemo
//
//  Created by SnowDream on 2018/5/18.
//  Copyright © 2018年 YingLink. All rights reserved.
//

#import "KVOData.h"

@implementation KVOData

- (NSDictionary *)kvoDic {

    if (!_kvoDic) {
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
        [mulDic setObject:@(0) forKey:@"thirdNum"];
        _kvoDic = @{@"MulDic" : mulDic};
    }
    
    return _kvoDic;
}

@end
