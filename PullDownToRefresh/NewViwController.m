//
//  NewViwController.m
//  PullDownToRefresh
//
//  Created by Fstech042 on 11/09/15.
//  Copyright (c) 2015 RahulMishra. All rights reserved.
//

#import "NewViwController.h"

@interface NewViwController ()

{
    NSMutableArray *data;
    UIRefreshControl *refreshControl;
    
}

@end

@implementation NewViwController

- (void)viewDidLoad
{
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor blueColor];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self
                       action:@selector(getLatestLoans)
             forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl]; //add to tableView
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = @"Refresh Control Using TableView";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if(data)
    {
        
        self.tableView.backgroundView = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
    }
    else {
        
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No data is currently available. Please pull down to refresh.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (data) {
        return [data count];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellIdentifier];
        
        
    }
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    return cell;
}

- (void)getLatestLoans
{
    if(data)
    {
        [data addObject:@"Another One"];
        [self.tableView reloadData];
        [refreshControl endRefreshing];
    }
    
    else
    {
        data = [[NSMutableArray alloc]init];
        [data addObject:@"GO TO UITableVIew"];
        [self.tableView reloadData];
        [refreshControl endRefreshing];
    }
}


@end
