
//
//  RoketFetcher.m
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 20/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "RoketFetcher.h"
#import "Reachability.h"
#import "Frecuencia.h"
#import "Problemas.h"
#import "Pareto.h"
#import "CincoW.h"
#import "Ishikawa.h"
#import "IshikawaDet.h"
#import "Why.h"
#import "AnalisisFallas.h"
#import "Estatus.h"

#define kAppUrl @"http://107.170.25.197:3001/"
#define apiKey @"61965cce7314a7mr2k3fdk26p0b2c1b1f351e47c45"
#define kPadding 10

@implementation RoketFetcher{
    //varialbe pdf
    CGSize _pageSize;
    NSString *fechaInicial;
    NSString *fechaFinal;
}

+ (NSDictionary *)executeSaveAccount:(NSMutableDictionary *)query
{
    NSString *appURL = [NSString stringWithFormat:@"%@registerAccount", kAppUrl];
    NSLog(@"appURL save: %@", appURL);
    NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: appURL ] ];
           NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:query options:NSJSONWritingPrettyPrinted error:&error];
    
    // convertimos los datos a un string para poder mostrarlos
    NSString *jSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"jsonstring: %@", jSONString);
    

    [request setHTTPMethod: @"POST" ];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:apiKey forHTTPHeaderField:@"APIKEY"];
    [request setHTTPBody:jsonData];
    NSLog(@"postdata: %@", jsonData);
    NSURLResponse *response;
    NSError *err;
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
    NSLog(@"%@",err);
    NSDictionary *results;
    if(returnData != nil){
        results =[NSJSONSerialization JSONObjectWithData:returnData options:0 error:&err];
    }else{
        results = nil;
    }
    NSLog(@"resultados: %@", results);
    return results;
}

+ (NSDictionary *)loginAccoun:(NSMutableDictionary *)query
{
    NSString *appURL = [NSString stringWithFormat:@"%@login", kAppUrl];
    NSLog(@"appURL save: %@", appURL);
    NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: appURL ] ];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:query options:NSJSONWritingPrettyPrinted error:&error];
    
    // convertimos los datos a un string para poder mostrarlos
    NSString *jSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"jsonstring: %@", jSONString);
    
    [request setHTTPMethod: @"POST" ];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:apiKey forHTTPHeaderField:@"APIKEY"];
    [request setHTTPBody:jsonData];
    NSLog(@"postdata: %@", jsonData);
    NSURLResponse *response;
    NSError *err;
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
    NSLog(@"%@",err);
    NSDictionary *results;
    
    if(returnData != nil){
        results =[NSJSONSerialization JSONObjectWithData:returnData options:0 error:&err];
    }else{
        results = nil;
    }
    NSLog(@"resultados: %@", results);
    return results;
}

+ (BOOL)CheckConnection{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        return FALSE;
    } else {
        return TRUE;
    }
}

-(void)agregarFrecuencia{
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context =[self.appDelegate managedObjectContext];
    NSError *error;
    
    //agregar
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:@"Hora"];
    [array addObject:@"Dia"];
    [array addObject:@"Semana"];
    [array addObject:@"Quincena"];
    [array addObject:@"Mes"];
    
    for(int i = 0; i< [array count]; i++){
        //agregando
        Frecuencia *frecuencia = [NSEntityDescription insertNewObjectForEntityForName:@"Frecuencia" inManagedObjectContext:self.context];
        frecuencia.id_frecuencia = [NSNumber numberWithInt:i];
        frecuencia.nb_frecuencia = [array objectAtIndex:i];
        
        [self.context save:&error];
        
        NSLog(@"%@",error);
    }
}

-(NSMutableArray *)leerProblemas{
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context =[self.appDelegate managedObjectContext];
    NSFetchRequest *request;
    NSError *error;
    
    //leer CincoW
    request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Problemas" inManagedObjectContext:self.context]];
    NSMutableArray *arrayProblemsReturn = [[NSMutableArray alloc]init];
    int count = [[self.context executeFetchRequest:request error:&error] count];
    for(int i = 0; i < count; i++){
        Problemas *obj =[[self.context executeFetchRequest:request error:&error]objectAtIndex:i];
        NSMutableDictionary *mydicTemp = [[NSMutableDictionary alloc]init];
        [mydicTemp setObject:obj.id_problema forKey:@"id_problema"];
        [mydicTemp setObject:obj.nb_problema forKey:@"name"];
        
        [arrayProblemsReturn addObject:mydicTemp];
    }
    return arrayProblemsReturn;
}


