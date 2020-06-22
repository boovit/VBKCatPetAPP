//
//  YHPetMoreHistoryVC+Weight.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/26.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetMoreHistoryVC+Weight.h"

#define YH_MoreHistory_Time_Tag     @"YH_MoreHistory_Time_Tag"
#define YH_MoreHistory_Weight_Tag   @"YH_MoreHistory_Weight_Tag"

@implementation YHPetMoreHistoryVC (Weight)
-(NSMutableArray*)weightDataSource
{
    NSMutableArray *array = [NSMutableArray array];
    YHInfoItemData *nameItem = [[YHInfoItemData alloc] init];
    nameItem.title = @"体重:";
    nameItem.placeholder = @"点击输入";
    nameItem.tag = YH_MoreHistory_Weight_Tag;
    [array addObject:nameItem];
    
    YHInfoItemData *birthdayItem = [[YHInfoItemData alloc] init];
    birthdayItem.title = @"称量时间:";
    birthdayItem.placeholder = @"点击选择";
    birthdayItem.tag = YH_MoreHistory_Time_Tag;
    [array addObject:birthdayItem];
    
    return array;
}

-(void)configTableView:(UITableView*)tableView
                  cell:(YHInfoTextTableCell*)cell
             indexPath:(NSIndexPath*)indexPath
            dataSource:(NSMutableArray*)dataSource
{
    YHInfoItemData *item = [dataSource safe_objectAtIndex:indexPath.row];
    if (__isStrEmpty(item.intro)) {
        [cell refreshTitle:item.title intro:item.placeholder poster:nil];
    }else{
        [cell refreshTitle:item.title intro:item.intro poster:nil];
    }
    
}

-(void)didSelectedWeightTableView:(UITableView*)tableView
                        indexPath:(NSIndexPath*)indexPath
                       dataSource:(NSMutableArray*)dataSource
{
    YHInfoItemData *item = [dataSource safe_objectAtIndex:indexPath.row];
    if ([item.tag isEqualToString:YH_MoreHistory_Weight_Tag]) {
        [self showInputViewWithTag:YH_MoreHistory_Weight_Tag];
    }else if([item.tag isEqualToString:YH_MoreHistory_Time_Tag]){
        [self showDatePickViewTag:YH_MoreHistory_Time_Tag indexPath:indexPath];
    }
}

-(void)modifiyData:(NSString*)text
               tag:(NSString*)tag
        dataSource:(NSMutableArray*)dataSource
{
    YHInfoItemData *itemData = [self cellItemDataByTag:tag];
    itemData.intro = text;
    NSInteger row = [dataSource indexOfObject:itemData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self reloadTableViewIndexPath:indexPath];
}

-(YHPetWeightHistoryData*)assambleItemDataWithDataSource:(NSMutableArray*)dataSource
{
    YHPetWeightHistoryData *data = [[YHPetWeightHistoryData alloc] init];
    for (YHInfoItemData *cellData in dataSource) {
        if ([cellData.tag isEqualToString:YH_MoreHistory_Time_Tag]) {
            data.last_record = cellData.intro;
        }else if ([cellData.tag isEqualToString:YH_MoreHistory_Weight_Tag]){
            data.weight = [NSNumber numberWithInteger:[cellData.intro integerValue]];
        }
    }
    return data;
}
@end
