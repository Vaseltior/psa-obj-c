//
//  PSAOCPSA.m
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

#import "PSAOCPSA.h"
#import "PSAOCAzimuthZenithAngle.h"

#define D_EARTH_MEAN_RADIUS 6371.01 // in km
#define D_ASTRONOMICAL_UNIT 149597890 // in km

#define TWOPI (2 * M_PI)
#define RAD (M_PI / 180)


@implementation PSAOCPSA

+ (PSAOCAzimuthZenithAngle *)computeSolarPositionWithDate:(NSDate *)date
                                                 latitude:(double)latitude
                                                longitude:(double)longitude {
    NSCalendar * utcTime = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone * zone = [NSTimeZone timeZoneWithName:@"GMT"];
    [utcTime setTimeZone:zone];

    NSDateComponents * dc = [utcTime components:(NSHourCalendarUnit |
                                                 NSMinuteCalendarUnit |
                                                 NSSecondCalendarUnit |
                                                 NSMonthCalendarUnit |
                                                 NSYearCalendarUnit) fromDate:date];

    // Main variables
    double dElapsedJulianDays;
    double dDecimalHours;
    double dEclipticLongitude;
    double dEclipticObliquity;
    double dRightAscension;
    double dDeclination;

    // Auxiliary variables
    double dY;
    double dX;

    // Calculate difference in days between the current Julian Day
    // and JD 2451545.0, which is noon 1 January 2000 Universal Time
    {
        long liAux1;
        long liAux2;
        double dJulianDate;
        // Calculate time of the day in UT decimal hours
        dDecimalHours = (double)[dc hour] + ((double)[dc minute] + (double)[dc second] / 60.0f) / 60.0f;
        // Calculate current Julian Day
        liAux1 = ([dc month] + 1 - 14) / 12;
        liAux2 = (1461 * ([dc year] + 4800 + liAux1)) / 4
                 + (367 * ([dc month] + 1 - 2 - 12 * liAux1)) / 12
                 - (3 * (([dc year] + 4900 + liAux1) / 100)) / 4
                 + [dc month] - 32075;
        dJulianDate = (liAux2) - 0.5 + dDecimalHours / 24.0;
        // Calculate difference between current Julian Day and JD 2451545.0
        dElapsedJulianDays = dJulianDate - 2451545.0;
    }

    // Calculate ecliptic coordinates (ecliptic longitude and obliquity of the
    // ecliptic in radians but without limiting the angle to be less than 2*Pi
    // (i.e., the result may be greater than 2*Pi)
    {
        double dMeanLongitude;
        double dMeanAnomaly;
        double dOmega;
        dOmega = 2.1429 - 0.0010394594 * dElapsedJulianDays;
        dMeanLongitude = 4.8950630 + 0.017202791698 * dElapsedJulianDays; // Radians
        dMeanAnomaly = 6.2400600 + 0.0172019699 * dElapsedJulianDays;
        dEclipticLongitude = dMeanLongitude + 0.03341607 * sin(dMeanAnomaly) + 0.00034894 * sin(2 * dMeanAnomaly) - 0.0001134 - 0.0000203 * sin(dOmega);
        dEclipticObliquity = 0.4090928 - 6.2140e-9 * dElapsedJulianDays + 0.0000396 * cos(dOmega);
    }

    // Calculate celestial coordinates ( right ascension and declination ) in radians
    // but without limiting the angle to be less than 2*Pi (i.e., the result
    // may be greater than 2*Pi)
    {
        double dSinEclipticLongitude;
        dSinEclipticLongitude = sin(dEclipticLongitude);
        dY = cos(dEclipticObliquity) * dSinEclipticLongitude;
        dX = cos(dEclipticLongitude);
        dRightAscension = atan2(dY, dX);

        if ( dRightAscension < 0.0 ) {
            dRightAscension = dRightAscension + 2 * M_PI;
        }

        dDeclination = asin(sin(dEclipticObliquity) * dSinEclipticLongitude);
    }

    // Calculate local coordinates ( azimuth and zenith angle ) in degrees
    {
        double dGreenwichMeanSiderealTime;
        double dLocalMeanSiderealTime;
        double dLatitudeInRadians;
        double dHourAngle;
        double dCosLatitude;
        double dSinLatitude;
        double dCosHourAngle;
        double dParallax;
        dGreenwichMeanSiderealTime = 6.6974243242 + 0.0657098283 * dElapsedJulianDays + dDecimalHours;
        dLocalMeanSiderealTime = (dGreenwichMeanSiderealTime * 15 + longitude) * RAD;
        dHourAngle = dLocalMeanSiderealTime - dRightAscension;
        dLatitudeInRadians = latitude * RAD;
        dCosLatitude = cos(dLatitudeInRadians);
        dSinLatitude = sin(dLatitudeInRadians);
        dCosHourAngle = cos(dHourAngle);
        double zenithAngle = (acos(dCosLatitude * dCosHourAngle * cos(dDeclination) + sin(dDeclination) * dSinLatitude));
        dY = -sin(dHourAngle);
        dX = tan(dDeclination) * dCosLatitude - dSinLatitude * dCosHourAngle;
        double azimuth = atan2(dY, dX);

        if ( azimuth < 0.0 ) {
            azimuth = azimuth + TWOPI;
        }

        azimuth = azimuth / RAD;
        // Parallax Correction
        dParallax = (D_EARTH_MEAN_RADIUS / D_ASTRONOMICAL_UNIT) * sin(zenithAngle);
        zenithAngle = (zenithAngle + dParallax) / RAD;

        return [PSAOCAzimuthZenithAngle azimuthZenithAngleWithAzimuth:azimuth andZenithAngle:zenithAngle];
    }
} /* computeSolarPositionWithDate */


@end
