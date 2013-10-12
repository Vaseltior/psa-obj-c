psa-obj-c
=========

PSA (Position Sun Algorithm) - Objective-C

The algorithm is supposed to work for the years -2000 to 6000, with uncertainties of +/-0.0003 degrees.

### How to use it?

You'll have to import the `PSAOCHeader.h` file considering that you have added the library to your project, 
and that headers are correctly defined.

Use the convenient method of the `PSAOCSPA` object to get a `PSAOCAzimuthZenithAngle` object representing the
*Azimuth* and *Angle* for the given parameters of *when* and *where* on earth.

    PSAOCAzimuthZenithAngle *result = nil;
    
    // Define the date you want
    NSDate *chosenDate = [NSDate date];
    
    // Define the place you want (here for example : Paris)
    CLLocationDegrees longitude = 2.344894f;
    CLLocationDegrees latitude = 48.860042f;
    
    // Now ask for a result for when and where
    result = [PSAOCSPA computeSolarPositionWithDate:chosenDate 
                                          longitude:longitude 
                                           latitude:latitude];
                                           
                                        
So now you should know how to use the result object. And free to you to use those values :-)

    NSString * s = [[NSString alloc] initWithFormat:@"azimuth %.6f deg, zenith angle %.6f deg",
                    result.azimuth,
                    result.zenithAngle];
    NSLog(@"%@", s);


![Description of the couple (*Azimuth*, *Angle*)](http://www.mpoweruk.com/images/sun_position.gif "Description of the couple (*Azimuth*, *Angle*)")

                                           

