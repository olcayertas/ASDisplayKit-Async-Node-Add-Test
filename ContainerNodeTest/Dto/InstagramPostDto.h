//
// Created by Olcay Ertaş on 6.10.2017.
// Copyright (c) 2017 Piri Medya. All rights reserved.
//

#import "EdgeNodeDto.h"

@interface InstagramPostDto : JSONModel

@property (nonatomic, strong) EdgeNodeDto<Optional> *rootNode;

@end