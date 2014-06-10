//
//  AIRTemperatureConverter.h
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIRTemperatureConverter : NSObject

+ (double)convertKelvinToFahrenheitWithKelvinTemp:(double)kelvinTemp;
+ (double)convertKelvinToCelsiusWithKelvinTemp:(double)kelvinTemp;

@end
