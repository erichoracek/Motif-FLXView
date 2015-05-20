//
//  FLXViewMarginsSpecs.m
//  MotifFLXView
//
//  Created by Eric Horacek on 5/16/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import Specta;
@import Expecta;
@import MotifFLXView;

SpecBegin(FLXViewMarginsSpecs)

describe(@"applying margins to a UIView", ^{
    __block NSError *error;
    __block UIView *view;

    beforeEach(^{
        error = nil;
        view = [[UIView alloc] init];
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
    };

    describe(@"values from a number", ^{
        it(@"should apply its margins from number", ^{
            applyClass(@{
                @"margins": @(1)
            });

            expect(view.flx_margins.top).to.beCloseTo(1.0f);
            expect(view.flx_margins.bottom).to.beCloseTo(1.0f);
            expect(view.flx_margins.left).to.beCloseTo(1.0f);
            expect(view.flx_margins.right).to.beCloseTo(1.0f);
        });
    });

    describe(@"values from an array", ^{
        it(@"should apply from an array with four elements", ^{
            applyClass(@{
                @"margins": @[@1, @2, @3, @4]
            });

            expect(view.flx_margins.top).to.beCloseTo(1.0f);
            expect(view.flx_margins.right).to.beCloseTo(2.0f);
            expect(view.flx_margins.bottom).to.beCloseTo(3.0f);
            expect(view.flx_margins.left).to.beCloseTo(4.0f);
        });

        it(@"should apply from an array with three elements", ^{
            applyClass(@{
                @"margins": @[@1, @2, @3]
            });

            expect(view.flx_margins.top).to.beCloseTo(1.0f);
            expect(view.flx_margins.right).to.beCloseTo(2.0f);
            expect(view.flx_margins.bottom).to.beCloseTo(3.0f);
            expect(view.flx_margins.left).to.beCloseTo(0.0f);
        });

        it(@"should apply from an array with two elements", ^{
            applyClass(@{
                @"margins": @[@1, @2]
            });

            expect(view.flx_margins.top).to.beCloseTo(1.0f);
            expect(view.flx_margins.right).to.beCloseTo(2.0f);
            expect(view.flx_margins.bottom).to.beCloseTo(1.0f);
            expect(view.flx_margins.left).to.beCloseTo(2.0f);
        });

        it(@"should throw an exception from an array with more than four elements", ^{
            expect(^{
                applyClass(@{
                    @"margins": @[@1, @2, @3, @4, @5]
                });
            }).to.raise(NSInternalInconsistencyException);
        });

        it(@"should throw an exception from an array with one element", ^{
            expect(^{
                applyClass(@{
                    @"margins": @[@1]
                });
            }).to.raise(NSInternalInconsistencyException);
        });

        it(@"should throw an exception from an array with an invalid value", ^{
            expect(^{
                applyClass(@{
                    @"margins": @[@"notANumber", @"notANumber"]
                });
            }).to.raise(NSInternalInconsistencyException);
        });
    });

    describe(@"values from a dictionary", ^{
        it(@"should apply", ^{
            applyClass(@{
                @"margins": @{
                    @"top": @1,
                    @"right": @2,
                    @"bottom": @3,
                    @"left": @4
                }
            });

            expect(view.flx_margins.top).to.beCloseTo(1.0f);
            expect(view.flx_margins.right).to.beCloseTo(2.0f);
            expect(view.flx_margins.bottom).to.beCloseTo(3.0f);
            expect(view.flx_margins.left).to.beCloseTo(4.0f);
        });

        it(@"should throw an exception with an invalid property name", ^{
            expect(^{
                applyClass(@{
                    @"margins": @{
                        @"invalid": @1
                    }
                });
            }).to.raise(NSInternalInconsistencyException);
        });

        it(@"should throw an exception with an invalid property value", ^{
            expect(^{
                applyClass(@{
                    @"margins": @{
                        @"top": @"notANumber"
                    }
                });
            }).to.raise(NSInternalInconsistencyException);
        });
    });

    describe(@"values separated into properties by components", ^{
        it(@"should apply", ^{
            applyClass(@{
                @"marginTop": @1,
                @"marginRight": @2,
                @"marginBottom": @3,
                @"marginLeft": @4
            });

            expect(view.flx_margins.top).to.beCloseTo(1.0f);
            expect(view.flx_margins.right).to.beCloseTo(2.0f);
            expect(view.flx_margins.bottom).to.beCloseTo(3.0f);
            expect(view.flx_margins.left).to.beCloseTo(4.0f);
        });
    });
});

SpecEnd
