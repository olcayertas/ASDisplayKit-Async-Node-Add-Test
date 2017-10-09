//
// Created by Olcay Ertaş on 7.10.2017.
// Copyright (c) 2017 Piri Medya. All rights reserved.
//

#import <Texture/AsyncDisplayKit/ASDimension.h>
#import "InstagramImageCardView.h"
#import "CaptionDto.h"
#import "CaptionWrapperDto.h"

@implementation InstagramImageCardView {
    ASNetworkImageNode *ownerImageNode;
    ASImageNode *instagramLogoNode;
    ASNetworkImageNode *postPhotoNode;
    ASTextNode *ownerNameNode;
    ASTextNode *captionNode;
    EdgeNodeDto *mPostData;
}

- (instancetype)initWithData:(EdgeNodeDto *)postData {

    self = [super init];

    if (self) {
        mPostData = postData;
        self.automaticallyManagesSubnodes = YES;
        [self instagramImageCardCommonInit];
    }

    return self;
}


- (void)instagramImageCardCommonInit {

    ownerImageNode = [ASNetworkImageNode new];
    ownerImageNode.style.preferredSize = CGSizeMake(40, 40);
    ownerImageNode.contentMode = UIViewContentModeScaleAspectFill;

    ownerNameNode = [ASTextNode new];

    instagramLogoNode = [ASImageNode new];
    instagramLogoNode.image = [UIImage imageNamed:@"instagram"];
    instagramLogoNode.style.preferredSize = CGSizeMake(28, 28);
    instagramLogoNode.contentMode = UIViewContentModeScaleAspectFit;

    postPhotoNode = [ASNetworkImageNode new];
    postPhotoNode.contentMode = UIViewContentModeScaleAspectFill;

    captionNode = [ASTextNode new];

    if (mPostData) [self setData];
}


- (void)setData {
    ownerImageNode.URL = [NSURL URLWithString:mPostData.ownerProfilePictureUrl];

    if (mPostData.ownerFullName) {
        NSDictionary *ownerNameAttributes =
                @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                        NSForegroundColorAttributeName: [UIColor blackColor]};

        NSAttributedString *as =
                [[NSAttributedString alloc]
                        initWithString:mPostData.ownerFullName
                            attributes:ownerNameAttributes];

        ownerNameNode.attributedText = as;
        NSLog(@"InstagramImageCard : setData : Owner name = %@", as.string);
    }

    postPhotoNode.URL = [NSURL URLWithString:mPostData.displayUrl];

    CaptionWrapperDto *captionWrapperDto = mPostData.captions.firstObject;
    CaptionDto * captionDto = captionWrapperDto.node;

    if (captionDto.text) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineHeightMultiple = 1.1;

        NSDictionary *captionAttributes =
                @{NSFontAttributeName: [UIFont systemFontOfSize:16],
                        NSForegroundColorAttributeName: [UIColor blackColor],
                        NSParagraphStyleAttributeName: paragraphStyle};

        NSAttributedString *as =
                [[NSAttributedString alloc]
                        initWithString:captionDto.text
                            attributes:captionAttributes];

        captionNode.attributedText = as;

        NSLog(@"InstagramImageCard : setData : Caption = %@", as.string);
    }
}


- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {

    ASInsetLayoutSpec *ownerImageInsetLS = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(8, 0, 8, 8) child:ownerImageNode];
    ASInsetLayoutSpec *instagramLogoInsetLS = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 14, 0, 14) child:instagramLogoNode];

    ASRelativeLayoutSpec *ownerImageRls = [ASRelativeLayoutSpec
            relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionStart
                                            verticalPosition:ASRelativeLayoutSpecPositionStart
                                                sizingOption:ASRelativeLayoutSpecSizingOptionDefault
                                                       child:ownerImageInsetLS];

    ASCenterLayoutSpec *centerLayoutSpec =
            [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringY
                                                       sizingOptions:ASCenterLayoutSpecSizingOptionDefault
                                                               child:ownerNameNode];
    ASLayoutSpec *spacer = [[ASLayoutSpec alloc] init];
    spacer.style.flexGrow = 1;

    ASRelativeLayoutSpec *instagramLogoRls = [ASRelativeLayoutSpec
            relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionEnd
                                            verticalPosition:ASRelativeLayoutSpecPositionCenter
                                                sizingOption:ASRelativeLayoutSpecSizingOptionDefault
                                                       child:instagramLogoInsetLS];

    ASStackLayoutSpec *topHorizontalLS = [ASStackLayoutSpec horizontalStackLayoutSpec];
    //topHorizontalLS.children = @[ownerImageInsetLS, centerLayoutSpec, instagramLogoInsetLS];
    topHorizontalLS.children = @[ownerImageRls, centerLayoutSpec, spacer, instagramLogoRls];
    topHorizontalLS.style.minWidth = ASDimensionMake(constrainedSize.max.width);

    ASRatioLayoutSpec *postPhotoRatioLS = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:1 child:postPhotoNode];

    ASInsetLayoutSpec *captionInsetLS = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(8, 16, 8, 16) child:captionNode];

    ASStackLayoutSpec *finalVerticalLS = [ASStackLayoutSpec verticalStackLayoutSpec];
    finalVerticalLS.children = @[topHorizontalLS, postPhotoRatioLS, captionInsetLS];

    return finalVerticalLS;
}


- (void)didEnterVisibleState {
    [super didEnterVisibleState];
    self.layer.name = @"InstagramImageCardView";
    ownerImageNode.layer.cornerRadius = 20;
}

@end