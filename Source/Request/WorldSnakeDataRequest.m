//
//  WorldSnakeDataRequest.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/14.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeDataRequest.h"

#import "WorldSnakeDataResult.h"
#import "WorldSnakeTaskDelegator.h"
#import "WSResponseSerialization.h"

#import "WorldSnakeMacro.h"

@interface WorldSnakeDataRequest () <WorldSnakeDataResultAttribute>

@property (nonatomic, strong, nullable) NSOperationQueue *responseQueue;

@property (nonatomic, copy) Class klass;
@property (nonatomic) dispatch_queue_t schedulingQueue;
@property (nonatomic, copy) id<WSResponseSerialization> serializer;
@property (nonatomic, copy, nullable) void (^progressBlock)(NSProgress *progress);

@end

@implementation WorldSnakeDataRequest

- (instancetype)initWithSession:(WorldSnakeSession *)session URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    if (self = [super initWithSession:session URLRequest:URLRequest]) {
        _responseQueue = NSOperationQueue.new;
        _responseQueue.maxConcurrentOperationCount = 1;
        _responseQueue.suspended = true;
        _responseQueue.qualityOfService = NSQualityOfServiceUtility;
    }
    return self;
}

- (void)didReceiveProgress:(NSProgress *)progress {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.schedulingQueue, ^{
        if (weakSelf.progressBlock) {
            weakSelf.progressBlock(progress);
        }
    });
}

- (void)didCompleteWithState:(WorldSnakeRequestState)state task:(NSURLSessionTask *)task error:(NSError *)error {
    if (state != WorldSnakeRequestInitial && state != WorldSnakeRequestRetry) {
        self.responseQueue.suspended = NO;
    }
}

#pragma mark Getter

- (id<WorldSnakeDataResultAttribute>)response {
    return self;
}

- (id<WorldSnakeDataResultAttribute> (^)(dispatch_queue_t))scheduling {
    return ^ id<WorldSnakeDataResultAttribute> _Nonnull (dispatch_queue_t _Nonnull queue) {
        self.schedulingQueue = queue;
        return self;
    };
}
- (id<WorldSnakeDataResultAttribute> (^)(__unsafe_unretained Class))resultClass {
    return ^ id<WorldSnakeDataResultAttribute> _Nonnull (__unsafe_unretained Class klass) {
        self.klass = klass;
        return self;
    };
}

- (id<WorldSnakeDataResultAttribute> (^)(id<WSResponseSerialization>))serizlization {
    return ^ id<WorldSnakeDataResultAttribute> _Nonnull (id<WSResponseSerialization> _Nullable serializer) {
        self.serializer = serializer;
        return self;
    };
}

- (id<WorldSnakeDataResultAttribute> (^)(void (^)(NSProgress * _Nonnull)))progress {
    return ^ id<WorldSnakeDataResultAttribute> _Nonnull (void (^block)(NSProgress * _Nonnull progress)) {
        self.progressBlock = block;
        return self;
    };
}

- (id<WorldSnakeDataResultAttribute> (^)(void (^)(NSURLSessionDataTask *, WorldSnakeDataResult * _Nullable)))success {
    return ^ id<WorldSnakeDataResultAttribute> _Nonnull (void (^block)(NSURLSessionDataTask * _Nullable task, WorldSnakeDataResult * _Nullable result)) {
        [self.responseQueue addOperationWithBlock:^{
            if (block && !self.error) {
                NSError *error = nil;
                id responseObject = [self.serializer serializeResponseWithDataTask:(NSURLSessionDataTask *)self.task data:self.data resultClass:nil error:&error];
                dispatch_async(self.schedulingQueue, ^{
                    block((NSURLSessionDataTask *)self.task, [[WorldSnakeDataResult alloc] initWithRequest:self responseObject:responseObject]);
                });
            }
        }];
        return self;
    };
}

- (id<WorldSnakeDataResultAttribute> (^)(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable)))failure {
    return ^ id<WorldSnakeDataResultAttribute> _Nonnull (void (^block)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error)) {
        [self.responseQueue addOperationWithBlock:^{
            if (block && self.error) {
                dispatch_async(self.schedulingQueue, ^{
                    block((NSURLSessionDataTask *)self.task, self.error);
                });
            }
        }];
        return self;
    };
}

- (id<WSResponseSerialization>)serializer {
    return _serializer ? : XYWSResponseSerializer.serizlizer;
}

- (dispatch_queue_t)schedulingQueue {
    return _schedulingQueue == NULL ? dispatch_get_main_queue() : _schedulingQueue;
}

@end

