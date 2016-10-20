//
//  ViewController.m
//  KWWeatherApp
//
//  Created by Kalyani on 17/10/16.
//  Copyright © 2016 kalyani Warke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//   [self startLocating];
    
    forcast = [[NSMutableArray alloc]init];
    
//    array7days = @[@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"saturday"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)startLocating {
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    NSLog(@"lattitude = %f",currentLocation.coordinate.latitude);
    
    NSLog(@"longitude = %f",currentLocation.coordinate.longitude);

    kLatitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude ];
    kLongitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    
    
    [self getCurrentWeatherDataWithLatitude:kLatitude.intValue longitude:kLongitude.intValue APIKey:kWeatherAPIKey];
    [self get7DaysWeatherDataWithLatitude:kLatitude.doubleValue longitude:kLongitude.doubleValue APIKey:kWeatherAPIKey];
    
    if (currentLocation !=nil) {
    
        [locationManager stopUpdatingLocation];
    
    }
    
}

-(void)getCurrentWeatherDataWithLatitude:(double)latitude
                               longitude:(double)longitude
                                  APIKey:(NSString *)key{
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=%@&units=metric",latitude,longitude,key];
//    NSLog(@"%@",urlString);
    
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [mySession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            
        }
        else{
            if(response){
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if(httpResponse.statusCode == 200)
                {
                    if (data) {
                        NSError *error;
                        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                        if(error){
                            
                        }
                        else{
                            [self performSelectorOnMainThread:@selector(updateUI:) withObject:jsonDictionary waitUntilDone:YES];
                        }
                    }
                }
            }
        }
    }];
    [task resume];
}

-(void)updateUI:(NSDictionary *)resultDictionary {
    
//    NSLog(@"%@",resultDictionary);
    
    
    
    NSString *temperature = [NSString stringWithFormat:@"%@",[resultDictionary valueForKeyPath:@"main.temp"]];
    
   
    
    int temp = temperature.intValue;
    
    temperature = [NSString stringWithFormat:@"%d °C",temp];
    
    
//    NSLog(@"\n\nTEMPERATURE : %@",temperature);
    
    NSArray *weather = [resultDictionary valueForKey:@"weather"];
    
//    NSLog(@"%@",weather);
    
    NSDictionary *weatherDictionary = weather.firstObject;
    
    
    
    
    NSString *condition = [NSString stringWithFormat:@"%@",[weatherDictionary valueForKey:@"description"]];
    
//    NSLog(@"%@",condition);
    
    
    NSString *city = [NSString stringWithFormat:@"%@",[resultDictionary valueForKey:@"name"]];
    
    
    self.labelCity.text = city;
    self.labelCondition.text = condition.capitalizedString;
    self.labelTemperature.text = temperature;
    
    
}




-(void)get7DaysWeatherDataWithLatitude:(double)latitude
                             longitude:(double)longitude
                                APIKey:(NSString *)key{
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&cnt=7&appid=%@&units=metric",latitude,longitude,key];
   // NSLog(@"%@",urlString);
    
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [mySession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            
        }
        else{
            if(response){
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if(httpResponse.statusCode == 200)
                {
                    if (data) {
                        NSError *error;
                        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                        if(error){
                            
                        }
                        else{
                            [self performSelectorOnMainThread:@selector(updateUIFor7Days:) withObject:jsonDictionary waitUntilDone:YES];
                        }
                    }
                }
            }
        }
    }];
    [task resume];
}
-(void)updateUIFor7Days:(NSDictionary *)resultDictionary{
//      NSLog(@"%@",resultDictionary);
    
    NSArray *list = [resultDictionary valueForKey:@"list"];
   NSLog(@"%@",list);
    
    if (forcast.count > 0) {
        [forcast removeAllObjects];
    }
    
    
    for (NSDictionary *weatherDetail in list) {
        
//        NSLog(@"%@",weatherDetail);
    
    
      
//        NSString *maximumTemperature =[NSString stringWithFormat:@"%@",[weatherDetail valueForKeyPath:@"temp.max"]];
//        int temp_max =maximumTemperature.intValue;
//        maximumTemperature =[NSString stringWithFormat:@"%d˚C ",temp_max ];
//        
//        NSString *minimumTemperature =[NSString stringWithFormat:@"%@",[weatherDetail valueForKeyPath:@"temp.min"]];
//        int temp_min =minimumTemperature.intValue;
//        
//        maximumTemperature =[NSString stringWithFormat:@"%d˚C ",temp_min ];

        NSString *max = [NSString stringWithFormat:@"%@",[weatherDetail valueForKeyPath:@"temp.max"]];
        max = [NSString stringWithFormat:@"%d°C",max.intValue];
        NSString *min = [NSString stringWithFormat:@"%@",[weatherDetail valueForKeyPath:@"temp.min"]];
        min = [NSString stringWithFormat:@"%d°C",min.intValue];
        
        
        NSDictionary *myDictionary = @{
                                       @"date" : [NSString stringWithFormat:@"%@",[weatherDetail valueForKey:@"dt"]],
                                     @"maximum_temp" : max,
                                       @"minimum_temp" : min
                                      
                                       };
        
        [forcast addObject:myDictionary];
        
    
    }
    
    if (forcast.count > 0) {
        [self.myTableView reloadData];
    }
    
    
    
//    NSDictionary *tempDictionary = [list valueForKey:@"temp"];
//    
//    NSLog(@"%@",tempDictionary);
//    
//   maxTemp = [tempDictionary valueForKey:@"max"];
//   NSLog(@"%@",maxTemp);
    
   }




- (IBAction)getWeatherAction:(id)sender {
    [self startLocating];
    
   
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return devices.count;
    
    return forcast.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weather_cell"];
    
    NSDictionary *temp = [forcast objectAtIndex:indexPath.row];
    
    NSLog(@"%@",temp);
    
    
    NSString *dt = [temp valueForKey:@"date"];
    
    NSTimeInterval time = dt.doubleValue;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    NSString *day = [dateFormatter stringFromDate:date];
    
    
    
    cell.labelDays .text = day;
//      cell.labelMaxTemperature.text =
    cell.labelMaxTemperature.text =[temp valueForKey:@"maximum_temp"];
    cell.labelMinTemperature.text = [temp valueForKey:@"minimum_temp"];
    
    
    
    return cell;
}


@end
