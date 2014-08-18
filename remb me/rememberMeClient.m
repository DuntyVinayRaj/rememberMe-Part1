//
//  rememberMeClient.m
//  remb me
//
//  Created by Vinay Raj on 18/08/14.
//  Copyright (c) 2014 Vinay Raj. All rights reserved.
//

#import "rememberMeClient.h"
#import "AppDelegate.h"

@implementation rememberMeClient

-(AppDelegate*)appDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

+(rememberMeClient*)getSharedInstance
{
    static rememberMeClient *client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    
    return client;
}



-(void)getListOfImagesForTheGame
{

    //https://api.flickr.com/services/feeds/photos_public.gne
    
    NSURL *serverURL = [NSURL URLWithString:@"https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:serverURL];
    NSURLConnection *serverCon = [NSURLConnection connectionWithRequest:req delegate:self];
    [serverCon start];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Log : Failed with error - %@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectionFailed" object:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(responseData != nil)
        responseData = nil;
    
    responseData = [[NSMutableData alloc]init];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    
    
    if( error == nil )
    {
        NSLog(@"Log : response data - %@", responseData);
        NSLog(@"Log : Json obtained is - %@", json);
        NSMutableArray *modalCollection = [rembMeParser getParsedListOfObjects:json];
        
        if( [self appDelegate].modalCollection != nil )
        {
            [[self appDelegate].modalCollection removeAllObjects];
            [self appDelegate].modalCollection = nil;
        }
        
        NSLog(@"Log : modal collection - %@", modalCollection);
        
        [self appDelegate].modalCollection = modalCollection;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadContents" object:nil];
    }
    else
    {
//        if( error.code == 3840 )
//        {
            NSLog(@"Log : Problem with parsing... Reload request...");
            
            [self getListOfImagesForTheGame];
//        }
    }
    

}


@end
