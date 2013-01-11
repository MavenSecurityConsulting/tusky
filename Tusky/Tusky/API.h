//
//  API.h
//  Tusky
//
//  Created by Hendy Chua on 23/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworking.h"

//API call completion block with result as json
typedef void (^JSONResponseBlock)(NSDictionary* json);

@interface API : AFHTTPClient

//the authorized user
@property (strong, nonatomic) NSDictionary* user;

//make this class a Singleton so that other classes can use this
+(API*)sharedInstance;

//check whether there's an authorized user
-(BOOL)isAuthorized;

//send an API command to the server
-(void)commandWithParams:(NSMutableDictionary*)params Path:(NSString *)action Method:(NSString *)method
			onCompletion:(JSONResponseBlock)completionBlock;

@end
