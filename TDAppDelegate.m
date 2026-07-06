#import "TDAppDelegate.h"
#import "TDRootViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation TDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    TDRootViewController *rootVC = [[TDRootViewController alloc] init];
    _window.rootViewController = rootVC;
    [_window makeKeyAndVisible];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_window animated:YES];
    
    hud.label.text = @"Testing Framework...";
    hud.detailsLabel.text = @"Loading, please wait";
   // hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:_window animated:YES];
        
    });    

    return YES;
}

@end