//
//  WBComposeViewController.m
//  weibo
//
//  Created by xiong on 15/9/30.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBComposeViewController.h"
#import "accountTool.h"
#import "WBtextView.h"
#import <AFNetworking.h>
#import "MBProgressHUD+MJ.h"
#import "WBcomposeToolBar.h"
#import "UIView+Extension.h"
#import "WBcompesePhotoView.h"
#import "WBemotionkeyboard.h"
#import "WBemotionModel.h"
#import "NSString+Emoji.h"
#import "WBemotionTextView.h"


@interface WBComposeViewController ()<UITextViewDelegate,WBcomposeToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) WBemotionTextView *textView;
@property(strong, nonatomic) UIView *tool;
@property(weak, nonatomic) WBcompesePhotoView *photoview;
@property(assign, nonatomic) BOOL swichKeyboard;
@property (nonatomic, strong) WBcomposeToolBar *toolBar;
@property (nonatomic, strong) WBemotionkeyboard *emotionKeyboard;

@property(assign, nonatomic) CGFloat keyboardHeight;/** 控制键盘上放工具条，在切换表情和系统键盘时不动*/

@end

@implementation WBComposeViewController
/**
 *  键盘赖加载
 */
-(WBemotionkeyboard *)emotionKeyboard{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[WBemotionkeyboard alloc] init];
        self.emotionKeyboard.width = self.view.width;
//        self.emotionKeyboard.height = 216;
        self.emotionKeyboard.height = self.keyboardHeight;
    }
    return _emotionKeyboard;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航
//    [self setNavi];
    //设置输入
    [self setTextView];
    [self setepPhotoview];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
#warning    //涉及到view的加载过程，需要再去了解下，为什么放在viewdidload不行，放在这里，又能使用预先设置好的导航栏右边按键颜色
    [self setNavi];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.textView becomeFirstResponder];
}
-(void)setepPhotoview{
    WBcompesePhotoView *photoView = [[WBcompesePhotoView alloc]init];
    photoView.width = self.view.width;
    photoView.height = self.view.height;
    photoView.y = 120;
    [self.textView addSubview:photoView];
    self.photoview = photoView;
    
}
//设置输入
-(void)setTextView{
    WBemotionTextView *textView = [[WBemotionTextView alloc] initWithFrame:self.view.bounds];
    textView.placeholder = @"分享你的任何";
    textView.alwaysBounceVertical = YES;
    textView.font = [UIFont systemFontOfSize:22];
    textView.placeholderColor = [UIColor grayColor];
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:textView];
    self.toolBar = [[WBcomposeToolBar alloc] init];
    self.toolBar.width = self.view.width;
    _toolBar.height = 44;
    _toolBar.x = 0;
    _toolBar.y = self.view.height - _toolBar.height;
    [self.view addSubview:_toolBar];
    _toolBar.delegate = self;
    self.tool = _toolBar;
//    [self.textView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
     ;
    /**
     *  键盘显示通知
     *
     *  @param keyboardH: 键盘高度
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardH:) name:UIKeyboardDidShowNotification object:nil];
    /**
     *  表情通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchEmotion:) name:@"emotionTouch" object:nil];
    /**
     *  表情删除通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteClick) name:@"deleteEmotion" object:nil];
    
}
-(void)deleteClick{
    //回删
    [self.textView deleteBackward];

}
-(void)touchEmotion:(NSNotification *)notification{
//    NSLog(@"----emotion%@",notification.userInfo);
    WBemotionModel *model =  notification.userInfo[@"emotion"];
    [self.textView insertEmotion:model];
//    self.textView.font = [UIFont systemFontOfSize:23];
    /**
     *  表情选中，也去调用textchange，只有表情也能发送
     */
    [self textChange];
}
/**
 *  通知键盘显示，获取高度
 */