-(NSMutableDictionary *)leerIshikawa:(int)id_problema{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_problema == %d", id_problema]; //condicion
    NSMutableDictionary *dicIshikawa = [[NSMutableDictionary alloc]init];
    
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context =[self.appDelegate managedObjectContext];
    NSFetchRequest *request;
    NSError *error;
    
    //leer CincoW
    request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"CincoW" inManagedObjectContext:self.context]];
    [request setPredicate:predicate];
    
    int count =[[self.context executeFetchRequest:request error:&error]count];
    if(count<1){
        return nil;
    }
    
    if(error)
        NSLog(@"%@",error);
    
    CincoW *cincoW =[[self.context executeFetchRequest:request error:&error]firstObject];
    if(error)
        NSLog(@"%@",error);
    
    NSLog(@"de_como: %@ \n de_cuanto: %@\n de_donde: %@\n de_porque: %@\n de_que: %@\n de_quien: %@\n id_problema: %@\n de_cuando: %@",cincoW.de_como,cincoW.de_cuanto,cincoW.de_donde,cincoW.de_porque,cincoW.de_que,cincoW.de_quien,cincoW.id_problema,cincoW.de_cuando);

    [dicIshikawa setObject:cincoW.id_problema forKey:@"id_problema"];
    [dicIshikawa setObject:cincoW.de_como forKey:@"how"];
    [dicIshikawa setObject:cincoW.de_cuanto forKey:@"HowMuch"];
    [dicIshikawa setObject:cincoW.de_donde forKey:@"where"];
    [dicIshikawa setObject:cincoW.de_porque forKey:@"why"];
    [dicIshikawa setObject:cincoW.de_que forKey:@"what"];
    [dicIshikawa setObject:cincoW.de_quien forKey:@"who"];
    [dicIshikawa setObject:cincoW.de_cuando forKey:@"when"];
    
    
    
    //leer Ishikawa
    request = [[NSFetchRequest alloc] init];
    [request setPredicate:predicate];
    self.context =[self.appDelegate managedObjectContext];
    [request setEntity:[NSEntityDescription entityForName:@"Ishikawa" inManagedObjectContext:self.context]];
    
    count =[[self.context executeFetchRequest:request error:&error]count];
    
    if(error)
        NSLog(@"%@",error);
    
    
    NSMutableArray *arrayIshikawaTem = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < count; i++){
        Ishikawa *obj =[[self.context executeFetchRequest:request error:&error]objectAtIndex:i];
        if(error)
            NSLog(@"%@",error);
        
        NSLog(@"id_usuario: %@ \n id_problema: %@\n id_ishikawa: %@\n id_categoria: %@\n id_rama: %@",obj.id_usuario,obj.id_problema,obj.id_ishikawa,obj.id_categoria,obj.id_rama);
        
        NSMutableDictionary *dicTemp = [[NSMutableDictionary alloc] init];
        [dicTemp setObject:obj.id_usuario forKey:@"id_usuario"];
        [dicTemp setObject:obj.id_problema forKey:@"id_problema"];
        [dicTemp setObject:obj.id_ishikawa forKey:@"id_ishikawa"];
        [dicTemp setObject:obj.id_categoria forKey:@"id_categoria"];
        [dicTemp setObject:obj.id_rama forKey:@"id_rama"];
        [arrayIshikawaTem addObject:dicTemp];
        
    }
    
    //leer IshikawaDet
    request = [[NSFetchRequest alloc] init];
    [request setPredicate:predicate];
    self.context =[self.appDelegate managedObjectContext];
    [request setEntity:[NSEntityDescription entityForName:@"IshikawaDet" inManagedObjectContext:self.context]];
    
    count =[[self.context executeFetchRequest:request error:&error]count];
    
    if(error)
        NSLog(@"%@",error);
    
    NSMutableArray *arrayWhy = [[NSMutableArray alloc]init];
    
    for(int j = 0; j <[arrayIshikawaTem count]; j++){
        NSMutableDictionary *myDicTemp = [arrayIshikawaTem objectAtIndex:j];
        NSMutableArray *arrayMRes = [[NSMutableArray alloc]init];
        
        for(int i = 0; i < count; i++){
            IshikawaDet *obj =[[self.context executeFetchRequest:request error:&error]objectAtIndex:i];
            
            if(error)
                NSLog(@"%@",error);
            
            NSLog(@"id_problema: %@ \n id_ishikawa: %@\n id_categoria: %@\n id_rama: %@\n id_detalle: %@ \n nu_prioridad: %@\n de_causa: %@",obj.id_problema,obj.id_ishikawa,obj.id_categoria,obj.id_rama,obj.id_detalle,obj.nu_prioridad,obj.de_causa);
            
            if([[myDicTemp objectForKey:@"id_categoria"] integerValue] == [obj.id_categoria integerValue] && [[myDicTemp objectForKey:@"id_rama"] integerValue] == [obj.id_rama integerValue]){
                [arrayMRes addObject:obj.de_causa];
            }
            
            if([obj.nu_prioridad integerValue] > 0 && [arrayWhy count] < 5){
                NSMutableDictionary *dicWhyTemp = [[NSMutableDictionary alloc]init];
                [dicWhyTemp setObject:obj.de_causa forKey:@"name"];
                [dicWhyTemp setObject:obj.nu_prioridad forKey:@"nu_prioridad"];
                [dicWhyTemp setObject:obj.id_categoria forKey:@"id_categoria"];
                
                [arrayWhy addObject:dicWhyTemp];
            }
        }
        
        NSMutableDictionary *dicTemp = [[NSMutableDictionary alloc]init];
        NSMutableArray *arrayTemp = [[NSMutableArray alloc]init];
        
        switch ([[myDicTemp objectForKey:@"id_categoria"]integerValue]) {
            case 1:
                if([dicIshikawa objectForKey:@"m1"]){
                    dicTemp = [dicIshikawa objectForKey:@"m1"];
                    arrayTemp = [dicTemp objectForKey:@"arrayMRes"];
                }
                [arrayTemp addObject:arrayMRes];
                [dicTemp setObject:arrayTemp forKey:@"arrayMRes"];
                [dicIshikawa setObject:dicTemp forKey:@"m1"];
                break;
                
            case 2:
                if([dicIshikawa objectForKey:@"m2"]){
                    dicTemp = [dicIshikawa objectForKey:@"m2"];
                    arrayTemp = [dicTemp objectForKey:@"arrayMRes"];
                }
                [arrayTemp addObject:arrayMRes];
                [dicTemp setObject:arrayTemp forKey:@"arrayMRes"];
                [dicIshikawa setObject:dicTemp forKey:@"m2"];
                break;
                
            case 3:
                if([dicIshikawa objectForKey:@"m3"]){
                    dicTemp = [dicIshikawa objectForKey:@"m3"];
                    arrayTemp = [dicTemp objectForKey:@"arrayMRes"];
                }
                [arrayTemp addObject:arrayMRes];
                [dicTemp setObject:arrayTemp forKey:@"arrayMRes"];
                [dicIshikawa setObject:dicTemp forKey:@"m3"];
                break;
                
            case 4:
                if([dicIshikawa objectForKey:@"m4"]){
                    dicTemp = [dicIshikawa objectForKey:@"m4"];
                    arrayTemp = [dicTemp objectForKey:@"arrayMRes"];
                }
                [arrayTemp addObject:arrayMRes];
                [dicTemp setObject:arrayTemp forKey:@"arrayMRes"];
                [dicIshikawa setObject:dicTemp forKey:@"m4"];
                break;
                
            case 5:
                if([dicIshikawa objectForKey:@"m5"]){
                    dicTemp = [dicIshikawa objectForKey:@"m5"];
                    arrayTemp = [dicTemp objectForKey:@"arrayMRes"];
                }
                [arrayTemp addObject:arrayMRes];
                [dicTemp setObject:arrayTemp forKey:@"arrayMRes"];
                [dicIshikawa setObject:dicTemp forKey:@"m5"];
                break;
                
            case 6:
                if([dicIshikawa objectForKey:@"m6"]){
                    dicTemp = [dicIshikawa objectForKey:@"m6"];
                    arrayTemp = [dicTemp objectForKey:@"arrayMRes"];
                }
                [arrayTemp addObject:arrayMRes];
                [dicTemp setObject:arrayTemp forKey:@"arrayMRes"];
                [dicIshikawa setObject:dicTemp forKey:@"m6"];
                break;
                
            default:
                break;
        }
    }
    
    //leer Why
    NSMutableArray *failuresArray = [[NSMutableArray alloc]init];
    request = [[NSFetchRequest alloc] init];
    [request setPredicate:predicate];
    self.context =[self.appDelegate managedObjectContext];
    [request setEntity:[NSEntityDescription entityForName:@"Why" inManagedObjectContext:self.context]];
    
    count =[[self.context executeFetchRequest:request error:&error]count];
    
    if(error)
        NSLog(@"%@",error);
    
    for(int i = 0; i < count; i++){
        Why *obj =[[self.context executeFetchRequest:request error:&error]objectAtIndex:i];
        if(error)
            NSLog(@"%@",error);
        
        NSMutableDictionary * myDicTemp = [[NSMutableDictionary alloc]init];
        
        NSLog(@"id_causa: %@ \n id_problema: %@\n id_categoria: %@\n id_why: %@\n de_why1: %@ \n de_why2: %@\n de_why3: %@ \n de_why4: %@\n de_why5: %@",obj.id_causa,obj.id_problema,obj.id_categoria,obj.id_why,obj.de_why1,obj.de_why2,obj.de_why3,obj.de_why4,obj.de_why5);
        
        [myDicTemp setObject:obj.de_why1 forKey:@"why1"];
        [myDicTemp setObject:obj.de_why2 forKey:@"why2"];
        [myDicTemp setObject:obj.de_why3 forKey:@"why3"];
        [myDicTemp setObject:obj.de_why4 forKey:@"why4"];
        [myDicTemp setObject:obj.de_why5 forKey:@"why5"];
        for (int i = 0; i < [arrayWhy count]; i++) {
            NSMutableDictionary * dicWhyTemp = [arrayWhy objectAtIndex:i];
            if([[dicWhyTemp objectForKey:@"id_categoria"] integerValue] == [obj.id_categoria integerValue] && [[dicWhyTemp objectForKey:@"nu_prioridad"] integerValue] == [obj.id_why integerValue]){
                [myDicTemp setObject:[dicWhyTemp objectForKey:@"name"] forKey:@"name"];
            }
        }
        
        [failuresArray addObject:myDicTemp];
    }
    
    [dicIshikawa setObject:failuresArray forKey:@"failuresArray"];
    [dicIshikawa setObject:failuresArray forKey:@"arrayWhy"];
    
    //ArraySelected
    NSMutableArray *arraySelected = [[NSMutableArray alloc]init];
    for (int i = 0; i < [arrayWhy count]; i++) {
        for(int j = 0; j <5; j++){
            NSMutableDictionary *dicTemp = [arrayWhy objectAtIndex:j];
            if (i+1 == [[dicTemp objectForKey:@"nu_prioridad"]integerValue]) {
                NSMutableDictionary *myDic = [[NSMutableDictionary alloc]init];
                [myDic setObject:[dicTemp objectForKey:@"name"] forKey:@"name"];
                [arraySelected addObject:myDic];
            }
        }
    }
    [dicIshikawa setObject:arraySelected forKey:@"arraySelected"];
    
    //leer AnalisisFallas
    request = [[NSFetchRequest alloc] init];
    [request setPredicate:predicate];
    self.context =[self.appDelegate managedObjectContext];
    [request setEntity:[NSEntityDescription entityForName:@"AnalisisFallas" inManagedObjectContext:self.context]];
    
    count =[[self.context executeFetchRequest:request error:&error]count];
    
    if(error)
        NSLog(@"%@",error);
    
    NSMutableArray *actionArray = [[NSMutableArray alloc ]init];
    
    for(int i = 0; i < count; i++){
        AnalisisFallas *obj =[[self.context executeFetchRequest:request error:&error]objectAtIndex:i];
        if(error)
            NSLog(@"%@",error);
        NSMutableDictionary *dicActionTemp = [[NSMutableDictionary alloc]init];
        
        NSLog(@"de_documentoGenerar: %@ \n de_documentoModificar: %@\n id_problema: %@\n id_ishikawa: %@\n de_causa: %@ \n id_analisis: %@\n fh_inicioRealizado: %@ \n fh_inicioPlan: %@\n fh_finRealizado: %@\n fh_finPlan: %@\n nb_responsable: %@ \n nb_actividadRealizar: %@\n nb_accion: %@",obj.de_documentoGenerar,obj.de_documentoModificar,obj.id_problema,obj.id_ishikawa,obj.de_causa,obj.id_analisis,obj.fh_inicioRealizado,obj.fh_inicioPlan,obj.fh_finRealizado,obj.fh_finPlan,obj.nb_responsable,obj.nb_actividadRealizar,obj.nb_accion);
        
        [dicActionTemp setObject:obj.de_documentoGenerar forKey:@"documentGenerated"];
        [dicActionTemp setObject:obj.de_documentoModificar forKey:@"documentModified"];
        [dicActionTemp setObject:obj.de_causa forKey:@"cause"];
        
        [dicActionTemp setObject:obj.id_analisis forKeyedSubscript:@"id_analisis"];
        [dicActionTemp setObject:obj.id_ishikawa forKeyedSubscript:@"id_ishikawa"];
        [dicActionTemp setObject:obj.id_problema forKeyedSubscript:@"id_problema"];
        
        if(obj.fh_inicioRealizado){
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
            NSString *stringFromDate = [formatter stringFromDate:obj.fh_inicioRealizado];
            
            [dicActionTemp setObject:stringFromDate forKey:@"dateStartRealized"];
        }
        else
            [dicActionTemp setObject:@"" forKey:@"dateStartRealized"];
        
        if(obj.fh_inicioPlan){
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
            NSString *stringFromDate = [formatter stringFromDate:obj.fh_inicioPlan];
            
            [dicActionTemp setObject:stringFromDate forKey:@"dateStartPlan"];
        }
        else
            [dicActionTemp setObject:@"" forKey:@"dateStartPlan"];
        
        if(obj.fh_finRealizado){
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
            NSString *stringFromDate = [formatter stringFromDate:obj.fh_finRealizado];
            
            [dicActionTemp setObject:stringFromDate forKey:@"dateFinishRealized"];
        }
        else
            [dicActionTemp setObject:@"" forKey:@"dateFinishRealized"];
        
        if(obj.fh_finPlan){
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
            NSString *stringFromDate = [formatter stringFromDate:obj.fh_finPlan];
            
            [dicActionTemp setObject:stringFromDate forKey:@"dateFinishPlan"];
        }
        else
            [dicActionTemp setObject:@"" forKey:@"dateFinishPlan"];
        
        [dicActionTemp setObject:obj.nb_responsable forKey:@"responsible"];
        [dicActionTemp setObject:obj.nb_actividadRealizar forKey:@"activity"];
        [dicActionTemp setObject:obj.nb_accion forKey:@"action"];
        
        [actionArray addObject:dicActionTemp];
    }
    
    [dicIshikawa setObject:actionArray forKey:@"actionArray"];

    return  dicIshikawa;
}


