//
//  WorldSnake.h
//  WorldSnake
//
//  Created by Panghu Lee on 2018/5/19.
//  Copyright © 2018 Panghu Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for WorldSnake.
FOUNDATION_EXPORT double WorldSnakeVersionNumber;

//! Project version string for WorldSnake.
FOUNDATION_EXPORT const unsigned char WorldSnakeVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <WorldSnake/PublicHeader.h>

#import "WorldSnakeMacro.h"

// Session
#import "WorldSnakeSession.h"
#import "WorldSnakeSession+WSAdding.h"
#import "WorldSnakeSessionDelegate.h"

// Request

#import "WorldSnakeRequest.h"
#import "WorldSnakeDataRequest.h"
#import "WorldSnakeDownloadRequest.h"
#import "WorldSnakeUploadRequest.h"

// Result

#import "WorldSnakeResult.h"
#import "WorldSnakeDataResult.h"
#import "WorldSnakeDownloadResult.h"
#import "WorldSnakeUploadResult.h"

// URLEncoding

#import "WorldSnakeURLEncoding.h"
#import "WSURLComponents.h"
#import "WSURLComponents+Enconding.h"
#import "WSEncodingAttribute.h"
#import "WorldSnakeTaskConstructor.h"

// Response Serialization

#import "WSResponseSerialization.h"
