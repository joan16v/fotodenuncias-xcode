//
//  fotoDenunciasViewController.h
//  foto denuncias
//
//  Created by Joan Gimenez Donat on 01/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface fotoDenunciasViewController : UIViewController 
<UIImagePickerControllerDelegate, 
UINavigationControllerDelegate>
{

    IBOutlet UITextField *descripcion;
    IBOutlet UIButton *elijeFoto;
    IBOutlet UIButton *hazFoto;    
    IBOutlet UIImageView *logo;
    UIImageView *imageView;
    IBOutlet UIButton *subir;
    IBOutlet UIButton *twitter;    
    
    BOOL newMedia;
    NSString *pathImagen;
    BOOL imagenElegida;

}

@property (nonatomic, retain) IBOutlet UITextField *descripcion;
@property (nonatomic, retain) IBOutlet UIButton *elijeFoto;
@property (nonatomic, retain) IBOutlet UIButton *hazFoto;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImageView *logo;
@property (nonatomic, retain) IBOutlet UIButton *subir;
@property (nonatomic, retain) IBOutlet UIButton *twitter;

- (IBAction)useCamera;
- (IBAction)useCameraRoll;
- (IBAction)subirDenuncia;
- (IBAction)abrirTwitter;
- (IBAction)abrirWeb;

- (IBAction)textFieldReturn:(id)sender;

@end
