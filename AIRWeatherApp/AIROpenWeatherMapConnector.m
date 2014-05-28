//
//  AIROpenWeatherMapConnector.m
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import "AIROpenWeatherMapConnector.h"

@interface AIROpenWeatherMapConnector ()

@property (nonatomic, strong) NSMutableData *apiReturnData;

@end

@implementation AIROpenWeatherMapConnector

- (void)openNewConnection
{
    self.apiReturnData = [NSMutableData new];
    NSString *callString = @"http://api.openweathermap.org/data/2.1/find/name?q=atlanta";
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
    
    [self.delegate openWeatherMapConnectionDidReceiveDataWithDictionary:jsonDictionary];
}

@end
