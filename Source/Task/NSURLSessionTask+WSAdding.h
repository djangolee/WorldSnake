//
//  NSURLSessionTask+WSAdding.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/17.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WorldSnakeRequest;

@interface NSURLSessionTask (WSAdding)

@property (nonatomic, strong, nullable) WorldSnakeRequest *ws_master;

@end

NS_ASSUME_NONNULL_END
