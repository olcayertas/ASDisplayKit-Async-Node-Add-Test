//
// Created by Olcay Ertaş on 6.10.2017.
// Copyright (c) 2017 Piri Medya. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "InstagramPostDto.h"

@interface InstagramCardView : ASDisplayNode

- (instancetype)initWithData:(InstagramPostDto *)postData;

- (instancetype)initWithPostId:(NSString *)postId;

@end