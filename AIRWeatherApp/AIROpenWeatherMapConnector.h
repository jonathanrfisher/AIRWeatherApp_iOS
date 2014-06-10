//
//  AIROpenWeatherMapConnector.h
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kMain = @"main";
static NSString * const kList = @"list";
static NSString * const kUrl = @"url";
static NSString * const kTemp = @"temp";
static NSString * const kTempMin = @"temp_min";
static NSString * const kTempMax = @"temp_max";
static NSString * const kWeather = @"weather";
static NSString * const kIcon = @"icon";
static NSString * const kName = @"name";

static NSString * const kImageURLString = @"http://openweathermap.org/img/w/%@.png";

@protocol AIROpenWeatherMapConnectorDelegate <NSObject>

- (void) openWeatherMapConnectionDidReceiveData;

@end

@interface AIROpenWeatherMapConnector : NSObject <NSURLConnectionDelegate, NSXMLParserDelegate>

- (void)openNewConnectionWithPlaceString:(NSString *)placeName;

@property (strong) id delegate;

//Weather data properties
@property double currentTemp;
@property double maxTemp;
@property double minTemp;
@property NSString *placeName;
@property NSURL *weatherIconURL;

@end
