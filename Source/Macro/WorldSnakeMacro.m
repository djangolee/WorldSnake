//
//  WorldSnakeMacro.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/14.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeMacro.h"

void wsext_execute_cleanup_block (__strong wsext_cleanup_block_t *block) {
    (*block)();
}
