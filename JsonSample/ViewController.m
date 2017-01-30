//
//  ViewController.m
//  JsonSample
//
//  Created by Sudheer Arava on 24/05/16.
//  Copyright © 2016 Sudheer. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{

    NSMutableArray *titleArray;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleArray = [[NSMutableArray alloc]init];
    
    NSLog(@"Task Num : 1");
    
    [self getJsonData];
    
    NSLog(@"Task Num : 9");
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)getJsonData{
    
    NSLog(@"Task Num : 2");
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/in/rss/topfreeapplications/limit=25/json"];
   // NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"Task Num : 3");
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       
                                                        if(error == nil)
                                                        {
                                                            
                                                            NSLog(@"Task Num : 6");
                                                            NSMutableDictionary * jsonDictnoryData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                            
                                                            NSLog(@"%@",jsonDictnoryData);
                                                            
                                                            NSDictionary *feed = [jsonDictnoryData objectForKey:@"feed"];
                                                            
                                                            NSArray * entry = [feed objectForKey:@"entry"];
                                                            
                                                            
                                                            for(NSDictionary *dict in entry){
                                                            
                                                                NSDictionary * title = [dict objectForKey:@"title"];
                                                                
                                                                NSString *label = [title objectForKey:@"label"];
                                                                
                                                                NSLog(@"label %@",label);
                                                                
                                                                [titleArray addObject:label];
                                                            
                                                            }

                                                            
//                                                            NSMutableArray * tableArray =  [jsonDictnoryData objectForKey:@"geonames"];
                                                            //titleArray = tableArray;
                                                            
                                                            [self.tableTask reloadData];
                                                            
                                                        }else{
                                                            NSLog(@"Error : %@ \n\n\n",error);
                                                            NSLog(@"Error : %@",error.localizedDescription);
                                                        }
                                                        
                                                        
                                                    }];
    
    NSLog(@"Task Num : 4");
    
    [dataTask resume];
    
    
    NSLog(@"Task Num : 5");

                                       
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    NSLog(@"Task Num : 7");
    return titleArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * useCell= @"jcell";
    
    UITableViewCell * cell =[_tableTask dequeueReusableCellWithIdentifier:useCell];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:useCell];
        
    }
    
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    //cell.detailTextLabel.text = [titleArray objectAtIndex:indexPath.row][@"fcodeName"];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    NSLog(@"Task Num : 8");
    
    //NSString *message = [NSString stringWithFormat:@"Selected Data %@ - %@",titleArray[indexPath.row][@"name"],titleArray[indexPath.row][@"fcodeName"]];
    
    NSString *message = [NSString stringWithFormat:@"Selected Data %@ ",titleArray[indexPath.row]];

    
       UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Alert title" message:message preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction * oKButton = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:oKButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
