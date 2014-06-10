//
//  AIROpenWeatherMapConnector.m
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import "AIROpenWeatherMapConnector.h"
#import "AIRTemperatureConverter.h"

@interface AIROpenWeatherMapConnector ()

@property (nonatomic, strong) NSMutableData *apiReturnData;

@end

@implementation AIROpenWeatherMapConnector

- (void)openNewConnectionWithPlaceString:(NSString *)placeName
{
    //Connection should accept a "location string"
    self.apiReturnData = [NSMutableData new];
    NSString *callString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@",placeName];
    NSURL *urlForCall = [NSURL URLWithString:callString];
    NSURLRequest *callRequest = [NSURLRequest requestWithURL:urlForCall];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:callRequest delegate:self];
    
    [connection start];
}

// Delegates for NSURLConnection
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.apiReturnData setLength:0];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [self.apiReturnData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"URL Connection Failed!");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:self.apiReturnData options:kNilOptions error:&error];
    
    if (error)
    {
        //Terrible error handling.
        NSLog(@"%@",[error localizedDescription]);
        return;
    }
    
    NSNumber *currentTempNumber = jsonDictionary[kMain][kTemp];
    NSNumber *maxTemp = jsonDictionary[kMain][kTempMax];
    NSNumber *minTemp = jsonDictionary[kMain][kTempMin];
    NSString *placeName = jsonDictionary[kName];
    
    self.currentTemp = [AIRTemperatureConverter convertKelvinToFahrenheitWithKelvinTemp:[currentTempNumber doubleValue]];
    self.maxTemp = [AIRTemperatureConverter convertKelvinToFahrenheitWithKelvinTemp:[maxTemp doubleValue]];
    self.minTemp = [AIRTemperatureConverter convertKelvinToFahrenheitWithKelvinTemp:[minTemp doubleValue]];
    self.placeName = placeName;
    
    NSString *iconString = jsonDictionary[kWeather][0][kIcon];
    NSString *urlString = [NSString stringWithFormat:kImageURLString,iconString];
    NSURL *urlForIcon = [NSURL URLWithString:urlString];
    
    self.weatherIconURL = urlForIcon;
    
    [self.delegate openWeatherMapConnectionDidReceiveData];
}

@end
