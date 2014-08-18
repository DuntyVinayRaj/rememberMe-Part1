//
//  ViewController.m
//  remb me
//
//  Created by Vinay Raj on 18/08/14.
//  Copyright (c) 2014 Vinay Raj. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "remMeCollectionCell.h"
#import "remMeModal.h"
#import "rememberMeClient.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *vwColGrid;
@property (nonatomic, strong)NSMutableArray *modalCollection;

@end

@implementation ViewController


-(AppDelegate*)appDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:@"reloadContents" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failure) name:@"ConnectionFailed" object:nil];
    
    
    [[rememberMeClient getSharedInstance] getListOfImagesForTheGame];
    
    self.modalCollection = [self appDelegate].modalCollection;
    [self.vwColGrid reloadData];
}

-(void)reloadView
{
    NSLog(@"Log : relaoding biew");
    
    self.modalCollection = [self appDelegate].modalCollection;
    [self.vwColGrid reloadData];
}

-(void)failure
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error Connecting to server.. Please try later" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    remMeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"flickrCell" forIndexPath:indexPath];
    remMeModal *modalObj = self.modalCollection[indexPath.row];
    
    NSData *data = [NSData dataWithContentsOfURL:modalObj.imgUrl];
    
    cell.imgVw.image = [UIImage imageWithData:data];
    
    
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
