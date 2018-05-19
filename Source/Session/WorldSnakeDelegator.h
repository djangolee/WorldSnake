//
//  WorldSnakeDelegator.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/14.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WorldSnakeRequest;
@class WorldSnakeSession;

@protocol WorldSnakeSessionDelegate;

@interface WorldSnakeDelegator : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate, NSURLSessionStreamDelegate>

@property (nonatomic, strong) id<WorldSnakeSessionDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithSession:(WorldSnakeSession * _Nullable)session NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
