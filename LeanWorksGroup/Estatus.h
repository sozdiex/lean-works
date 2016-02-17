//
//  Estatus.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 26/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Estatus : NSManagedObject

@property (nonatomic, retain) NSNumber * id_estatus;
@property (nonatomic, retain) NSString * nombre_archivo;
@property (nonatomic, retain) NSString * mainProblem;
@property (nonatomic, retain) NSNumber * estatus;

@end
