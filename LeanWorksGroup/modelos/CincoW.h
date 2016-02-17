//
//  CincoW.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 21/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CincoW : NSManagedObject

@property (nonatomic, retain) NSString * de_como;
@property (nonatomic, retain) NSString * de_cuanto;
@property (nonatomic, retain) NSString * de_donde;
@property (nonatomic, retain) NSString * de_porque;
@property (nonatomic, retain) NSString * de_que;
@property (nonatomic, retain) NSString * de_quien;
@property (nonatomic, retain) NSNumber * id_problema;
@property (nonatomic, retain) NSString * de_cuando;

@end