-(void)leerFrecuencias{
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context =[self.appDelegate managedObjectContext];
    NSFetchRequest *request;
    NSError *error;
    
    //leer
    request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Frecuencia" inManagedObjectContext:self.context]];
    
    int count =[[self.context executeFetchRequest:request error:&error]count];
    
    if(error)
        NSLog(@"%@",error);
    
    for(int i = 0; i < count; i++){
        Frecuencia *obj =[[self.context executeFetchRequest:request error:&error]objectAtIndex:i];
        if(error)
            NSLog(@"%@",error);
        
        NSLog(@"%@",obj.nb_frecuencia);
    }
}


-(void)EliminarFrecuencia{
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context =[self.appDelegate managedObjectContext];
    NSFetchRequest *request;
    NSError *error;
    
    //Elimianr
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_frecuencia == %@", @""]; //condicion
    [request setPredicate:predicate];
    [request setEntity:[NSEntityDescription entityForName:@"Frecuencia" inManagedObjectContext:self.context]];
    Frecuencia* obj = [[self.context executeFetchRequest:request error:&error]firstObject];
    NSManagedObject* ManObj = (NSManagedObject*)obj;
    [self.context deleteObject:ManObj];
    [self.context save:&error];
    
}

-(void)setFrecuencia{
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context =[self.appDelegate managedObjectContext];
    NSFetchRequest *request;
    NSError *error;
    
    //Elimianr
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_frecuencia == %@", @""]; //condicion
    //[request setPredicate:predicate];
    request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Frecuencia" inManagedObjectContext:self.context]];
    int count = [[self.context executeFetchRequest:request error:&error]count];
    
    for (int i = 0; i < count; i++) {

        Frecuencia* obj = [[self.context executeFetchRequest:request error:&error]objectAtIndex:0];
        NSManagedObject* ManObj = (NSManagedObject*)obj;
        [self.context deleteObject:ManObj];
        [self.context save:&error];
    }
    
    
    //agregar
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:@"Hora"];
    [array addObject:@"Dia"];
    [array addObject:@"Semana"];
    [array addObject:@"Quincena"];
    [array addObject:@"Mes"];
    
    for(int i = 0; i< [array count]; i++){
        //agregando
        Frecuencia *frecuencia = [NSEntityDescription insertNewObjectForEntityForName:@"Frecuencia" inManagedObjectContext:self.context];
        frecuencia.id_frecuencia = [NSNumber numberWithInt:i];
        frecuencia.nb_frecuencia = [array objectAtIndex:i];
        
        [self.context save:&error];
        if(error)
            NSLog(@"%@",error);
    }
}

