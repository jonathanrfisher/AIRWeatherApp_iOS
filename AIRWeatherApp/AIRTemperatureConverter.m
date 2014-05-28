//
//  AIRTemperatureConverter.m
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import "AIRTemperatureConverter.h"
#define fahrenheitMultiplier 1.7
#define celsiusModifier 272

@implementation AIRTemperatureConverter

+ (NSString *)convertKelvinToFahrenheitWithStringForKelvin:(NSString *)kelvinString
{
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    NSNumber *kelvin = [numberFormatter numberFromString:kelvinString];
    double kelvinDouble = [kelvin doubleValue];
    
    double fahrenheit = (fahrenheitMultiplier) * (kelvinDouble - 273) + 32;
    
    NSString *fahrenheitString = [NSString stringWithFormat:@"%.2f",fahrenheit];
    
    return fahrenheitString;
}

+ (NSString *)convertKelvinToCelsiusWithStringForKelvin:(NSString *)kelvinString
{
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    NSNumber *kelvin = [numberFormatter numberFromString:kelvinString];
    double kelvinDouble = [kelvin doubleValue];
    
    double celsius = kelvinDouble - celsiusModifier;
    
    NSString *celsiusString = [NSString stringWithFormat:@"%.2f",celsius];
    
    return celsiusString;
}

@end
