//
//  SideView.m
//  MyPractice
//
//  Created by eph132 on 10/06/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "SideView.h"
#import "CategoryMenu.h"
#import "DetailCell.h"
#import "SectionInfo.h"
#import "SDWebImageManager.h"
#import "UIView+WebCacheOperation.h"
#import "SDWebImageOperation.h"
#import "UIImageView+WebCache.h"


#define DEFAULT_ROW_HEIGHT 157
#define HEADER_HEIGHT 50


@interface SideView ()
-(void)openDrawer;
-(void)closeDrqwer;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSMutableArray *sectionInfoArray;
@property (nonatomic, strong) NSArray *categoryList;
- (void) setCategoryArray;
@end

@implementation SideView
{
    
    NSArray *topItems;
    NSMutableArray *subItems; // array of arrays
    
    int currentExpandedIndex;
    UITableView *_tableView;
}


@synthesize categoryList = _categoryList;
@synthesize openSectionIndex;
@synthesize sectionInfoArray;


SideView *side;

NSArray *titleArray;
NSArray *imageArray;
NSArray *vcArray;


- (id)init{
    
    
    
    side = [[[NSBundle mainBundle] loadNibNamed:@"SideView"
                                          owner:self
                                        options:nil]
            objectAtIndex:0];
    
    
    [side sizeToFit];
    
   
    

    
   
    
    CGRect basketTopFrame = side.frame;
    
    basketTopFrame.origin.x = -320;
    
   // NSLog(@"Width:%f",basketTopFrame.size.width);
   //  NSLog(@"Width:%f",basketTopFrame.size.height);
    
    
    side.frame = basketTopFrame;
   
    
    _closeView.hidden=YES;
    
    
    _gesView.hidden = NO;
    
        [self openDrawer];
    
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    
    
    
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_gesView addGestureRecognizer:gestureRecognizer];

    
    
    [_menuTableView reloadData];
    
    
    return side;
    
}

-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe received.");
    _gesView.hidden = YES;
    [self closeDrawer:nil];
}


- (void)configureWith:(id<customProtocol>)delegate{
    //Configure the delegate it will manage the events
    //from subviews like buttons and other controls
    self.delegate = delegate;
    //.. to configure any subView
}


- (void) awakeFromNib
{
    
    _imgUser.layer.cornerRadius = _imgUser.frame.size.height/2;
    _imgUser.clipsToBounds = true;

    _lblName.frame = CGRectMake(_imgUser.frame.origin.x + _imgUser.frame.size.width+7, _imgUser.frame.origin.y+7, _lblName.frame.size.width, _lblName.frame.size.height);
    _lblSubName.frame = CGRectMake(_lblName.frame.origin.x, _lblName.frame.origin.y+_lblName.frame.size.height, _lblSubName.frame.size.width, _lblSubName.frame.size.height);
    
    //_lblCity.text =  [[NSUserDefaults standardUserDefaults] stringForKey:@"SELECTED_CITY"];
    
    
    NSDictionary *reportData = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LOGIN_DATA"];
   // NSDictionary *reportData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    NSLog(@"Reported:%@",reportData);
    
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[reportData valueForKeyPath:@"picture"]];
    
    
    NSLog(@"URL:%@",mainUrl);
    
    
    
   // [_customerImage sd_setImageWithURL:[NSURL URLWithString:mainUrl]placeholderImage:[UIImage imageNamed:@"default-placeholder.jpg"]];
    
    _customerLabel.text = @"Thomas\nthomas@test.com" ;
    
    
   // _customerLabel.text = [NSString stringWithFormat:@"%@\n%@",[reportData valueForKeyPath:@"first_name"],[reportData valueForKeyPath:@"last_name"]];
    
    
   // _emailLabel.text = [NSString stringWithFormat:@"%@",[reportData valueForKey:@"email"]];
    
    
    
    
    
   

    
