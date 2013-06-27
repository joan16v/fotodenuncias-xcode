//
//  fotoDenunciasViewController.m
//  foto denuncias
//
//  Created by Joan Gimenez Donat on 01/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "fotoDenunciasViewController.h"
//#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
//#import "AFImageRequestOperation.h"
//#import "../Reachability.h"
//#import "ASIFormDataRequest.h"
#import "SVProgressHUD.h"
#include <math.h>

@interface fotoDenunciasViewController ()

@end

@implementation fotoDenunciasViewController

@synthesize descripcion; 
@synthesize elijeFoto; 
@synthesize hazFoto; 
@synthesize infoweb; 
@synthesize logo;
@synthesize imageView;
@synthesize subir; //@dynamic imageView;
@synthesize twitter;
@synthesize locationManager;
@synthesize imageGlobal;
@synthesize baseAlert;
@synthesize newMedia;
@synthesize imagenElegida;
//@synthesize pathImagen;
@synthesize idrespuesta;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    imagenElegida=FALSE; //UIImage *imageGlobal=nil;
    idrespuesta=@"-";
    //AFHTTPRequestOperation *operation;
    
    //geolocalizacion
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) useCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = 
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker 
                                animated:YES];
        //[imagePicker release];
        newMedia = YES;
    }
}

- (void) useCameraRoll
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = 
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker animated:YES]; //imagePicker release];
        newMedia = NO;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];       
    [self dismissModalViewControllerAnimated:YES];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];    
        //imageGlobal=image; 
        imageGlobal = [self resizeImage:image];
        //UIImagePickerControllerOriginalImage.description;    
        //NSURL* localUrl = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
        //NSString* theActualPath = [localUrl path];
        imageView.image = imageGlobal;    
        if (newMedia) UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:finishedSavingWithError:contextInfo:),nil);    
        imagenElegida=TRUE;
        //pathImagen=theActualPath;
    
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
     //Code here to support video if enabled
	}
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
        [alert show]; //[alert release];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)abrirTwitter{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.twitter.com/joan16v"]];
}

-(void)abrirWeb{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.fotodenuncias.net"]];
}

// Displays our progress indicator with a message
- (IBAction)showProgress {
    
    // initialize our Alert View window without any buttons
    baseAlert=[[UIAlertView alloc]initWithTitle:@"Enviando foto-denuncia..." 
                                                     message:nil 
                                                    delegate:self
                                           cancelButtonTitle:nil 
                                           otherButtonTitles:nil];    
    // Display our Progress Activity view
    [baseAlert show];
    
    // create and add the UIActivity Indicator
    UIActivityIndicatorView *activityIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center=CGPointMake(baseAlert.bounds.size.width/2.0f,baseAlert.bounds.size.height-40.0f);
    
    // initialize to tell our activity to start animating.
    [activityIndicator startAnimating];
    [baseAlert addSubview:activityIndicator]; //[activityIndicator release];
    
    // automatically close our window after 3 seconds has passed.
    [self performSelector:@selector(showProgressDismiss)
               withObject:nil afterDelay:0.0f];
}

// Delegate to dismiss our Activity indicator after the number of seconds has passed.
- (void) showProgressDismiss
{
    NSLog(@"entrado en el delegado del alert progress");
    //durante 30 segundos revisar si se ha subido la foto denuncia.
    /*NSInteger maxtry=30;
    NSInteger i=0;
    while (i<maxtry) {
        NSLog(@"entrado en while de comprobacion idrespuesta");
        //NSLog(idrespuesta);
        sleep(1);
        if([idrespuesta isEqualToString:@"-"]) {        
        } else {
            NSString *trimmedString = [idrespuesta stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];            
            if([trimmedString length])
            {
                NSLog(@"some characters outside of the decimal character set found");
                //ko
                [baseAlert dismissWithClickedButtonIndex:0 animated:NO]; 
                //error: intentalo mas tarde
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"Error"
                                      message: @"Error subiendo denuncia. Vuelve a intentarlo."\
                                      delegate: nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];  
            }
            else
            {
                NSLog(@"all characters were in the decimal character set");
                //ok
                [baseAlert dismissWithClickedButtonIndex:0 animated:NO]; 
                // open a alert with an OK and cancel button
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Completado" message:@"Foto-denuncia publicada!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Ver denuncia", nil];
                [alert show]; //[alert release];        
                
            }            
        }
        i++;
    }    
    //ko
    [baseAlert dismissWithClickedButtonIndex:0 animated:NO]; 
    //error: intentalo mas tarde
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Error"
                          message: @"Error subiendo denuncia. Tiempo máximo de espera alcanzado. Revisa la conexión a Internet!."\
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show]; */
}        

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        NSLog(@"ok");
        descripcion.text=@"";
    }
    else
    {
        NSLog(@"ver"); //[self abrirWeb];
        NSString *urlweb=@"http://www.fotodenuncias.net/foto.php";
        urlweb = [urlweb stringByAppendingString:@"?denuncia="];        
        urlweb = [urlweb stringByAppendingString:idrespuesta];        
        urlweb = [urlweb stringByAppendingString:@"&desc=denuncia"];        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: urlweb]];
    }
}

