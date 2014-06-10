//
//  AIRWeatherAppTests.m
//  AIRWeatherAppTests
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "AIRTemperatureConverter.h"
#import "AIROpenWeatherMapConnector.h"
#import "AIRViewController.h"

static const double kKelvinTemp = 310.0; // 36.85 Celsius, 98.33 Fahrenheit


//These temp convertions were obtained via Google.
static const double kKelvinCurrentTempConst = 301.62;
static const double kKelvinMinTempConst = 299.82;
static const double kKelvinMaxTempConst = 303.15;
static const double kFahrenheitCurrentTempConst = 83.246;
static const double kFahrenheitMinTempConst = 80.006;
static const double kFahrenheitMaxTempConst = 86;

static NSString * const kPlaceName = @"Atlanta,GA";
static NSString * const kIconString = @"10d";

//static NSString * const kValidJSON = @"{\"coord\":{\"lon\":-84.39,\"lat\":33.75},\"sys\":{\"message\":0.2587,\"country\":\"United States of America\",\"sunrise\":1401791233,\"sunset\":1401842667},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"base\":\"cmc stations\",\"main\":{\"temp\":301.62,\"pressure\":1016,\"temp_min\":299.82,\"temp_max\":303.15,\"humidity\":86},\"wind\":{\"speed\":1.81,\"deg\":206.003},\"rain\":{\"3h\":2},\"clouds\":{\"all\":32},\"dt\":1401828130,\"id\":4180439,\"name\":\"Atlanta\",\"cod\":200}";

@interface AIROpenWeatherMapConnector (Test)

@property (nonatomic, strong) NSMutableData *apiReturnData;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end


@interface AIRWeatherAppTests : XCTestCase

@property AIROpenWeatherMapConnector *realAIROpenWeatherMapConnector;
@property id mockNSJSONSerialization;
@property id mockAirTemperatureConverter;
@property id mockAirViewController;
@property (nonatomic, strong) NSDictionary *validJSONDictionary;
@property (nonatomic, strong) NSDictionary *unexpectedJSONDictionary;
@property (nonatomic, strong) NSURL *expectedImageURL;

@end

@implementation AIRWeatherAppTests

//These class level setup and teardown methods are called ONCE per test class.  Use these to set up
//things like read-only files and other items that can be used throughout the entire test class for
//each test. Ensure that these items are not mutated throughout the tests, or you will have overflow
//from one test to the next.
+ (void)setUp
{
    
}

+ (void)tearDown
{
    
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.realAIROpenWeatherMapConnector = [AIROpenWeatherMapConnector new];
    self.mockAirTemperatureConverter = [OCMockObject mockForClass:[AIRTemperatureConverter class]];
    self.mockNSJSONSerialization = [OCMockObject mockForClass:[NSJSONSerialization class]];
    self.mockAirViewController = [OCMockObject mockForClass:[AIRViewController class]];
    
    self.validJSONDictionary = @{@"coord":@{@"lon":@(-84.39),@"lat":@(33.75)},@"sys":@{@"message":@(0.2587),@"country":@"United States of America",@"sunrise":@(1401791233),@"sunset":@(1401842667)},@"weather":@[@{@"id":@(500),@"main":@"Rain",@"description":@"light rain",kIcon:kIconString}],@"base":@"cmc stations",kMain:@{kTemp:@(kKelvinCurrentTempConst),@"pressure":@(1016),kTempMin:@(kKelvinMinTempConst),kTempMax:@(kKelvinMaxTempConst),@"humidity":@(86)},@"wind":@{@"speed":@(1.81),@"deg":@(206.003)},@"rain":@{@"3h":@(2)},@"clouds":@{@"all":@(32)},@"dt":@(1401828130),@"id":@(4180439),kName:kPlaceName,@"cod":@(200)};
    
    self.unexpectedJSONDictionary = @{@"randomKey":@"randomValue",@"jennysNumber":@(8675309)};
    self.expectedImageURL = [NSURL URLWithString:[NSString stringWithFormat:kImageURLString,kIconString]];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    //We want to nil out and tear down any of our objects to ensure nothing spills over into a
    //subsequent test.
    self.realAIROpenWeatherMapConnector = nil;
    self.mockNSJSONSerialization = nil;
    self.mockAirViewController = nil;
    self.mockAirTemperatureConverter = nil;
    self.validJSONDictionary = nil;
    self.expectedImageURL = nil;
    self.unexpectedJSONDictionary = nil;
}

//This is a pretty simple functional test, the JSON test is quite a bit more detailed.
- (void)testKelvinToFahrenheitConversion
{
    double fahrenheitValue = [AIRTemperatureConverter convertKelvinToFahrenheitWithKelvinTemp:kKelvinTemp];
    XCTAssertEqualWithAccuracy(98.33, fahrenheitValue, .001, @"Not Accurate Enough!");
}

