//
//  ViewController.m
//  ContainerNodeTest
//
//  Created by Olcay Ertaş on 9.10.2017.
//  Copyright © 2017 Piri Medya. All rights reserved.
//

#import "ViewController.h"
#import "InstagramCardView.h"


@implementation ViewController {
    ASDisplayNode * contentNode;
}


- (instancetype)init {

    contentNode = [[ASDisplayNode alloc] init];
    contentNode.layoutSpecBlock = ^ASLayoutSpec *(__kindof ASDisplayNode *node, ASSizeRange constrainedSize) {
        ASStackLayoutSpec *sls = [ASStackLayoutSpec verticalStackLayoutSpec];
        sls.children = node.subnodes;
        return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(20, 0, 0, 0) child:sls];
    };

    self = [super initWithNode:contentNode];

    if (self) {
        InstagramCardView *instagramCardView = [[InstagramCardView alloc] initWithPostId:@"BZ1NQxmB_5x"];
        [contentNode addSubnode:instagramCardView];
    }

    return self;
}


@end