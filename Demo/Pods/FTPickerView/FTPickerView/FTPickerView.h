//
//  FTPickerView.h
//  FTPickerView
//
//  Created by liufengting on 15/12/3.
//  Copyright © 2015年 liufengting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ FTPickerDoneBlock )(NSInteger);
typedef void (^ FTPickerCancelBlock )();
typedef void (^ FTDatePickerDoneBlock )(NSDate *);
typedef void (^ FTDatePickerCancelBlock )();

/**
 *  FTPickerTitleView
 */

@interface FTPickerTitleView : UIView

@end

/**
 *  FTPickerView
 */

@interface FTPickerView : NSObject 

/**
 *  show method
 *
 *  @param title       title
 *  @param nameArray   nameArray
 *  @param doneBlock   FTPickerDoneBlock
 *  @param cancelBlock FTPickerCancelBlock
 */
+(void)showWithTitle:(NSString *)title
           nameArray:(NSArray<NSString *> *)nameArray
          doneBlock :(FTPickerDoneBlock)doneBlock
         cancelBlock:(FTPickerCancelBlock)cancelBlock;
/**
 *  dismiss
 */
+(void)dismiss;

@end

/**
 *  FTDatePickerView
 */

@interface FTDatePickerView : UIView

/**
 *  show method
 *
 *  @param title       title
 *  @param doneBlock   FTDatePickerDoneBlock
 *  @param cancelBlock FTDatePickerCancelBlock
 */
+(void)showWithTitle:(NSString *)title
          doneBlock :(FTDatePickerDoneBlock)doneBlock
         cancelBlock:(FTDatePickerCancelBlock)cancelBlock;
/**
 *  show method
 *
 *  @param title          title
 *  @param selectDate     selectDate
 *  @param datePickerMode datePickerMode
 *  @param doneBlock      FTDatePickerDoneBlock
 *  @param cancelBlock    FTDatePickerCancelBlock
 */
+(void)showWithTitle:(NSString *)title
          selectDate:(NSDate *)selectDate
      datePickerMode:(UIDatePickerMode )datePickerMode
          doneBlock :(FTDatePickerDoneBlock)doneBlock
         cancelBlock:(FTDatePickerCancelBlock)cancelBlock;
/**
 *  dismiss
 */
+(void)dismiss;

@end
