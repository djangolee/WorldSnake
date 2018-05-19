//
//  DetailViewController.h
//  WorldSnake Example
//
//  Created by Panghu Lee on 2018/5/19.
//  Copyright © 2018 Panghu Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WSEncodingURLRequestConvertible;

@interface DetailViewController : UIViewController

- (instancetype)initWithRequest:(id <WSEncodingURLRequestConvertible>)URLRequest;

@end

NS_ASSUME_NONNULL_END
