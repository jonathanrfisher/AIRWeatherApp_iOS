//
//  AIROpenWeatherMapConnector.h
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import <Foundation/Foundation.h>

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
