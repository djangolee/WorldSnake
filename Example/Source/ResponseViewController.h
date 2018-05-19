//
//  ResponseViewController.h
//  WorldSnake Example
//
//  Created by Panghu on 2018/5/21.
//  Copyright © 2018 Panghu Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WorldSnakeResult;

@interface ResponseViewController : UIViewController

- (void)setResponse:(NSURLResponse * _Nullable)response result:(WorldSnakeResult * _Nullable)result error:(NSError * _Nullable)error;

@property (nonatomic, strong, readonly) UIRefreshControl *refreshControl;

@end

NS_ASSUME_NONNULL_END

