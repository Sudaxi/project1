//
//  People+CoreDataProperties.m
//  
//
//  Created by SYQ on 2017/3/16.
//
//  This file was automatically generated and should not be edited.
//

#import "People+CoreDataProperties.h"

@implementation People (CoreDataProperties)

+ (NSFetchRequest<People *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"People"];
}

@dynamic age;
@dynamic gender;
@dynamic name;
@dynamic card;

@end
