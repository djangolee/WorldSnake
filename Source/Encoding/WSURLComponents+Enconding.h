//
//  WSURLComponents+Enconding.h
//  WorldSnake
//
//  Created by Panghu Lee on 2018/5/13.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WSURLComponents.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WSEncodingAttributeURL;
@protocol WSEncodingAttributeScheme;
@protocol WSEncodingAttributeUser;
@protocol WSEncodingAttributePassword;
@protocol WSEncodingAttributeHost;
@protocol WSEncodingAttributePort;
@protocol WSEncodingAttributePath;
@protocol WSEncodingAttributePattern;
@protocol WSEncodingAttributeHTTPMethod;
@protocol WSEncodingAttributeHeader;
@protocol WSEncodingAttributeQuery;

@interface WSURLComponents (Enconding)

@property (nonatomic, strong, readonly) id <WSEncodingAttributeURL> basURL;
@property (nonatomic, strong, readonly) id <WSEncodingAttributeScheme> scheme;
@property (nonatomic, strong, readonly) id <WSEncodingAttributeUser> user;
@property (nonatomic, strong, readonly) id <WSEncodingAttributePassword> password;
@property (nonatomic, strong, readonly) id <WSEncodingAttributeHost> host;
@property (nonatomic, strong, readonly) id <WSEncodingAttributePort> port;
@property (nonatomic, strong, readonly) id <WSEncodingAttributePath> path;
@property (nonatomic, strong, readonly) id <WSEncodingAttributePattern> pattern;
@property (nonatomic, strong, readonly) id <WSEncodingAttributeHTTPMethod> HTTPMethod;
@property (nonatomic, strong, readonly) id <WSEncodingAttributeHeader> head;
@property (nonatomic, strong, readonly) id <WSEncodingAttributeQuery> query;

@end

NS_ASSUME_NONNULL_END
