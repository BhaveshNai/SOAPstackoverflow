//
//  ViewController.m
//  SopaStackOverflow
//
//  Created by spice on 17/06/15.
//  Copyright (c) 2015 SpiceDigital. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [self method_GetUpcomingLotteries];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)method_GetUpcomingLotteries
{
    
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<env:Envelope xmlns:env=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:ns1=\"urn:Lottery.Intf-ILottery\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:enc=\"http://www.w3.org/2003/05/soap-encoding\">\n"
                             "<env:Body>\n"
                             "<ns1:GetUpcomingLotteries env:encodingStyle=\"http://www.w3.org/2003/05/soap-encoding\">\n"
                             "<EntityID xsi:type=\"xsd:int\">2</EntityID>\n"
                             "<Password xsi:type=\"xsd:string\">Smart@Winners</Password>\n"
                             "<SortBy xsi:type=\"xsd:int\">0</SortBy>\n"
                             "<limit xsi:type=\"xsd:int\">0</limit>\n"
                             "</ns1:GetUpcomingLotteries>\n"
                             "</env:Body>\n"
                             "</env:Envelope>"];
    
    
    NSURL *sRequestURL = [NSURL URLWithString:@"http://isapi.mekashron.com/soapclient/soapclient.php?"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: @"urn:Lottery.Intf-ILottery/GetUpcomingLotteries" forHTTPHeaderField:@"SOAPAction"];
    [request addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPMethod:@"POST"];
    
    
    
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"soapMessage===\n %@",soapMessage);
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if( theConnection ) {
        NSLog(@"hiii");
        self.webResponseData = [NSMutableData data];
    }else {
        NSLog(@"Some error occurred in Connection");
        
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Received Bytes from server: %lu", (unsigned long)[self.webResponseData length]);
    
    NSString * strXml = [[NSString alloc] initWithBytes: [self.webResponseData mutableBytes] length:[self.webResponseData length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"---- %@" ,strXml);
    
    //TBXML *sourceXML = [[TBXML alloc] initWithXMLString:strXml error:nil];
   // TBXMLElement *rootElement = sourceXML.rootXMLElement;
   // TBXMLElement *entryElement = [TBXML childElementNamed:@"soap:Body" parentElement:rootElement];
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [self.webResponseData  setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.webResponseData  appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Some error in your Connection. Please try again.");
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
