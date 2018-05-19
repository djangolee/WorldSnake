//
//  WorldSnakeRequest.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/8.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WorldSnakeSession;
@class WorldSnakeTaskDelegator;

@class WorldSnakeDataRequest;
@class WorldSnakeDownloadRequest;
@class WorldSnakeUploadRequest;
@class WorldSnakeStreamRequest;

@protocol WSEncodingURLRequestConvertible;

typedef NS_ENUM(NSUInteger, WorldSnakeRequestState) {
    WorldSnakeRequestInitial = 0,
    WorldSnakeRequestInitialFailure,
    WorldSnakeRequestFinish,
    WorldSnakeRequestCancel,
    WorldSnakeRequestUnknow,
    WorldSnakeRequestRetry,
    WorldSnakeRequestMaxRetryFinish,
};

struct WorldSnakeRequestTimeline {
    CFAbsoluteTime startTime;
    CFAbsoluteTime endTime;
    CFAbsoluteTime initialResponseTime;
};

typedef struct WorldSnakeRequestTimeline WorldSnakeRequestTimeline;

@interface WorldSnakeRequest : NSObject

@property (nonatomic, strong, readonly) WorldSnakeSession *session;

@property (nonatomic) uint maxRetryCount; // defalut: 1
@property (nonatomic, readonly) uint retryCount;
@property (nonatomic, strong, nullable, readonly) id <WSEncodingURLRequestConvertible> URLRequestConvertible;

@property (nonatomic, readonly) WorldSnakeRequestState state;

@property (nonatomic, readonly) WorldSnakeRequestTimeline timeline;

@property (nonatomic, copy, nullable, readonly) NSData  *data;
@property (nonatomic, copy, nullable, readonly) NSError  *error;

@property (nonatomic, strong, readonly) NSURLSessionTask *task;

@property (nonatomic, strong, readonly) WorldSnakeTaskDelegator *delegator;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithSession:(WorldSnakeSession *)session URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest NS_DESIGNATED_INITIALIZER;

+ (WorldSnakeDataRequest *)dataRequestWithSession:(WorldSnakeSession *)session URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest;
+ (WorldSnakeDownloadRequest *)downloadRequestWithSession:(WorldSnakeSession *)session URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest;
+ (WorldSnakeUploadRequest *)uploadRequestWithSession:(WorldSnakeSession *)session URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest;

- (void)resume;
- (void)suspend;
- (void)cancel;

- (void)didReceiveProgress:(NSProgress *)progress;
- (void)didCompleteWithState:(WorldSnakeRequestState)state task:(NSURLSessionTask * _Nullable)task error:(NSError * _Nullable)error;

@end

NS_ASSUME_NONNULL_END
