//
//  AIRTemperatureConverter.m
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import "AIRTemperatureConverter.h"
#define kFahrenheitMultiplier 1.8
#define kFahrenheitModifier 273.15
#define kCelsiusModifier 275

@implementation AIRTemperatureConverter

/**
 *  Converts temperatures from Kelvin to Fahrenheit. This should work =)
 *
 *  @param kelvinTemp kelvin temperature given as a double.
 *
 *  @return fahrenheit temperature returned as a double.
 */
+ (double)convertKelvinToFahrenheitWithKelvinTemp:(double)kelvinTemp
{
    //Direct conversion from double to int will perform truncation.
    double fahrenheitTemp = (kFahrenheitMultiplier) * (kelvinTemp - kFahrenheitModifier) + 32;
    
    char *p = malloc(sizeof(char) * 12);
    
    NSLog(@"%s",p);
    
    return fahrenheitTemp;
}

/**
 *  Converts temperatures from Kelvin to Celsius.  Something may be wrong here...
 *
 *  @param kelvinTemp kelvin temperature given as a double.
 *
 *  @return fahrenheit temperature returned as a double.
 */
+ (double)convertKelvinToCelsiusWithKelvinTemp:(double)kelvinTemp
{
    double celsiusTemp = kelvinTemp - kCelsiusModifier;
    
    return celsiusTemp;
}

@end
