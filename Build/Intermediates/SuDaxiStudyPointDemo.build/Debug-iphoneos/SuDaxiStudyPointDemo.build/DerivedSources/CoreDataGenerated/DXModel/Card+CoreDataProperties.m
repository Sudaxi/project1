//
//  Card+CoreDataProperties.m
//  
//
//  Created by SYQ on 2017/3/16.
//
//  This file was automatically generated and should not be edited.
//

#import "Card+CoreDataProperties.h"

@implementation Card (CoreDataProperties)

+ (NSFetchRequest<Card *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Card"];
}

@dynamic no;
@dynamic people;

@end
