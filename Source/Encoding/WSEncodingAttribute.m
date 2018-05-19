//
//  WSEncodingAttribute.m
//  WorldSnake
//
//  Created by Panghu Lee on 2018/5/12.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WSEncodingAttribute.h"

#import "WSURLComponents.h"

@interface WSEncodingAttribute ()

@property (nonatomic, weak) WSURLComponents *URLComponents;

@end

@implementation WSEncodingAttribute

- (instancetype)init {
    return [self initWithURLComponents:nil];
}

- (instancetype)initWithURLComponents:(WSURLComponents *)URLComponents  {
    if (self = [super init]) {
        _URLComponents = URLComponents;
    }
    return self;
}

@end

@implementation WSEncodingAttributeURLItem

#pragma mark WSEncodingAttributeURL

- (id<WSEncodingAttributeURLSet>)set {
    return self;
}

#pragma mark WSEncodingAttributeURLSet

- (void (^)(id<WSEncodingURLConvertible> _Nonnull))URL {
    return ^void (id<WSEncodingURLConvertible> _Nonnull URL) {
        [self.URLComponents setURL:URL];
    };
}

@end

@implementation WSEncodingAttributeSchemeItem

#pragma mark WSEncodingAttributeScheme

- (id<WSEncodingAttributeStringSet>)set {
    return self;
}

#pragma mark WSEncodingAttributeStringSet

- (void (^)(NSString * _Nonnull))string {
    return ^void (NSString * _Nonnull string) {
        [self.URLComponents setScheme:string];
    };
}

@end

@implementation WSEncodingAttributeUserItem

#pragma mark WSEncodingAttributeUser

- (id<WSEncodingAttributeStringSet>)set {
    return self;
}

#pragma mark WSEncodingAttributeStringSet

- (void (^)(NSString * _Nonnull))string {
    return ^void (NSString * _Nonnull string) {
        [self.URLComponents setUser:string];
    };
}

@end

@implementation WSEncodingAttributePasswordItem

#pragma mark WSEncodingAttributePassword

- (id<WSEncodingAttributeStringSet>)set {
    return self;
}

#pragma mark WSEncodingAttributeStringSet

- (void (^)(NSString * _Nonnull))string {
    return ^void (NSString * _Nonnull string) {
        [self.URLComponents setPassword:string];
    };
}

@end

@implementation WSEncodingAttributeHostItem

#pragma mark WSEncodingAttributeHost

- (id<WSEncodingAttributeStringSet>)set {
    return self;
}

#pragma mark WSEncodingAttributeStringSet

- (void (^)(NSString * _Nonnull))string {
    return ^void (NSString * _Nonnull string) {
        [self.URLComponents setHost:string];
    };
}

@end

@implementation WSEncodingAttributePortItem

#pragma mark WSEncodingAttributePort

- (id<WSEncodingAttributeNumberSet>)set {
    return self;
}

#pragma mark WSEncodingAttributeNumberSet

- (void (^)(NSNumber * _Nonnull))number {
    return ^void (NSNumber * _Nonnull number) {
        [self.URLComponents setPort:number];
    };
}

@end

@implementation WSEncodingAttributePathItem

#pragma mark WSEncodingAttributePath

- (id<WSEncodingAttributeStringSet>)set {
    return self;
}

#pragma mark WSEncodingAttributeStringSet

- (void (^)(NSString * _Nonnull))string {
    return ^void (NSString * _Nonnull string) {
        [self.URLComponents setPath:string];
    };
}

@end

@implementation WSEncodingAttributePatternItem

#pragma mark WSEncodingAttributePattern

- (id<WSEncodingAttributePatternSet>)set {
    return self;
}

#pragma mark WSEncodingAttributePatternSet

- (id<WSEncodingAttributePatternKeys>  _Nonnull (^)(NSString * _Nonnull))string {
    return ^id<WSEncodingAttributePatternKeys> (NSString * _Nonnull string) {
        self.pattern = string;
        return self;
    };
}

#pragma mark WSEncodingAttributePatternKeys

- (void (^)(NSArray<NSString *> * _Nonnull))keys {
    return ^void (NSArray<NSString *> * _Nonnull keys) {
        [self.URLComponents setPattern:self.pattern keys:keys];
    };
}

@end

@implementation WSEncodingAttributeHTTPMethodItem

#pragma mark WSEncodingAttributeHTTPMethod

- (id<WSEncodingAttributeHTTPMethodSet>)set {
    return self;
}

#pragma mark WSEncodingAttributeHTTPMethodSet

- (void (^)(WSHTTPMethod))enumeration {
    return ^void (WSHTTPMethod enumeration) {
        [self.URLComponents setHTTPMethod:enumeration];
    };
}

@end

@implementation WSEncodingAttributeHeaderItem

#pragma mark WSEncodingAttributeHeader

- (id<WSEncodingAttributeArrayAdding>)adding {
    return self;
}

- (id<WSEncodingAttributeArrayRemove>)remove {
    return self;
}

#pragma mark WSEncodingAttributeArrayAdding

- (void (^)(NSURLQueryItem * _Nonnull))item {
    return ^void (NSURLQueryItem * _Nonnull item) {
        [self.URLComponents addingHeader:item];
    };
}

- (void (^)(NSArray<NSURLQueryItem *> * _Nonnull))items {
    return ^void (NSArray<NSURLQueryItem *> * _Nonnull items) {
        [self.URLComponents addingHeaders:items];
    };
}

#pragma mark WSEncodingAttributeArrayRemove

- (void (^)(NSString * _Nonnull))name {
    return ^void (NSString * _Nonnull name) {
        [self.URLComponents removeHeaderForName:name];
    };
}

- (void (^)(void))all {
    return ^void (void) {
        [self.URLComponents removeAllHeaders];
    };
}

@end

@implementation WSEncodingAttributeQueryItem

#pragma mark WSEncodingAttributeQuery

- (id<WSEncodingAttributeStringAppending>)appending {
    return self;
}

- (id<WSEncodingAttributeArrayAdding>)adding {
    return self;
}

- (id<WSEncodingAttributeArrayRemove>)remove {
    return self;
}
#pragma mark WSEncodingAttributeStringAppending

- (void (^)(NSString * _Nonnull))string {
    return ^void (NSString * _Nonnull string) {
        [self.URLComponents appendingQuery:string];
    };
}

#pragma mark WSEncodingAttributeArrayAdding

- (void (^)(NSURLQueryItem * _Nonnull))item {
    return ^void (NSURLQueryItem * _Nonnull item) {
        [self.URLComponents addingQuery:item];
    };
}

- (void (^)(NSArray<NSURLQueryItem *> * _Nonnull))items {
    return ^void (NSArray<NSURLQueryItem *> * _Nonnull items) {
        [self.URLComponents addingQueryItems:items];
    };
}

#pragma mark WSEncodingAttributeArrayRemove

- (void (^)(NSString * _Nonnull))name {
    return ^void (NSString * _Nonnull name) {
        [self.URLComponents removeQueryForName:name];
    };
}

- (void (^)(void))all {
    return ^void (void) {
        [self.URLComponents removeAllQuery];
    };
}

@end