-(UIImage *)resizeImage:(UIImage *)image {
	
	CGImageRef imageRef = [image CGImage];
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	CGColorSpaceRef colorSpaceInfo = CGColorSpaceCreateDeviceRGB();
	
	if (alphaInfo == kCGImageAlphaNone)
		alphaInfo = kCGImageAlphaNoneSkipLast;
	
	int width, height;
	
	width = 640;
	height = 480;
	
	CGContextRef bitmap;
	
	if (image.imageOrientation == UIImageOrientationUp | image.imageOrientation == UIImageOrientationDown) {
		bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);		
	} else {
		bitmap = CGBitmapContextCreate(NULL, height, width, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);		
	}	
	if (image.imageOrientation == UIImageOrientationLeft) {
		NSLog(@"image orientation left");
		CGContextRotateCTM (bitmap,M_PI/2);
		CGContextTranslateCTM (bitmap, 0, -height);		
	} else if (image.imageOrientation == UIImageOrientationRight) {
		NSLog(@"image orientation right");
		CGContextRotateCTM (bitmap, (M_PI/2)*(-1));
		CGContextTranslateCTM (bitmap, -width, 0);		
	} else if (image.imageOrientation == UIImageOrientationUp) {
		NSLog(@"image orientation up");			
	} else if (image.imageOrientation == UIImageOrientationDown) {
		NSLog(@"image orientation down");	
		CGContextTranslateCTM (bitmap, width,height);
		CGContextRotateCTM (bitmap, M_PI*(-1));		
	}	
	CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage *result = [UIImage imageWithCGImage:ref];
	
	CGContextRelease(bitmap);
	CGImageRelease(ref);
	
	return result;	
}

- (void) subirDenuncia
{
    
    if( [descripcion.text isEqualToString:@""] ) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error"
                              message: @"Debes escribir una descripción!"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];            
    } else {        
        if ( imagenElegida==FALSE ) {            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Error"
                                  message: @"Debes elegir o hacer una foto!"\
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];                        
        } else {
            
            //subir la fotodenuncia
            
            subir.enabled=NO;
            elijeFoto.enabled=NO;
            hazFoto.enabled=NO;
            descripcion.enabled=NO;
            infoweb.enabled=NO;
            twitter.enabled=NO;
            [SVProgressHUD show];  
            
            //preparamos coordenadas
            NSString *coordenadas=[NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
            coordenadas = [coordenadas stringByAppendingString:@","];
            coordenadas = [coordenadas stringByAppendingString:[NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude]];            
            
            NSString *urlfull=@"http://www.fotodenuncias.net/iphone/iphonePost.php";
            NSURL *url = [NSURL URLWithString:urlfull];            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];            
            [request setHTTPMethod:@"POST"];      
            
            NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
            [request addValue:contentType forHTTPHeaderField:@"Content-Type"];            
            
            NSMutableData *postBody = [NSMutableData data];
           
            [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[@"Content-Disposition: form-data; name=\"desc\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[descripcion.text dataUsingEncoding:NSUTF8StringEncoding]];            
            
            [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[@"Content-Disposition: form-data; name=\"coord\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[coordenadas dataUsingEncoding:NSUTF8StringEncoding]];                          
            
            //reescalado de la imagen: para que no ocupe demasiado
            //UIImage *img = [self resizeImage:imageGlobal];
            UIImage *img = imageGlobal;
            
            NSData *imageData = UIImageJPEGRepresentation(img, 70);
            [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //le ponemos un nombre aleatorio a la imagen
            NSInteger rand=arc4random();
            NSString *nameimg=@"Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"iphonepic";
            NSString *string = [NSString stringWithFormat:@"%d", rand];            
            nameimg = [nameimg stringByAppendingString:string];
            nameimg = [nameimg stringByAppendingString:@".jpg\"\r\n"];
            
            [postBody appendData:[[NSString stringWithString:nameimg] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithString:@"Content-Type: image/jpg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[NSData dataWithData:imageData]];   
            [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPBody:postBody];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {                  
               
                NSLog(@"operation hasAcceptableStatusCode: %d", [operation.response statusCode]);                
                NSLog(@"response string: %@ ", operation.responseString);    
                idrespuesta=operation.responseString;
                
                [SVProgressHUD dismiss];                
                
                if([idrespuesta isEqualToString:@"-"]) {        
                } else {
                    NSString *trimmedString = [idrespuesta stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];            
                    if([trimmedString length])
                    {
                        //ko
                        NSLog(@"some characters outside of the decimal character set found");
                        [baseAlert dismissWithClickedButtonIndex:0 animated:NO]; 
                        //error: intentalo mas tarde
                        UIAlertView *alert = [[UIAlertView alloc]
                                              initWithTitle: @"Error"
                                              message: @"Error subiendo denuncia. Vuelve a intentarlo."\
                                              delegate: nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
                        [alert show]; 
                        subir.enabled=YES;
                        elijeFoto.enabled=YES;
                        hazFoto.enabled=YES;
                        descripcion.enabled=YES;    
                        infoweb.enabled=YES;
                        twitter.enabled=YES;                        
                    }
                    else
                    {
                        //ok
                        NSLog(@"all characters were in the decimal character set");
                        [baseAlert dismissWithClickedButtonIndex:0 animated:NO]; 
                        // open a alert with an OK and cancel button
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Completado" message:@"Foto-denuncia publicada!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Ver denuncia", nil];
                        [alert show]; //[alert release];                                
                        subir.enabled=YES;
                        elijeFoto.enabled=YES;
                        hazFoto.enabled=YES;
                        descripcion.enabled=YES;    
                        infoweb.enabled=YES;
                        twitter.enabled=YES;                        
                    }            
                }                                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {                
                NSLog(@"error: %@", operation.responseString);                
            }];       

            [operation start];      
            
            //[SVProgressHUD show];  
            
        }       
    }

}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 

@end
