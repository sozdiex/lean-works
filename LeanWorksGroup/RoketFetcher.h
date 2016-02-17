//
//  RoketFetcher.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 20/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface RoketFetcher : NSObject

@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;
@property NSFetchRequest *request;

+ (NSDictionary *)executeSaveAccount:(NSMutableDictionary *)query;
+ (BOOL)CheckConnection;
+ (NSDictionary *)loginAccoun:(NSMutableDictionary *)query;

+(void)createJson:(NSMutableDictionary *)dicPareto : (NSMutableDictionary *)dicIshikawa : (NSString*)nameView;
+(NSMutableDictionary*)readJson:(NSString *)name;
-(void)setFrecuencia;
-(void)leerFrecuencias;
-(int)savePareto:(NSMutableDictionary *)dicPareto;
-(void)saveIshikawa:(NSMutableDictionary *)dicIshikawa : (int)id_problema;
-(NSMutableDictionary *)leerIshikawa:(int)id_problema;
-(NSMutableDictionary*)nameJSON:(NSMutableDictionary*)dicPareto;
-(NSMutableArray *)getEstatus;
-(void)setEstatusTrue:(int)id_estatus;
-(NSMutableArray *)leerProblemas;
-(NSMutableDictionary *)leerPareto:(int) id_problema;
- (void)mdfActionArray:(NSMutableArray *)actionArray;
-(void)saveActionFailure:(NSMutableArray *)actionArray countActionArray:(int*) countActionArray;

-(NSMutableDictionary*)getDataJSON;
-(void)restaurarBD:(NSMutableDictionary *)data;

-(NSString *)makePdf:(NSMutableArray *)actionArray;


@end
