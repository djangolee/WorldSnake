//
//  NSURLSessionTask+WSAdding.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/17.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "NSURLSessionTask+WSAdding.h"

#import <objc/runtime.h>

static char _supportload_xywsmast_key;

@implementation NSURLSessionTask (WSAdding)

- (WorldSnakeRequest *)ws_master {
    return objc_getAssociatedObject(self, &_supportload_xywsmast_key);
}

- (void)setWs_master:(WorldSnakeRequest *)ws_master {
    objc_setAssociatedObject(self, &_supportload_xywsmast_key, ws_master, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
