//
//  WorldSnakeSession+WSAdding.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/16.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeSession+WSAdding.h"

@implementation WorldSnakeSession (WSAdding)

#pragma mark Getter

+ (WorldSnakeDataRequest * _Nullable (^)(id<WSEncodingURLConvertible> _Nonnull))dataURL {
    return ^WorldSnakeDataRequest * _Nullable (id<WSEncodingURLConvertible> _Nonnull URL) {
        return [self.sharedSession requestWithURL:URL];
    };
}

+ (WorldSnakeDataRequest * _Nullable (^)(id<WSEncodingURLRequestConvertible> _Nonnull))dataRequest {
    return ^WorldSnakeDataRequest * _Nullable (id<WSEncodingURLRequestConvertible> _Nonnull URLRequest) {
        return [self.sharedSession requestWithURLRequest:URLRequest];
    };
}


+ (WorldSnakeDownloadRequest * _Nullable (^)(id<WSEncodingURLConvertible> _Nonnull))downloadURL {
    return ^WorldSnakeDownloadRequest * _Nullable (id<WSEncodingURLConvertible> _Nonnull URL) {
        return [self.sharedSession downloadWithURL:URL];
    };
}

+ (WorldSnakeDownloadRequest * _Nullable (^)(id<WSEncodingURLRequestConvertible> _Nonnull))downloadRequest {
    return ^WorldSnakeDownloadRequest * _Nullable (id<WSEncodingURLRequestConvertible> _Nonnull URLRequest) {
        return [self.sharedSession downloadWithURLRequest:URLRequest];
    };
}

+ (WorldSnakeUploadRequest * _Nullable (^)(id<WSEncodingURLConvertible> _Nonnull))uploadURL {
    return ^WorldSnakeUploadRequest * _Nullable (id<WSEncodingURLConvertible> _Nonnull URL) {
        return [self.sharedSession uploadWithURL:URL];
    };
}

+ (WorldSnakeUploadRequest * _Nullable (^)(id<WSEncodingURLRequestConvertible> _Nonnull))uploadRequest {
    return ^WorldSnakeUploadRequest * _Nullable (id<WSEncodingURLRequestConvertible> _Nonnull URLRequest) {
        return [self.sharedSession uploadWithURLRequest:URLRequest];
    };
}

- (WorldSnakeDataRequest * _Nullable (^)(id<WSEncodingURLConvertible> _Nonnull))dataURL {
    return ^WorldSnakeDataRequest * _Nullable (id<WSEncodingURLConvertible> _Nonnull URL) {
        return [self requestWithURL:URL];
    };
}

- (WorldSnakeDataRequest * _Nullable (^)(id<WSEncodingURLRequestConvertible> _Nonnull))dataRequest {
    return ^WorldSnakeDataRequest * _Nullable (id<WSEncodingURLRequestConvertible> _Nonnull URLRequest) {
        return [self requestWithURLRequest:URLRequest];
    };
}

- (WorldSnakeDownloadRequest * _Nullable (^)(id<WSEncodingURLConvertible> _Nonnull))downloadURL {
    return ^WorldSnakeDownloadRequest * _Nullable (id<WSEncodingURLConvertible> _Nonnull URL) {
        return [self downloadWithURL:URL];
    };
}

- (WorldSnakeDownloadRequest * _Nullable (^)(id<WSEncodingURLRequestConvertible> _Nonnull))downloadRequest {
    return ^WorldSnakeDownloadRequest * _Nullable (id<WSEncodingURLRequestConvertible> _Nonnull URLRequest) {
        return [self downloadWithURLRequest:URLRequest];
    };
}

- (WorldSnakeUploadRequest * _Nullable (^)(id<WSEncodingURLConvertible> _Nonnull))uploadURL {
    return ^WorldSnakeUploadRequest * _Nullable (id<WSEncodingURLConvertible> _Nonnull URL) {
        return [self uploadWithURL:URL];
    };
}

- (WorldSnakeUploadRequest * _Nullable (^)(id<WSEncodingURLRequestConvertible> _Nonnull))uploadRequest {
    return ^WorldSnakeUploadRequest * _Nullable (id<WSEncodingURLRequestConvertible> _Nonnull URLRequest) {
        return [self uploadWithURLRequest:URLRequest];
    };
}


@end
