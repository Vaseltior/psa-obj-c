//
//  PSAOCSPA.m
//  PositionSunAlgorithm
//
//  Created by Samuel Grau on 5/17/12.
//  Copyright (c) 2012 Samuel Grau.
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "PSAOCSPA.h"

@interface PSAOCSPA ()

// Initializers
- (void)initializeDeltaTimes;
- (void)createSpaDataStructure;
- (void)destroySpaDataStructure;

// Helpers
- (NSInteger)dayOfYear;
- (NSUInteger)numberOfdaysInYear;

@end

@implementation PSAOCSPA



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark -
#pragma mark Private Methods
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- (void)initializeDeltaTimes {
    self->_deltaTimes = [[NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithDouble:66.603], [NSNumber numberWithDouble:2012.00],
                          [NSNumber numberWithDouble:66.693], [NSNumber numberWithDouble:2012.25],
                          [NSNumber numberWithDouble:66.761], [NSNumber numberWithDouble:2012.50],
                          [NSNumber numberWithDouble:66.792], [NSNumber numberWithDouble:2012.75],
                          [NSNumber numberWithDouble:67.1], [NSNumber numberWithDouble:2013.00],
                          [NSNumber numberWithDouble:67.2], [NSNumber numberWithDouble:2013.25],
                          [NSNumber numberWithDouble:67.3], [NSNumber numberWithDouble:2013.50],
                          [NSNumber numberWithDouble:67.5], [NSNumber numberWithDouble:2013.75],
                          [NSNumber numberWithDouble:67.6], [NSNumber numberWithDouble:2014.00],
                          [NSNumber numberWithDouble:67.7], [NSNumber numberWithDouble:2014.25],
                          [NSNumber numberWithDouble:67.8], [NSNumber numberWithDouble:2014.50],
                          [NSNumber numberWithDouble:67.9], [NSNumber numberWithDouble:2014.75],
                          [NSNumber numberWithDouble:68.0], [NSNumber numberWithDouble:2015.00],
                          [NSNumber numberWithDouble:68.2], [NSNumber numberWithDouble:2015.25],
                          [NSNumber numberWithDouble:68.], [NSNumber numberWithDouble:2015.50],
                          [NSNumber numberWithDouble:68.], [NSNumber numberWithDouble:2015.75],
                          [NSNumber numberWithDouble:69.], [NSNumber numberWithDouble:2016.00],
                          [NSNumber numberWithDouble:69.], [NSNumber numberWithDouble:2016.25],
                          [NSNumber numberWithDouble:69.], [NSNumber numberWithDouble:2016.50],
                          [NSNumber numberWithDouble:69.], [NSNumber numberWithDouble:2016.75],
                          [NSNumber numberWithDouble:69.], [NSNumber numberWithDouble:2017.00],
                          [NSNumber numberWithDouble:69.], [NSNumber numberWithDouble:2017.25],
                          [NSNumber numberWithDouble:69.], [NSNumber numberWithDouble:2017.50],
                          [NSNumber numberWithDouble:69.], [NSNumber numberWithDouble:2017.75],
                          [NSNumber numberWithDouble:69.], [NSNumber numberWithDouble:2018.00],
                          [NSNumber numberWithDouble:70.], [NSNumber numberWithDouble:2018.25],
                          [NSNumber numberWithDouble:70.], [NSNumber numberWithDouble:2018.50],
                          [NSNumber numberWithDouble:70.], [NSNumber numberWithDouble:2018.75],
                          [NSNumber numberWithDouble:70.], [NSNumber numberWithDouble:2019.00],
                          [NSNumber numberWithDouble:70.], [NSNumber numberWithDouble:2019.25],
                          [NSNumber numberWithDouble:70.], [NSNumber numberWithDouble:2019.50],
                          [NSNumber numberWithDouble:70.], [NSNumber numberWithDouble:2019.75],
                          [NSNumber numberWithDouble:70.], [NSNumber numberWithDouble:2020.00],
                          [NSNumber numberWithDouble:71.], [NSNumber numberWithDouble:2020.25],
                          [NSNumber numberWithDouble:71.], [NSNumber numberWithDouble:2020.50],
                          [NSNumber numberWithDouble:71.], [NSNumber numberWithDouble:2020.75],
                          [NSNumber numberWithDouble:71.], [NSNumber numberWithDouble:2021.00],
                          nil] retain];
} /* initializeDeltaTimes */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)destroySpaDataStructure {
    if ( self->_spaData ) {
        free(self->_spaData);
    }
} /* destroySpaDataStructure */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)createSpaDataStructure {
    [self destroySpaDataStructure];
    self->_spaData = malloc(sizeof(spa_data));
} /* createSpaDataStructure */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (NSInteger)dayOfYear {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger dayOfYear = [gregorian ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:self->_date];
    [gregorian release];
    return dayOfYear;
} /* dayOfYear */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (NSUInteger)numberOfdaysInYear {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSRange days = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:self->_date];
    return days.length;
} /* numberOfdaysInYear */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark -
#pragma mark Initialization
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (id)init {
    self = [super init];

    if ( self ) {
        self->_date = [[NSDate date] retain];
        [self createSpaDataStructure];

        self->_longitude = 2;
        self->_latitude = 48;
        self->_deltaT = 0.0f;
        self->_elevation = 0.0f;
        self->_pressure = 0.0f;
        self->_temperature = 15.0f;
        self->_slope = 0.0f;
        self->_azimuthRotation = 0.0;
        self->_atmosphericRefraction = 0.5667f;
    }

    return self;
} /* init */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark -
#pragma mark Memory Management
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)dealloc {
    [self->_date release]; self->_date = nil;

    // Cleaning up the spa_data structure if needed
    [self destroySpaDataStructure];

    [super dealloc];
} /* dealloc */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark -
#pragma mark Getters
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (NSDictionary *)deltaTimes {
    if ( !self->_deltaTimes ) {
        [self initializeDeltaTimes];
    }

    return self->_deltaTimes;
} /* deltaTimes */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark -
#pragma mark Public methods
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- (NSDateComponents *)suitableComponents {
    NSAssert(self->_date, @"This object should have a date", nil);

    NSCalendar * currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents * dc = [currentCalendar components:(NSYearCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSHourCalendarUnit |
                                                         NSMinuteCalendarUnit |
                                                         NSSecondCalendarUnit) fromDate:self->_date];
    return dc;
} /* suitableComponents */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (PSAOCAzimuthZenithAngle *)computeSolarPosition {
    if ( !self->_date ) {
        return nil;
    }

    // We start by initializing the structure with date elements
    NSDateComponents * dc = [self suitableComponents];

    // 4-digit year, valid range: -2000 to 6000, error code: 1
    self->_spaData->year = [dc year];

    // 2-digit month, valid range: 1 to 12, error code: 2
    self->_spaData->month = [dc month];

    // 2-digit day, valid range: 1 to 31, error code: 3
    self->_spaData->day = [dc day];
    // Observer local hour, valid range: 0 to 24, error code: 4

    self->_spaData->hour = [dc hour];
    // Observer local minute, valid range: 0 to 59, error code: 5

    self->_spaData->minute = [dc minute];

    // Observer local second, valid range: 0 to 59, error code: 6
    self->_spaData->second = [dc second];

    // We now set the delta time if we can
    // Difference between earth rotation time and terrestrial time
    NSDictionary * d = [self deltaTimes];
    NSUInteger dayOfYear = [self dayOfYear];
    NSUInteger numberOfDaysInYear = [self numberOfdaysInYear];
    double yearRatio = (double)dayOfYear / (double)numberOfDaysInYear;
    NSNumber * keyForDeltaT = nil;

    if ( yearRatio >= 0 && yearRatio < 0.25 ) {
        keyForDeltaT = [NSNumber numberWithDouble:((double)[dc year] + 0.0f)];
    } else if ( yearRatio >= 0.25 && yearRatio < 0.5 ) {
        keyForDeltaT = [NSNumber numberWithDouble:((double)[dc year] + 0.25f)];
    } else if ( yearRatio >= 0.5 && yearRatio < 0.75 ) {
        keyForDeltaT = [NSNumber numberWithDouble:((double)[dc year] + 0.5f)];
    } else if ( yearRatio >= 0.75 && yearRatio < 1 ) {
        keyForDeltaT = [NSNumber numberWithDouble:((double)[dc year] + 0.75f)];
    } else {
        keyForDeltaT = [NSNumber numberWithDouble:0];
    }

    NSNumber * foundDeltaT = [d objectForKey:keyForDeltaT];

    if ( foundDeltaT ) {
        self->_spaData->delta_t = [foundDeltaT doubleValue];
    } else {
        //self->_spaData->delta_t = 0;
    }

    // It is derived from observation only and is reported in this
    // bulletin: http://maia.usno.navy.mil/ser7/ser7.dat,
    // where delta_t = 32.184 + (TAI-UTC) + DUT1
    // valid range: -8000 to 8000 seconds, error code: 7
    NSTimeZone * tz = [[NSCalendar currentCalendar] timeZone];
    // Observer time zone (negative west of Greenwich)
    self->_spaData->timezone = (double)[tz secondsFromGMTForDate:self->_date];

    // valid range: -12 to 12 hours, error code: 8
    // Observer longitude (negative west of Greenwich)
    self->_spaData->longitude = self->_longitude;

    // valid range: -180 to 180 degrees, error code: 9
    // Observer latitude (negative south of equator)
    self->_spaData->latitude = self->_latitude;

    // valid range: -90 to 90 degrees, error code: 10
    // Observer elevation [meters]
    self->_spaData->elevation = self->_elevation;

    // valid range: -6500000 or higher meters, error code: 11
    // Annual average local pressure [millibars]
    self->_spaData->pressure = self->_pressure;

    // valid range: 0 to 5000 millibars, error code: 12
    // Annual average local temperature [degrees Celsius]
    self->_spaData->temperature = self->_temperature;

    // valid range: -273 to 6000 degrees Celsius, error code; 13
    // Surface slope (measured from the horizontal plane)
    self->_spaData->slope = self->_slope;

    // valid range: -360 to 360 degrees, error code: 14
    // Surface azimuth rotation (measured from south to projection of surface normal on horizontal plane, negative west)
    self->_spaData->azm_rotation = self->_azimuthRotation;

    // valid range: -360 to 360 degrees, error code: 15
    // Atmospheric refraction at sunrise and sunset (0.5667 deg is typical)
    self->_spaData->atmos_refract = self->_atmosphericRefraction;

    // valid range: -5 to 5 degrees, error code: 16
    //int function; // Switch to choose functions for desired output (from enumeration)*/

    int result = spa_calculate(self->_spaData);
    NSLog(@"%i", result);

    return nil;
} /* computeSolarPosition */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ (PSAOCAzimuthZenithAngle *)computeSolarPositionWithDate:(NSDate *)date longitude:(double)longitude latitude:(double)latitude {
    return nil;
}


@end
