//
//  SGHorseRaceLampView.m
//  SGHorseRaceLampView
//
//  Created by Sorgle on 2017/6/17.
//  Copyright © 2017年 Sorgle. All rights reserved.
//
//  - - - - - - - - - - - - - - 交流QQ：1357127436 - - - - - - - - - - - - - - - //
//
//  - - 如在使用中, 遇到什么问题或者有更好建议者, 请于 kingsic@126.com 邮箱联系 - - - - //
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//  - - GitHub下载地址 https://github.com/kingsic/SGAnimation.git - — - - - - - //
//
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //

#import "SGHorseRaceLampView.h"

@interface SGHorseRaceLampView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *contentLabel;
//@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation SGHorseRaceLampView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupSubviews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];
    [self setupSubviews];
}

- (void)initialization {
    _scrollTimeInterval = 20;
    _titleFont = [UIFont systemFontOfSize:15];
}

- (void)setupSubviews {
    [self addSubview:self.imageView];
    [self addSubview:self.contentView];
    //    [self addSubview:self.closeBtn];
    [_contentView addSubview:self.contentLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat spacing = 40;
    
    CGFloat imageViewW = 0;//_imageView.image.size.width;
    CGFloat imageViewH = _imageView.image.size.height;
    if (imageViewH > self.frame.size.height) {
        imageViewH = self.frame.size.height - spacing;
    }
    CGFloat imageViewX = 0;
    CGFloat imageViewY = 0.5 * (self.frame.size.height - imageViewH);
    _imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    CGFloat contentViewX = CGRectGetMaxX(_imageView.frame) + 10;
    CGFloat contentViewY = 0;
    CGFloat contentViewW = self.frame.size.width - contentViewX - spacing;
    CGFloat contentViewH = self.frame.size.height;
    _contentView.frame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
    
    CGFloat textWidth = [self SG_widthWithString:_contentLabel.text font:self.titleFont];
    CGFloat contentLabelX = 0;
    CGFloat contentLabelY = 0;
    CGFloat contentLabelW = textWidth + _contentView.frame.size.width;
    CGFloat contentLabelH = _contentView.frame.size.height;
    _contentLabel.frame = CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
    
    if (textWidth > _contentView.frame.size.width) {
        [self addAnimationWithFirstContentLabel];
    }
}

- (void)closeHorseView{
    if (self.closeBlock) {
        self.closeBlock();
    }
}

- (CGFloat)SG_widthWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName: font};
    CGFloat stringWidth = [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    return stringWidth;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

//- (UIButton *)closeBtn{
//    if (!_closeBtn) {
//        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 0, 40, self.height)];
//        [_closeBtn addTarget:self action:@selector(closeHorseView) forControlEvents:UIControlEventTouchUpInside];
//        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
//        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        [_closeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    }
//
//    return _closeBtn;
//}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentView)];
        [_contentView addGestureRecognizer:tap];
    }
    return _contentView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
    }
    return _contentLabel;
}

- (void)tapContentView {
    if (self.selectedBlock) {
        self.selectedBlock();
    }
}



- (void)addAnimationWithFirstContentLabel {

    @weakify(self)
    [UIView animateWithDuration:self.scrollTimeInterval delay:1 options:(UIViewAnimationOptionCurveLinear) animations:^{
        @strongify(self)
        CGFloat width = [self SG_widthWithString:_contentLabel.text font:self.titleFont];
        CGRect tempFrame = _contentLabel.frame;
        tempFrame.origin.x = - width;
        _contentLabel.frame = tempFrame;
        
    } completion:^(BOOL finished) {
        @strongify(self)
        [self addAnimationWithContentLabel];
    }];
}

- (void)addAnimationWithContentLabel {
    CGFloat width = [self SG_widthWithString:_contentLabel.text font:self.titleFont];
    CGFloat contentLabelX = _contentView.frame.size.width;
    CGFloat contentLabelY = 0;
    CGFloat contentLabelW = width;
    CGFloat contentLabelH = _contentView.frame.size.height;
    _contentLabel.frame = CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
    
    @weakify(self)
    [UIView animateWithDuration:self.scrollTimeInterval delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        @strongify(self)
        CGRect tempFrame = _contentLabel.frame;
        tempFrame.origin.x = - width;
        self.contentLabel.frame = tempFrame;
        
    } completion:^(BOOL finished) {
       @strongify(self)
        [self addAnimationWithContentLabel];
    }];
}

- (void)setImageNage:(NSString *)imageNage {
    _imageNage = imageNage;
    if (imageNage) {
        _imageView.image = [UIImage imageNamed:imageNage];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (title) {
        _contentLabel.text = title;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    if (titleColor) {
        _contentLabel.textColor = titleColor;
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    if (titleFont) {
        _contentLabel.font = titleFont;
        _titleFont = titleFont;
    }
}

- (void)setScrollTimeInterval:(CGFloat)scrollTimeInterval {
    _scrollTimeInterval = scrollTimeInterval;
}


@end

