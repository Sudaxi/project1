//
//  Card+CoreDataProperties.h
//  
//
//  Created by SYQ on 2017/3/16.
//
//  This file was automatically generated and should not be edited.
//

#import "Card+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Card (CoreDataProperties)

+ (NSFetchRequest<Card *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *no;
@property (nullable, nonatomic, retain) People *people;

@end

NS_ASSUME_NONNULL_END
