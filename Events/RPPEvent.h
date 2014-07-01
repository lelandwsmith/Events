//
//  RPPEvent.h
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPPEvent : NSObject

@property (nonatomic, strong) NSString *eventId;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end