-(void)keyboardH:(NSNotification *)notification{
   
    NSDictionary *height = notification.userInfo;
    CGRect rect = [height[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = rect.size.height;
    
}
-(void)changeFrame:(NSNotification *)notification{
    if (self.swichKeyboard) return;
    NSDictionary *useinfo = notification.userInfo;
    /**userInfo = {
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 252}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 442}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 694}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 316}, {320, 252}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 568}, {320, 252}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     }}
     */
    CGRect rec = [useinfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double animation = [useinfo[UIKeyboardAnimationDurationUserInfoKey ] doubleValue];
    [UIView animateWithDuration:animation animations:^{
        self.tool.y = rec.origin.y -44;
    
    }];
    
}
-(void)textChange{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//设置导航
-(void)setNavi{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;



    NSString *nameStr = [accountTool account].name;
    if (nameStr) {
        UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        titleView.numberOfLines = 0;
        titleView.textAlignment = NSTextAlignmentCenter;
        
        NSString *str = [NSString stringWithFormat:@"发微博\n%@",nameStr];
        //带属性的字符串（颜色 字体。。。）
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:nameStr]];
        
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[str rangeOfString:nameStr]];
        titleView.attributedText = attr;
        //  titleView.text = str;
        self.navigationItem.titleView = titleView;
    }else{
        self.title = @"发微博";
    }

}
-(void)send{
//    NSLog(@"%lu",_photoview.photo.count);
//    // URL: https://api.weibo.com/2/statuses/update.json
//    // 参数:
//    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
//    /**	pic false binary 微博的配图。*/
//    /**	access_token true string*/
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
//    prams[@"access_token"] =[accountTool account].access_token;
//    prams[@"status"] = self.textView.text;
//    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:prams success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//        
//    
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        NSLog(@"失败-%@",error);
//        [MBProgressHUD showError:@"失败"];
//    }];
//
//  [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_photoview.photo.count) {
        [self sendWithImage];
    }else{
        [self sendWithNilImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送有图
 */
-(void)sendWithImage{
    
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	pic false binary 微博的配图。*/
    /**	access_token true string*/
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    prams[@"access_token"] =[accountTool account].access_token;
    prams[@"status"] = self.textView.text;

    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:prams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       UIImage *image = [_photoview.photo firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 0.5) ;
//        [formData appendPartWithFormData:data name:@"pic"];
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
//        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"失败-%@",error);
        [MBProgressHUD showError:@"失败"];
    }];
}
     
     
/**
 *  发送无图
 */
-(void)sendWithNilImage{
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	pic false binary 微博的配图。*/
    /**	access_token true string*/
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    prams[@"access_token"] =[accountTool account].access_token;
    prams[@"status"] = self.textView.fulltext;
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:prams success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"失败-%@",error);
        [MBProgressHUD showError:@"失败"];
    }];
}


-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(void)composeToolBar:(WBcomposeToolBar *)toolbar didclickButton:(WBcomposeToolBarButtonType)btnType{
    switch (btnType) {
        case WBcomposeToolBarButtonTypeCamera:
            [self openCamera];
            break;
        case WBcomposeToolBarButtonTypePicture:
            [self openAlbum];
            break;
        case WBcomposeToolBarButtonTypeTrend:
//            NSLog(@"@");
            break;
        case WBcomposeToolBarButtonTypeMention:
//            NSLog(@"话题");
            break;
        case WBcomposeToolBarButtonTypeEmotion:
//            NSLog(@"表情");
            [self sendEmotion];
            break;
            
        default:
            break;
    }
    
}
-(void)openCamera{
    [self openImagePicker:UIImagePickerControllerSourceTypeCamera];
}
-(void)openAlbum{
    [self openImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}
-(void)openImagePicker:(UIImagePickerControllerSourceType)type{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
-(void)sendEmotion{

   
    if (self.textView.inputView == nil) {
        //表情键盘时图标取反显示键盘图标
        self.toolBar.showKeyboard = YES;
         //弹出表情键盘
         self.textView.inputView = self.emotionKeyboard;
        
    }else{
        //系统键盘
        self.textView.inputView = nil;
        //系统键盘时图标取反显示表情图标
        self.toolBar.showKeyboard = NO;
    }
    self.swichKeyboard = YES;
    /**
     *  键盘切换时会有一个隐藏和显示的动画，其y值也会改变，工具条也会跟着动画；为了取消动画设置一个bool标记；这样就能切换完键盘设置为yes，这时就会去工具条设置Y值，然而工具条有一个判断，当标记是yes的时候直接return，不执行改变y值，就能保证其不会动画
     */
    /**
     *      [self.textView endEditing:YES]; 关闭键盘
     *       self.swichKeyboard = NO; 这个bool值是为了不让工具条随着键盘弹出和隐藏时跟随其动画
     *  [self.textView becomeFirstResponder];成为第一响应者，这两条命令执行完，键盘才会切换，不然是没有反应的，只有隐藏键盘再弹出键盘才会改变键盘；
     */
    [self.textView endEditing:YES];
    
    // 结束切换键盘
    self.swichKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.textView becomeFirstResponder];
 
    });


}
//-(void)openCamera{
//    
//}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    NSLog(@"%@",info); 
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photoview addphoto:image];
}
@end