-(NSMutableDictionary *)leerPareto:(int) id_problema{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_problema == %d", id_problema]; //condicion
    NSMutableDictionary *dicPareto = [[NSMutableDictionary alloc]init];
    
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context =[self.appDelegate managedObjectContext];
    NSFetchRequest *request;
    NSError *error;

    request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Problemas" inManagedObjectContext:self.context]];
    [request setPredicate:predicate];
    
    if(error)
        NSLog(@"%@",error);
    
    Problemas *problemas =[[self.context executeFetchRequest:request error:&error]firstObject];

    [dicPareto setObject:@"1" forKey:@"EstatusGuardado"];
    if([problemas.sn_unidad integerValue] == 1){
        [dicPareto setObject:problemas.sn_unidad forKey:@"unidadMedidaValue"];
        [dicPareto setObject:@"Pesos" forKey:@"unidadMedida"];
        
    }else if([problemas.sn_unidad integerValue] == 0){
        [dicPareto setObject:problemas.sn_unidad forKey:@"unidadMedidaValue"];
        [dicPareto setObject:@"Unidades" forKey:@"unidadMedida"];
    }
    
    [dicPareto setObject:problemas.id_giro forKey:@"seleccionValue"];
    [dicPareto setObject:problemas.nb_problema forKey:@"mainProblem"];
    [dicPareto setObject:problemas.id_frecuencia forKey:@"FrecuenciaMedidaValue"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy hh:mm"];
    
    if(problemas.fh_frecuenciaInicio){
        NSString *stringFromDate = [df stringFromDate:problemas.fh_frecuenciaInicio];
        [dicPareto setObject:stringFromDate forKey:@"dateStart"];
    }else{
        [dicPareto setObject:@"" forKey:@"dateStart"];
    }
    
    if(problemas.fh_frecuenciaFin){
        NSString *stringFromDate = [df stringFromDate:problemas.fh_frecuenciaFin];
        [dicPareto setObject:stringFromDate forKey:@"dateFinish"];
    }else{
        [dicPareto setObject:@"" forKey:@"dateFinish"];
    }

    request = [[NSFetchRequest alloc] init];
    [request setPredicate:predicate];
    self.context =[self.appDelegate managedObjectContext];
    [request setEntity:[NSEntityDescription entityForName:@"Pareto" inManagedObjectContext:self.context]];
    
    int count =[[self.context executeFetchRequest:request error:&error]count];
    
    if(error)
        NSLog(@"%@",error);
    
    NSMutableArray *causesArray = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < count; i++){
        Pareto *obj =[[self.context executeFetchRequest:request error:&error]objectAtIndex:i];

        NSMutableDictionary *dicTemp = [[NSMutableDictionary alloc]init];
        [dicTemp setObject:obj.nb_causa forKey:@"name"];
        [dicTemp setObject:obj.pj_acumulado forKey:@"accumulatedPercentage"];
        [dicTemp setObject:obj.pj_frecuencia forKey:@"percentage"];
        [dicTemp setObject:obj.nu_frecuencia forKey:@"frecuency"];
        [dicTemp setObject:obj.nu_acumulado forKey:@"accumulated"];
        [causesArray addObject:dicTemp];
    }
    
    [dicPareto setObject:causesArray forKey:@"causesArray"];
    return dicPareto;
}

-(int)savePareto:(NSMutableDictionary *)dicPareto{
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context = [self.appDelegate managedObjectContext];
    NSFetchRequest *request;
    NSError *error;

    request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Problemas" inManagedObjectContext:self.context]];
    int id_problema = [[self.context executeFetchRequest:request error:&error]count]+1;
    Problemas *problema = [NSEntityDescription insertNewObjectForEntityForName:@"Problemas" inManagedObjectContext:self.context];

    problema.id_problema = [NSNumber numberWithInt:id_problema];
    problema.id_usuario = [NSNumber numberWithInt:0]; //poner id usuario
    problema.id_frecuencia = [NSNumber numberWithInt:[[dicPareto objectForKey:@"FrecuenciaMedidaValue"] integerValue]];
    problema.id_giro = [NSNumber numberWithInt:[[dicPareto objectForKey:@"seleccionValue"] integerValue]];
    problema.sn_unidad = [NSNumber numberWithInt:[[dicPareto objectForKey:@"unidadMedidaValue"] integerValue]];
    problema.nb_problema = [dicPareto objectForKey:@"mainProblem"];
    
    
     NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSDate *myDate = [df dateFromString: [dicPareto objectForKey:@"dateStart"]];
    problema.fh_frecuenciaInicio = myDate;
    
    myDate = [df dateFromString: [dicPareto objectForKey:@"dateFinish"]];
    problema.fh_frecuenciaFin = myDate;
     
    [self.context save:&error];
    
    self.context =[self.appDelegate managedObjectContext];
    NSMutableArray *causesArray = [dicPareto objectForKey:@"causesArray"];
    for(int i = 0; i<[causesArray count]; i++){
        NSMutableDictionary *myDic = [causesArray objectAtIndex:i];
        Pareto *paretoDetail = [NSEntityDescription insertNewObjectForEntityForName:@"Pareto" inManagedObjectContext:self.context];

        paretoDetail.id_problema = [NSNumber numberWithInt:id_problema];
        paretoDetail.id_causa = [NSNumber numberWithInt:i];
        paretoDetail.nb_causa = [myDic objectForKey:@"name"];
        paretoDetail.nu_frecuencia = [NSNumber numberWithDouble:[[myDic objectForKey:@"frecuency"] doubleValue]];
        paretoDetail.nu_acumulado = [NSNumber numberWithDouble:[[myDic objectForKey:@"accumulated"] doubleValue]];
        paretoDetail.pj_acumulado = [NSNumber numberWithDouble:[[myDic objectForKey:@"accumulatedPercentage"] doubleValue]];
        paretoDetail.pj_frecuencia = [NSNumber numberWithDouble:[[myDic objectForKey:@"percentage"] doubleValue]];
        
        [self.context save:&error];
        if(error)
            NSLog(@"%@",error);
    }

    
    return id_problema;
}

