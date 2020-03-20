//
//  MAAPokemonDetailViewController.m
//  Week15SprintChallenge
//
//  Created by Angelique Abacajan on 3/20/20.
//  Copyright © 2020 Angelique Abacajan. All rights reserved.
//

#import "MAAPokemonDetailViewController.h"
#import "MAAPokemon.h"
#import "Week15SprintChallenge-Swift.h"

void *KVOContext = &KVOContext;

@interface MAAPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation MAAPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonAPI.sharedController addObserver:self forKeyPath:@"pokemon" options:NSKeyValueObservingOptionInitial context:KVOContext];
    [PokemonAPI.sharedController addObserver:self forKeyPath:@"pokemonImage" options:NSKeyValueObservingOptionInitial context:KVOContext];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [PokemonAPI.sharedController removeObserver:self forKeyPath:@"pokemon" context:KVOContext];
    [PokemonAPI.sharedController removeObserver:self forKeyPath:@"pokemonImage" context:KVOContext];
}

- (void) updateViews {
    
    MAAPokemon *pokemon = PokemonAPI.sharedController.pokemon;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", [pokemon.name capitalizedString]];
        self.idLabel.text = [NSString stringWithFormat:@"ID: %i", pokemon.idenitifier];
        self.abilitiesLabel.text =  [NSString stringWithFormat:@"Abilities:\n\n%@", [pokemon.abilities capitalizedString]];
        
        self.imageView.image = PokemonAPI.sharedController.pokemonImage;
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"pokemon"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"pokemonImage"]) {
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    PokemonAPI.sharedController.pokemon = nil;
    PokemonAPI.sharedController.pokemonImage = nil;
}

@end
