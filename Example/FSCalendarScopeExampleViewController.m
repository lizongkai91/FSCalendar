//
//  FSCalendarScopeExampleViewController.m
//  FSCalendar
//
//  Created by Wenchao Ding on 8/29/15.
//  Copyright (c) 2015 wenchaoios. All rights reserved.
//

#import "FSCalendarScopeExampleViewController.h"

@implementation FSCalendarScopeExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    _calendar.scrollDirection = FSCalendarScrollDirectionVertical;
}

- (void)calendarCurrentScopeWillChange:(FSCalendar *)calendar animated:(BOOL)animated
{
    CGSize size = [calendar sizeThatFits:calendar.frame.size];
    _calendarHeightConstraint.constant = size.height;
    [self.view layoutIfNeeded];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FSCalendarScope scopeForIndexPath = indexPath.row == 0 ? FSCalendarScopeMonth : FSCalendarScopeWeek;
    NSString *identifier = @[@"cell_month",@"cell_week"][indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.accessoryType = _calendar.scope == scopeForIndexPath ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView.visibleCells setValue:@(UITableViewCellAccessoryNone) forKey:@"accessoryType"];
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    FSCalendarScope selectedScope = indexPath.row == 0 ? FSCalendarScopeMonth : FSCalendarScopeWeek;
    //    _calendar.scope = selectedScope;
    [_calendar setScope:selectedScope animated:_animationSwitch.on];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

@end