//
//  GYComposeViewController.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-8.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYComposeViewController.h"
#import "GYTextView.h"
#import "GYComposeToolBar.h"
#import "GYComposePhotosView.h"
#import "GYSendStatusParam.h"
#import "GYAccountTool.h"
#import "GYAccount.h"
#import "MBProgressHUD+MJ.h"
#import "GYStatusTool.h"

@interface GYComposeViewController ()<GYComposeToolBarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) GYTextView *composeView;

@property (nonatomic, weak) GYComposePhotosView *photosView;

@end

@implementation GYComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNavBar];
    
    // 添加编辑微博控件
    [self setupComposeView];
    
    // 添加工具条
    [self setupComposeToolBar];
    
    // 添加显示图片的控件
    [self setupPhotosView];
}

/**
 *  添加显示图片的控件在发微博控件中
 */
- (void)setupPhotosView
{
    GYComposePhotosView *photosView = [[GYComposePhotosView alloc] init];
    [self.composeView addSubview:photosView];
    self.photosView = photosView;
    
    // 设置frame
    photosView.y = 70;
    photosView.width = self.composeView.width;
    photosView.height = self.composeView.height;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.composeView becomeFirstResponder];
}

/**
 *  添加工具条
 */

- (void)setupComposeToolBar
{
    GYComposeToolBar *toolBar = [[GYComposeToolBar alloc] init];
    toolBar.delegate = self;
    self.composeView.inputAccessoryView = toolBar;
    
    // 设置frame
    toolBar.width = self.view.width;
    toolBar.height = 44;
}

/**
 *  设置编辑微博控件
 */

- (void)setupComposeView
{
    GYTextView *composeView = [[GYTextView alloc] init];
    composeView.delegate = self;
    self.composeView = composeView;
    [self.view addSubview:composeView];
    
    // 设置属性
    composeView.frame = self.view.bounds;
    composeView.placeholder = @"分享新鲜事...";
    composeView.alwaysBounceVertical = YES;
}

- (void)setNavBar
{
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发布微博
 */
- (void)send
{
    // 发布微博
    if (self.photosView.images.count > 0) {
        // 发送有图片的微博
        [self sendStatusWithImage];
    } else {
        // 发送没有图片的微博
        [self sendStatusWithoutImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发布带图片的微博
 */
- (void)sendStatusWithImage
{
    // 设置微博参数
    GYSendStatusParam *param = [GYSendStatusParam param];
    param.status = self.composeView.text;
    
    UIImage *image = self.photosView.images[0];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    // 发布带图片的微博
    [GYStatusTool sendStatusesWithParam:param imageData:imageData success:^(GYSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发布成功"];
        GYLog(@"发布成功");
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发布失败"];
        GYLog(@"发布失败");
    }];
}

/**
 *  发布没有图片的微博
 */
- (void)sendStatusWithoutImage
{
    // 设置发微博参数
    GYSendStatusParam *param = [GYSendStatusParam param];
    param.status = self.composeView.text;
    
    // 发布微博
    [GYStatusTool sendStatusesWithParam:param success:^(GYSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发布成功"];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD showError:@"发布失败"];
    }];
}

#pragma mark - UITextViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing: YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = (textView.text.length != 0);
}

#pragma mark - GYComposeToolBarDelegate

-(void)composeToolBar:(GYComposeToolBar *)toolBar DidClickButton:(GYComposeToolBarButtonType)buttonType
{
    switch (buttonType) {
        case GYComposeToolBarButtonTypeCamera:
            [self openCamera];
            break;
            
        case GYComposeToolBarButtonTypePicture:
            [self openAlbum];
            break;
            
        case GYComposeToolBarButtonTypeEmotion:
            [self openEmotion];
            break;
            
        default:
            break;
    }
}

/**
 *  打开相机
 */

- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [MBProgressHUD showError:@"当前设备不支持拍照功能"];
        return;
    }
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */

- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  显示表情页
 */

- (void)openEmotion
{
    GYLog(@"打开表情页");
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 添加图片到编辑微博的相册控件中
    [self.photosView addImage:image];
}

@end
