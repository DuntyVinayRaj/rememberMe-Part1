//
//  rembMeParser.h
//  remb me
//
//  Created by Vinay Raj on 18/08/14.
//  Copyright (c) 2014 Vinay Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "remMeModal.h"

@interface rembMeParser : NSObject

+(NSMutableArray*)getParsedListOfObjects : (NSDictionary*)response;


@end
