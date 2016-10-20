# FTPickerView
[![Twitter](https://img.shields.io/badge/twitter-@liufengting-blue.svg?style=flat)](http://twitter.com/liufengting) 
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/liufengting/FTPickerView/master/LICENSE)
[![Version](https://img.shields.io/cocoapods/v/FTPickerView.svg?style=flat)](http://cocoapods.org/pods/FTPickerView)
[![CI Status](http://img.shields.io/travis/liufengting/FTPickerView.svg?style=flat)](https://travis-ci.org/liufengting/FTPickerView)
[![GitHub stars](https://img.shields.io/github/stars/liufengting/FTPickerView.svg)](https://github.com/liufengting/FTPickerView/stargazers)


A simple UIPickerView/UIDatePicker wrapper.

## Features

- singleton
- block callbacks


## ScreenShots

<table>
  <tr>
    <th><img src="/ImageAssets/SimplePicker.png" width="250"/></th>
    <th><img src="/ImageAssets/DatePicker.png" width="250"/></th>
  </tr>
</table>


## Useage

* Simple Picker 

```objective-c
    //simple picker
    [FTPickerView showWithTitle:@"Choose a step"
                      nameArray:self.optionArrayOne
                      doneBlock:^(NSInteger selectedIndex) {
                          [sender setTitle:_optionArrayOne[selectedIndex] forState:UIControlStateNormal];
                      } cancelBlock:^{

                      }];
```

* Date Picker 


```objective-c
    //date picker
    [FTDatePickerView showWithTitle:@"Choose a date"
                         selectDate:nil
                     datePickerMode:UIDatePickerModeDateAndTime
                          doneBlock:^(NSDate *selectedDate) {
                              NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
                              [dateFormate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                              [sender setTitle:[dateFormate stringFromDate:selectedDate] forState:UIControlStateNormal];
                          } cancelBlock:^{
                              
                          }];
```

# Installation

## Manual
* Drag 'FTPickerView' file to you project,
* Import 'FTPickerView.h',
* Enjoy！ 🍺

## Cocoapods

* add the following line to you podFile，then `pod update`

```
   pod 'FTPickerView', '~> 0.1.1'
```

## License

FTPickerView is available under the MIT license. See the LICENSE file for more info.




