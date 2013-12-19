//
//  ViewController.m
//  NumberFormatterSample
//
//  Created by Natsuko Nishikata on 2013/12/19.
//  Copyright (c) 2013年 Natsuko Nishikata. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *_styles;
    NSArray *_formatters;
    double _value;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
	// Do any additional setup after loading the view, typically from a nib.
    
    _styles = @[@"No", @"Decimal", @"Currency", @"Percent", @"Scientific", @"SpellOut"];

    NSNumberFormatter *noStyleFormatter = [[NSNumberFormatter alloc] init];
    
    NSNumberFormatter *decimalFormatter = [[NSNumberFormatter alloc] init];
    [decimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSNumberFormatter *percentFormatter = [[NSNumberFormatter alloc] init];
    [percentFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    
    NSNumberFormatter *scientificFormatter = [[NSNumberFormatter alloc] init];
    [scientificFormatter setNumberStyle:NSNumberFormatterScientificStyle];
    
    NSNumberFormatter *spellOutFormatter = [[NSNumberFormatter alloc] init];
    [spellOutFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    
    _formatters = @[noStyleFormatter,
                    decimalFormatter,
                    currencyFormatter,
                    percentFormatter,
                    scientificFormatter,
                    spellOutFormatter];
    
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"ja_JP"];
    for (NSNumberFormatter *formatter in _formatters) {
        formatter.locale = locale;
    }
    
    _value = 123.456;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _styles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSNumberFormatter *formatter = _formatters[indexPath.row];
    
    cell.textLabel.text = [formatter stringFromNumber:@(_value)];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"NSNumberFormatter%@Style", _styles[indexPath.row]];
    
    return cell;
}


- (IBAction)localeChanged:(id)sender {
    
    NSInteger index = [(UISegmentedControl *)sender selectedSegmentIndex];
    NSLocale *locale;
    switch (index) {
        case 0:
            locale = [NSLocale localeWithLocaleIdentifier:@"ja_JP"];
            break;
        case 1:
            locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
            break;
        case 2:
            locale = [NSLocale localeWithLocaleIdentifier:@"de_DE"];
            break;
        case 3:
            locale = [NSLocale localeWithLocaleIdentifier:@"sv_SE"];
            break;
        default:
            break;
    }
    
    for (NSNumberFormatter *formatter in _formatters) {
        formatter.locale = locale;
    }
    [self.tableView reloadData];
}

@end
