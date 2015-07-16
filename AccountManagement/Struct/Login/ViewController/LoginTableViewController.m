//
//  LoginViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/25.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "LoginTableViewController.h"
#import "RegisterTableViewController.h"


@interface LoginTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation LoginTableViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAutoLoginInNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.registerBtn.layer.borderColor = [UIColor redColor].CGColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autloginIn:) name:kAutoLoginInNotification object:nil];

    if ([self canEvaluatePolicy]) {
        [self evaluatePolicy];
    }
}

- (IBAction)loginBtnAction:(UIButton *)sender {
    
    //账号 :huwei    密码 :H12345_90
    [self loginWithUserName:self.userNameTextField.text pwd:self.pwdTextField.text];
    
}
- (void)loginWithUserName:(NSString *)userName pwd:(NSString *)pwd
{
    [UserLoginModel logInWithUsernameInBackground:userName password:pwd block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            //登陆成功
            [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RootTabBarViewController"];

            
            [[NSUserDefaults standardUserDefaults] setObject:self.userNameTextField.text  forKey:kUSERNAME];
            [[NSUserDefaults standardUserDefaults] setObject:self.pwdTextField.text  forKey:kUSERPASSWARD];
            
        } else {
            //登陆失败

        }
    }];
}

- (IBAction)registerBtnAction:(UIButton *)sender {
    RegisterTableViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RegisterTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)autloginIn:(NSNotification *)notification
{
    NSString *userName =  [[NSUserDefaults standardUserDefaults] objectForKey:kUSERNAME];
    NSString *userPwd =  [[NSUserDefaults standardUserDefaults] objectForKey:kUSERPASSWARD];
    if (userName.length > 0 && userPwd > 0) {
        [self loginWithUserName:userName pwd:userPwd];
    }
}

- (BOOL)canEvaluatePolicy
{
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    BOOL success;
    
    // test if we can evaluate the policy, this test will tell us if Touch ID is available and enrolled
    success = [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    
    return success;
}

- (void)evaluatePolicy
{
    LAContext *context = [[LAContext alloc] init];
    context.maxBiometryFailures = @(3);
    
    // show the authentication UI with our reason string
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"请验证已有指纹", nil) reply:
     ^(BOOL success, NSError *authenticationError) {
         if (success) {
             [[NSNotificationCenter defaultCenter] postNotificationName:kAutoLoginInNotification object:nil];
         } else {

         }
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
