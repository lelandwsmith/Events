//
//  RPPActiveEventsCall.m
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import "RPPActiveEventsCall.h"
#import "RPPEventsRequest.h"
#import "RPPEventsResponse.h"

@interface RPPActiveEventsCall ()
@property (nonatomic, strong) RPPEventsRequest *eventsRequest;
@property (nonatomic, weak) id<RPPActiveEventsCallDelegate> delegate;
@end

@implementation RPPActiveEventsCall

- (instancetype)init
{
    self = [super init];
    if(self)
        [self createRequest];
    
    return self;
}

- (instancetype)initWithDelgate:(id<RPPActiveEventsCallDelegate>)delegate
{
    self = [self init];
    if(self)
        _delegate = delegate;
    return self;
}

- (void)createRequest
{
    self.eventsRequest = [[RPPEventsRequest alloc] init];
}

- (void)sendRequest
{
    NSLog(@"%@",[self.eventsRequest.activeEventsRequest description]);
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[self.eventsRequest activeEventsRequest] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        RPPEventsResponse *eventsResponse = [[RPPEventsResponse alloc] init];
        NSArray *events =  [eventsResponse eventsFromJsonData:data];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.delegate eventsDownloaded:events];
        }];
    }];
    
    [task resume];
}

@end
