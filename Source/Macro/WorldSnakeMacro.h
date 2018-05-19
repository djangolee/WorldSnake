//
//  WorldSnakeMacro.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/14.
//  Copyright © 2018 Panghu. All rights reserved.
//

#ifndef WorldSnakeMacro_h

#define WorldSnakeMacro_h

typedef void (^wsext_cleanup_block_t)(void);

#if defined(__cplusplus)
extern "C" {
#endif
    void wsext_execute_cleanup_block (__strong wsext_cleanup_block_t *block);
#if defined(__cplusplus)
}
#endif

#define wsmetamacro_concat_(A, B) A ## B
#define wsmetamacro_concat(A, B) \
wsmetamacro_concat_(A, B)

#if defined(DEBUG) && !defined(NDEBUG)
#define xywsext_keywordify autoreleasepool {}
#else
#define xywsext_keywordify try {} @catch (...) {}
#endif

#define defer_xyws \
xywsext_keywordify \
__strong wsext_cleanup_block_t wsmetamacro_concat(ext_exitBlock_, __LINE__) __attribute__((cleanup(wsext_execute_cleanup_block), unused)) = ^

#endif /* WorldSnakeMacro_h */
