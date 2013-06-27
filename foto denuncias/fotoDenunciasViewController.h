//
//  fotoDenunciasViewController.h
//  foto denuncias
//
//  Created by Joan Gimenez Donat on 01/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>


@interface fotoDenunciasViewController : UIViewController 
<UIImagePickerControllerDelegate, 
UINavigationControllerDelegate,
UIAlertViewDelegate>
{

    IBOutlet UITextField *descripcion;
    IBOutlet UIButton *elijeFoto;
    IBOutlet UIButton *hazFoto;    
    IBOutlet UIButton *infoweb;    
    IBOutlet UIImageView *logo;
    UIImageView *imageView;
    IBOutlet UIButton *subir;
    IBOutlet UIButton *twitter;    
    IBOutlet CLLocationManager *locationManager;    
    UIImage *imageGlobal;
    UIAlertView *baseAlert;    
    BOOL newMedia;
    BOOL imagenElegida;    
    //NSString *pathImagen;
    NSString *idrespuesta;   
    
    //AFHTTPRequestOperation *operation;

}

@property (nonatomic, retain) IBOutlet UITextField *descripcion;
@property (nonatomic, retain) IBOutlet UIButton *elijeFoto;
@property (nonatomic, retain) IBOutlet UIButton *hazFoto;
@property (nonatomic, retain) IBOutlet UIButton *infoweb;
@property (nonatomic, retain) UIImageView *logo;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *subir;
@property (nonatomic, retain) IBOutlet UIButton *twitter;
@property (nonatomic, retain) IBOutlet CLLocationManager *locationManager;
@property (nonatomic, retain) UIImage *imageGlobal;
@property (nonatomic, retain) UIAlertView *baseAlert;
@property (nonatomic) BOOL newMedia;
@property (nonatomic) BOOL imagenElegida;
//@property (nonatomic, retain) NSString *pathImagen;
@property (nonatomic, retain) NSString *idrespuesta;

- (IBAction)useCamera;
- (IBAction)useCameraRoll;
- (IBAction)subirDenuncia;
- (IBAction)abrirTwitter;
- (IBAction)abrirWeb;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)showProgress:(id)sender;
- (IBAction)showProgressDismiss;

@end
