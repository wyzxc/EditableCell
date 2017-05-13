//
//  EditableCellModel.h
//  EditableCell
//
//  Created by 蔡强 on 2017/5/13.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditableCellModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *range;
@property (nonatomic,copy) NSString *value;

/** 是否在编辑状态 */
@property (nonatomic,assign) BOOL isEditState;

@end
