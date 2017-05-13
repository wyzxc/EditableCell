//
//  EditableCell.m
//  EditableCell
//
//  Created by 蔡强 on 2017/5/13.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "EditableCell.h"

@interface EditableCell ()

@end

@implementation EditableCell{
    UILabel *_nameLabel;
    UILabel *_rangeLabel;
    UITextField *_valueTextField;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // UI搭建
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (int i = 0; i < 2; i ++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i * ([UIScreen mainScreen].bounds.size.width / 3), 0, [UIScreen mainScreen].bounds.size.width / 3, 40)];
        [self addSubview:label];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
            {
                _nameLabel = label;
            }
                break;
                
            case 1:
            {
                _rangeLabel = label;
            }
                break;
                
            default:
                break;
        }
    }
    
    _valueTextField = [[UITextField alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 3 * 2, 0, [UIScreen mainScreen].bounds.size.width / 3, 40)];
    [self addSubview:_valueTextField];
    _valueTextField.layer.borderWidth = 1;
    [_valueTextField addTarget:self action:@selector(valueTextFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setModel:(EditableCellModel *)model{
    _model = model;
    
    _nameLabel.text = _model.name;
    _rangeLabel.text = _model.range;
    _valueTextField.text = _model.value;
    
    if (_model.isEditState) {
        _valueTextField.userInteractionEnabled = YES;
        _valueTextField.layer.borderColor = [UIColor grayColor].CGColor;
    }else{
        _valueTextField.userInteractionEnabled = NO;
        _valueTextField.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

#pragma mark - textField的值改变时调用
- (void)valueTextFieldTextChanged:(UITextField *)sender{
    if ([self.delegate respondsToSelector:@selector(editableCell:valueTextFieldTextDidChange:)]) {
        [self.delegate editableCell:self valueTextFieldTextDidChange:sender];
    }
}

@end