-(void)saveIshikawa:(NSMutableDictionary *)dicIshikawa : (int) id_problema {
    
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context = [self.appDelegate managedObjectContext];
    NSManagedObjectContext *contextCincoW = [self.appDelegate managedObjectContext];
    NSManagedObjectContext *contextIshikawa = [self.appDelegate managedObjectContext];
    NSManagedObjectContext *contextIshikawaDet = [self.appDelegate managedObjectContext];
    NSManagedObjectContext *contextWhy = [self.appDelegate managedObjectContext];
    NSFetchRequest *request;
    NSError *error;
    
    request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Ishikawa" inManagedObjectContext:self.context]];
    
    int id_ishikawa = [[self.context executeFetchRequest:request error:&error]count]+1;
    //5w + 2h
    CincoW *cincoW = [NSEntityDescription insertNewObjectForEntityForName:@"CincoW" inManagedObjectContext:contextCincoW];
    
    cincoW.id_problema = [NSNumber numberWithInt:id_problema];
    cincoW.de_como = [dicIshikawa objectForKey:@"how"];
    cincoW.de_cuanto = [dicIshikawa objectForKey:@"HowMuch"];
    cincoW.de_que = [dicIshikawa objectForKey:@"what"];
    cincoW.de_porque = [dicIshikawa objectForKey:@"why"];
    cincoW.de_quien = [dicIshikawa objectForKey:@"who"];
    cincoW.de_cuando = [dicIshikawa objectForKey:@"when"];
    cincoW.de_donde = [dicIshikawa objectForKey:@"where"];

    //gurdar cincoW
    [contextCincoW save:&error];
    if(error)
        NSLog(@"%@",error);
   
    NSMutableArray *arrayWhy = [dicIshikawa objectForKey:@"arrayWhy"];
    for (int x = 0; x < 6; x++) {
        NSString *m = [NSString stringWithFormat:@"m%d",x+1];

        if([dicIshikawa objectForKey:m]){
            NSMutableDictionary *dicM= [dicIshikawa objectForKey:m];
            NSMutableArray *arrayMRes = [dicM objectForKey:@"arrayMRes"];
            for(int i= 0;i<[arrayMRes count];i++){
                Ishikawa *ishikawa = [NSEntityDescription insertNewObjectForEntityForName:@"Ishikawa" inManagedObjectContext:contextIshikawa];
                
                ishikawa.id_usuario = [NSNumber numberWithInt:0];
                ishikawa.id_problema = [NSNumber numberWithInt:id_problema];
                ishikawa.id_ishikawa = [NSNumber numberWithInt:id_ishikawa];
                ishikawa.id_categoria =[NSNumber numberWithInt:x+1];
                ishikawa.id_rama = [ NSNumber numberWithInt:i];
                
                NSMutableArray *arrayM = [arrayMRes objectAtIndex:i];
                for (int j = 0; j < [arrayM count]; j++) {
                    
                    IshikawaDet *ishikawaDet = [NSEntityDescription insertNewObjectForEntityForName:@"IshikawaDet" inManagedObjectContext:contextIshikawaDet];
                    
                    ishikawaDet.id_problema = [NSNumber numberWithInt:id_problema];
                    ishikawaDet.id_ishikawa = [NSNumber numberWithInt:id_ishikawa];
                    ishikawaDet.id_categoria =[NSNumber numberWithInt:x+1];
                    ishikawaDet.id_rama = [ NSNumber numberWithInt:i];
                    ishikawaDet.id_detalle = [NSNumber numberWithInt:j];
                    ishikawaDet.nu_prioridad =[NSNumber numberWithInt:0];
                    ishikawaDet.de_causa = [arrayM objectAtIndex:j];
                    
                    for(int z = 0; z <[arrayWhy count]; z++){
                        
                        NSMutableDictionary *dicWhy = [arrayWhy objectAtIndex:z];
                        
                        if([[dicWhy objectForKey:@"name"] isEqualToString:[arrayM objectAtIndex:j]]){
                            
                            Why *why = [NSEntityDescription insertNewObjectForEntityForName:@"Why" inManagedObjectContext:contextWhy];
                            
                            why.id_causa = [NSNumber numberWithInt:j];
                            why.id_problema = [NSNumber numberWithInt:id_problema];
                            why.id_categoria = [NSNumber numberWithInt:x+1];
                            
                            why.id_why = [NSNumber numberWithInt:z+1];
                            ishikawaDet.nu_prioridad =[NSNumber numberWithInt:z+1];
                            
                            if([dicWhy objectForKey:@"why1"])
                                why.de_why1 = [dicWhy objectForKey:@"why1"];
                            else
                                why.de_why1 = @"";
                            
                            if([dicWhy objectForKey:@"why2"])
                                why.de_why2 = [dicWhy objectForKey:@"why2"];
                            else
                                why.de_why2 = @"";
                            
                            if([dicWhy objectForKey:@"why3"])
                                why.de_why3 = [dicWhy objectForKey:@"why3"];
                            else
                                why.de_why3 = @"";
                            
                            if([dicWhy objectForKey:@"why4"])
                                why.de_why4 = [dicWhy objectForKey:@"why4"];
                            else
                                why.de_why4 = @"";
                            
                            if([dicWhy objectForKey:@"why5"])
                                why.de_why5 = [dicWhy objectForKey:@"why5"];
                            else
                                why.de_why5 = @"";
                            
                            //guardar Why!!!
                            [contextWhy save:&error];
                            
                            if(error)
                                NSLog(@"%@",error);
                        }
                    }
                    
                    //guardar ishikawaDet
                    [contextIshikawaDet save:&error];
                    if(error)
                        NSLog(@"%@",error);
                }
                //guardar ishikawa
                [contextIshikawa save:&error];
                if(error)
                    NSLog(@"%@",error);
            }
            
        }//termina if dicIshikawa
    }

    
    NSMutableArray *actionArray = [dicIshikawa objectForKey:@"actionArray"];
    for(int i = 0; i< [actionArray count]; i++){
        self.context = [self.appDelegate managedObjectContext];
        AnalisisFallas *analisisFallas = [NSEntityDescription insertNewObjectForEntityForName:@"AnalisisFallas" inManagedObjectContext:self.context];
        NSMutableDictionary *dicAction = [actionArray objectAtIndex:i];

        analisisFallas.de_documentoGenerar = [dicAction objectForKey:@"documentGenerated"];
        analisisFallas.de_documentoModificar = [dicAction objectForKey:@"documentModified"];
        analisisFallas.id_problema =[NSNumber numberWithInt:id_problema];
        analisisFallas.id_ishikawa=[NSNumber numberWithInt:id_ishikawa];
        analisisFallas.de_causa = [dicAction objectForKey:@"cause"];
        analisisFallas.id_analisis = [NSNumber numberWithInt:i];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy hh:mm"];
        NSString *fecha = [NSString stringWithFormat:@"%@",[dicAction objectForKey:@"dateStartRealized"]];
        NSDate *myDate = [df dateFromString: fecha];
        analisisFallas.fh_inicioRealizado = myDate;
        
        fecha = [NSString stringWithFormat:@"%@",[dicAction objectForKey:@"dateStartPlan"]];
        myDate = [df dateFromString: fecha];
        analisisFallas.fh_inicioPlan = myDate;
        
        fecha = [NSString stringWithFormat:@"%@",[dicAction objectForKey:@"dateFinishRealized"]];
        myDate = [df dateFromString: fecha];
        analisisFallas.fh_finRealizado = myDate;
        
        fecha = [NSString stringWithFormat:@"%@",[dicAction objectForKey:@"dateFinishPlan"]];
        myDate = [df dateFromString: fecha];
        analisisFallas.fh_finPlan = myDate;
        
        analisisFallas.nb_responsable = [dicAction objectForKey:@"responsible"];
        analisisFallas.nb_actividadRealizar = [dicAction objectForKey:@"activity"];
        analisisFallas.nb_accion = [dicAction objectForKey:@"action"];
        
        [self.context save:&error];
        if(error)
            NSLog(@"%@",error);
    }
}

