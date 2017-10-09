//
// Created by Olcay Ertaş on 6.10.2017.
// Copyright (c) 2017 Piri Medya. All rights reserved.
//

#import "InstagramPostDto.h"


@implementation InstagramPostDto

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
            @"rootNode" : @"graphql.shortcode_media"
    }];
}

@end