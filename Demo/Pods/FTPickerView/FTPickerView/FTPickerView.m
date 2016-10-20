//
//  FTPickerView.m
//  FTPickerView
//
//  Created by liufengting on 15/12/3.
//  Copyright © 2015年 liufengting. All rights reserved.
//

#import "FTPickerView.h"

#define KSCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define KSCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height
#define PickerHeight             216
#define BackgroundColor          [[UIColor blackColor] colorWithAlphaComponent:0.2]
#define LineHeight               0.6

#pragma mark -
#pragma mark - FTPickerTitleView

@interface FTPickerTitleView ()

@property (nonatomic,strong)UIButton *cancelButton;
@property (nonatomic,strong)UIButton *confirmButton;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *bottomLine;

@end

@implementation FTPickerTitleView

-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, 0, 60, self.bounds.size.height);
        _cancelButton.backgroundColor = [UIColor clearColor];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:_cancelButton];
        
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame= CGRectMake(self.bounds.size.width - 60, 0, 60, self.bounds.size.height);
        _confirmButton.backgroundColor=[UIColor clearColor];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_confirmButton];
        
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, self.bounds.size.width - 120 , self.bounds.size.height )];
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.textColor=[UIColor blackColor];
        _titleLabel.font=[UIFont boldSystemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = title;
        [self addSubview:_titleLabel];
        
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - LineHeight, self.bounds.size.width, LineHeight)];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_bottomLine];
    }
    return self;
}

@end

#pragma mark -
#pragma mark - FTPickerView

@interface FTPickerView() <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)UIView *backgroundView;
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)FTPickerTitleView *titleView;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,assign)NSInteger pickerTag;
@property (nonatomic,strong)FTPickerDoneBlock doneBlock;
@property (nonatomic,strong)FTPickerCancelBlock cancelBlock;

@end

#pragma mark - FTPickerView

@implementation FTPickerView

#pragma mark - public methods

+ (FTPickerView *)sharedInstance
{
    static dispatch_once_t once = 0;
    static FTPickerView *sharedView;
    dispatch_once(&once, ^{ sharedView = [[FTPickerView alloc] init]; });
    return sharedView;
}
+(void)showWithTitle:(NSString *)title nameArray:(NSArray<NSString *> *)nameArray  doneBlock :(FTPickerDoneBlock)doneBlock cancelBlock:(FTPickerCancelBlock)cancelBlock
{
    [[self sharedInstance] showWithTitle:title nameArray:nameArray doneBlock:doneBlock cancelBlock:cancelBlock];
}
+(void)dismiss
{
    [[self sharedInstance] onCancel];
}

#pragma mark - private methods
-(void)showWithTitle:(NSString *)title nameArray:(NSArray<NSString *> *)nameArray  doneBlock :(FTPickerDoneBlock)doneBlock cancelBlock:(FTPickerCancelBlock)cancelBlock
{
    _titleArray = nameArray;
    _doneBlock = doneBlock;
    _cancelBlock = cancelBlock;
    
    if(!_backgroundView){
        
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        [_backgroundView setBackgroundColor:[UIColor clearColor]];
        [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
        
        UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-PickerHeight-40)];
        [blankView setBackgroundColor:[UIColor clearColor]];
        [blankView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBlankTouched)]];
        [_backgroundView addSubview:blankView];
        
        _titleView = [[FTPickerTitleView alloc]initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-PickerHeight-40, KSCREEN_WIDTH, 40)
                                                   withTitle:title];
        [_titleView.cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
        [_titleView.confirmButton addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView  addSubview:_titleView];
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-PickerHeight,KSCREEN_WIDTH, PickerHeight)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [_backgroundView  addSubview:_pickerView];
        
        
        [_pickerView reloadAllComponents];
        [_pickerView selectRow:0 inComponent:0 animated:YES];
        [self open];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
        _titleView.titleLabel.text = title;
        [_pickerView reloadAllComponents];
        [self open];
    }
}

#pragma mark - onBlankTouched
-(void)onBlankTouched
{
    self.cancelBlock();
    [self close];
}

#pragma mark - cancel
-(void)onCancel
{
    self.cancelBlock();
    
    [self close];
}
#pragma mark - confirm
-(void)onConfirm
{
    
    self.doneBlock([_pickerView selectedRowInComponent:0]);
    
    [self close];
}
#pragma mark - open
-(void)open
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [_backgroundView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              _backgroundView.backgroundColor = BackgroundColor;
                                          }];
                     }];
}
#pragma mark - close
-(void)close
{
    [UIView animateWithDuration:0.1
                     animations:^{
                         _backgroundView.backgroundColor = [UIColor clearColor];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              [_backgroundView setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
                                          }];
                     }];
}

