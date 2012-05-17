//
//  PSAOCJulianDate.h
//  PositionSunAlgorithm
//
//  Created by Samuel Grau on 5/17/12.
//  Copyright (c) 2012 Samuel Grau.
//
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

/*!
 Calculate Julian date for a given point in time. 
 This follows the algorithm described in 
 Reda, I.; Andreas, A. (2003): Solar Position Algorithm for Solar Radiation Applications. 
 NREL Report No. TP-560-34302, Revised January 2008.
 */
@interface PSAOCJulianDate : NSObject {
    @private
    NSCalendar * _gregorianCalendar;
    NSDate * _date;
    double _julianDate;
    double _deltaT;
}

@property (nonatomic, readonly) double julianDate;

/*!
 @brief Construct a Julian date, assuming deltaT to be 0.
 @param date The date to consider
 */
- (id)initWithGregorianCalendar:(NSDate *)date;


/*!
 @brief Construct a Julian date, observing deltaT.

 @details deltaT is the difference between earth rotation time and terrestrial time 
 (or Universal Time and Terrestrial Time), in seconds. 
 @see <a href ="http://maia.usno.navy.mil/ser7/deltat.preds">http://maia.usno.navy.mil/ser7/deltat.preds</a> 
 for values. For the year 2011, a reasonably accurate default would be 67.
 
 @param date The date to consider
 @param deltaT The difference
 
 */
- (id)initWithGregorianCalendar:(NSDate *)date andDeltaT:(double)deltaT;

- (double)julianEphemerisDay;
- (double)julianCentury;
- (double)julianEphemerisCentury;
- (double)julianEphemerisMillennium;
    
@end



//YEAR    TT-UT PREDICTION  UT1-UTC PREDICTION  ERROR
//
//2012.00      66.603             -0.419         0.000
//2012.25      66.693             -0.509         0.000
//2012.50      66.761              0.423         0.008
//2012.75      66.792              0.392         0.014
//2013.00      67.1                0.109         0.1
//2013.25      67.2               -0.021         0.2
//2013.50      67.3               -0.151         0.2
//2013.75      67.5               -0.281         0.3
//2014.00      67.6               -0.402         0.4
//2014.25      67.7               -0.506         0.4
//2014.50      67.8                0.396         0.5
//2014.75      67.9                0.285         0.7
//2015.00      68.0                0.155         0.8
//2015.25      68.2                0.024         0.9
//2015.50      68.                -0.106         1.
//2015.75      68.                -0.230         1.
//2016.00      69.                -0.343         1.
//2016.25      69.                -0.458         1.
//2016.50      69.                -0.587         2.
//2016.75      69.                 0.286         2.
//2017.00      69.                 0.177         2.
//2017.25      69.                 0.080         2.
//2017.50      69.                -0.010         2.
//2017.75      69.                -0.114         2.
//2018.00      69.                -0.238         2.
//2018.25      70.                -0.376         3.
//2018.50      70.                -0.509         3.
//2018.75      70.                 0.354         3.
//2019.00      70.                 0.230         3.
//2019.25      70.                 0.106         3.
//2019.50      70.                -0.020         3.
//2019.75      70.                -0.148         3.
//2020.00      70.                -0.267         4.
//2020.25      71.                -0.373         4.
//2020.50      71.                -0.473         4.
//2020.75      71.                -0.589         4.
//2021.00      71.                 0.279         4.
