//
//  EventsCollectionViewCell.m
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import "EventsCollectionViewCell.h"

#import "RPPEvent.h"
#import "UIImageView+WebCache.h"

@interface EventsCollectionViewCell ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@end

@implementation EventsCollectionViewCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.titleLabel.text = nil;
    self.imageView.image = nil;
}

- (void)applyContentsFromEvent:(RPPEvent *)event
{
    self.titleLabel.text = event.title;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:event.imageURL]];
}

@end
