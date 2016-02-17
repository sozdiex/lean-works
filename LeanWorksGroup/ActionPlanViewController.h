//
//  ActionPlanViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 18/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionPlanViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property NSMutableDictionary *dicIshikawa;
@property NSMutableDictionary *dicPareto;
@property BOOL historico;
@property (strong, nonatomic) NSMutableArray *failuresArray;
@property (strong, nonatomic) NSMutableArray *actionArray;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;

@property (weak, nonatomic) IBOutlet UIButton *buttonCausa;
@property  (strong,nonatomic) NSMutableArray *arrayCausaSelect;
@property (weak, nonatomic) IBOutlet UITextField *txtAccion;
@property (weak, nonatomic) IBOutlet UITextField *txtActividad;
@property (weak, nonatomic) IBOutlet UITextField *txtResponsable;
@property (weak, nonatomic) IBOutlet UITextField *txtDocumentoGenerar;
@property (weak, nonatomic) IBOutlet UITextField *txtDocumentoModificar;

@property (weak, nonatomic) IBOutlet UIButton *buttonFechaInicialPlan;
@property (weak, nonatomic) IBOutlet UIButton *buttonFechaFinalPlan;
@property (weak, nonatomic) IBOutlet UIButton *buttonFechaInicialRealizado;
@property (weak, nonatomic) IBOutlet UIButton *buttonFechaFinalRealizado;
/*
@property (weak, nonatomic) IBOutlet UIButton *date;
@property (weak, nonatomic) IBOutlet UIButton *dateEnd;*/

//@property (strong, nonatomic) IBOutlet UITableView *tableForm;
@property (weak, nonatomic) IBOutlet UITableView *tableData;
@property (strong, nonatomic) IBOutlet UITableView *tableDataFull;
@property (weak, nonatomic) IBOutlet UIView *viewForm;

/*@property (strong, nonatomic) IBOutlet UITableViewCell *causaCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *accionCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *actividadesCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *responsableCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *documentoGenerarCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *documentoModificarCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *fechaPlanCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *fechaRealizadoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *buttonCell;*/

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UILabel *lbl5;
@property (weak, nonatomic) IBOutlet UILabel *lbl6;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha1;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha2;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha3;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha4;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnNext;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@end
