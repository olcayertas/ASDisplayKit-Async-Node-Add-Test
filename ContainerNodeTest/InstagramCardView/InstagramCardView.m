//
// Created by Olcay Ertaş on 6.10.2017.
// Copyright (c) 2017 Piri Medya. All rights reserved.
//

#import "InstagramCardView.h"

#import "InstagramImageCardView.h"
#import "InstagramVideoCardView.h"
#import "EdgeNodeWrapperDto.h"

#define InstagramCardTypeImage   @"GraphImage"
#define InstagramCardTypeVideo   @"GraphVideo"
#define InstagramCardTypeGallery @"GraphSidecar"


@implementation InstagramCardView {
    InstagramPostDto *mPostData;
    NSMutableArray *children;
    ASDisplayNode *mParent;
}


- (instancetype)initWithData:(InstagramPostDto *)postData {

    self = [super init];

    if (self) {
        children = [NSMutableArray new];
        mPostData = postData;
        [self instagramCardCommonInit];
    }

    return self;
}


- (instancetype)initWithParent:(ASDisplayNode *)parent {

    NSLog(@"InstagramCardView : initWithParent");
    self = [super init];

    if (self) {
        children = [NSMutableArray new];
        mParent = parent;
    }

    return self;
}


- (instancetype)initWithPostId:(NSString *)postId {

    NSLog(@"InstagramCardView : initWithPostId : %@", postId);
    self = [super init];

    if (self) {
        children = [NSMutableArray new];
        [self getPostData:postId];
    }

    return self;
}


- (void)getPostData:(NSString *)postId {
    NSString *postUrl = [NSString stringWithFormat:@"https://www.instagram.com/p/%@/?__a=1", postId];
    NSURL *requestUrl = [NSURL URLWithString:postUrl];

    [[[NSURLSession sharedSession] dataTaskWithURL:requestUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        mPostData = [self convertResponseToModel:data error:nil];
        [self instagramCardCommonInit];
    }] resume];
}

- (InstagramPostDto *)convertResponseToModel:(NSData *)responseObject error:(NSError **)error {
    NSError *jsonSerializationError;
    id object = [NSJSONSerialization
            JSONObjectWithData:responseObject
                       options:NSJSONReadingMutableContainers
                         error:&jsonSerializationError];

    if (jsonSerializationError) {
        *error = jsonSerializationError;
        return nil;
    }

    InstagramPostDto *responseData;

    if ([object isKindOfClass:NSDictionary.class]) {
        responseData = [[InstagramPostDto alloc] initWithDictionary:object error:error];
    }

    return responseData ;
}


- (void)instagramCardCommonInit {

    NSLog(@"InstagramCardView : instagramCardCommonInit");

    if (mPostData && mPostData.rootNode) {
        self.automaticallyManagesSubnodes = YES;
        [self addInstagramCard:mPostData.rootNode];
    }

    [self setNeedsLayout];
}


- (void)addInstagramCard:(EdgeNodeDto *)dto {
    if ([dto.typeName isEqualToString:InstagramCardTypeImage]) {
        NSLog(@"InstagramCardView : instagramCardCommonInit : Adding Instagram image card view...");
        ASDisplayNode *node = [[InstagramImageCardView alloc] initWithData:dto];
        [children addObject:node];
    }
    else if ([dto.typeName isEqualToString:InstagramCardTypeVideo]) {
        NSLog(@"InstagramCardView : instagramCardCommonInit : Adding Instagram video card view...");
        ASDisplayNode *node = [[InstagramVideoCardView alloc] initWithData:dto];
        [children addObject:node];
    }
    else if ([dto.typeName isEqualToString:InstagramCardTypeGallery]) {
        NSLog(@"InstagramCardView : instagramCardCommonInit : This is a instagram gallery!");
        for (NSUInteger i = 0; i < dto.children.count; ++i) {
            NSLog(@"InstagramCardView : instagramCardCommonInit : Adding Instagram card view...");
            EdgeNodeWrapperDto *wrapperDto = dto.children[i];
            [self addInstagramCard:wrapperDto.node];
        }
    }
}


- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASStackLayoutSpec *sls = [ASStackLayoutSpec verticalStackLayoutSpec];
    sls.children = children;
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) child:sls];
}


- (void)didEnterVisibleState {
    [super didEnterVisibleState];
    self.layer.name = @"InstagramCardView";
}

- (void)didEnterDisplayState {
    [super didEnterDisplayState];
}


@end