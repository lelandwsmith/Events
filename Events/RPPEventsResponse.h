//
//  RPPEventsResponse.h
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPPEventsResponse : NSObject

- (NSArray *)eventsFromJsonData:(NSData *)responseData;

@end
