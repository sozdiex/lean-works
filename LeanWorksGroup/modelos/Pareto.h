//
//  Pareto.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 21/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Pareto : NSManagedObject

@property (nonatomic, retain) NSNumber * id_causa;
@property (nonatomic, retain) NSNumber * id_problema;
@property (nonatomic, retain) NSString * nb_causa;
@property (nonatomic, retain) NSNumber * nu_frecuencia;
@property (nonatomic, retain) NSNumber * pj_acumulado;
@property (nonatomic, retain) NSNumber * pj_frecuencia;
@property (nonatomic, retain) NSNumber * nu_acumulado;

@end