-(void)saveActionFailure:(NSMutableArray *)actionArray countActionArray:(int)countActionArray{
    
    NSError *error;
    //NSMutableArray *actionArray = [dicIshikawa objectForKey:@"actionArray"];
    NSDictionary *dic = [actionArray objectAtIndex:0];
    int id_problema = [[dic objectForKey:@"id_problema"] integerValue];
    int id_ishikawa = [[dic objectForKey:@"id_ishikawa"]integerValue];
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context = [self.appDelegate managedObjectContext];
    for(int i = countActionArray ; i< [actionArray count]; i++){
        self.context =[self.appDelegate managedObjectContext];
        AnalisisFallas *analisisFallas = [NSEntityDescription insertNewObjectForEntityForName:@"AnalisisFallas" inManagedObjectContext:self.context];
        NSMutableDictionary *dicAction = [actionArray objectAtIndex:i];
        
        analisisFallas.de_documentoGenerar = [dicAction objectForKey:@"documentGenerated"];
        analisisFallas.de_documentoModificar = [dicAction objectForKey:@"documentModified"];
        analisisFallas.id_problema  = [NSNumber numberWithInt:id_problema];
        analisisFallas.id_ishikawa = [NSNumber numberWithInt:id_ishikawa];
        analisisFallas.de_causa = [dicAction objectForKey:@"cause"];
        analisisFallas.id_analisis = [NSNumber numberWithInt:i];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy hh:mm"];
        NSString *fecha = [NSString stringWithFormat:@"%@",[dicAction objectForKey:@"dateStartRealized"]];
        NSDate *myDate = [df dateFromString: fecha];
        analisisFallas.fh_inicioRealizado = myDate;
        
        fecha = [NSString stringWithFormat:@"%@",[dicAction objectForKey:@"dateStartPlan"]];
        myDate = [df dateFromString: fecha];
        analisisFallas.fh_inicioPlan = myDate;
        
        fecha = [NSString stringWithFormat:@"%@",[dicAction objectForKey:@"dateFinishRealized"]];
        myDate = [df dateFromString: fecha];
        analisisFallas.fh_finRealizado = myDate;
        
        fecha = [NSString stringWithFormat:@"%@",[dicAction objectForKey:@"dateFinishPlan"]];
        myDate = [df dateFromString: fecha];
        analisisFallas.fh_finPlan = myDate;
        
        analisisFallas.nb_responsable = [dicAction objectForKey:@"responsible"];
        analisisFallas.nb_actividadRealizar = [dicAction objectForKey:@"activity"];
        analisisFallas.nb_accion = [dicAction objectForKey:@"action"];
        
        [self.context save:&error];
        if(error)
            NSLog(@"%@",error);
    }

}

- (void)mdfActionArray:(NSMutableArray *)actionArray{
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context =[self.appDelegate managedObjectContext];
    NSFetchRequest *request;
    NSError *error;
    
    //Modificar
    for (int i = 0; i < [actionArray count]; i++) {
        NSMutableDictionary *dicAction = [actionArray objectAtIndex:i];
        request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"AnalisisFallas" inManagedObjectContext:self.context]];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_problema == %@", [dicAction objectForKey:@"id_problema"]]; //condicion
        //[request setPredicate:predicate];
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"id_ishikawa == %@", [dicAction objectForKey:@"id_ishikawa"]]; //condicion
        //[request setPredicate:predicate2];
        NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"id_analisis == %@", [dicAction objectForKey:@"id_analisis"]]; //condicion3
        //[request setPredicate:predicate3];
        
        NSArray *subpreds = [NSArray arrayWithObjects:predicate, predicate2 , predicate3, nil];
        NSPredicate *finished = [NSCompoundPredicate andPredicateWithSubpredicates:subpreds];
        
        [request setPredicate:finished];
        
        int count = [[self.context executeFetchRequest:request error:&error]count];
        
        AnalisisFallas* obj = [[self.context executeFetchRequest:request error:&error]objectAtIndex:0];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy hh:mm"];
        NSString *fecha = [NSString stringWithFormat:@"%@",[dicAction objectForKey:@"dateStartRealized"]];
        NSDate *myDate = [df dateFromString: fecha];
        obj.fh_inicioRealizado = myDate;
        
        fecha = [NSString stringWithFormat:@"%@",[dicAction objectForKey:@"dateFinishRealized"]];
        myDate = [df dateFromString: fecha];
        obj.fh_finRealizado = myDate;
        [self.context save:&error];
    }
}