//    if([[[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_BARBER"] isEqualToString:@""] || [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_BARBER"] == [NSNull null] || [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_BARBER"].length == 0)
//    {
//
//        titleArray=[NSArray arrayWithObjects:@"Home",@"Products",@"Login/Signup",@"Contact Us",@"Join Us",@"Terms & Conditions", nil];
//
//        vcArray=[NSArray arrayWithObjects:@"Home",@"Products",@"Login/Signup",@"Contact Us",@"Join Us",@"Terms & Condition", nil];
//
//        imageArray=[NSArray arrayWithObjects:@"db_icon_home.png",@"db_icon_terms.png",@"db_icon_login.png",@"db_icon_contacts.png",@"db_icon_login.png",@"db_icon_terms.png", nil];
//
//    }
//    else
    {
     
        
        /*
        titleArray=[NSArray arrayWithObjects:@"Home",@"Profile",@"Appointments",@"Favourites",@"Messages",@"Notes",@"Logout", nil];
        
        vcArray=[NSArray arrayWithObjects:@"Home",@"Profile",@"History",@"Cart",@"Messages",@"Notes",@"Logout",nil];
        
        imageArray=[NSArray arrayWithObjects:@"db_icon_home.png",@"menu_profile.png",@"menu_appointments.png",@"menu_favourites.png",@"menu_messages.png",@"menu_notes.png",@"menu_logout.png", nil];
        */
        
      
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"SUPP_123"];

        
        if([[[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] isEqualToString:@"2"])
        {
            titleArray=[NSArray arrayWithObjects:@"Inicio",@"Mi Entrenamiento",@"Mi Plan de Comida",@"Mis Servicios Fitness",@"Social",@"Mi Tienda",@"Mensajes",@"Invita a Tus Amigos",@"Órdenes",@"Ayuda", nil];
        }
        else
        {
            titleArray=[NSArray arrayWithObjects:@"Publications/News",@"Contacts",@"Fellowship",@"Notify",@"Calendar",@"Chapel",@"Pulpit",@"Class",@"Profile",@"Settings", nil];
        }
        
        
        
        vcArray=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
        
        imageArray=[NSArray arrayWithObjects:@"news1.png",@"user.png",@"app.png",@"notification.png",@"calendar.png",@"church.png",@"priest.png",@"seminar.png",@"user.png",@"settings1.png", nil];
      
    }
   
        
    
        

    
    
   
    
    
    [super awakeFromNib];
    
}



- (id)initWithTitle:(NSString *)aTitle options:(NSArray *)aOptions {
    CGRect rect = [[UIScreen mainScreen] applicationFrame]; // portrait bounds
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        rect.size = CGSizeMake(rect.size.height, rect.size.width);
    }
    if (self = [super initWithFrame:rect])
    {
       
       
        
    }
    return self;
}





/*
- (id)initWithTitle:(NSString *)aTitle
            options:(NSArray *)aOptions
            handler:(void (^)(NSInteger anIndex))aHandlerBlock {
    
    
    
    
   
    
    if(self = [self initWithTitle:aTitle options:aOptions])
        self.handlerBlock = aHandlerBlock;
    
    return self;
}
 */

- (void)setUpTableView
{
}


#pragma mark - Instance Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    
    
    
 
    
  
    
    
    
    side = [[[NSBundle mainBundle] loadNibNamed:@"SideView"
                                         owner:self
                                       options:nil]
           objectAtIndex:0];
    
    CGRect basketTopFrame = side.frame;
    //basketTopFrame.origin.x = basketTopFrame.size.width;
    basketTopFrame.origin.x = -320;
    side.frame = basketTopFrame;
    
    //side.delegate = self;
    
    [aView addSubview: side];
    //side.hidden=YES;
    
    
    
    if (animated) {
        
         _gesView.hidden = NO;
        [self openDrawer];
    }
    
    [_menuTableView reloadData];
    
    
}

-(void)openDrawer
{
    side.hidden=NO;
    _closeView.hidden=YES;
    
    
    
    
    
    CGRect basketTopFrame = side.frame;
    //basketTopFrame.origin.x = basketTopFrame.size.width;
    basketTopFrame.origin.x = 0;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         side.frame = basketTopFrame;
                         // basketBottom.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished)
     {
         NSLog(@"Done! AAA");
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _closeView.hidden=NO;
         });
         
         
     }];
    
    
    
    

}



- (IBAction)closeDrawer:(id)sender {
    
     _gesView.hidden = YES;
    
   
    
    side.hidden=NO;
    _closeView.hidden=YES;
    CGRect basketTopFrame = side.frame;
    //basketTopFrame.origin.x = basketTopFrame.size.width;
    basketTopFrame.origin.x = -320;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         side.frame = basketTopFrame;
                         // basketBottom.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished)
     {
         NSLog(@"Done!");
         
         
         
         
         [self removeFromSuperview];
         
     }];

    
     
    
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DetailCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (DetailCell*)view;
            }
        }
    }
    
    cell1.emptyDate.text=titleArray[indexPath.row] ;
    cell1.img.image= [UIImage imageNamed:imageArray[indexPath.row]];
    
    
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell1;

    
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    //SectionInfo *array = [self.sectionInfoArray objectAtIndex:indexPath.section];
    //return [[array objectInRowHeightsAtIndex:indexPath.row] floatValue];
    
    
    return 60;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"Index:%ld",(long)indexPath.row);
        
        [_delegate didTapSomeButton:vcArray[indexPath.row]];
   
    _gesView.hidden = YES;
    [self closeDrawer:nil];
    
    
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (IBAction)clickProfile:(id)sender {
    
    
    
    [_delegate didTapSomeButton:@"0"];
    
    _gesView.hidden = YES;
    [self closeDrawer:nil];
    
}
    
- (IBAction)clickSettings:(id)sender {
    
     [_delegate didTapSomeButton:@"-1"];
    
    _gesView.hidden = YES;
    
    [self closeDrawer:nil];
    
}

@end
