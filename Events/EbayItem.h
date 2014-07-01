//
//  EbayItem.h
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EbayItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *itemURL;
@property (nonatomic, strong) NSString *imageURL;

@end
