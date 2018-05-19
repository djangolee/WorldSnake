//
//  WSEncodingAttribute
//  WorldSnake
//
//  Created by Panghu Lee on 2018/5/12.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WorldSnakeURLEncoding.h"

NS_ASSUME_NONNULL_BEGIN

@class WSURLComponents;

@protocol WSEncodingURLConvertible;

///
/// Operation protocol
///
@protocol WSEncodingAttributeStringSet <NSObject>

@property (nonatomic, copy, readonly) void (^string)(NSString *string);

@end

@protocol WSEncodingAttributeStringAppending <NSObject>

@property (nonatomic, copy, readonly) void (^string)(NSString *string);

@end

@protocol WSEncodingAttributeNumberSet <NSObject>

@property (nonatomic, copy, readonly) void (^number)(NSNumber *number);

@end

@protocol WSEncodingAttributeArrayAdding <NSObject>

@property (nonatomic, copy, readonly) void (^item)(NSURLQueryItem *item);
@property (nonatomic, copy, readonly) void (^items)(NSArray <NSURLQueryItem *> *items);

@end

@protocol WSEncodingAttributeArrayRemove <NSObject>

@property (nonatomic, copy, readonly) void (^name)(NSString *name);
@property (nonatomic, copy, readonly) void (^all)(void);

@end

@protocol WSEncodingAttributeURLSet <NSObject>

@property (nonatomic, copy, readonly) void (^URL)(id<WSEncodingURLConvertible> URL);

@end

@protocol WSEncodingAttributeHTTPMethodSet <NSObject>

@property (nonatomic, copy, readonly) void (^enumeration)(WSHTTPMethod HTTPMethod);

@end

@protocol WSEncodingAttributePatternKeys <NSObject>

@property (nonatomic, copy, readonly) void (^keys)(NSArray <NSString *> *string);

@end

@protocol WSEncodingAttributePatternSet <NSObject>

@property (nonatomic, copy, readonly) id <WSEncodingAttributePatternKeys> (^string)(NSString *string);

@end

/// Item procotol

// URL

@protocol WSEncodingAttributeURL <NSObject>

@property (nonatomic, strong, readonly) id <WSEncodingAttributeURLSet> set;

@end

// Scheme

@protocol WSEncodingAttributeScheme <NSObject>

@property (nonatomic, strong, readonly) id <WSEncodingAttributeStringSet> set;

@end

// User
@protocol WSEncodingAttributeUser <NSObject>

@property (nonatomic, strong, readonly) id <WSEncodingAttributeStringSet> set;

@end

// Password

@protocol WSEncodingAttributePassword <NSObject>

@property (nonatomic, strong, readonly) id <WSEncodingAttributeStringSet> set;

@end

// Host

@protocol WSEncodingAttributeHost <NSObject>

@property (nonatomic, strong, readonly) id <WSEncodingAttributeStringSet> set;

@end

// Port

@protocol WSEncodingAttributePort <NSObject>

@property (nonatomic, strong, readonly) id <WSEncodingAttributeNumberSet> set;

@end

// Path

@protocol WSEncodingAttributePath <NSObject>

@property (nonatomic, strong, readonly) id <WSEncodingAttributeStringSet> set;

@end

// Pattern

@protocol WSEncodingAttributePattern <NSObject>

@property (nonatomic, strong, readonly) id <WSEncodingAttributePatternSet> set;

@end

// HTTPMethod

@protocol WSEncodingAttributeHTTPMethod <NSObject>

@property (nonatomic, strong, readonly) id <WSEncodingAttributeHTTPMethodSet> set;

@end

// Head

@protocol WSEncodingAttributeHeader <NSObject>

@property (nonatomic, strong, readonly) id <WSEncodingAttributeArrayAdding> adding;
@property (nonatomic, strong, readonly) id <WSEncodingAttributeArrayRemove> remove;

@end

// Query

@protocol WSEncodingAttributeQuery <NSObject>

@property (nonatomic, strong, readonly) id <WSEncodingAttributeStringAppending> appending;
@property (nonatomic, strong, readonly) id <WSEncodingAttributeArrayAdding> adding;
@property (nonatomic, strong, readonly) id <WSEncodingAttributeArrayRemove> remove;

@end

@interface WSEncodingAttribute : NSObject

- (instancetype)initWithURLComponents:(WSURLComponents * _Nullable)URLComponents NS_DESIGNATED_INITIALIZER;

@end

@interface WSEncodingAttributeURLItem : WSEncodingAttribute <WSEncodingAttributeURL, WSEncodingAttributeURLSet>

@end

@interface WSEncodingAttributeSchemeItem : WSEncodingAttribute <WSEncodingAttributeScheme, WSEncodingAttributeStringSet>

@end

@interface WSEncodingAttributeUserItem : WSEncodingAttribute <WSEncodingAttributeUser, WSEncodingAttributeStringSet>

@end

@interface WSEncodingAttributePasswordItem : WSEncodingAttribute <WSEncodingAttributePassword, WSEncodingAttributeStringSet>

@end

@interface WSEncodingAttributeHostItem : WSEncodingAttribute <WSEncodingAttributeHost, WSEncodingAttributeStringSet>

@end

@interface WSEncodingAttributePortItem : WSEncodingAttribute <WSEncodingAttributePort, WSEncodingAttributeNumberSet>

@end

@interface WSEncodingAttributePathItem : WSEncodingAttribute <WSEncodingAttributePath, WSEncodingAttributeStringSet>

@end

@interface WSEncodingAttributePatternItem : WSEncodingAttribute <WSEncodingAttributePattern, WSEncodingAttributePatternSet, WSEncodingAttributePatternKeys>

@property (nonatomic, copy) NSString *pattern;

@end

@interface WSEncodingAttributeHTTPMethodItem : WSEncodingAttribute <WSEncodingAttributeHTTPMethod, WSEncodingAttributeHTTPMethodSet>

@end

@interface WSEncodingAttributeHeaderItem : WSEncodingAttribute <WSEncodingAttributeHeader, WSEncodingAttributeArrayAdding, WSEncodingAttributeArrayRemove>

@end

@interface WSEncodingAttributeQueryItem : WSEncodingAttribute <WSEncodingAttributeQuery, WSEncodingAttributeStringAppending, WSEncodingAttributeArrayAdding, WSEncodingAttributeArrayRemove>

@end

NS_ASSUME_NONNULL_END
