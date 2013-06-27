//
//  fotoDenunciasAppDelegate.m
//  foto denuncias
//
//  Created by Joan Gimenez Donat on 01/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "fotoDenunciasAppDelegate.h"

#import "fotoDenunciasViewController.h"

@implementation fotoDenunciasAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
//@synthesize imageView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[fotoDenunciasViewController alloc] initWithNibName:@"fotoDenunciasViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
-(void)UIImagePickerControllerDelegate:(UIImagePickerController *)picker
{

    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Save failed"
                          message: @"Failed to save image"\
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];    


}*/


/*
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Save failed"
                          message: @"Failed to save image"\
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];    
    
    //[self dismissModalViewControllerAnimated:YES];
    //if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //image
        
        //imageView.image = image;
        //imageView.
        //image;
        
        //if (newMedia) UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:finishedSavingWithError:contextInfo:),nil);
        
    //}
    //else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    //{
		// Code here to support video if enabled
	//}
}
-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error 
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        //[alert release];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //[self dismissModalViewControllerAnimated:YES];
}*/

@end
