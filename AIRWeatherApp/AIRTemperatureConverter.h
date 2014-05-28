//
//  AIRTemperatureConverter.h
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIRTemperatureConverter : NSObject

+ (NSString *)convertKelvinToFahrenheitWithStringForKelvin:(NSString *)kelvinString;
+ (NSString *)convertKelvinToCelsiusWithStringForKelvin:(NSString *)kelvinString;

@end
