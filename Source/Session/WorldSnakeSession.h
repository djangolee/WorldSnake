//
//  WorldSnakeSession.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/8.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WorldSnakeURLEncoding.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WorldSnakeSessionDelegate;
@protocol WorldSnakeTaskConvertible;
@protocol WSResponseSerialization;

@class WorldSnakeTaskConstructor;
@class XYWSResponseSerializer;

@class WorldSnakeDataRequest;
@class WorldSnakeDownloadRequest;
@class WorldSnakeUploadRequest;

@interface WorldSnakeSession : NSObject

@property (class, nonatomic, strong, readonly) WorldSnakeSession *sharedSession;

@property (nonatomic, strong, readonly) NSURLSession *URLsession;
@property (nonatomic, copy, readonly) NSURLSessionConfiguration *configuration;
@property (nonatomic, strong, nullable, readonly) id<WorldSnakeSessionDelegate> delegate;

@property (nonatomic, strong) WorldSnakeTaskConstructor <WorldSnakeTaskConvertible> *taskConstructor;
@property (nonatomic, strong) XYWSResponseSerializer <WSResponseSerialization> *serializer;
@property (nonatomic) BOOL startRequestsImmediately;

- (instancetype)initWithConfiguration:(NSURLSessionConfiguration * _Nullable)configuration;
- (instancetype)initWithConfiguration:(NSURLSessionConfiguration * _Nullable)configuration delegate:(id<WorldSnakeSessionDelegate> _Nullable)delegate NS_DESIGNATED_INITIALIZER;

+ (WorldSnakeSession *)sessionWithConfiguration:(NSURLSessionConfiguration * _Nullable)configuration;
+ (WorldSnakeSession *)sessionWithConfiguration:(NSURLSessionConfiguration * _Nullable)configuration delegate:(id<WorldSnakeSessionDelegate> _Nullable)delegate;

// DataRequest

- (WorldSnakeDataRequest * _Nullable)requestWithURLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest;

- (WorldSnakeDataRequest * _Nullable)requestWithURL:(id <WSEncodingURLConvertible>)URL;
- (WorldSnakeDataRequest * _Nullable)requestWithURL:(id <WSEncodingURLConvertible>)URL method:(WSHTTPMethod)method queryItems:(NSArray <NSURLQueryItem *> * _Nullable)queryItems headers:(NSArray <NSURLQueryItem *> * _Nullable)headers;

// Download

- (WorldSnakeDownloadRequest * _Nullable)downloadWithURLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest;

- (WorldSnakeDownloadRequest * _Nullable)downloadWithURL:(id <WSEncodingURLConvertible>)URL;
- (WorldSnakeDownloadRequest * _Nullable)downloadWithURL:(id <WSEncodingURLConvertible>)URL method:(WSHTTPMethod)method queryItems:(NSArray <NSURLQueryItem *> * _Nullable)queryItems headers:(NSArray <NSURLQueryItem *> * _Nullable)headers;

// Upload

- (WorldSnakeUploadRequest * _Nullable)uploadWithURLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest;

- (WorldSnakeUploadRequest * _Nullable)uploadWithURL:(id <WSEncodingURLConvertible>)URL;
- (WorldSnakeUploadRequest * _Nullable)uploadWithURL:(id <WSEncodingURLConvertible>)URL method:(WSHTTPMethod)method queryItems:(NSArray <NSURLQueryItem *> * _Nullable)queryItems headers:(NSArray <NSURLQueryItem *> * _Nullable)headers;

@end

NS_ASSUME_NONNULL_END
