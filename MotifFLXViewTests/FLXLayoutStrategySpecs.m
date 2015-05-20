//
//  FLXLayoutStrategySpecsSpec.m
//  MotifFLXView
//
//  Created by Eric Horacek on 5/19/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import Specta;
@import Expecta;
@import MotifFLXView;

SpecBegin(FLXLayoutStrategySpecs)

describe(@"applying layout strategy to UIView", ^{
    __block NSError *error;
    __block UIView *view;
    __block FLXView *container;

    beforeEach(^{
        error = nil;
        container = [[FLXView alloc] initWithFrame:(CGRect){
            .size.width = CGFLOAT_MAX,
            .size.height = CGFLOAT_MAX
        }];

        view = [[UIView alloc] init];

        [container addSubview:view];
    });

    afterEach(^{
        expect(error).to.beNil();
    });

    void(^applyClass)(NSDictionary *) = ^(NSDictionary *class) {
        MTFTheme *theme = [[MTFTheme alloc] initWithThemeDictionary:@{
            @".Class": class
        } error:&error];

        BOOL applied = [theme applyClassWithName:@"Class" toObject:view];
        expect(applied).to.beTruthy();

        // Since FLXLayoutStrategy doesn't expose its size, we test it by
        // forcing layout of its container
        [container layoutSubviews];
    };

    describe(@"values from a number", ^{
        it(@"should apply its layout strategy from number", ^{
            applyClass(@{
                @"layoutStrategy": @(1)
            });

            expect(view.frame.size.width).to.beCloseTo(1.0f);
            expect(view.frame.size.height).to.beCloseTo(1.0f);
        });
    });

    describe(@"values from an array", ^{
        it(@"should apply from an array with two elements", ^{
            applyClass(@{
                @"layoutStrategy": @[@1, @2]
            });

            expect(view.frame.size.width).to.beCloseTo(1.0f);
            expect(view.frame.size.height).to.beCloseTo(2.0f);
        });

        it(@"should throw an exception from an array with more than two elements", ^{
            expect(^{
                applyClass(@{
                    @"layoutStrategy": @[@1, @2, @3]
                });
            }).to.raise(NSInternalInconsistencyException);
        });

        it(@"should throw an exception from an array with one element", ^{
            expect(^{
                applyClass(@{
                    @"layoutStrategy": @[@1]
                });
            }).to.raise(NSInternalInconsistencyException);
        });

        it(@"should throw an exception with an invalid property value", ^{
            expect(^{
                applyClass(@{
                    @"layoutStrategy": @[@"notANumber"]
                });
            }).to.raise(NSInternalInconsistencyException);
        });
    });

    describe(@"values from a dictionary", ^{
        it(@"should apply", ^{
            applyClass(@{
                @"layoutStrategy": @{
                    @"width": @1,
                    @"height": @2,
                }
            });

            expect(view.frame.size.width).to.beCloseTo(1.0f);
            expect(view.frame.size.height).to.beCloseTo(2.0f);
        });

        it(@"should throw an exception with an invalid property name", ^{
            expect(^{
                applyClass(@{
                    @"layoutStrategy": @{
                        @"invalid": @1
                    }
                });
            }).to.raise(NSInternalInconsistencyException);
        });

        it(@"should throw an exception with an invalid property value", ^{
            expect(^{
                applyClass(@{
                    @"layoutStrategy": @{
                        @"top": @"notANumber"
                    }
                });
            }).to.raise(NSInternalInconsistencyException);
        });
    });
});

SpecEnd
