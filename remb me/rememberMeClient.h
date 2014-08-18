//
//  rememberMeClient.h
//  remb me
//
//  Created by Vinay Raj on 18/08/14.
//  Copyright (c) 2014 Vinay Raj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "rembMeParser.h"

@interface rememberMeClient : NSObject<NSURLConnectionDelegate>
{
    NSMutableData *responseData;
}
+(rememberMeClient*)getSharedInstance;

-(void)getListOfImagesForTheGame;
@end
