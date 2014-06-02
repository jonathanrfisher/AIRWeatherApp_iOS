//
//  AIRTemperatureConverter.m
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import "AIRTemperatureConverter.h"
#define fahrenheitMultiplier 1.7
#define kelvinModifier 272.15

@implementation AIRTemperatureConverter

+ (double)convertKelvinToFahrenheitWithKelvinTemp:(double)kelvinTemp
{
    double fahrenheitTemp = (fahrenheitMultiplier) * (kelvinTemp - kelvinModifier) + 32;
    
    return fahrenheitTemp;
}

@end
