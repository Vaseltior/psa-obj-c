//
//  PositionSunAlgorithmTests.m
//  PositionSunAlgorithmTests
//
//  Created by Samuel Grau on 5/17/12.
//  Copyright (c) 2012 Samuel Grau. All rights reserved.
//

#import "PositionSunAlgorithmTests.h"
#import "PSAOCJulianDate.h"
#import "PSAOCSPA.h"

@implementation PositionSunAlgorithmTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in PositionSunAlgorithmTests");
    PSAOCJulianDate * jd = [[PSAOCJulianDate alloc] initWithGregorianCalendar:[NSDate date]];
    NSLog(@"%f", [jd julianDate]);
    NSLog(@"%@", jd);
    [jd release], jd = nil;
    
    jd = [[PSAOCJulianDate alloc] initWithGregorianCalendar:[NSDate date] andDeltaT:66.693f];
    NSLog(@"%f", [jd julianDate]);
    NSLog(@"%@", jd);
    [jd release];
    
    PSAOCSPA * spaComputer = [[PSAOCSPA alloc] init];
    [spaComputer release];
}

@end
