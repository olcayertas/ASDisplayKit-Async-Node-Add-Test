//
// Created by Olcay Ertaş on 7.10.2017.
// Copyright (c) 2017 Piri Medya. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class CaptionDto;

@protocol CaptionWrapperDto;

@interface CaptionWrapperDto : JSONModel

@property (nonatomic, strong) CaptionDto *node;

@end