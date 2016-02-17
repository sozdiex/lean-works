//
//  IshikawaDet.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 22/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface IshikawaDet : NSManagedObject

@property (nonatomic, retain) NSNumber * id_problema;
@property (nonatomic, retain) NSNumber * id_ishikawa;
@property (nonatomic, retain) NSNumber * id_categoria;
@property (nonatomic, retain) NSNumber * id_rama;
@property (nonatomic, retain) NSNumber * id_detalle;
@property (nonatomic, retain) NSNumber * nu_prioridad;
@property (nonatomic, retain) NSString * de_causa;

@end
