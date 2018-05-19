//
//  WorldSnakeResult.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/16.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WorldSnakeRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorldSnakeResult : NSObject

@property (nonatomic, strong, readonly) id responseObject;

@property (nonatomic, strong, nullable, readonly) NSData  *data;
@property (nonatomic, copy, nullable, readonly) NSError  *error;
@property (nonatomic, copy, nullable, readonly) NSURLSessionTask *task;
@property (nonatomic, copy, nullable, readonly) NSURLRequest  *request;
@property (nonatomic, copy, nullable, readonly) NSURLResponse *response;

@property (nonatomic, readonly) WorldSnakeRequestTimeline timeline;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithRequest:(WorldSnakeRequest *)request responseObject:(id _Nullable)responseObject NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
