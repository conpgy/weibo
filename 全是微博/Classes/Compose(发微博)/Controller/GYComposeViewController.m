//
//  GYComposeViewController.m
//  全是微博
//
//  Created by 彭根勇 on 14-7-8.
//  Copyright (c) 2014年 conpgy. All rights reserved.
//

#import "GYComposeViewController.h"
#import "GYComposeToolBar.h"
#import "GYComposePhotosView.h"
#import "GYSendStatusParam.h"
#import "GYAccountTool.h"
#import "GYAccount.h"
#import "GYStatusTool.h"
#import "GYEmotionKeyboard.h"
#import "GYEmotion.h"
#import "GYEmotionTool.h"
#import "GYEmotionTextView.h"

@interface GYComposeViewController ()<GYComposeToolBarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) GYEmotionTextView *composeView;

@property (nonatomic, weak) GYComposePhotosView *photosView;

@property (nonatomic, weak) GYComposeToolBar *toolbar;

@property (nonatomic, strong) GYEmotionKeyboard *emotionKeyboard;

/**
 *  是否正在键盘
 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;


@end

@implementation GYComposeViewController

#pragma mark - 懒加载

-(GYEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        _emotionKeyboard = [GYEmotionKeyboard keyboard];
        _emotionKeyboard.width = GYScreenW;
        _emotionKeyboard.height = 216;
    }
    
    return _emotionKeyboard;
}

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
    
    // 监听表情键盘表情的选中
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:GYEmotionDidSelectedNotification object:nil];
    
    // 监听表情键盘删除按钮的点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDeleteButtonDidClick:) name:GYEmotionKeyboardDidClickDeleteButtonNotification object:nil];
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
    GYComposeToolBar *toolbar = [[GYComposeToolBar alloc] init];
    self.toolbar = toolbar;
    toolbar.delegate = self;
    
    // 设置frame
    toolbar.x = 0;
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    
    [self.view addSubview:toolbar];
}

/**
 *  设置编辑微博控件
 */

- (void)setupComposeView
{
    GYEmotionTextView *composeView = [[GYEmotionTextView alloc] init];
    composeView.delegate = self;
    self.composeView = composeView;
    [self.view addSubview:composeView];
    
    // 设置属性
    composeView.frame = self.view.bounds;
    composeView.placeholder = @"分享新鲜事...";
    composeView.alwaysBounceVertical = YES;
    
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
 *  监听发布微博按钮点击
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
    param.status = self.composeView.realText;
    
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
    param.status = self.composeView.realText;
    
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
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
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
    self.changingKeyboard = YES;
    
    if (self.composeView.inputView) {
        self.composeView.inputView = nil;
    } else {
        self.composeView.inputView = self.emotionKeyboard;
    }
    
    [self.composeView resignFirstResponder];
    self.changingKeyboard = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.composeView becomeFirstResponder];
    });
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

#pragma mark - 监听键盘

/**
 *  键盘将要显示
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 计算键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘的高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
    }];
}

/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 计算键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (self.isChangingKeyboard) return;
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - 监听表情选中

- (void)emotionDidSelected:(NSNotification *)note
{
    GYEmotion *emotion = note.userInfo[GYSelectedEmotion];
    [self.composeView appendEmotion:emotion];
    
    // 检测文字长度
    [self textViewDidChange:self.composeView];
}

- (void)emotionDeleteButtonDidClick:(NSNotification *)note
{
    [self.composeView deleteBackward];
}

@end
