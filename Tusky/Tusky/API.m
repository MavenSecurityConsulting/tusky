//
//  API.m
//  Tusky
//
//  Created by Hendy Chua on 23/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "API.h"

//the web location of the service
#define kAPIHost @"http://localhost:5000"
#define kAPIPath @""

@implementation API

@synthesize user;

/**
 * Singleton methods
 */
+(API*)sharedInstance
{
    static API *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAPIHost]];
    });
    
    return sharedInstance;
}

-(API*)init
{
	//call super init
    self = [super init];
	
    if (self != nil) {
        //initialize the object
        user = nil;
		
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
		
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
	
    return self;
	
}

-(BOOL)isAuthorized
{
    return [[user objectForKey:@"userID"] intValue]>0;
}

-(void)commandWithParams:(NSMutableDictionary*)params Path:(NSString *)action Method:(NSString *)method onCompletion:
(JSONResponseBlock)completionBlock
{
	NSLog(@"Getting API service for %@ with parameters=%@",action, params);
    NSMutableURLRequest *apiRequest = [self multipartFormRequestWithMethod:method
                                                                      path:action
                                                                parameters:params
                                                 constructingBodyWithBlock:^(id <AFMultipartFormData>formData)
									   {
										   //can attach file here if needed 
									   }
                                       ];
	
    AFJSONRequestOperation* operation = [[AFJSONRequestOperation alloc] initWithRequest: apiRequest];
	
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //success
		 NSLog(@"Response object in commandWithParams: %@",responseObject);
         completionBlock(responseObject);
		 
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //failure
		 NSLog(@"Error: %@",error);
         completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
     }
	 ];
	
    [operation start];
	
}

@end
