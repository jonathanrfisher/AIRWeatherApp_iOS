//
//  AIROpenWeatherMapConnector.h
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AIROpenWeatherMapConnectorDelegate <NSObject>

- (void) openWeatherMapConnectionDidReceiveDataWithDictionary:(NSDictionary *)weatherDataDictionary;

@end

@interface AIROpenWeatherMapConnector : NSObject <NSURLConnectionDelegate, NSXMLParserDelegate>

- (void)openNewConnection;

@property (strong) id delegate;

@end
