//
//  NSError+WSAdding.h
//  WorldSnake
//
//  Created by Panghu Lee on 2018/5/20.
//  Copyright © 2018 Panghu Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WorldSnakeErrorCode) {
    WorldSnakeErrorTaskInitialFailure   = 100000, // Reuqest 的Task初始化失败
    WorldSnakeErrorResponseCancel       = 100001, // Response 已从网络中获得，但被标记为取消
    WorldSnakeErrorRequestRetryMax      = 100002, // Request 的尝试次数到达了最大
    WorldSnakeErrorRequestUnknow        = 100003, // Request 发生了意料之外的状况
};

inline static NSError * WSErrorWithUnderlyingError(NSError *error, NSError *underlyingError) {
    if (!error) {
        return underlyingError;
    }
    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }
    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}

@interface NSError (WSAdding)

+ (instancetype)errorWithWSErrorCode:(WorldSnakeErrorCode)code reason:(NSString * _Nullable)reason;

@end

NS_ASSUME_NONNULL_END
