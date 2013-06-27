//
//  fotoDenunciasViewController.m
//  foto denuncias
//
//  Created by Joan Gimenez Donat on 01/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "fotoDenunciasViewController.h"
//#import "ASIFormDataRequest.h"

@interface fotoDenunciasViewController ()

@end

@implementation fotoDenunciasViewController

@synthesize descripcion, elijeFoto, hazFoto, subir;
//@dynamic imageView;
@synthesize imageView, twitter, logo;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    imagenElegida=FALSE;
    
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
        //imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
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
        //imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker animated:YES];
        //imagePicker release];
        newMedia = NO;
    }
}




-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];    
   
    [self dismissModalViewControllerAnimated:YES];
    //if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //image.
    //UIImagePickerControllerOriginalImage.description;
    
    //NSString *pipi=(@"%@",UIImagePickerControllerOriginalImage.image);
    
    NSURL* localUrl = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
    NSString *filePath= [localUrl absoluteString];
    
    /*UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"pipi"
                          message: filePath\
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];  */  
    
    imageView.image = image;
    
    //imageView.
    //image;
    
    if (newMedia) UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:finishedSavingWithError:contextInfo:),nil);
    
    imagenElegida=TRUE;
    pathImagen=filePath;
    
    //}
    //else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    //{
     //Code here to support video if enabled
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
    [self dismissModalViewControllerAnimated:YES];
}

-(void)abrirTwitter{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.twitter.com/joan16v"]];
}

-(void)abrirWeb{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.fotodenuncias.net"]];
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
            
            /*NSString *urlpost=@"http://www.fotodenuncias.net/iphone/iphonePost.php";
            NSURL *fileURLpost = [NSURL fileURLWithPath:urlpost];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:fileURLpost];
            [request addPostValue:descripcion.text forKey:@"desc"];
            [request addPostValue:@"GPS" forKey:@"gps"];
            [request addFile:@"/Users/ben/Desktop/ben.jpg" forKey:@"photos"];
            [request addData:imageView withFileName:@"pic.jpg" andContentType:@"image/jpeg" forKey:@"photo"];            */
            
            
            
            
            //vaciar descripcion y imagen
            imagenElegida=FALSE;
            pathImagen=@"";
            [imageView removeFromSuperview];
            descripcion.text=@"";
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"OK"
                                  message: @"Foto-denuncia subida en fotodenuncias.net!"\
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];                
            
        }       
    }

}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 

@end
