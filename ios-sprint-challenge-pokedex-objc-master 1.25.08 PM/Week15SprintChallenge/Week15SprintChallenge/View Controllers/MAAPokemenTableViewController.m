//
//  MAAPokemenTableViewController.m
//  Week15SprintChallenge
//
//  Created by Angelique Abacajan on 3/20/20.
//  Copyright © 2020 Angelique Abacajan. All rights reserved.
//

#import "MAAPokemenTableViewController.h"
#import "Week15SprintChallenge-Swift.h"
#import "MAAPokemon.h"

@interface MAAPokemenTableViewController ()

@property NSArray<MAAPokemon *> *pokemen;

@end

@implementation MAAPokemenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNames];
}

- (void)loadNames {
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<MAAPokemon *> *pokemonNames, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemen = pokemonNames;
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemen.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.pokemen[indexPath.row].name capitalizedString];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    MAAPokemon *pokemon = self.pokemen[indexPath.row];
    
    [PokemonAPI.sharedController fillInDetailsFor:pokemon];
}

@end