#pragma mark - UIPicker delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_titleArray count];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, pickerView.bounds.size.width,40 )];
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor blackColor];
    label.font=[UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = _titleArray[row];
    return label;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return pickerView.bounds.size.width;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

@end

#pragma mark - FTDatePickerView

@interface FTDatePickerView ()

@property (nonatomic,strong)UIView *backgroundView;
@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong)NSDate *selectedDate;
@property (nonatomic,strong)FTPickerTitleView *titleView;
@property (nonatomic,strong)FTDatePickerDoneBlock doneBlock;
@property (nonatomic,strong)FTDatePickerCancelBlock cancelBlock;

@end

@implementation FTDatePickerView

#pragma mark - public methods

+ (FTDatePickerView *)sharedInstance
{
    static dispatch_once_t once = 0;
    static FTDatePickerView *sharedView;
    dispatch_once(&once, ^{ sharedView = [[FTDatePickerView alloc] init]; });
    return sharedView;
}

+(void)showWithTitle:(NSString *)title doneBlock :(FTDatePickerDoneBlock)doneBlock cancelBlock:(FTDatePickerCancelBlock)cancelBlock
{
    [[self sharedInstance] showWithTitle:title selectDate:nil datePickerMode:UIDatePickerModeDateAndTime doneBlock:doneBlock cancelBlock:cancelBlock];
    
}

+(void)showWithTitle:(NSString *)title selectDate:(NSDate *)selectDate datePickerMode:(UIDatePickerMode )datePickerMode doneBlock :(FTDatePickerDoneBlock)doneBlock cancelBlock:(FTDatePickerCancelBlock)cancelBlock
{
    [[self sharedInstance] showWithTitle:title selectDate:selectDate datePickerMode:datePickerMode doneBlock:doneBlock cancelBlock:cancelBlock];
}

+(void)dismiss
{
    [[self sharedInstance] onCancel];
}

#pragma mark - private methods
-(void)showWithTitle:(NSString *)title doneBlock :(FTDatePickerDoneBlock)doneBlock cancelBlock:(FTDatePickerCancelBlock)cancelBlock
{
    [self showWithTitle:title selectDate:nil datePickerMode:UIDatePickerModeDateAndTime doneBlock:doneBlock cancelBlock:cancelBlock];
    
}

-(void)showWithTitle:(NSString *)title selectDate:(NSDate *)selectDate datePickerMode:(UIDatePickerMode )datePickerMode doneBlock :(FTDatePickerDoneBlock)doneBlock cancelBlock:(FTDatePickerCancelBlock)cancelBlock
{
    
    _doneBlock = doneBlock;
    _cancelBlock = cancelBlock;
    
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        [_backgroundView setBackgroundColor:[UIColor clearColor]];
        [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
        
        UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-PickerHeight-40)];
        [blankView setBackgroundColor:[UIColor clearColor]];
        [blankView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBlankTouched)]];
        [_backgroundView addSubview:blankView];
        
        
        _titleView = [[FTPickerTitleView alloc]initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-PickerHeight-40, KSCREEN_WIDTH, 40)
                                                   withTitle:title];
        [_titleView.cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
        [_titleView.confirmButton addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView  addSubview:_titleView];
        
        
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-PickerHeight, KSCREEN_WIDTH, PickerHeight)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = datePickerMode;
        _datePicker.minuteInterval = 5;
        if (selectDate) {
            [_datePicker setDate:selectDate];
        }
        [_backgroundView addSubview:_datePicker];
        
        [self open];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];

        _titleView.titleLabel.text = title;
        _datePicker.datePickerMode = datePickerMode;
        if (selectDate) {
            [_datePicker setDate:selectDate];
        }
        [self open];
    }
}

#pragma mark - cancel
-(void)onCancel
{
    _selectedDate = nil;
    [self close];
}
#pragma mark - confirm
-(void)onConfirm
{
    _selectedDate = _datePicker.date;
    [self close];
}
#pragma mark - onBlankTouched
-(void)onBlankTouched
{
    _selectedDate = nil;
    [self close];
}
#pragma mark - open/close
-(void)open
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [_backgroundView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              _backgroundView.backgroundColor = BackgroundColor;
                                          }];
                     }];
}
-(void)close
{
    [UIView animateWithDuration:0.1
                     animations:^{
                         _backgroundView.backgroundColor = [UIColor clearColor];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              [_backgroundView setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
                                          }completion:^(BOOL finished) {
                                              if (_selectedDate) {
                                                  self.doneBlock(_selectedDate);
                                              }else{
                                                  self.cancelBlock();
                                              }
                                          }];
                     }];
}


@end
