//
//  YHPetMoreHistoryVC+Weight.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/26.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetMoreHistoryVC.h"
#import "YHInfoTextTableCell.h"

@interface YHPetMoreHistoryVC (Weight)
-(NSMutableArray*)weightDataSource;
-(void)configTableView:(UITableView*)tableView
                  cell:(YHInfoTextTableCell*)cell
             indexPath:(NSIndexPath*)indexPath
            dataSource:(NSMutableArray*)dataSource;
-(void)didSelectedWeightTableView:(UITableView*)tableView
                        indexPath:(NSIndexPath*)indexPath
                       dataSource:(NSMutableArray*)dataSource;
-(void)modifiyData:(NSString*)text
               tag:(NSString*)tag
        dataSource:(NSMutableArray*)dataSource;
-(YHPetWeightHistoryData*)assambleItemDataWithDataSource:(NSMutableArray*)dataSource;
@end
