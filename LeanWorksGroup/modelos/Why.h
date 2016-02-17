//
//  Why.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 21/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Why : NSManagedObject

@property (nonatomic, retain) NSNumber * id_causa;
@property (nonatomic, retain) NSNumber * id_problema;
@property (nonatomic, retain) NSNumber * id_categoria;
@property (nonatomic, retain) NSNumber * id_why;
@property (nonatomic, retain) NSString * de_why1;
@property (nonatomic, retain) NSString * de_why2;
@property (nonatomic, retain) NSString * de_why3;
@property (nonatomic, retain) NSString * de_why4;
@property (nonatomic, retain) NSString * de_why5;

@end
