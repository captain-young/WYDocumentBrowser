//
//  ViewController.m
//  DocumentBrowserDemo
//
//  Created by Apple on 2017/6/13.
//  Copyright © 2017年 White-Young. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import <QuickLook/QuickLook.h>
#import "ZPDFReaderController.h"
@interface ViewController ()<QLPreviewControllerDelegate,QLPreviewControllerDataSource,UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) QLPreviewController *qlVc;
@property (nonatomic, strong) NSArray *files;

@property (nonatomic, strong) UIDocumentInteractionController *docVc;

@end

@implementation ViewController

- (QLPreviewController *)qlVc{
    if (!_qlVc) {
        _qlVc = [[QLPreviewController alloc] init];
        _qlVc.delegate = self;
        _qlVc.dataSource = self;
    }return _qlVc;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"阿里巴巴java开发手册" ofType:@"pdf"];
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"excel操作大全" ofType:@"doc"];
    NSString *filePath3 = [[NSBundle mainBundle] pathForResource:@"H5,JS资源" ofType:@"txt"];
    NSString *filePath4 = [[NSBundle mainBundle] pathForResource:@"Xcode快捷键" ofType:@"rtf"];
    NSString *filePath5 = [[NSBundle mainBundle] pathForResource:@"华为推荐书目" ofType:@"xls"];
    NSString *filePath6 = [[NSBundle mainBundle] pathForResource:@"大话Swift 3.0（上）" ofType:@"key"];
    NSString *filePath7 = [[NSBundle mainBundle] pathForResource:@"抵押贷款" ofType:@"numbers"];
    NSString *filePath8 = [[NSBundle mainBundle] pathForResource:@"Page" ofType:@"pages"];
    NSString *filePath9 = [[NSBundle mainBundle] pathForResource:@"iOS" ofType:@"ppt"];
    NSString *filePath10 = [[NSBundle mainBundle] pathForResource:@"Beyond - 真的爱你" ofType:@"mp3"];
    NSString *filePath11 = [[NSBundle mainBundle] pathForResource:@"aa" ofType:@"jpg"];
    NSString *filePath12 = [[NSBundle mainBundle] pathForResource:@"4AC51038CA4411EED492019D6EA79A50" ofType:@"mp4"];
    
    _files = @[filePath1,filePath2,filePath3,filePath4,filePath5,filePath6,filePath7,filePath8,filePath9,filePath10,filePath11,filePath12];

}

- (IBAction)webView:(UIButton *)sender {
    WebViewController *webVc = [[WebViewController alloc] init];
    [self.navigationController pushViewController:webVc animated:YES];
}

- (IBAction)qlPreviewController:(UIButton *)sender {
    [self.navigationController pushViewController:self.qlVc animated:YES];
}

- (IBAction)uiDocmentInteractionController:(UIButton *)sender {
    _docVc = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:_files[0]]];
    _docVc.delegate = self;
    [_docVc presentPreviewAnimated:YES];
}

- (IBAction)cgContexDrawPDFPage:(UIButton *)sender {
    ZPDFReaderController *pdfVc = [[ZPDFReaderController alloc] init];
    pdfVc.titleText = @"阿里巴巴java开发手册";
    pdfVc.fileName =  @"阿里巴巴java开发手册.pdf";
    [self.navigationController pushViewController:pdfVc animated:YES];
}

#pragma mark -- UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}
- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller
{
    return self.view;
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
{
    return self.view.frame;
}
#pragma mark  QLPreviewControllerDelegate
- (void)previewControllerWillDismiss:(QLPreviewController *)controller{
    
}
- (void)previewControllerDidDismiss:(QLPreviewController *)controller{
    
}
- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item{
    return YES;
}
- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id <QLPreviewItem>)item inSourceView:(UIView * _Nullable * __nonnull)view{
    return self.view.frame;
}
- (UIImage *)previewController:(QLPreviewController *)controller transitionImageForPreviewItem:(id <QLPreviewItem>)item contentRect:(CGRect *)contentRect{
    UIImage *image = [UIImage imageNamed:@"aa.jpg"];
    return image;
}

- (UIView* _Nullable)previewController:(QLPreviewController *)controller transitionViewForPreviewItem:(id <QLPreviewItem>)item NS_AVAILABLE_IOS(10_0){
    return nil;
}

#pragma mark QLPreviewControllerDataSource
//返回文件的个数
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return _files.count;
}

//加载需要显示的文件 
- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    
    return [NSURL fileURLWithPath:_files[index]];
}


@end