-(NSMutableDictionary*)nameJSON:(NSMutableDictionary*)dicPareto{
    
    int id_JSON;
    
    if([dicPareto objectForKey:@"id_JSON"])
        return  dicPareto;
    
    if(![dicPareto objectForKey:@"nombreJSON"]){
        self.appDelegate = [[UIApplication sharedApplication]delegate];
        self.context =[self.appDelegate managedObjectContext];
        NSFetchRequest *request;
        NSError *error;
        
        request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Estatus" inManagedObjectContext:self.context]];
        id_JSON = [[self.context executeFetchRequest:request error:&error]count]+1;
        
        Estatus *estatus = [NSEntityDescription insertNewObjectForEntityForName:@"Estatus" inManagedObjectContext:self.context];
        estatus.id_estatus = [NSNumber numberWithInt:id_JSON];
        estatus.estatus = [NSNumber numberWithBool:NO];
        estatus.nombre_archivo = [NSString stringWithFormat:@"flujo%d.JSON",id_JSON];
        
        if([dicPareto objectForKey:@"mainProblem"]){
            estatus.mainProblem = [dicPareto objectForKey:@"mainProblem"];
        }else{
            return dicPareto;
        }
        
        [self.context save:&error];
        
        if(error)
            NSLog(@"%@",error);
        
        [dicPareto setObject:[NSString stringWithFormat:@"flujo%d.JSON",id_JSON] forKey:@"nombreJSON"];
        [dicPareto setObject:[NSString stringWithFormat:@"%d",id_JSON] forKey:@"id_JSON"];
    }
    return  dicPareto;
}
+(NSMutableDictionary*)readJson:(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * filePath =[[NSString alloc] initWithString:
                             [documentsDirectory stringByAppendingPathComponent:name]];
    //NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:name];
    NSLog(@"ruta de archivo: %@",filePath);
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    if (!myJSON) {
        NSLog(@"Archivo no se puede leer");
        NSMutableDictionary *jsonrtn;
        return jsonrtn;
    }
    
    NSError *error;
    NSMutableDictionary *json = [[NSMutableDictionary alloc]init];
    
    
    json = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    return json;
}


+(void)createJson:(NSMutableDictionary *)dicPareto : (NSMutableDictionary *)dicIshikawa : (NSString*)nameView{
    
    NSMutableDictionary *dicJSON = [[NSMutableDictionary alloc]init];
    
    if(dicPareto)
       [dicJSON setObject:dicPareto forKey:@"dicPareto"];
    else
        [dicJSON setObject:@"" forKey:@"dicPareto"];
    
    if(dicIshikawa)
        [dicJSON setObject:dicIshikawa forKey:@"dicIshikawa"];
    else{
        NSMutableDictionary *mydic = [[NSMutableDictionary alloc]init];
        [dicJSON setObject:mydic forKey:@"dicIshikawa"];
    }

    
    [dicJSON setObject:nameView forKey:@"nameView"];
    
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJSON options:NSJSONWritingPrettyPrinted error:&error];
    
    // convertimos los datos a un string para poder mostrarlos
    NSString *stringJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSFileManager *gestorArchivos = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * rutaArchivo =[[NSString alloc] initWithString:
                      [documentsDirectory stringByAppendingPathComponent:[dicPareto objectForKey:@"nombreJSON"]]];
    //NSString *rutaArchivo = [NSDocumentDirectory() stringByAppendingPathComponent:[dicPareto objectForKey:@"nombreJSON"]];
    NSLog(@"JSON: %@",stringJson);
    NSLog(@"ruta de archivo: %@",rutaArchivo);
    
    [gestorArchivos createFileAtPath: rutaArchivo contents:jsonData attributes: nil];
    
}
-(void)setEstatusTrue:(int)id_estatus{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context = [self.appDelegate managedObjectContext];
    [request setEntity:[NSEntityDescription entityForName:@"Estatus" inManagedObjectContext:self.context]];
    NSError* error;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_estatus == %d", id_estatus];
    [request setPredicate:predicate];
    int count =[[self.context executeFetchRequest:request error:&error]count];
    NSLog(@"%d",count);
    Estatus *estatus = [[self.context executeFetchRequest:request error:&error]firstObject];
    estatus.estatus = [[NSNumber alloc] initWithBool:YES];
    
    NSFileManager *gestorArchivos = [NSFileManager defaultManager];
    NSString *rutaArchivo = [NSTemporaryDirectory() stringByAppendingPathComponent:estatus.nombre_archivo];
    [gestorArchivos removeItemAtPath:rutaArchivo error:&error];
    [self.context save:&error];

    
}

-(NSMutableArray *)getEstatus{
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.context =[self.appDelegate managedObjectContext];
    NSFetchRequest *request;
    NSError *error;
    NSMutableArray *arrayReturn = [[NSMutableArray alloc]init];

    //leer
    request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Estatus" inManagedObjectContext:self.context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"estatus == %@", [NSNumber numberWithBool: NO]]; //condicion
    [request setPredicate:predicate];
    
    int count =[[self.context executeFetchRequest:request error:&error]count];
    
    if(error)
        NSLog(@"%@",error);
    
    for(int i = 0; i < count; i++){
        Estatus *obj =[[self.context executeFetchRequest:request error:&error]objectAtIndex:i];
        if(error)
            NSLog(@"%@",error);
        
        NSMutableDictionary *estatus = [[NSMutableDictionary alloc]init];
        [estatus setObject:obj.id_estatus forKey:@"id_estatus"];
        [estatus setObject:obj.nombre_archivo forKey:@"nombre_archivo"];
        [estatus setObject:obj.mainProblem forKey:@"mainProblem"];
        [estatus setObject:[NSString stringWithFormat:@"%@",obj.estatus] forKey:@"estatus"];
        [arrayReturn addObject:estatus];
        
    }
    return arrayReturn;
}

#pragma mark - make PDF
-(NSString *)makePdf:(NSMutableArray *)actionArray{
    //make PDF
    [self getDateMax:actionArray];
    NSString *pdfPath = [self setupPDFDocumentNamed:@"Jade Lean" Width:850 Height:1100];
    [self createPdf:0 actionArray:actionArray];
    [self finishPDF];

    return pdfPath;
}

