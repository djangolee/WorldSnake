//
//  NSError+WSAdding.m
//  WorldSnake
//
//  Created by Panghu Lee on 2018/5/20.
//  Copyright © 2018 Panghu Lee. All rights reserved.
//

#import "NSError+WSAdding.h"

@implementation NSError (WSAdding)

+ (instancetype)errorWithWSErrorCode:(WorldSnakeErrorCode)code reason:(NSString * _Nullable)reason {
    reason = reason ? : @"";
    NSString *description = @"";
    
    switch (code) {
        case WorldSnakeErrorTaskInitialFailure:
            description = @"Reuqest 的Task初始化失败";
            break;
        case WorldSnakeErrorResponseCancel:
            description = @"Response 已从网络中获得，但被标记为取消";
            break;
        case WorldSnakeErrorRequestRetryMax:
            description = @"Request 的尝试次数到达了最大";
            break;
        case WorldSnakeErrorRequestUnknow:
            description = @"Request 发生了意料之外的状况";
            break;
    }
    
    return [NSError errorWithDomain:@"com.worldsnake" code:code userInfo:@{
                                                                           NSLocalizedDescriptionKey : description,
                                                                           NSLocalizedFailureReasonErrorKey : reason
                                                                           }];
}
@end

