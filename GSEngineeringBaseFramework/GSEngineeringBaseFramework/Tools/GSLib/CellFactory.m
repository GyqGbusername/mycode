//
//  CellFactory.m
//  MFSC
//
//  Created by mfwl on 16/3/21.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "CellFactory.h"

@implementation CellFactory

+ (GSBaseTableViewCell *)creatCellWithClassName:(NSString *)cellClassName cellModel:(GSBaseModel *)cellModel indexPath:(NSIndexPath *)indexPath {
    GSBaseTableViewCell *cell = nil;
    
    // 通过反射来定义cell，当遇到cell拓展时，可以直接用字符串反射，无需修改该工厂方法
    
//    Class classForCell = NSClassFromString(cellClassName);
    
    // 初始化目标cell
    
    cell = [[[NSBundle mainBundle] loadNibNamed:cellClassName owner:nil options:nil] firstObject];
    
    if (cellModel) {
        cell.gsBaseModel = cellModel;
    }
    
    return cell;
    
//    return [cell initWithModel:cellModel];
}





@end
