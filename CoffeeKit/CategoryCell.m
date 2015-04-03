//
//  CategoryCell.m
//  CoffeeKit
//
//  Created by Rahul Nadella on 4/3/15.
//  Copyright (c) 2015 Rahul Nadella. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

@synthesize title = _title;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    _title = nil;
}

@end
