//
// Created by Olcay Ertaş on 7.10.2017.
// Copyright (c) 2017 Piri Medya. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "EdgeNodeDto.h"

@interface InstagramImageCardView : ASDisplayNode

- (instancetype)initWithData:(EdgeNodeDto *)postData;

@end