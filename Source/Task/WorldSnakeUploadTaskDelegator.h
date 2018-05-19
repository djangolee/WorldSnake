//
//  WorldSnakeUploadTaskDelegator.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/15.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeDataTaskDelegator.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorldSnakeUploadTaskDelegator : WorldSnakeDataTaskDelegator

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend;

@end

NS_ASSUME_NONNULL_END