- (void)createPdf:(int)numberOfPage actionArray:(NSMutableArray *)actionArray{
    int kPaddingCurrent = kPadding;
    
    [self beginPDFPage];
    
    UIImage *anImage = [UIImage imageNamed:@"logo_leanwork"];
    CGRect imageRect = [self addImage:anImage atPoint:CGPointMake(550 , 40)];
    kPaddingCurrent = imageRect.origin.y + kPadding + 40;
    
    [self addText:NSLocalizedString(@"Analisis de fallas", nil) withFrame:CGRectMake(280, 55 , 850, 200) fontSize:20.0f];
    [self addText:[NSString stringWithFormat:@"%@ (%@ - %@)", NSLocalizedString(@"Actividades", nil), fechaInicial, fechaFinal] withFrame:CGRectMake(30, imageRect.origin.y + imageRect.size.height - kPadding , 850, 200) fontSize:16.0f];
    
    CGRect lineRect = [self addLineWithFrame:CGRectMake(kPadding, imageRect.origin.y + imageRect.size.height + kPadding*3 , 800, 4) withColor:[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0]];
    
    kPaddingCurrent = lineRect.origin.y + lineRect.size.height;
    for (int i =numberOfPage; i < [actionArray count]; i++) {
        
        NSMutableDictionary *dicTemp = [actionArray objectAtIndex:i];
        
        //kPaddingCurrent += 20;
        CGRect textRect = [self addText:[dicTemp objectForKey:@""] withFrame:CGRectMake(kPadding*1, kPaddingCurrent, 850, 200) fontSize:12.0f];
        
        kPaddingCurrent += 20;
        textRect =  [self addText:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"lbl1", nil),[dicTemp objectForKey:@"cause"]] withFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height + kPadding, 850, 200) fontSize:12.0f];
        
        kPaddingCurrent += 20;
        textRect =[self addText:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"lbl2", nil), [dicTemp objectForKey:@"action"]] withFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height + kPadding, 850, 200) fontSize:12.0f];
        
        kPaddingCurrent += 20;
        textRect = [self addText:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"lbl3", nil), [dicTemp objectForKey:@"activity"]] withFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height + kPadding, 850, 200) fontSize:12.0f];
        
        kPaddingCurrent += 20;
        textRect =  [self addText:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"lbl4", nil), [dicTemp objectForKey:@"responsible"]] withFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height + kPadding, 850, 200) fontSize:12.0f];
        
        kPaddingCurrent += 20;
        textRect =  [self addText:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"lbl5", nil), [dicTemp objectForKey:@"documentGenerated"]] withFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height + kPadding, 850, 200) fontSize:12.0f];
        
        kPaddingCurrent += 20;
        textRect =  [self addText:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"lbl6", nil), [dicTemp objectForKey:@"documentModified"]] withFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height + kPadding, 850, 200) fontSize:12.0f];
        
        kPaddingCurrent += 20;
        textRect = [self addText:[NSString stringWithFormat:@"%@ %@      %@ %@", NSLocalizedString(@"lblFecha1", nil), [dicTemp objectForKey:@"dateStartPlan"], NSLocalizedString(@"lblFecha2", nil), [dicTemp objectForKey:@"dateFinishPlan"]] withFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height + kPadding, 850, 200) fontSize:12.0f];
        
        kPaddingCurrent += 20;
        textRect = [self addText:[NSString stringWithFormat:@"%@ %@      %@ %@", NSLocalizedString(@"lblFecha3", nil), [dicTemp objectForKey:@"dateStartRealized"], NSLocalizedString(@"lblFecha4", nil), [dicTemp objectForKey:@"dateFinishRealized"]] withFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height + kPadding, 850, 200) fontSize:12.0f];
        
        //Add line Blue
        textRect = [self addLineWithFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height + kPadding, 800, 4) withColor:[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0]];
        kPaddingCurrent = textRect.origin.y;
        if((i+1)%4 == 0 && i > 0){
            [self createPdf:i+1 actionArray:actionArray];
        }
    }
    
}

- (NSString *)setupPDFDocumentNamed:(NSString*)name Width:(float)width Height:(float)height {
    _pageSize = CGSizeMake(width, height);
    
    NSString *newPDFName = [NSString stringWithFormat:@"%@.pdf", name];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:newPDFName];
    
    UIGraphicsBeginPDFContextToFile(pdfPath, CGRectZero, nil);
    
    return pdfPath;
}

- (void)beginPDFPage {
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, _pageSize.width, _pageSize.height), nil);
}

- (void)finishPDF {
    UIGraphicsEndPDFContext();
}

- (CGRect)addText:(NSString*)text withFrame:(CGRect)frame fontSize:(float)fontSize {
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    CGSize stringSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(_pageSize.width - 2*20-2*20, _pageSize.height - 2*20 - 2*20) lineBreakMode:UILineBreakModeWordWrap];
    
    float textWidth = frame.size.width;
    
    if (textWidth < stringSize.width)
        textWidth = stringSize.width;
    if (textWidth > _pageSize.width)
        textWidth = _pageSize.width - frame.origin.x;
    
    CGRect renderingRect = CGRectMake(frame.origin.x, frame.origin.y, textWidth, stringSize.height);
    
    [text drawInRect:renderingRect
            withFont:font
       lineBreakMode:UILineBreakModeWordWrap
           alignment:UITextAlignmentLeft];
    
    frame = CGRectMake(frame.origin.x, frame.origin.y, textWidth, stringSize.height);
    
    return frame;
}

- (CGRect)addLineWithFrame:(CGRect)frame withColor:(UIColor*)color {
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    
    // this is the thickness of the line
    CGContextSetLineWidth(currentContext, frame.size.height);
    
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    return frame;
}

- (CGRect)addImage:(UIImage*)image atPoint:(CGPoint)point {
    CGRect imageFrame = CGRectMake(point.x, point.y, 230, 80);
    [image drawInRect:imageFrame];
    
    return imageFrame;
}

-(void)getDateMax:(NSMutableArray *)actionArray{
    NSMutableArray *arrayFechas = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [actionArray count]; i++) {
        NSMutableDictionary *myDic = [actionArray objectAtIndex:i];
        
        if(![[myDic objectForKey:@"dateStartPlan"] isEqualToString:@""]){
            [arrayFechas addObject:[myDic objectForKey:@"dateStartPlan"]];
        }
        if(![[myDic objectForKey:@"dateStartRealized"] isEqualToString:@""]){
            [arrayFechas addObject:[myDic objectForKey:@"dateStartRealized"]];
        }
        if(![[myDic objectForKey:@"dateFinishPlan"] isEqualToString:@""]){
            [arrayFechas addObject:[myDic objectForKey:@"dateFinishPlan"]];
        }
        if(![[myDic objectForKey:@"dateFinishRealized"] isEqualToString:@""]){
            [arrayFechas addObject:[myDic objectForKey:@"dateFinishRealized"]];
        }
    }
    NSString *dateMax;
    NSString *dateMin;
    if([arrayFechas count]>0){
        dateMax = [arrayFechas objectAtIndex:0];
        dateMin = [arrayFechas objectAtIndex:0];
    }
    
    for (int i = 1; i < [arrayFechas count]; i++) {
        
        NSString *newDate = [arrayFechas objectAtIndex:i];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy hh:mm"];
        NSString *fecha = [NSString stringWithFormat:@"%@",dateMax];
        
        NSDate *myDate = [df dateFromString: fecha];
        NSTimeInterval timeInMiliseconds = [myDate timeIntervalSince1970];
        double millisecondsMax = timeInMiliseconds*1000;
        
        fecha = [NSString stringWithFormat:@"%@",newDate];
        myDate = [df dateFromString: fecha];
        timeInMiliseconds = [myDate timeIntervalSince1970];
        double millisecondsNew = timeInMiliseconds*1000;
        
        fecha = [NSString stringWithFormat:@"%@",dateMin];
        myDate = [df dateFromString: fecha];
        timeInMiliseconds = [myDate timeIntervalSince1970];
        double millisecondsMin = timeInMiliseconds*1000;
        
        if(millisecondsNew > millisecondsMax){
            dateMax = newDate;
        }
        
        if(millisecondsNew < millisecondsMin){
            dateMin = newDate;
        }
    }
    NSLog(@"fecha maxicma: %@ \n fecha minima: %@",dateMax, dateMin);
    fechaInicial = dateMin;
    fechaFinal = dateMax;
}


//Termina pdf
@end
