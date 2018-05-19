//
//  WSURLComponents.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/11.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WorldSnakeURLEncoding.h"

NS_ASSUME_NONNULL_BEGIN

@interface WSURLComponents : NSObject <NSCopying, NSSecureCoding, WSEncodingURLRequestConvertible>

@property (nonatomic, strong, readonly) NSURLComponents *URLComponents;
@property (nonatomic, strong, readonly) NSURLComponents *URLHeadComponents;
@property (nonatomic, readonly) WSHTTPMethod method;

- (instancetype)initWithURLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest;
- (instancetype)initWithURL:(id <WSEncodingURLConvertible>)URL;
- (instancetype)initWithURL:(id <WSEncodingURLConvertible>)URL method:(WSHTTPMethod)method queryItems:(NSArray <NSURLQueryItem *> * _Nullable)queryItems headers:(NSArray <NSURLQueryItem *> * _Nullable)headers;

- (void)compactQuery;   // eliminate and sort
- (void)compactHead;   // eliminate and sort

- (void)setURL:(id<WSEncodingURLConvertible>)URL;

- (void)setHTTPMethod:(WSHTTPMethod)HTTPMethod;

- (void)setScheme:(NSString * _Nullable)scheme;
- (void)setUser:(NSString * _Nullable)user;
- (void)setPassword:(NSString * _Nullable)password;
- (void)setHost:(NSString * _Nullable)host;
- (void)setPort:(NSNumber * _Nullable)port;
- (void)setPath:(NSString * _Nullable)path;
- (void)setPattern:(NSString * _Nullable)pattern keys:(NSArray <NSString *> * _Nullable)keys;

- (void)addingHeader:(NSURLQueryItem *)item;
- (void)addingHeaders:(NSArray <NSURLQueryItem *> *)items;

- (void)appendingQuery:(NSString *)query;
- (void)addingQuery:(NSURLQueryItem *)item;
- (void)addingQueryItems:(NSArray <NSURLQueryItem *> *)items;

- (void)removeAllHeaders;
- (void)removeHeaderForName:(NSString *)name;

- (void)removeAllQuery;
- (void)removeQueryForName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
