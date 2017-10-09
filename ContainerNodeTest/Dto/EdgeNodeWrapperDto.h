//
// Created by Olcay Ertaş on 7.10.2017.
// Copyright (c) 2017 Piri Medya. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class EdgeNodeDto;

@protocol EdgeNodeWrapperDto;

@interface EdgeNodeWrapperDto : JSONModel

@property (nonatomic, strong) EdgeNodeDto<Optional> *node;

@end