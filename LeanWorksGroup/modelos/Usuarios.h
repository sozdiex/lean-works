//
//  Usuarios.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 21/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Usuarios : NSManagedObject

@property (nonatomic, retain) NSString * cl_password;
@property (nonatomic, retain) NSNumber * es_premiun;
@property (nonatomic, retain) NSNumber * id_usuario;
@property (nonatomic, retain) NSString * nb_usuario;

@end
