//
//  AlbumBackgroundView.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/18.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "AlbumBackgroundView.h"

@implementation AlbumBackgroundView
{
    UIImageView *_imageView;//图片显示控件
    CIContext *_context;//Core Image上下文
    CIFilter *_gaussianBlurFilter;//高斯模糊滤镜
    CIImage *_image;//我们要编辑的图像
}

@synthesize bgImageName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bgImageName = @"ablum";
        //创建图片显示控件
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //初始化CIContext
    //创建基于CPU的图像上下文
    //    NSNumber *number=[NSNumber numberWithBool:YES];
    //    NSDictionary *option=[NSDictionary dictionaryWithObject:number forKey:kCIContextUseSoftwareRenderer];
    //    _context=[CIContext contextWithOptions:option];
    _context=[CIContext contextWithOptions:nil];//使用GPU渲染，推荐,但注意GPU的CIContext无法跨应用访问，例如直接在UIImagePickerController的完成方法中调用上下文处理就会自动降级为CPU渲染，所以推荐现在完成方法中保存图像，然后在主程序中调用
    //    EAGLContext *eaglContext=[[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES1];
    //    _context=[CIContext contextWithEAGLContext:eaglContext];//OpenGL优化过的图像上下文
    
    //取得滤镜
    _gaussianBlurFilter=[CIFilter filterWithName:@"CIGaussianBlur"];
    
    //取得选择图片
    UIImage *selectedImage = [UIImage imageNamed:bgImageName];
    _imageView.image = selectedImage;
    //初始化CIImage源图像
    _image = [CIImage imageWithCGImage:selectedImage.CGImage];
    [_gaussianBlurFilter setValue:_image forKey:@"inputImage"];//设置滤镜的输入图片
    [_gaussianBlurFilter setValue:[NSNumber numberWithFloat:40.0f] forKey:@"inputRadius"];//设置模糊程度参数
    [self setImage];
}

#pragma mark 将输出图片设置到UIImageView
-(void)setImage{
    CIImage *outputImage = [_gaussianBlurFilter outputImage];//取得输出图像
    CGImageRef temp = [_context createCGImage:outputImage fromRect:[outputImage extent]];
    _imageView.image = [UIImage imageWithCGImage:temp];//转化为CGImage显示在界面中

    CGImageRelease(temp);//释放CGImage对象
}

- (void)changeAlbumWithImageName:(NSString *)newImageName
{
    bgImageName = newImageName;
    [self setNeedsDisplay];
}

@end
