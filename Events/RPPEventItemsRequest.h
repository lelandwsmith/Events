
//
//  RPPEventItemsRequest.h
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RPPEvent;

@interface RPPEventItemsRequest : NSObject

- (instancetype)initWithEvent:(RPPEvent *)event pageNumber:(NSUInteger)pageNumber;

- (NSURLRequest *)request;

@end
