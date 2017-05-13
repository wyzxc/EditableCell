//
//  EditableCell.h
//  EditableCell
//
//  Created by 蔡强 on 2017/5/13.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditableCellModel.h"

@class EditableCell;
@protocol EditableCellDelegate <NSObject>

- (void)editableCell:(EditableCell *)editableCell valueTextFieldTextDidChange:(UITextField *)sender;

@end

@interface EditableCell : UITableViewCell

@property (nonatomic,strong) EditableCellModel *model;
@property (nonatomic,weak) id <EditableCellDelegate> delegate;

@end
