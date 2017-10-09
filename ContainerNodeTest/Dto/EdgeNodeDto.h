//
// Created by Olcay Ertaş on 6.10.2017.
// Copyright (c) 2017 Piri Medya. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol EdgeNodeWrapperDto;
@protocol CaptionWrapperDto;

@interface EdgeNodeDto : JSONModel

@property (nonatomic, strong) NSNumber<Optional>                    *isVideo;
@property (nonatomic, strong) NSNumber<Optional>                    *nodeId;
@property (nonatomic, strong) NSString<Optional>                    *displayUrl;
@property (nonatomic, strong) NSString<Optional>                    *mediaPreview;
@property (nonatomic, strong) NSString<Optional>                    *ownerFullName;
@property (nonatomic, strong) NSString<Optional>                    *ownerProfilePictureUrl;
@property (nonatomic, strong) NSString<Optional>                    *ownerUserName;
@property (nonatomic, strong) NSString<Optional>                    *profilePictureUrl;
@property (nonatomic, strong) NSString<Optional>                    *text;
@property (nonatomic, strong) NSString<Optional>                    *typeName;
@property (nonatomic, strong) NSString<Optional>                    *userName;
@property (nonatomic, strong) NSString<Optional>                    *videoUrl;
@property (nonatomic, strong) NSArray<CaptionWrapperDto, Optional>  *captions;
@property (nonatomic, strong) NSArray<EdgeNodeWrapperDto, Optional> *children;

@end