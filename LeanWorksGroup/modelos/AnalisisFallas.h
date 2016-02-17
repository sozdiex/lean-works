//
//  AnalisisFallas.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 21/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AnalisisFallas : NSManagedObject

@property (nonatomic, retain) NSString * de_documentoGenerar;
@property (nonatomic, retain) NSString * de_documentoModificar;
@property (nonatomic, retain) NSNumber * id_problema;
@property (nonatomic, retain) NSNumber * id_ishikawa;
@property (nonatomic, retain) NSString * de_causa;
@property (nonatomic, retain) NSNumber * id_analisis;
@property (nonatomic, retain) NSDate * fh_inicioRealizado;
@property (nonatomic, retain) NSDate * fh_inicioPlan;
@property (nonatomic, retain) NSDate * fh_finRealizado;
@property (nonatomic, retain) NSDate * fh_finPlan;
@property (nonatomic, retain) NSString * nb_responsable;
@property (nonatomic, retain) NSString * nb_actividadRealizar;
@property (nonatomic, retain) NSString * nb_accion;

@end
