//
//  YHFileUploadOP.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/15.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHBaseOP.h"
#import "YHBaseData.h"

@interface YHUploadFileItem : JSONModel
@property(nonatomic,copy)NSString *onLineUrl;
@property(nonatomic,copy)NSString *originalFilename;
@end

@protocol YHUploadFileItem
@end

@interface YHFileUploadRespData : YHBaseData
@property(nonatomic,strong)NSMutableArray<YHUploadFileItem> *result;
@end

@interface YHFileUploadOP : YHBaseOP
-(void)uploadFiles:(NSArray*)files url:(NSString *)url param:(NSDictionary *)param completeBlock:(void (^)(YHFileUploadRespData *))completeBlock errorBlock:(void (^)(NSError *))errorBlock;
@end
