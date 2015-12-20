//
//  CommentsListModel.h
//  3HDoctorClient
//
//  Created by 郑彦华 on 15/12/20.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
//addtime = "2015-11-13";
//content = "\U56de\U590d13311112222\Uff1a\U6bd4\U8f83";
//id = 67;
//pics =             (
//);
//uid = 3;
//uname = 13311112222;
//upic = "http://123.57.231.12:85/Public/uploads/mface/56406820133d9.jpg";
//utype = 0;
@interface CommentsListModel : BaseModel
@property (nonatomic, copy) NSString * addtime;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, retain) NSArray * pics;
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * uname;
@property (nonatomic, copy) NSString * upic;
@property (nonatomic, copy) NSString * utype;
@end
