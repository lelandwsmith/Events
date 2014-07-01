//
//  SearchResultsCell.h
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EbayItem;

@interface SearchResultsCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;

- (void)applyContentsFromItem:(EbayItem *)item;
@end
