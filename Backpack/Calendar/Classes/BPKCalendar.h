/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "BPKSimpleDate.h"

@class BPKCalendar;

/**
 * Enum values for specifying calendar selection type
 */
typedef NS_ENUM(NSUInteger, BPKCalendarSelection) {
    BPKCalendarSelectionSingle = 0,
    BPKCalendarSelectionRange = 1,
    BPKCalendarSelectionMultiple = 2,
};

NS_SWIFT_NAME(CalendarDelegate) @protocol BPKCalendarDelegate <NSObject>

/**
 * Called when a date selection changed.
 *
 * @param calendar The backpack calendar.
 * @param dateList List of selected dates.
 */
- (void)calendar:(BPKCalendar *)calendar didChangeDateSelection:(NSArray<BPKSimpleDate *> *)dateList;

@optional

/**
 * Called when the calendar was scrolled
 * @param calendar The backpack calendar.
 * @param contentOffset The content offset
 */
- (void)calendar:(BPKCalendar *)calendar didScroll:(CGPoint)contentOffset;

@end

/**
 * `BPKCalendar` is a subclass of `FSCalendar` configured with Skyscanner style properties.
 */
NS_SWIFT_NAME(Calendar) @interface BPKCalendar: UIView

/**
 * The active calendar being used by the reciever.
 */
@property(nonatomic, strong, nonnull, readonly) NSCalendar *gregorian;

/**
 * Locale used for displaying name of days and months
 */
@property (copy, nonatomic) NSLocale *locale;

/**
 * Type of selection allowed
 */
@property (nonatomic) BPKCalendarSelection selectionType;

/**
 * List of selected dates
 */
@property (nonatomic) NSArray<BPKSimpleDate *> *selectedDates;

/**
 * The earliest date that the user is allowed to select
 */
@property (nonatomic) BPKSimpleDate *minDate;

/**
 * The latest date that the user is allowed to select
 */
@property (nonatomic) BPKSimpleDate *maxDate;

/**
 * The calendar's delegate
 */
@property (nonatomic) id<BPKCalendarDelegate> delegate;

- (void)reloadData;

/**
 * Converts a Date to a SimpleDate based on the device's locale timezone
 */
- (BPKSimpleDate *)simpleDateFromDate:(NSDate *)date;

/**
 * Converts a SimpleDate to a Date based on the device's locale timezone
 */
-(NSDate *)dateFromSimpleDate:(BPKSimpleDate *)simpleDate;

@end
