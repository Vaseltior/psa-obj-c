//
//  PSAOCPSA.h
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

#import <Foundation/Foundation.h>

@class PSAOCAzimuthZenithAngle;

/*!
   @brief Compute sun position for a given date/time and longitude/latitude.

   @details This is a simple Objective-C port of the "PSA" solar positioning algorithm, as documented in:
   Blanco-Muriel et al.: Computing the Solar Vector. Solar Energy Vol 70 No 5 pp 431-441.
   http://dx.doi.org/10.1016/S0038-092X(00)00156-0

   According to the paper, "The algorithm allows .. the true solar vector to be determined with an accuracy of 0.5
   minutes of arc for the period 1999–2015."

 */
@interface PSAOCPSA : NSObject

/**
   @brief Compute sun position for a given time and location.

   @param date Note that it's unclear how well the algorithm performs before the year 1990 or after the year 2015.
   @param latitude in degrees (positive east of Greenwich)
   @param longitude in degrees (positive north of equator)

   @return an azimuth zenith angle object

 */
+ (PSAOCAzimuthZenithAngle *)computeSolarPositionWithDate:(NSDate *)date
     latitude                                             :(double)latitude
    longitude                                            :(double)longitude;



@end
