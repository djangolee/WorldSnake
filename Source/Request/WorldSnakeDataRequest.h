//
//  WorldSnakeDataRequest.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/14.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeRequest.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WorldSnakeDataResultAttribute;

@interface WorldSnakeDataRequest : WorldSnakeRequest

@property (nonatomic, strong, readonly) id <WorldSnakeDataResultAttribute> response;

@end

NS_ASSUME_NONNULL_END
