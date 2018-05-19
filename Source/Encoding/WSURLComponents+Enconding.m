//
//  WSURLComponents+Enconding.m
//  WorldSnake
//
//  Created by Panghu Lee on 2018/5/13.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WSURLComponents+Enconding.h"

#import "WSEncodingAttribute.h"

@implementation WSURLComponents (Enconding)

#pragma mark Getter

- (id<WSEncodingAttributeURL>)basURL {
    return [[WSEncodingAttributeURLItem alloc] initWithURLComponents:self];
}

- (id<WSEncodingAttributeScheme>)scheme {
    return [[WSEncodingAttributeSchemeItem alloc] initWithURLComponents:self];
}

- (id<WSEncodingAttributeUser>)user {
    return [[WSEncodingAttributeUserItem alloc] initWithURLComponents:self];
}

- (id<WSEncodingAttributePassword>)password {
    return [[WSEncodingAttributePasswordItem alloc] initWithURLComponents:self];
}

- (id<WSEncodingAttributeHost>)host {
    return [[WSEncodingAttributeHostItem alloc] initWithURLComponents:self];;
}

- (id<WSEncodingAttributePort>)port {
    return [[WSEncodingAttributePortItem alloc] initWithURLComponents:self];
}

- (id<WSEncodingAttributePath>)path {
    return [[WSEncodingAttributePathItem alloc] initWithURLComponents:self];
}

- (id<WSEncodingAttributePattern>)pattern {
    return [[WSEncodingAttributePatternItem alloc] initWithURLComponents:self];
}

- (id<WSEncodingAttributeHTTPMethod>)HTTPMethod {
    return [[WSEncodingAttributeHTTPMethodItem alloc] initWithURLComponents:self];
}

- (id<WSEncodingAttributeHeader>)head {
    return [[WSEncodingAttributeHeaderItem alloc] initWithURLComponents:self];
}

- (id<WSEncodingAttributeQuery>)query {
    return [[WSEncodingAttributeQueryItem alloc] initWithURLComponents:self];
}

@end
