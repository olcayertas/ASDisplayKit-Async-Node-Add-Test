//
// Created by Olcay Ertaş on 6.10.2017.
// Copyright (c) 2017 Piri Medya. All rights reserved.
//

#import "EdgeNodeDto.h"


@implementation EdgeNodeDto

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
            @"captions"                   :@"edge_media_to_caption.edges",
            @"children"                   :@"edge_sidecar_to_children.edges",
            @"displayUrl"                 :@"display_url",
            @"isVideo"                    :@"is_video",
            @"mediaPreview"               :@"media_preview",
            @"nodeId"                     :@"id",
            @"ownerFullName"              :@"owner.full_name",
            @"ownerProfilePictureUrl"     :@"owner.profile_pic_url",
            @"ownerUserName"              :@"owner.user_name",
            @"profilePictureUrl"          :@"profile_pic_url",
            @"text"                       :@"text",
            @"typeName"                   :@"__typename",
            @"username"                   :@"user.username",
            @"videoUrl"                   :@"video_url",
            @"videoViewCount"             :@"video_view_count",
    }];
}

@end