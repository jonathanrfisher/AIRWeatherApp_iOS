//
//  AIRViewController.m
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import "AIRViewController.h"
#import "AIRTemperatureConverter.h"

static NSString * const kMain = @"main";
static NSString * const kList = @"list";
static NSString * const kUrl = @"url";
static NSString * const kTemp = @"temp";
static NSString * const kTempMin = @"temp_min";
static NSString * const kTempMax = @"temp_max";
static NSString * const kWeather = @"weather";
static NSString * const kIcon = @"icon";
static NSString * const kAtlantaURL = @"http://openweathermap.org/city/4180439";

@interface AIRViewController ()

@property (nonatomic, strong) AIROpenWeatherMapConnector *openWeatherMapConnector;
@property (nonatomic, strong) NSDictionary *mainDictionary;

@end

@implementation AIRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.openWeatherMapConnector = [AIROpenWeatherMapConnector new];
    self.openWeatherMapConnector.delegate = self;
    [self.openWeatherMapConnector openNewConnection];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) openWeatherMapConnectionDidReceiveDataWithDictionary:(NSDictionary *)weatherDataDictionary
{
    //Update UI.
    NSArray *resultsArray = [NSArray new];
    
    if (weatherDataDictionary[kList])
    {
        resultsArray = weatherDataDictionary[kList];
    }
    
    NSDictionary *resultDictionary;
    BOOL foundAtlanta = NO;
    
    for (NSDictionary *result in resultsArray)
    {
        resultDictionary = result;
        if ([resultDictionary[kUrl]  isEqualToString:kAtlantaURL])
        {
            foundAtlanta = YES;
            break;
        }
    }
    
    if (foundAtlanta)
    {
        self.mainDictionary = resultDictionary;
        [self updateUIElements];
    }
}

- (void)updateUIElements
{
    NSString *currentTemp = [NSString stringWithFormat:@"%@",self.mainDictionary[kMain][kTemp]];
    NSString *highTemp = [NSString stringWithFormat:@"%@",self.mainDictionary[kMain][kTempMax]];
    NSString *lowTemp = [NSString stringWithFormat:@"%@",self.mainDictionary[kMain][kTempMin]];
    
    currentTemp = [AIRTemperatureConverter convertKelvinToFahrenheitWithStringForKelvin:currentTemp];
    highTemp = [AIRTemperatureConverter convertKelvinToFahrenheitWithStringForKelvin:highTemp];
    lowTemp = [AIRTemperatureConverter convertKelvinToFahrenheitWithStringForKelvin:lowTemp];
    
    self.currentTempLabel.text = [NSString stringWithFormat:@"%@º",currentTemp];
    self.highTempLabel.text = [NSString stringWithFormat:@"%@º",highTemp];
    self.lowTempLabel.text = [NSString stringWithFormat:@"%@º",lowTemp];
    
    NSArray *weatherArray = self.mainDictionary[kWeather];
    NSString *iconString = weatherArray[0][kIcon];
    [self updateImageForIcon:iconString];
}

- (void)updateImageForIcon:(NSString *)iconString
{
    NSString *urlString = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",iconString];
    NSURL *urlForString = [NSURL URLWithString:urlString];
    NSData *imageData = [NSData dataWithContentsOfURL:urlForString];
    
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    self.weatherImage.image = image;
}


@end
