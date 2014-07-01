//
//  SearchResultsCell.m
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import "SearchResultsCell.h"
#import "EbayItem.h"
#import "UIImageView+WebCache.h"


@interface SearchResultsCell ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@end

@implementation SearchResultsCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.titleLabel.text = nil;
    self.priceLabel.text = nil;
    self.imageView.image = nil;
}

- (void)applyContentsFromItem:(EbayItem *)item
{
    self.titleLabel.text = item.title;
    self.priceLabel.text = item.price;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageURL]];
}

@end
