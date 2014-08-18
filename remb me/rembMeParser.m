//
//  rembMeParser.m
//  remb me
//
//  Created by Vinay Raj on 18/08/14.
//  Copyright (c) 2014 Vinay Raj. All rights reserved.
//

#import "rembMeParser.h"

@implementation rembMeParser

+(NSMutableArray*)getParsedListOfObjects : (NSDictionary*)response
{
    NSMutableArray *modalArray; int count;
    if( response != nil )
    {
        NSArray *itemsArray = response[@"items"];
        modalArray = [[NSMutableArray alloc]init];
        
        for( NSDictionary *record in itemsArray )
        {
            if( count > 9 )
                break;
            
            remMeModal *modalObj = [[remMeModal alloc]init];
            modalObj.imgUrl = [NSURL URLWithString: record[@"media"][@"m"]];
            [modalArray addObject:modalObj];
            count++;
        }
    }
    
    return modalArray;
}

@end
