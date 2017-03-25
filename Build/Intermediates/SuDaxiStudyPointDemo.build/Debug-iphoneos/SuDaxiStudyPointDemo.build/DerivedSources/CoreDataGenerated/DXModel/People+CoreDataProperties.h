//
//  People+CoreDataProperties.h
//  
//
//  Created by SYQ on 2017/3/16.
//
//  This file was automatically generated and should not be edited.
//

#import "People+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface People (CoreDataProperties)

+ (NSFetchRequest<People *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *gender;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Card *card;

@end

NS_ASSUME_NONNULL_END
