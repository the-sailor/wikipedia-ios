//  Created by Monte Hurd on 8/19/15.
//  Copyright (c) 2015 Wikimedia Foundation. Provided under MIT-style license; please copy and modify!

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import "NSAttributedString+WMFTrim.h"
#import "XCTestCase+WMFLabelConvenience.h"

@interface NSAttributedString_WMFTrimTests : FBSnapshotTestCase

@end

@implementation NSAttributedString_WMFTrimTests

- (void)setUp {
    [super setUp];
    //self.recordMode = YES;
}

- (NSAttributedString*)testString {
    NSMutableAttributedString* attributedText = [[NSMutableAttributedString alloc] initWithString:@" \n \n This is a test string which should help confirm that this is working the way we want it to.  \n"];
    [attributedText addAttribute:NSBackgroundColorAttributeName value:[UIColor greenColor] range:[attributedText.string rangeOfString:@"should"]];
    [attributedText addAttribute:NSBackgroundColorAttributeName value:[UIColor greenColor] range:[attributedText.string rangeOfString:@"working"]];
    return attributedText;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTrimReference {
    FBSnapshotVerifyViewWithOptions([self wmf_getLabelConfiguredWithBlock:^(UILabel* label){
        label.attributedText = [self testString];
    }], nil, [NSSet setWithObject:@"_64"], 0);
}

- (void)testTrim {
    FBSnapshotVerifyViewWithOptions([self wmf_getLabelConfiguredWithBlock:^(UILabel* label){
        label.attributedText = [[self testString] wmf_trim];
    }], nil, [NSSet setWithObject:@"_64"], 0);
}

@end
