# WYDocumentBrowser
iOS PDF文件预览的几种方法

## PDF文档预览的几种方式
* UIWebView
* QLPreviewController
* UIDocumentInteractionController
* CGContexDrawPDFPage

先看效果：
![image](http://t2.qpic.cn/mblogpic/79119cdbd8aee5756df0/460)

### UIWebView

苹果的webView组件可以预览各种格式的文件，支持在线预览和本地预览，相比于安卓的webView控件简直就是一大神器，UIWebview使用起来也非常简单

```
NSString *filePath = [[NSBundle mainBundle] pathForResource:@"阿里巴巴java开发手册" ofType:@"pdf"];
NSURL *url = [NSURL fileURLWithPath:filePath];  
_webView.scalesPageToFit = YES;
NSURLRequest *request = [NSURLRequest requestWithURL:url];
[self.webView loadRequest:request];
```
### QLPreviewController

``QLPreviewController``是系统自带的文件预览控制器,QL全称``quick look``快速查看的意思，要使用QLPreviewController先得在文件中导入头文件``#import <QuickLook/QuickLook.h>
``，并且实现其代理方法``QLPreviewControllerDelegate``

```
- (QLPreviewController *)qlVc{
if (!_qlVc) {
_qlVc = [[QLPreviewController alloc] init];
_qlVc.delegate = self;
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
NSString *filePath12 = [[NSBundle mainBundle] pathForResource:@"52CB015AA5D0A2330C59C0600469CA8F2" ofType:@"mp4"];

_files = @[filePath1,filePath2,filePath3,filePath4,filePath5,filePath6,filePath7,filePath8,filePath9,filePath10,filePath11,filePath12];

// push跳转预览页面 也可以present
[self.navigationController pushViewController:self.qlVc animated:YES];

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

```
* QLPreviewController只能加载本地文件，不支持在线预览。显示效果比wenView要好。
* 以前认为QLPreviewController只能加载PDF、word之类的文件，没想到也能加载本地音视频文件
* 支持多文件预览，支持横滑切换
* 系统自带分享功能，可以在预览的同时将文件分享出去

### UIDocumentInteractionController
使用UIDocumentInteractionController预览文件也得遵循``UIDocumentInteractionControllerDelegate``代理方法,UIDocumentInteractionController本身并不是一个控制器类，它直接继承``NSObject``，所以就不能直接push或者模态跳转了，所以需要使用它类方法提供的模态跳转函数

```
_docVc = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:_files[0]]];
_docVc.delegate = self;
[_docVc presentPreviewAnimated:YES];

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
```
* 预览效果和QLPreviewController一样，但不支持多文件预览
* 同样支持文件共享功能，在预览之前可以选择先跳转预览页面还是先弹出分享面板。

### CGContexDrawPDFPage
利用``CGContexDrawPDFPage``和``UIPageViewController``实现翻页浏览功能，这种方法只能加载本地的PDF文件，但是显示效果比其他几种炫酷很多。具体使用方法参考[iOS开发笔记——PDF的显示和浏览](http://blog.csdn.net/yiyaaixuexi/article/details/7645725)这篇博客。

