//
//  DynamicDetailTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "DynamicDetailTableViewCell.h"

@implementation DynamicDetailTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labAuthor];
    [self.contentView addSubview:self.labTime];
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.webView];

}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width - 20, 17)];
        _labTitle.font = [UIFont boldSystemFontOfSize:16];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
    }
    return _labTitle;
}

- (UILabel *)labAuthor{
    if (!_labAuthor) {
        _labAuthor = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom +10, (DeviceSize.width - 20)/2, 13)];
        _labAuthor.font = [UIFont systemFontOfSize:13];
        _labAuthor.textColor = [UIColor colorWithHEX:0x999999];
    }
    return _labAuthor;
}

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(self.labAuthor.right, self.labTitle.bottom +10, (DeviceSize.width - 20)/2, 13)];
        _labTime.font = [UIFont systemFontOfSize:13];
        _labTime.textColor = [UIColor colorWithHEX:0x999999];
        _labTime.textAlignment = NSTextAlignmentRight;
    }
    return _labTime;
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.labAuthor.bottom +10, DeviceSize.width -20, 145)];
    }
    return _imgLogo;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(10, self.imgLogo.bottom +10, DeviceSize.width -20, 0)];
        _labDetail.font = [UIFont systemFontOfSize:13];
        _labDetail.textColor = [UIColor colorWithHEX:0x888888];
        _labDetail.numberOfLines = 0;
    }
    return _labDetail;
}

//赋值
- (CGFloat )confingWithModel:(NSDictionary *)dic{
    self.labTitle.text = dic[@"title"];
    self.labAuthor.text = dic[@"author"];
    self.labTime.text = dic[@"addtime"];
    //self.labDetail.text = dic[@"content"];
    [self.imgLogo sd_setImageWithURL:[NSURL URLWithString:dic[@"thumb"]] placeholderImage:[UIImage imageNamed:@""]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:dic[@"share_url"]]];
    self.webView.height = DeviceSize.height - 64 - 44 - self.imgLogo.bottom;
    [self.webView loadRequest:request];
    

    return self.webView.bottom;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, self.imgLogo.bottom +10, DeviceSize.width -20, 0)];
        _webView.backgroundColor = [UIColor colorWithHEX:0xffffff];
        
    }
    return _webView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
