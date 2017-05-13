//
//  ViewController.m
//  EditableCell
//
//  Created by 蔡强 on 2017/5/13.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "ViewController.h"
#import "EditableCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,EditableCellDelegate>

/** 数据源数组 */
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建数据源
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 100; i ++) {
        EditableCellModel *cellModel = [[EditableCellModel alloc]init];
        cellModel.name = @"name";
        cellModel.range = @"1-200";
        cellModel.value = @"500";
        cellModel.isEditState = NO;
        [self.dataArray addObject:cellModel];
    }
    
    // 编辑按钮
    UIButton *editButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    [self.view addSubview:editButton];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

/** 编辑按钮点击 */
- (void)editButtonClicked:(UIButton *)sender{
    // 改变数据源
    for (EditableCellModel *cellModel in self.dataArray) {
        // 是否进入编辑状态取反
        cellModel.isEditState = !cellModel.isEditState;
    }
    
    // 刷新tableView
    [self.tableView reloadData];
    
    // 更新按钮文字
    NSString *editButtonTitle = [sender.titleLabel.text isEqualToString:@"编辑"] ? @"完成" : @"编辑";
    [sender setTitle:editButtonTitle forState:UIControlStateNormal];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (cell == nil) {
        cell = [[EditableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
    }
    cell.model = self.dataArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - cell的textField文本改变时回调
- (void)editableCell:(EditableCell *)editableCell valueTextFieldTextDidChange:(UITextField *)sender{
    // 获取cell所在行数
    NSInteger row = [self.tableView indexPathForCell:editableCell].row;
    // 获取cell对应的model
    EditableCellModel *cellModel = self.dataArray[row];
    // 修改model
    cellModel.value = sender.text;
}

@end
