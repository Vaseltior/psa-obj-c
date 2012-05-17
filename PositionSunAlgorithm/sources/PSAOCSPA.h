//
//  PSAOCSPA.h
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
 @brief Calculate topocentric solar position, 
 i.e. the location of the sun on the sky for a certain point in time on a
 certain point of the Earth's surface.
 
 @details This follows the SPA algorithm described in Reda, I.; Andreas, A. (2003): Solar Position Algorithm for Solar
 Radiation Applications. NREL Report No. TP-560-34302, Revised January 2008.
 This is <i>not</i> a port of the C code, but a re-implementation based on the published procedure.
 */
@interface PSAOCSPA : NSObject

+ (PSAOCAzimuthZenithAngle *)computeSolarPositionWithDate:(NSDate *)date longitude:(double)longitude latitude:(double)latitude;

@end
