//
//  Problemas.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 21/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Problemas : NSManagedObject

@property (nonatomic, retain) NSNumber * id_frecuencia;
@property (nonatomic, retain) NSNumber * id_giro;
@property (nonatomic, retain) NSNumber * id_problema;
@property (nonatomic, retain) NSString * nb_problema;
@property (nonatomic, retain) NSNumber * sn_unidad;
@property (nonatomic, retain) NSNumber * id_usuario;
@property (nonatomic, retain) NSDate * fh_frecuenciaInicio;
@property (nonatomic, retain) NSDate * fh_frecuenciaFin;

@end