- (void)xxxtestAssertKelvinToCelsiusConversion
{
    //Stubbed test, this needs to be written =) have at it AirWatch Developer!
}

- (void)testConnectionDidFinishLoadingWithWellFormedJSON
{
    //We don't care to define our return data since we will mock the JSONSerialization.
    self.realAIROpenWeatherMapConnector.apiReturnData = nil;
    
    //When we make our call to our delegate, we don't want the actual delegate to be called.  We will
    //set our delegate to be a mocked version.
    self.realAIROpenWeatherMapConnector.delegate = self.mockAirViewController;
    
    //The data used here will be nil as we defined it above.  This expect will only work with EXACTLY
    //these parameters.  However, [OCMarg anyObjectRef] allows us to accept any &error so that we
    //don't have to inject our error that is created at runtime.
    [[[self.mockNSJSONSerialization expect] andReturn:self.validJSONDictionary]
     JSONObjectWithData:nil options:kNilOptions error:[OCMArg anyObjectRef]];
    
    //We expect our 3 convertions to occur, we will call our expect "expecting" the values stored in
    //our dictionary to be used for the conversion from kelvin.  We will return the correct conversions
    //as obtained via Google.  We do this to force our app to use the correct values without making
    //any assumptions of whether our tempConverter actually works correctly.  We aren't currently
    //testing our temp converter, so we don't actually want to use it.
    [[[self.mockAirTemperatureConverter expect] andReturnValue:OCMOCK_VALUE(kFahrenheitCurrentTempConst)]
     convertKelvinToFahrenheitWithKelvinTemp:kKelvinCurrentTempConst];
    [[[self.mockAirTemperatureConverter expect] andReturnValue:OCMOCK_VALUE(kFahrenheitMaxTempConst)]
     convertKelvinToFahrenheitWithKelvinTemp:kKelvinMaxTempConst];
    [[[self.mockAirTemperatureConverter expect] andReturnValue:OCMOCK_VALUE(kFahrenheitMinTempConst)]
     convertKelvinToFahrenheitWithKelvinTemp:kKelvinMinTempConst];
    
    //We expect our delegate to get called when we finish, but since we are just testing, we will use
    //our mock and not actually do anything.
    [[self.mockAirViewController expect] openWeatherMapConnectionDidReceiveData];
    
    //Lets make the actual call!
    [self.realAIROpenWeatherMapConnector connectionDidFinishLoading:nil];
    
    //We want to verify that all of the expected calls were made and NO extra calls.
    //This checks the behavior of our method.
    [self.mockAirViewController verify];
    [self.mockAirTemperatureConverter verify];
    [self.mockNSJSONSerialization verify];
    
    //Now we want to verify that our properties are in their expected state so that the viewController
    //can update our UI appropriatly.
    XCTAssertEqual(self.realAIROpenWeatherMapConnector.currentTemp, kFahrenheitCurrentTempConst,
                   @"Current temp did not update properly! %f",self.realAIROpenWeatherMapConnector.currentTemp);
    XCTAssertEqual(self.realAIROpenWeatherMapConnector.maxTemp, kFahrenheitMaxTempConst,
                   @"Max temp did not update properly! %f",self.realAIROpenWeatherMapConnector.maxTemp);
    XCTAssertEqualWithAccuracy(self.realAIROpenWeatherMapConnector.minTemp, kFahrenheitMinTempConst,
                               .001, @"Min temp did not update properly! %f",self.realAIROpenWeatherMapConnector.minTemp);
    XCTAssertEqual(self.realAIROpenWeatherMapConnector.placeName, kPlaceName,
                   @"Place Name did not update properly! %@",self.realAIROpenWeatherMapConnector.placeName);
    XCTAssertEqualObjects(self.realAIROpenWeatherMapConnector.weatherIconURL, self.expectedImageURL,
                   @"Weather Icon URL did not update properly! %@",self.realAIROpenWeatherMapConnector.weatherIconURL);
}

//The expected behavior is that all of our values:
//self.currentTemp, self.maxTemp, self.minTemp, self.placeName, self.weatherIconURL
//should be nil if we receive a dictionary that is complete garbage for us.
- (void)xxxtestConnectionDidFinishLoadingWithUnexpectedlyFormedJSON
{
    //Stubbed test, this needs to be written =)
    //This test will require mocking, have at it AirWatch Developer!
    //Please DO NOT copy paste since that would completely ruin the exercise right?
    //The above test should be used as an example, make sure you understand what is going on and
    //Ask Questions!!
}

@end
