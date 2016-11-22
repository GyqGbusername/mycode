//
//  CellFactory.h
//  MFSC
//
//  Created by mfwl on 16/3/21.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GSBaseTableViewCell.h"

@interface CellFactory : NSObject


+ (GSBaseTableViewCell *)creatCellWithClassName:(NSString *)cellClassName cellModel:(GSBaseModel *)cellModel indexPath:(NSIndexPath *)indexPath;


@end
