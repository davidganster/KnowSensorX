@STATIC;1.0;p;15;AppController.jt;12856;@STATIC;1.0;I;21;Foundation/CPObject.jI;37;RestfulCappuccino/RestfulCappuccino.jI;29;RestfulCappuccino/CRSupport.ji;23;Frameworks/CPLightbox.ji;9;Globals.ji;26;Categories/CPDate_Format.ji;25;Categories/CPDate_Names.ji;27;Categories/CPDate_Methods.ji;32;Categories/CPColor_CustomColor.ji;26;Categories/CPImage_Icons.ji;26;Categories/CPString_Date.ji;23;Model/KCResourceBlock.ji;26;Model/KCImageTransformer.ji;18;Model/KCActivity.ji;17;Model/KCProject.ji;16;Model/KCExport.ji;21;Model/KCObservation.ji;44;KCCalendar/KCCalendarToolbarViewController.ji;37;KCCalendar/KCCalendarViewController.ji;45;Visualization/KCVisualizationViewController.ji;56;Visualization/KCVisualizationViewController_DataSource.ji;54;Visualization/KCVisualizationViewController_Delegate.ji;37;StopWatch/KCStopWatchViewController.ji;50;StopWatch/KCStopWatchConfigurationViewController.ji;30;KCAlertBox/KCNotificationBox.ji;22;KCHorizontalLineView.ji;23;KCLoginViewController.ji;24;KCExportViewController.ji;33;KCAllObservationsViewController.jt;11835;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("RestfulCappuccino/RestfulCappuccino.j",NO);
objj_executeFile("RestfulCappuccino/CRSupport.j",NO);
objj_executeFile("Frameworks/CPLightbox.j",YES);
objj_executeFile("Globals.j",YES);
objj_executeFile("Categories/CPDate_Format.j",YES);
objj_executeFile("Categories/CPDate_Names.j",YES);
objj_executeFile("Categories/CPDate_Methods.j",YES);
objj_executeFile("Categories/CPColor_CustomColor.j",YES);
objj_executeFile("Categories/CPImage_Icons.j",YES);
objj_executeFile("Categories/CPString_Date.j",YES);
objj_executeFile("Model/KCResourceBlock.j",YES);
objj_executeFile("Model/KCImageTransformer.j",YES);
objj_executeFile("Model/KCActivity.j",YES);
objj_executeFile("Model/KCProject.j",YES);
objj_executeFile("Model/KCExport.j",YES);
objj_executeFile("Model/KCObservation.j",YES);
objj_executeFile("KCCalendar/KCCalendarToolbarViewController.j",YES);
objj_executeFile("KCCalendar/KCCalendarViewController.j",YES);
objj_executeFile("Visualization/KCVisualizationViewController.j",YES);
objj_executeFile("Visualization/KCVisualizationViewController_DataSource.j",YES);
objj_executeFile("Visualization/KCVisualizationViewController_Delegate.j",YES);
objj_executeFile("StopWatch/KCStopWatchViewController.j",YES);
objj_executeFile("StopWatch/KCStopWatchConfigurationViewController.j",YES);
objj_executeFile("KCAlertBox/KCNotificationBox.j",YES);
objj_executeFile("KCHorizontalLineView.j",YES);
objj_executeFile("KCLoginViewController.j",YES);
objj_executeFile("KCExportViewController.j",YES);
objj_executeFile("KCAllObservationsViewController.j",YES);
var _1=objj_allocateClassPair(CPObject,"AppController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("theWindow"),new objj_ivar("visualizationView"),new objj_ivar("visualizationViewController"),new objj_ivar("toolbar"),new objj_ivar("exportButton"),new objj_ivar("reloadButton"),new objj_ivar("feedbackButton"),new objj_ivar("allObservationsButton"),new objj_ivar("modalSheet"),new objj_ivar("calendarPopOver"),new objj_ivar("calendarToolbarViewController"),new objj_ivar("stopWatchPopOver"),new objj_ivar("stopWatchViewController"),new objj_ivar("visualizationViewController"),new objj_ivar("reloadToolbarItemView"),new objj_ivar("currentActivity"),new objj_ivar("calendarPopOverShown"),new objj_ivar("stopWatchPopOverShown")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("applicationDidFinishLaunching:"),function(_3,_4,_5){
with(_3){
CPLog("AppController:applicationDidFinishLaunching");
CPLog(objj_msgSend(Globals,"getBaseURL"));
var _6=objj_msgSend(objj_msgSend(objj_msgSend(KCImageTransformer,"alloc"),"init"),"autorelease");
objj_msgSend(CPValueTransformer,"setValueTransformer:forName:",_6,"KCImageTransformer");
calendarToolbarViewController=objj_msgSend(objj_msgSend(KCCalendarToolbarViewController,"alloc"),"initWithCibName:bundle:","KCCalendarToolbarView",nil);
objj_msgSend(objj_msgSend(calendarToolbarViewController,"view"),"setFrameOrigin:",CPPointMake(15,5));
objj_msgSend(toolbar,"addSubview:",objj_msgSend(calendarToolbarViewController,"view"));
var _7=objj_msgSend(objj_msgSend(KCCalendarViewController,"alloc"),"initWithFrame:",CPRectMake(0,0,270,200));
objj_msgSend(_7,"setDelegate:",_3);
calendarPopOver=objj_msgSend(objj_msgSend(CPPopover,"alloc"),"init");
objj_msgSend(calendarPopOver,"setBehaviour:",CPPopoverBehaviorTransient);
objj_msgSend(calendarPopOver,"setAnimates:",YES);
objj_msgSend(calendarPopOver,"setContentViewController:",_7);
objj_msgSend(calendarPopOver,"setDelegate:",_3);
calendarPopOverShown=NO;
stopWatchViewController=objj_msgSend(objj_msgSend(KCStopWatchViewController,"alloc"),"initWithCibName:bundle:","KCStopWatchView",nil);
objj_msgSend(objj_msgSend(stopWatchViewController,"view"),"setCenter:",objj_msgSend(toolbar,"center"));
objj_msgSend(objj_msgSend(stopWatchViewController,"view"),"setAutoresizingMask:",CPViewMinXMargin|CPViewMaxXMargin);
objj_msgSend(toolbar,"addSubview:",objj_msgSend(stopWatchViewController,"view"));
var _8=objj_msgSend(objj_msgSend(KCStopWatchConfigurationViewController,"alloc"),"initWithCibName:bundle:","KCStopWatchConfigurationView",nil);
objj_msgSend(_8,"setDelegate:",_3);
objj_msgSend(_8,"setDataSource:",_3);
stopWatchPopOver=objj_msgSend(objj_msgSend(CPPopover,"alloc"),"init");
objj_msgSend(stopWatchPopOver,"setBehaviour:",CPPopoverBehaviorTransient);
objj_msgSend(stopWatchPopOver,"setAnimates:",YES);
objj_msgSend(stopWatchPopOver,"setContentViewController:",_8);
objj_msgSend(stopWatchPopOver,"setDelegate:",_3);
stopWatchPopOverShown=NO;
objj_msgSend(allObservationsButton,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_notes.png",CGSizeMake(50,50)));
objj_msgSend(allObservationsButton,"setAlternateImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_notes_highlighted.png",CGSizeMake(50,50)));
objj_msgSend(exportButton,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_export.png",CGSizeMake(50,50)));
objj_msgSend(exportButton,"setAlternateImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_export_highlighted.png",CGSizeMake(50,50)));
objj_msgSend(reloadButton,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_reload.png",CGSizeMake(50,50)));
objj_msgSend(reloadButton,"setAlternateImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_reload_highlighted.png",CGSizeMake(50,50)));
objj_msgSend(_3,"loadActivity");
objj_msgSend(visualizationViewController,"setStartDate:",objj_msgSend(CPDate,"date"));
}
}),new objj_method(sel_getUid("awakeFromCib"),function(_9,_a){
with(_9){
objj_msgSend(theWindow,"setFullPlatformWindow:",YES);
var _b=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/NSLinenBackgroundPattern.png",CPSizeMake(256,256)),_c=objj_msgSend(CPColor,"colorWithPatternImage:",_b);
objj_msgSend(objj_msgSend(theWindow,"contentView"),"setBackgroundColor:",_c);
}
}),new objj_method(sel_getUid("loadActivity"),function(_d,_e){
with(_d){
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_d,sel_getUid("activityDidLoad:"),"RestfulCappuccinoResourcesDidLoad",KCActivity);
objj_msgSend(KCActivity,"allAsync");
}
}),new objj_method(sel_getUid("activityDidLoad:"),function(_f,_10,_11){
with(_f){
currentActivity=nil;
var _12=objj_msgSend(objj_msgSend(objj_msgSend(_11,"object"),"restfulNotification"),"eventData");
if(objj_msgSend(_12,"count")>0){
currentActivity=objj_msgSend(_12,"objectAtIndex:",0);
objj_msgSend(stopWatchViewController,"startRecordingAtTime:withProject:andActivity:",objj_msgSend(currentActivity,"startDate"),objj_msgSend(currentActivity,"project"),objj_msgSend(currentActivity,"activity"));
}
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"removeObserver:name:object:",_f,"RestfulCappuccinoResourcesDidLoad",KCActivity);
}
}),new objj_method(sel_getUid("calendarView:didSelectDate:"),function(_13,_14,_15,_16){
with(_13){
objj_msgSend(calendarToolbarViewController,"setDate:",_16);
objj_msgSend(calendarPopOver,"close");
objj_msgSend(visualizationViewController,"setStartDate:",_16);
objj_msgSend(visualizationViewController,"setWeekMode:",NO);
}
}),new objj_method(sel_getUid("calendarView:didSelectDateRangeFrom:to:"),function(_17,_18,_19,_1a,_1b){
with(_17){
objj_msgSend(calendarToolbarViewController,"setTimespanFrom:to:",_1a,_1b);
objj_msgSend(calendarPopOver,"close");
objj_msgSend(visualizationViewController,"setStartDate:andEndDate:",_1a,_1b);
objj_msgSend(visualizationViewController,"setWeekMode:",YES);
}
}),new objj_method(sel_getUid("willStartRecordingWithProject:andActivity:"),function(_1c,_1d,_1e,_1f){
with(_1c){
var now=objj_msgSend(CPDate,"date");
objj_msgSend(stopWatchViewController,"startRecordingAtTime:withProject:andActivity:",now,objj_msgSend(_1e,"name"),_1f);
currentActivity=objj_msgSend(KCActivity,"new:",{activity:_1f,project:objj_msgSend(_1e,"identifier")});
objj_msgSend(currentActivity,"setStartDate:",now);
objj_msgSend(currentActivity,"saveAsync");
objj_msgSend(stopWatchPopOver,"close");
}
}),new objj_method(sel_getUid("willStopRecording"),function(_20,_21){
with(_20){
objj_msgSend(stopWatchViewController,"stopRecording");
if(currentActivity){
objj_msgSend(currentActivity,"setEndDate:",objj_msgSend(CPDate,"date"));
objj_msgSend(currentActivity,"saveAsync");
currentActivity=nil;
}
objj_msgSend(stopWatchPopOver,"close");
}
}),new objj_method(sel_getUid("resourceDidSave:"),function(_22,_23,_24){
with(_22){
var _25=objj_msgSend(objj_msgSend(objj_msgSend(_24,"object"),"restfulNotification"),"eventData");
objj_msgSend(currentActivity,"setIdentifier:",_25.identifier);
}
}),new objj_method(sel_getUid("isStopWatchInRecordMode"),function(_26,_27){
with(_26){
if(currentActivity==nil){
return NO;
}else{
return YES;
}
}
}),new objj_method(sel_getUid("projectOfStopWatch"),function(_28,_29){
with(_28){
if(currentActivity==nil){
return "";
}else{
return objj_msgSend(currentActivity,"project");
}
}
}),new objj_method(sel_getUid("activityOfStopWatch"),function(_2a,_2b){
with(_2a){
if(currentActivity==nil){
return "";
}else{
return objj_msgSend(currentActivity,"activity");
}
}
}),new objj_method(sel_getUid("popoverDidClose:"),function(_2c,_2d,_2e){
with(_2c){
if(_2e==calendarPopOver){
calendarPopOverShown=NO;
}else{
stopWatchPopOverShown=NO;
}
}
}),new objj_method(sel_getUid("openCalendar:"),function(_2f,_30,_31){
with(_2f){
if(calendarPopOverShown){
objj_msgSend(calendarPopOver,"close");
calendarPopOverShown=NO;
}else{
objj_msgSend(calendarPopOver,"showRelativeToRect:ofView:preferredEdge:",objj_msgSend(_31,"bounds"),_31,3);
calendarPopOverShown=YES;
}
}
}),new objj_method(sel_getUid("openStopWatch:"),function(_32,_33,_34){
with(_32){
if(stopWatchPopOverShown){
objj_msgSend(stopWatchPopOver,"close");
stopWatchPopOverShown=NO;
}else{
var _35=objj_msgSend(_34,"convertRectToBase:",objj_msgSend(_34,"bounds"));
_35.origin.y=2;
objj_msgSend(stopWatchPopOver,"showRelativeToRect:ofView:preferredEdge:",_35,_34,3);
stopWatchPopOverShown=YES;
}
}
}),new objj_method(sel_getUid("allObservationsButtonPressed:"),function(_36,_37,_38){
with(_36){
var _39=objj_msgSend(objj_msgSend(CPWindowController,"alloc"),"initWithWindowCibName:","KCObservationsWindow");
objj_msgSend(_39,"showWindow:",_36);
}
}),new objj_method(sel_getUid("exportButtonPressed:"),function(_3a,_3b,_3c){
with(_3a){
modalSheet=objj_msgSend(objj_msgSend(CPWindow,"alloc"),"initWithContentRect:styleMask:",CGRectMake(0,0,441,278),CPDocModalWindowMask);
objj_msgSend(modalSheet,"setMinSize:",CGSizeMake(441,278));
var _3d=objj_msgSend(objj_msgSend(KCExportViewController,"alloc"),"initWithCibName:bundle:","KCExportView",nil);
objj_msgSend(_3d,"setDelegate:",_3a);
objj_msgSend(modalSheet,"setContentView:",objj_msgSend(_3d,"view"));
objj_msgSend(CPApp,"beginSheet:modalForWindow:modalDelegate:didEndSelector:contextInfo:",modalSheet,theWindow,nil,nil,nil);
}
}),new objj_method(sel_getUid("reloadData:"),function(_3e,_3f,_40){
with(_3e){
}
}),new objj_method(sel_getUid("openUserVoice:"),function(_41,_42,_43){
with(_41){
UserVoice.showPopupWidget();
}
}),new objj_method(sel_getUid("didLoginSuccessfully:"),function(_44,_45,_46){
with(_44){
objj_msgSend(objj_msgSend(_46,"view"),"removeFromSuperview");
_46=nil;
objj_msgSend(_44,"loadActivity");
objj_msgSend(visualizationViewController,"setStartDate:",objj_msgSend(CPDate,"date"));
}
}),new objj_method(sel_getUid("willEndModalSheet:"),function(_47,_48,_49){
with(_47){
objj_msgSend(CPApp,"endSheet:",modalSheet);
objj_msgSend(modalSheet,"orderOut:",_47);
}
})]);
p;9;Globals.jt;628;@STATIC;1.0;t;610;
kDarkGrayColor="5f5f5f";
kDarkGrayShadowColor="d2d2d2";
kHexColors=["114586","C72519","006400","4A1E6E","FBD238","2B83CF","E53F1F","569C23","9D1165","FFFF45","83C9F9","EF942C","ADCF32","CC0066","969696"];
var _1=objj_allocateClassPair(CPObject,"Globals"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_2,[new objj_method(sel_getUid("getBaseURL"),function(_3,_4){
with(_3){
var _5=document.URL,_6=objj_msgSend(_5,"substringFromIndex:",objj_msgSend(_5,"length")-1);
if(objj_msgSend(_6,"isEqualToString:","/")){
_5=objj_msgSend(_5,"substringToIndex:",objj_msgSend(_5,"length")-1);
}
return _5;
}
})]);
p;33;KCAllObservationsViewController.jt;2994;@STATIC;1.0;t;2975;
var _1=objj_allocateClassPair(CPViewController,"KCAllObservationsViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("observationScrollView"),new objj_ivar("stackView"),new objj_ivar("stackViewArray")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("viewDidLoad"),function(_3,_4){
with(_3){
var _5=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/NSLinenBackgroundPattern.png",CPSizeMake(256,256)),_6=objj_msgSend(CPColor,"colorWithPatternImage:",_5);
objj_msgSend(objj_msgSend(_3,"view"),"setBackgroundColor:",_6);
stackViewArray=objj_msgSend(objj_msgSend(CPMutableArray,"alloc"),"init");
var _7=CGRectInset(objj_msgSend(objj_msgSend(observationScrollView,"contentView"),"frame"),0,5);
_7=CGRectOffset(_7,0,9);
stackView=objj_msgSend(objj_msgSend(TNStackView,"alloc"),"initWithFrame:",_7);
objj_msgSend(stackView,"setDataSource:",stackViewArray);
objj_msgSend(stackView,"setPadding:",15);
objj_msgSend(observationScrollView,"setDocumentView:",stackView);
var _8=objj_msgSend(objj_msgSend(CPDate,"dateWithTimeIntervalSince1970:",0),"ISOString"),_9=objj_msgSend(objj_msgSend(CPDate,"dateWithTimeIntervalSinceNow:",100),"ISOString");
observationsArray=objj_msgSend(KCObservation,"findWithParameters:",{start_date:_8,end_date:_9});
var _a=objj_msgSend(CPSortDescriptor,"sortDescriptorWithKey:ascending:","date",NO);
observationsArray=objj_msgSend(observationsArray,"sortedArrayUsingDescriptors:",objj_msgSend(CPArray,"arrayWithObject:",_a));
var _b=objj_msgSend(CPDate,"date");
for(var i=0;i<objj_msgSend(observationsArray,"count");i++){
console.log(i);
var _c=objj_msgSend(observationsArray,"objectAtIndex:",i);
date=objj_msgSend(_c,"date");
console.log(date);
var _d=objj_msgSend(CPDate,"beginOfDay:",date);
if(!objj_msgSend(_b,"isEqual:",_d)){
_b=_d;
objj_msgSend(_3,"addLabel:",_b);
}
objj_msgSend(_3,"addObservation:",_c);
}
objj_msgSend(stackView,"reload");
}
}),new objj_method(sel_getUid("addLabel:"),function(_e,_f,_10){
with(_e){
var _11=objj_msgSend(CPTextField,"labelWithTitle:",objj_msgSend(_10,"formatToDate"));
objj_msgSend(_11,"setFrame:",CGRectMake(0,0,200,22));
objj_msgSend(_11,"setTextColor:",objj_msgSend(CPColor,"colorWithWhite:alpha:",1,0.6));
objj_msgSend(_11,"setTextShadowColor:",objj_msgSend(CPColor,"colorWithWhite:alpha:",0.3,0.3));
objj_msgSend(_11,"setTextShadowOffset:",CGSizeMake(0,-1));
objj_msgSend(_11,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",20));
objj_msgSend(stackViewArray,"addObject:",_11);
}
}),new objj_method(sel_getUid("addObservation:"),function(_12,_13,_14){
with(_12){
var _15=objj_msgSend(objj_msgSend(KCObservationView,"alloc"),"initWithObservation:",_14);
objj_msgSend(_15,"setDelegate:",_12);
objj_msgSend(stackViewArray,"addObject:",_15);
}
}),new objj_method(sel_getUid("willDeleteObservationView:"),function(_16,_17,_18){
with(_16){
objj_msgSend(stackViewArray,"removeObject:",_18);
objj_msgSend(stackView,"reload");
}
})]);
p;24;KCExportViewController.jt;7440;@STATIC;1.0;i;17;Frameworks/md5.jsi;29;Frameworks/EKShakeAnimation.ji;36;Frameworks/EKActivityIndicatorView.jt;7324;
objj_executeFile("Frameworks/md5.js",YES);
objj_executeFile("Frameworks/EKShakeAnimation.j",YES);
objj_executeFile("Frameworks/EKActivityIndicatorView.j",YES);
var _1=objj_allocateClassPair(CPViewController,"KCExportViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("formatView"),new objj_ivar("dataActivitiesCB"),new objj_ivar("dataResourcesCB"),new objj_ivar("dataObservationsCB"),new objj_ivar("privacyWindowTitleCB"),new objj_ivar("privacyPathCB"),new objj_ivar("privacyProjectsCB"),new objj_ivar("privacyActivitiesCB"),new objj_ivar("privacyObservationsCB"),new objj_ivar("spinner"),new objj_ivar("serverInfoTF"),new objj_ivar("exportButton"),new objj_ivar("delegate"),new objj_ivar("formatRadioGroup"),new objj_ivar("timer")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("init"),function(_8,_9){
with(_8){
_8=objj_msgSendSuper({receiver:_8,super_class:objj_getClass("KCExportViewController").super_class},"init");
if(_8){
spinner=objj_msgSend(objj_msgSend(EKActivityIndicatorView,"alloc"),"initWithFrame:",CGRectMake(30,0,40,40));
objj_msgSend(spinner,"setColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(contentView,"addSubview:",spinner);
}
return _8;
}
}),new objj_method(sel_getUid("viewDidLoad"),function(_a,_b){
with(_a){
formatRadioGroup=objj_msgSend(_a,"radioGroupOfView:",objj_msgSend(_a,"view"));
objj_msgSend(formatRadioGroup,"setAction:",sel_getUid("formatChanged:"));
objj_msgSend(formatRadioGroup,"setTarget:",_a);
objj_msgSend(_a,"formatChanged:",formatRadioGroup);
}
}),new objj_method(sel_getUid("formatChanged:"),function(_c,_d,_e){
with(_c){
var _f=objj_msgSend(_e,"selectedRadio");
if(objj_msgSend(objj_msgSend(_f,"title"),"isEqualToString:","JSON")){
objj_msgSend(_c,"switchToJSON");
}else{
objj_msgSend(_c,"switchToCSV");
}
}
}),new objj_method(sel_getUid("switchToCSV"),function(_10,_11){
with(_10){
objj_msgSend(dataActivitiesCB,"setEnabled:",NO);
objj_msgSend(dataResourcesCB,"setEnabled:",YES);
objj_msgSend(dataObservationsCB,"setEnabled:",NO);
objj_msgSend(privacyWindowTitleCB,"setEnabled:",YES);
objj_msgSend(privacyPathCB,"setEnabled:",YES);
objj_msgSend(privacyProjectsCB,"setEnabled:",NO);
objj_msgSend(privacyActivitiesCB,"setEnabled:",NO);
objj_msgSend(privacyObservationsCB,"setEnabled:",NO);
}
}),new objj_method(sel_getUid("switchToJSON"),function(_12,_13){
with(_12){
objj_msgSend(dataActivitiesCB,"setEnabled:",YES);
objj_msgSend(dataResourcesCB,"setEnabled:",YES);
objj_msgSend(dataObservationsCB,"setEnabled:",YES);
objj_msgSend(privacyWindowTitleCB,"setEnabled:",YES);
objj_msgSend(privacyPathCB,"setEnabled:",YES);
objj_msgSend(privacyProjectsCB,"setEnabled:",YES);
objj_msgSend(privacyActivitiesCB,"setEnabled:",YES);
objj_msgSend(privacyObservationsCB,"setEnabled:",YES);
}
}),new objj_method(sel_getUid("cancelButtonPressed:"),function(_14,_15,_16){
with(_14){
objj_msgSend(_14,"cancelRequestWithMessage:","");
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("willEndModalSheet:"))){
objj_msgSend(delegate,"willEndModalSheet:",_14);
}
}
}),new objj_method(sel_getUid("exportButtonPressed:"),function(_17,_18,_19){
with(_17){
objj_msgSend(spinner,"startAnimating");
objj_msgSend(exportButton,"setEnabled:",NO);
var _1a="";
if(objj_msgSend(objj_msgSend(objj_msgSend(formatRadioGroup,"selectedRadio"),"title"),"isEqualToString:","JSON")){
_1a=objj_msgSend(Globals,"getBaseURL")+"/mirror/KCExports/json"+"?dAct="+objj_msgSend(dataActivitiesCB,"state")+"&dRes="+objj_msgSend(dataResourcesCB,"state")+"&dObs="+objj_msgSend(dataObservationsCB,"state")+"&pWin="+objj_msgSend(privacyWindowTitleCB,"state")+"&pPat="+objj_msgSend(privacyPathCB,"state")+"&pPro="+objj_msgSend(privacyProjectsCB,"state")+"&pAct="+objj_msgSend(privacyActivitiesCB,"state")+"&pObs="+objj_msgSend(privacyObservationsCB,"state");
}else{
_1a=objj_msgSend(Globals,"getBaseURL")+"/mirror/KCExports/csv"+"?dAct="+objj_msgSend(dataActivitiesCB,"state")+"&dRes="+objj_msgSend(dataResourcesCB,"state")+"&dObs="+objj_msgSend(dataObservationsCB,"state")+"&pWin="+objj_msgSend(privacyWindowTitleCB,"state")+"&pPat="+objj_msgSend(privacyPathCB,"state")+"&pPro="+objj_msgSend(privacyProjectsCB,"state")+"&pAct="+objj_msgSend(privacyActivitiesCB,"state")+"&pObs="+objj_msgSend(privacyObservationsCB,"state");
}
var _1b=objj_msgSend(CPURLRequest,"requestJSONWithURL:",_1a);
objj_msgSend(_1b,"setHTTPMethod:","GET");
var _1c=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_1b,nil);
objj_msgSend(_1c,"start");
objj_msgSend(_17,"setServerStatus:","Download started");
timer=objj_msgSend(CPTimer,"scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:",10,_17,sel_getUid("checkServerStatus:"),nil,YES);
}
}),new objj_method(sel_getUid("checkServerStatus:"),function(_1d,_1e,_1f){
with(_1d){
var _20=objj_msgSend(CPURLRequest,"requestWithURL:",objj_msgSend(CPURL,"URLWithString:",objj_msgSend(Globals,"getBaseURL")+"/mirror/KCExports"));
objj_msgSend(_20,"setHTTPMethod:","GET");
var _21=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_20,_1d);
objj_msgSend(_21,"start");
}
}),new objj_method(sel_getUid("connection:didFailWithError:"),function(_22,_23,_24,_25){
with(_22){
objj_msgSend(spinner,"stopAnimating");
}
}),new objj_method(sel_getUid("connection:didReceiveData:"),function(_26,_27,_28,_29){
with(_26){
var _2a=nil;
try{
var _2a=objj_msgSend(_29,"objectFromJSON");
}
catch(err){
objj_msgSend(spinner,"stopAnimating");
objj_msgSend(timer,"invalidate");
}
var _2b=objj_msgSend(CPDictionary,"dictionaryWithJSObject:",_2a),_2c=objj_msgSend(_2b,"objectForKey:","status");
if(objj_msgSend(_2c,"isEqualToString:","done")){
objj_msgSend(_26,"cancelRequestWithMessage:","Done Processing");
objj_msgSend(exportButton,"setEnabled:",YES);
window.location.href=objj_msgSend(Globals,"getBaseURL")+"/mirror/KCExports/download";
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("willEndModalSheet:"))){
objj_msgSend(delegate,"willEndModalSheet:",_26);
}
}else{
if(objj_msgSend(_2c,"isEqualToString:","inProgress")){
var _2d=objj_msgSend(_2b,"objectForKey:","message");
objj_msgSend(_26,"setServerStatus:",_2d);
}else{
if(objj_msgSend(_2c,"isEqualToString:","error")){
objj_msgSend(_26,"cancelRequestWithMessage:","Error");
}else{
objj_msgSend(_26,"cancelRequestWithMessage:","Unknown Error");
}
}
}
}
}),new objj_method(sel_getUid("cancelRequestWithMessage:"),function(_2e,_2f,_30){
with(_2e){
objj_msgSend(spinner,"stopAnimating");
objj_msgSend(timer,"invalidate");
objj_msgSend(_2e,"setServerStatus:",_30);
objj_msgSend(exportButton,"setEnabled:",YES);
}
}),new objj_method(sel_getUid("setServerStatus:"),function(_31,_32,_33){
with(_31){
objj_msgSend(serverInfoTF,"setStringValue:",_33);
}
}),new objj_method(sel_getUid("radioGroupOfView:"),function(_34,_35,_36){
with(_34){
var _37=nil;
var _38=objj_msgSend(_36,"subviews");
for(var i=0;i<objj_msgSend(_38,"count");i++){
var _39=objj_msgSend(_38,"objectAtIndex:",i);
if(objj_msgSend(_39,"isKindOfClass:",objj_msgSend(CPRadio,"class"))){
return objj_msgSend(_39,"radioGroup");
}else{
_37=objj_msgSend(_34,"radioGroupOfView:",_39);
if(_37!=nil){
return _37;
}
}
}
return _37;
}
})]);
p;22;KCHorizontalLineView.jt;311;@STATIC;1.0;t;293;
var _1=objj_allocateClassPair(CPView,"KCHorizontalLineView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("drawRect:"),function(_3,_4,_5){
with(_3){
objj_msgSend(_3,"setBackgroundColor:",objj_msgSend(CPColor,"colorWithHexString:","d4d4d4"));
}
})]);
p;23;KCLoginViewController.jt;3472;@STATIC;1.0;i;17;Frameworks/md5.jsi;29;Frameworks/EKShakeAnimation.jt;3397;
objj_executeFile("Frameworks/md5.js",YES);
objj_executeFile("Frameworks/EKShakeAnimation.j",YES);
var _1=objj_allocateClassPair(CPViewController,"KCLoginViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("loginView"),new objj_ivar("passwordTextField")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("loadView"),function(_8,_9){
with(_8){
var _a=objj_msgSend(objj_msgSend(CPApp,"mainWindow"),"frame"),_b=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",_a);
objj_msgSend(_b,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_b,"setBackgroundColor:",objj_msgSend(CPColor,"colorWithWhite:alpha:",0.1,0.6));
loginView=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",CGRectMake(0,0,280,240));
objj_msgSend(loginView,"setCenter:",objj_msgSend(_b,"center"));
objj_msgSend(loginView,"setAutoresizingMask:",CPViewMinXMargin|CPViewMaxXMargin|CPViewMinYMargin|CPViewMaxYMargin);
objj_msgSend(loginView,"setBackgroundColor:",objj_msgSend(CPColor,"whiteColor"));
loginView=objj_msgSend(CPShadowView,"shadowViewEnclosingView:withWeight:",loginView,CPHeavyShadow);
objj_msgSend(_b,"addSubview:",loginView);
var _c=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_lock.png",CGSizeMake(100,100));
var _d=objj_msgSend(objj_msgSend(CPImageView,"alloc"),"initWithFrame:",CGRectMake(90,45,100,100));
objj_msgSend(_d,"setImage:",_c);
objj_msgSend(loginView,"addSubview:",_d);
passwordTextField=objj_msgSend(CPSecureTextField,"textFieldWithStringValue:placeholder:width:","","Password",100);
objj_msgSend(passwordTextField,"setFrame:",CGRectMake(40,180,180,30));
[passwordTextField];
objj_msgSend(loginView,"addSubview:",passwordTextField);
var _e=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(220,187,16,16));
var _f=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/btn_login.png",CGSizeMake(16,16));
var _10=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/btn_openLink_highlighted.png",CGSizeMake(16,16));
objj_msgSend(_e,"setImage:",_f);
objj_msgSend(_e,"setAlternateImage:",_10);
objj_msgSend(_e,"setBordered:",NO);
objj_msgSend(_e,"setAction:",sel_getUid("logInButtonPressed:"));
objj_msgSend(_e,"setTarget:",_8);
objj_msgSend(_e,"setKeyEquivalent:",CPNewlineCharacter);
objj_msgSend(loginView,"addSubview:",_e);
objj_msgSend(_8,"setView:",_b);
}
}),new objj_method(sel_getUid("logInButtonPressed:"),function(_11,_12,_13){
with(_11){
var _14=hex_md5(objj_msgSend(passwordTextField,"objectValue"));
var _15=objj_msgSend(CPURLRequest,"requestWithURL:",objj_msgSend(Globals,"getBaseURL")+"mirror/KCCredentials?pw="+_14);
objj_msgSend(_15,"setValue:forHTTPHeaderField:","foo","If-Modified-Since");
objj_msgSend(_15,"setHTTPMethod:","GET");
var _16=objj_msgSend(CPURLConnection,"sendSynchronousRequest:",_15);
if(_16[0]>=400){
objj_msgSend(objj_msgSend(EKShakeAnimation,"alloc"),"initWithView:",loginView);
}else{
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("didLoginSuccessfully:"))){
objj_msgSend(delegate,"didLoginSuccessfully:",_11);
}
}
}
})]);
p;6;main.jt;267;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;181;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/AppKit.j",NO);
objj_executeFile("AppController.j",YES);
main=function(_1,_2){
CPApplicationMain(_1,_2);
};
p;32;Categories/CPColor_CustomColor.jt;1063;@STATIC;1.0;t;1044;
var _1=objj_getClass("CPColor");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPColor\"");
}
var _2=_1.isa;
class_addMethods(_2,[new objj_method(sel_getUid("darkGrayColor"),function(_3,_4){
with(_3){
return objj_msgSend(CPColor,"colorWithHexString:","5f5f5f");
}
}),new objj_method(sel_getUid("darkGrayShadowColor"),function(_5,_6){
with(_5){
return objj_msgSend(CPColor,"colorWithHexString:","d2d2d2");
}
}),new objj_method(sel_getUid("lightGrayColor"),function(_7,_8){
with(_7){
return objj_msgSend(CPColor,"colorWithHexString:","9199a6");
}
}),new objj_method(sel_getUid("blueColor"),function(_9,_a){
with(_9){
return objj_msgSend(CPColor,"colorWithHexString:","3676d2");
}
}),new objj_method(sel_getUid("blueShadowColor"),function(_b,_c){
with(_b){
return objj_msgSend(CPColor,"colorWithHexString:","f4f6f7");
}
}),new objj_method(sel_getUid("colorAtIndex:"),function(_d,_e,_f){
with(_d){
var _10=objj_msgSend(kHexColors,"objectAtIndex:",_f%15);
return objj_msgSend(CPColor,"colorWithHexString:",_10);
}
})]);
p;26;Categories/CPDate_Format.jt;1137;@STATIC;1.0;i;21;../Frameworks/date.jst;1092;
objj_executeFile("../Frameworks/date.js",YES);
var _1=objj_getClass("CPDate");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPDate\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("format:"),function(_3,_4,_5){
with(_3){
return _3.toString(_5);
}
}),new objj_method(sel_getUid("formatToDate"),function(_6,_7){
with(_6){
return _6.toString("yyyy-MM-dd");
}
}),new objj_method(sel_getUid("formatToTime"),function(_8,_9){
with(_8){
return _8.toString("HH:mm:ss");
}
}),new objj_method(sel_getUid("formatToShortTime"),function(_a,_b){
with(_a){
return _a.toString("HH:mm");
}
}),new objj_method(sel_getUid("description"),function(_c,_d){
with(_c){
return _c.toString();
}
}),new objj_method(sel_getUid("ISOString"),function(_e,_f){
with(_e){
var _10=new Date(_e),_11=_10.getTimezoneOffset();
_10.setHours(_10.getHours()+(_11/60));
var _12=_10.toString("yyyy-MM-ddTHH:mm:ssZ");
return _12;
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("dateWithFormat:"),function(_13,_14,_15){
with(_13){
var _16=new Date();
_16.toString(_15);
}
})]);
p;27;Categories/CPDate_Methods.jt;2471;@STATIC;1.0;i;21;../Frameworks/date.jst;2426;
objj_executeFile("../Frameworks/date.js",YES);
var _1=objj_getClass("CPDate");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPDate\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("day"),function(_3,_4){
with(_3){
return _3.getDate();
}
}),new objj_method(sel_getUid("hours"),function(_5,_6){
with(_5){
return _5.getHours();
}
}),new objj_method(sel_getUid("minutes"),function(_7,_8){
with(_7){
return _7.getMinutes();
}
}),new objj_method(sel_getUid("seconds"),function(_9,_a){
with(_9){
return _9.getSeconds();
}
}),new objj_method(sel_getUid("week"),function(_b,_c){
with(_b){
var _d=objj_msgSend(_b,"donnerstag:",_b),_e=_d.getFullYear(),_f=new Date(_e,0,4),_10=objj_msgSend(_b,"donnerstag:",_f),kw=Math.floor(1.5+(_d.getTime()-_10.getTime())/86400000/7);
return kw;
}
}),new objj_method(sel_getUid("donnerstag:"),function(_11,_12,_13){
with(_11){
var Do=new Date();
Do.setTime(_13.getTime()+(3-((_13.getDay()+6)%7))*86400000);
return Do;
}
}),new objj_method(sel_getUid("dateWithAddedDays:"),function(_14,_15,_16){
with(_14){
var _17=_14.clone();
return _17.addDays(_16);
}
}),new objj_method(sel_getUid("timeInSeconds"),function(_18,_19){
with(_18){
return (objj_msgSend(_18,"hours")*60*60)+(objj_msgSend(_18,"minutes")*60)+objj_msgSend(_18,"seconds");
}
}),new objj_method(sel_getUid("timeIntervalOfDaySince1970"),function(_1a,_1b){
with(_1a){
var _1c=objj_msgSend(CPDate,"dateWithTimeIntervalSince1970:",objj_msgSend(_1a,"timeIntervalSince1970"));
_1c.set({hour:0,minute:0,second:0,millisecond:0});
return objj_msgSend(_1c,"timeIntervalSince1970");
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("beginOfDay:"),function(_1d,_1e,_1f){
with(_1d){
var _20=new Date(objj_msgSend(_1f,"timeIntervalSince1970")*1000);
_20.set({hour:0,minute:0,second:0,millisecond:0});
return _20;
}
}),new objj_method(sel_getUid("endOfDay:"),function(_21,_22,_23){
with(_21){
var _24=new Date(objj_msgSend(_23,"timeIntervalSince1970")*1000);
_24.set({hour:23,minute:59,second:59,millisecond:999});
return _24;
}
}),new objj_method(sel_getUid("firstDayOfWeek:inYear:"),function(_25,_26,_27,_28){
with(_25){
var _29=new Date(_28,0,0);
_29.setWeek(_27);
return _29;
}
}),new objj_method(sel_getUid("lastDayOfWeek:inYear:"),function(_2a,_2b,_2c,_2d){
with(_2a){
var _2e=objj_msgSend(CPDate,"firstDayOfWeek:inYear:",_2c,_2d);
_2e=_2e.add(7).days();
return _2e.add(-1).seconds();
}
})]);
p;25;Categories/CPDate_Names.jt;992;@STATIC;1.0;t;974;
var _1=objj_getClass("CPDate");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPDate\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("weekdayName"),function(_3,_4){
with(_3){
var _5=objj_msgSend(CPArray,"arrayWithObjects:","Sunday","Monday","Tuesday","Wednesday","Thurday","Friday","Saturday",nil);
return objj_msgSend(_5,"objectAtIndex:",_3.getDay());
}
}),new objj_method(sel_getUid("monthName"),function(_6,_7){
with(_6){
var _8=objj_msgSend(CPArray,"arrayWithObjects:","January","February","March","April","May","June","July","August","September","October","November","December",nil);
return objj_msgSend(_8,"objectAtIndex:",_6.getMonth());
}
}),new objj_method(sel_getUid("shortMonthName"),function(_9,_a){
with(_9){
var _b=objj_msgSend(CPArray,"arrayWithObjects:","Jan.","Feb.","Mar.","Apr.","May","Jun.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.",nil);
return objj_msgSend(_b,"objectAtIndex:",_9.getMonth());
}
})]);
p;26;Categories/CPImage_Icons.jt;1236;@STATIC;1.0;t;1217;
var _1=objj_getClass("CPImage");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPImage\"");
}
var _2=_1.isa;
class_addMethods(_2,[new objj_method(sel_getUid("applicationImageNamed:size:"),function(_3,_4,_5,_6){
with(_3){
var _7=objj_msgSend(_3,"imageResolutionForSize:",_6);
return objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Icons/Applications/"+_5+"_"+_7+".png",_6);
}
}),new objj_method(sel_getUid("extensionImageNamed:size:"),function(_8,_9,_a,_b){
with(_8){
var _c=objj_msgSend(_8,"imageResolutionForSize:",_b);
return objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Icons/Extensions/"+_a+"_"+_c+".png",_b);
}
}),new objj_method(sel_getUid("failureImageWithSize:"),function(_d,_e,_f){
with(_d){
var _10=objj_msgSend(_d,"imageResolutionForSize:",_f);
return objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Icons/unknown_"+_10+".png",_f);
}
}),new objj_method(sel_getUid("imageResolutionForSize:"),function(_11,_12,_13){
with(_11){
var _14=Math.max(_13.width,_13.height);
if(_14>32){
return 128;
}else{
if(_14>16){
return 32;
}
}
return 16;
}
})]);
p;32;Categories/CPOutlineViewExtend.jt;1385;@STATIC;1.0;I;22;AppKit/CPOutlineView.jt;1339;
objj_executeFile("AppKit/CPOutlineView.j",NO);
var _1=objj_getClass("CPOutlineView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPOutlineView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("expandAll"),function(_3,_4){
with(_3){
for(var _5=0;objj_msgSend(_3,"itemAtRow:",_5);_5++){
var _6=objj_msgSend(_3,"itemAtRow:",_5);
if(objj_msgSend(_3,"isExpandable:",_6)){
objj_msgSend(_3,"expandItem:",_6);
}
}
}
}),new objj_method(sel_getUid("collapseAll"),function(_7,_8){
with(_7){
for(var _9=0;objj_msgSend(_7,"itemAtRow:",_9);_9++){
var _a=objj_msgSend(_7,"itemAtRow:",_9);
if(objj_msgSend(_7,"isExpandable:",_a)){
objj_msgSend(_7,"collapseItem:",_a);
}
}
}
}),new objj_method(sel_getUid("recoverExpandedWithBaseKey:itemKeyPath:"),function(_b,_c,_d,_e){
with(_b){
var _f=objj_msgSend(CPUserDefaults,"standardUserDefaults");
for(var _10=0;objj_msgSend(_b,"itemAtRow:",_10);_10++){
var _11=objj_msgSend(_b,"itemAtRow:",_10);
if(objj_msgSend(_b,"isExpandable:",_11)){
var key=_d+objj_msgSend(_11,"valueForKey:",_e);
if((objj_msgSend(objj_msgSend(_f,"objectForKey:","TNOutlineViewsExpandedGroups"),"objectForKey:",key)=="expanded")||(objj_msgSend(objj_msgSend(_f,"objectForKey:","TNOutlineViewsExpandedGroups"),"objectForKey:",key)==nil)){
objj_msgSend(_b,"expandItem:",_11);
}
}
}
}
})]);
p;26;Categories/CPString_Date.jt;544;@STATIC;1.0;t;526;
var _1=objj_getClass("CPString");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPString\"");
}
var _2=_1.isa;
class_addMethods(_2,[new objj_method(sel_getUid("stringOfTimeInterval:"),function(_3,_4,_5){
with(_3){
var _6=Math.floor(_5/60/60),_7=Math.floor(_5/60-_6*60),_8=_5-(_7*60+_6*60*60);
if(_6>0){
return objj_msgSend(CPString,"stringWithFormat:","%i hours, %i minutes, %i seconds",_6,_7,_8);
}else{
return objj_msgSend(CPString,"stringWithFormat:","%i minutes, %i seconds",_7,_8);
}
}
})]);
p;25;Categories/CPStringJSON.jt;446;@STATIC;1.0;t;428;
var _1=objj_getClass("CPString");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPString\"");
}
var _2=_1.isa;
class_addMethods(_2,[new objj_method(sel_getUid("randomString:"),function(_3,_4,_5){
with(_3){
var _6="0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz",_7="";
for(var i=0;i<_5;i++){
var _8=Math.floor(Math.random()*_6.length);
_7+=_6.substring(_8,_8+1);
}
return _7;
}
})]);
p;23;Frameworks/CPLightBox.jt;3998;@STATIC;1.0;I;21;Foundation/CPObject.jt;3953;
objj_executeFile("Foundation/CPObject.j",NO);
var _1;
var _2=objj_allocateClassPair(CPObject,"CPLightbox"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("_backgroundColor"),new objj_ivar("_backgroundWindow"),new objj_ivar("_modalWindow"),new objj_ivar("_sheetWindow"),new objj_ivar("_actionButtons")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("init"),function(_4,_5){
with(_4){
_4=objj_msgSendSuper({receiver:_4,super_class:objj_getClass("CPLightbox").super_class},"init");
if(_4){
_backgroundColor=objj_msgSend(CPColor,"colorWithCalibratedRed:green:blue:alpha:",209/255,216/255,227/255,0.7);
}
return _4;
}
}),new objj_method(sel_getUid("runModalForWindow:"),function(_6,_7,_8){
with(_6){
if(_modalWindow||_sheetWindow){
objj_msgSend(_6,"stopModal");
}
_modalWindow=_8;
for(var i=0;i<objj_msgSend(_actionButtons,"count");i++){
var _9=objj_msgSend(_actionButtons,"objectAtIndex:",i);
objj_msgSend(objj_msgSend(_modalWindow,"contentView"),"addSubview:",_9);
}
objj_msgSend(_6,"_show");
objj_msgSend(CPApp,"runModalForWindow:",_modalWindow);
if(!objj_msgSend(_modalWindow,"autoresizingMask")){
objj_msgSend(_modalWindow,"setAutoresizingMask:",CPViewMinXMargin|CPViewMaxXMargin|CPViewMinYMargin|CPViewMaxYMargin);
}
}
}),new objj_method(sel_getUid("runSheetForWindow:"),function(_a,_b,_c){
with(_a){
if(_modalWindow||_sheetWindow){
objj_msgSend(_a,"stopModal");
}
_sheetWindow=_c;
objj_msgSend(_a,"_show");
objj_msgSend(CPApp,"runModalForWindow:",_sheetWindow);
var _d=objj_msgSend(_sheetWindow,"frame");
objj_msgSend(_sheetWindow,"setFrameOrigin:",CGPointMake(CGRectGetMinX(_d),-CGRectGetHeight(_d)));
objj_msgSend(_sheetWindow,"setFrame:display:animate:",CGRectMake(CGRectGetMinX(_d),-26,CGRectGetWidth(_d),CGRectGetHeight(_d)),YES,YES);
if(!objj_msgSend(_sheetWindow,"autoresizingMask")){
objj_msgSend(_sheetWindow,"setAutoresizingMask:",CPViewMinXMargin|CPViewMaxXMargin);
}
}
}),new objj_method(sel_getUid("stopModal"),function(_e,_f){
with(_e){
objj_msgSend(CPApp,"stopModal");
objj_msgSend((_modalWindow||_sheetWindow),"orderOut:",_e);
objj_msgSend(_e,"_hide");
_modalWindow=nil;
_sheetWindow=nil;
}
}),new objj_method(sel_getUid("backgroundColor"),function(_10,_11){
with(_10){
return _backgroundColor;
}
}),new objj_method(sel_getUid("setBackgroundColor:"),function(_12,_13,_14){
with(_12){
_backgroundColor=_14;
}
}),new objj_method(sel_getUid("_show"),function(_15,_16){
with(_15){
if(!_backgroundWindow){
_backgroundWindow=objj_msgSend(objj_msgSend(CPWindow,"alloc"),"initWithContentRect:styleMask:",objj_msgSend(objj_msgSend(CPPlatformWindow,"primaryPlatformWindow"),"contentBounds"),CPBorderlessWindowMask);
objj_msgSend(_backgroundWindow,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
var _17=objj_msgSend(_backgroundWindow,"contentView");
objj_msgSend(_17,"setBackgroundColor:",_backgroundColor);
}
objj_msgSend(_backgroundWindow,"orderFront:",_15);
}
}),new objj_method(sel_getUid("_hide"),function(_18,_19){
with(_18){
objj_msgSend(_backgroundWindow,"orderOut:",_18);
}
}),new objj_method(sel_getUid("resizedRect:"),function(_1a,_1b,_1c){
with(_1a){
var _1d=_1c,_1e=objj_msgSend(objj_msgSend(CPPlatformWindow,"primaryPlatformWindow"),"contentBounds");
if(CGRectGetWidth(_1d)>CGRectGetWidth(_1e)){
console.log("bild zu breit");
var _1f=CGRectGetWidth(_1d)/CGRectGetHeight(_1d);
return CGRectMake(0,0,CGRectGetWidth(_1e)-50,(CGRectGetWidth(_1e)-50)/_1f);
}else{
if(CGRectGetHeight(_1d)>CGRectGetHeight(_1e)){
console.log("bild zu hoch");
var _1f=CGRectGetWidth(_1d)/CGRectGetHeight(_1d);
return CGRectMake(0,0,(CGRectGetHeight(_1e)-50)*_1f,CGRectGetHeight(_1e)-50);
}else{
return _1d;
}
}
}
}),new objj_method(sel_getUid("setActionButtons:"),function(_20,_21,_22){
with(_20){
_actionButtons=_22;
}
})]);
class_addMethods(_3,[new objj_method(sel_getUid("sharedLightbox"),function(_23,_24){
with(_23){
if(!_1){
_1=objj_msgSend(objj_msgSend(CPLightbox,"alloc"),"init");
}
return _1;
}
})]);
p;36;Frameworks/EKActivityIndicatorView.jt;5241;@STATIC;1.0;t;5222;
var _1=objj_allocateClassPair(CPView,"EKActivityIndicatorView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_isAnimating"),new objj_ivar("_shouldUseCSS"),new objj_ivar("_CSSProperty"),new objj_ivar("_step"),new objj_ivar("_timer"),new objj_ivar("_color"),new objj_ivar("_colorRed"),new objj_ivar("_colorGreen"),new objj_ivar("_colorBlue")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("EKActivityIndicatorView").super_class},"initWithFrame:",_5);
if(_3){
_isAnimating=NO;
_shouldUseCSS=NO;
objj_msgSend(_3,"setColor:",objj_msgSend(CPColor,"blackColor"));
objj_msgSend(_3,"setUseCSS:",YES);
}
return _3;
}
}),new objj_method(sel_getUid("checkCSS"),function(_6,_7){
with(_6){
var _8=["transform","webkitTransform","oTransform","MozTransform","msTransform"];
for(var i=0,_9;_9=_8[i++];){
if(typeof _6._DOMElement.style[_9]!="undefined"){
_CSSProperty=_9;
break;
}
}
}
}),new objj_method(sel_getUid("setUseCSS:"),function(_a,_b,_c){
with(_a){
if(!_CSSProperty){
objj_msgSend(_a,"checkCSS");
}
_shouldUseCSS=_c;
if(!_isAnimating){
return;
}
objj_msgSend(_a,"stopAnimating");
objj_msgSend(_a,"startAnimating");
}
}),new objj_method(sel_getUid("setColor:"),function(_d,_e,_f){
with(_d){
_color=_f;
_colorRed=objj_msgSend(_f,"redComponent");
_colorGreen=objj_msgSend(_f,"greenComponent");
_colorBlue=objj_msgSend(_f,"blueComponent");
if(_shouldUseCSS){
objj_msgSend(_d,"setNeedsDisplay:",YES);
}
}
}),new objj_method(sel_getUid("setObjectValue:"),function(_10,_11,_12){
with(_10){
switch(_12){
case YES:
objj_msgSend(_10,"startAnimating");
break;
case NO:
objj_msgSend(_10,"stopAnimating");
break;
}
}
}),new objj_method(sel_getUid("startAnimating"),function(_13,_14){
with(_13){
if(_isAnimating){
return;
}
_isAnimating=YES;
_step=1;
objj_msgSend(_13,"setNeedsDisplay:",YES);
_timer=objj_msgSend(CPTimer,"scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:",0.1,_13,sel_getUid("timerDidFire"),nil,YES);
}
}),new objj_method(sel_getUid("stopAnimating"),function(_15,_16){
with(_15){
if(!_isAnimating){
return;
}
_isAnimating=NO;
objj_msgSend(_timer,"invalidate");
objj_msgSend(_15,"setNeedsDisplay:",YES);
if(_shouldUseCSS&&_CSSProperty){
_15._DOMElement.style[_CSSProperty]="rotate(0deg)";
}
}
}),new objj_method(sel_getUid("isAnimating"),function(_17,_18){
with(_17){
return _isAnimating;
}
}),new objj_method(sel_getUid("color"),function(_19,_1a){
with(_19){
return _color;
}
}),new objj_method(sel_getUid("timerDidFire"),function(_1b,_1c){
with(_1b){
if(_step==12){
_step=1;
}else{
_step++;
}
if(!_CSSProperty||!_shouldUseCSS){
return objj_msgSend(_1b,"setNeedsDisplay:",YES);
}
var rad=_step/12*2*Math.PI;
var _1d="rotate("+rad+"rad)";
_1b._DOMElement.style[_CSSProperty]=_1d;
}
}),new objj_method(sel_getUid("drawRect:"),function(_1e,_1f,_20){
with(_1e){
var _21=MIN(_20.size.height,_20.size.width),c=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort");
CGContextClearRect(c,_20);
if(!_isAnimating){
return;
}
var _22=_21*0.1,_23=_21*0.28,_24=_22/2,_25=CGRectMake(_21/2-_22/2,0,_22,_23),_26=CGRectGetMinX(_25),_27=CGRectGetMidX(_25),_28=CGRectGetMaxX(_25),_29=CGRectGetMinY(_25),_2a=CGRectGetMidY(_25),_2b=CGRectGetMaxY(_25),_2c=[];
CGContextSetFillColor(c,objj_msgSend(CPColor,"blackColor"));
fillWithOpacity=function(_2d){
CGContextSetFillColor(c,objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",_colorRed,_colorGreen,_colorBlue,_2d));
};
for(i=1;i<=12;i++){
for(j=1;j<=6;j++){
_2c[j]=(_step<=j)?12-j:-j;
}
if(i==_step){
CGContextSetFillColor(c,_color);
}else{
if(i==_step+_2c[1]){
fillWithOpacity(0.9);
}else{
if(i==_step+_2c[2]){
fillWithOpacity(0.8);
}else{
if(i==_step+_2c[3]){
fillWithOpacity(0.7);
}else{
if(i==_step+_2c[4]){
fillWithOpacity(0.6);
}else{
if(i==_step+_2c[5]){
fillWithOpacity(0.5);
}else{
if(i==_step+_2c[6]){
fillWithOpacity(0.4);
}else{
fillWithOpacity(0.3);
}
}
}
}
}
}
}
CGContextBeginPath(c);
CGContextMoveToPoint(c,_26,_2a);
CGContextAddArcToPoint(c,_26,_29,_27,_29,_24);
CGContextAddArcToPoint(c,_28,_29,_28,_2a,_24);
CGContextAddArcToPoint(c,_28,_2b,_27,_2b,_24);
CGContextAddArcToPoint(c,_26,_2b,_26,_2a,_24);
CGContextClosePath(c);
CGContextFillPath(c);
CGContextTranslateCTM(c,_21/2,_21/2);
CGContextRotateCTM(c,30*(Math.PI/180));
CGContextTranslateCTM(c,-_21/2,-_21/2);
}
}
})]);
var _2e="EKActivityIndicatorViewColor";
var _1=objj_getClass("EKActivityIndicatorView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"EKActivityIndicatorView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_2f,_30,_31){
with(_2f){
_2f=objj_msgSendSuper({receiver:_2f,super_class:objj_getClass("EKActivityIndicatorView").super_class},"initWithCoder:",_31);
if(_2f){
objj_msgSend(_2f,"setColor:",objj_msgSend(_31,"decodeObjectForKey:",_2e));
}
return _2f;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_32,_33,_34){
with(_32){
objj_msgSendSuper({receiver:_32,super_class:objj_getClass("EKActivityIndicatorView").super_class},"encodeWithCoder:",_34);
objj_msgSend(_34,"encodeObject:forKey:",objj_msgSend(_32,"color"),_2e);
}
})]);
p;29;Frameworks/EKShakeAnimation.jt;1729;@STATIC;1.0;t;1710;
var _1=objj_allocateClassPair(CPObject,"EKShakeAnimation"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("target"),new objj_ivar("currentStep"),new objj_ivar("delta"),new objj_ivar("targetFrame"),new objj_ivar("steps"),new objj_ivar("stepDuration"),new objj_ivar("timer")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithView:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("EKShakeAnimation").super_class},"init")){
target=_5;
targetFrame=objj_msgSend(target,"frame");
currentStep=1;
delta=7;
steps=5;
stepDuration=0.07;
timer=objj_msgSend(CPTimer,"scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:",stepDuration,_3,sel_getUid("timerDidFire"),nil,YES);
objj_msgSend(timer,"fire");
}
return _3;
}
}),new objj_method(sel_getUid("timerDidFire"),function(_6,_7){
with(_6){
if(currentStep===steps){
objj_msgSend(timer,"invalidate");
setTimeout(function(){
objj_msgSend(_6,"animateToFrame:",targetFrame);
},stepDuration);
}else{
var _8=(currentStep%2===1)?-1:1;
objj_msgSend(_6,"animateToFrame:",CGRectMake(targetFrame.origin.x+delta*_8,targetFrame.origin.y,targetFrame.size.width,targetFrame.size.height));
currentStep++;
}
}
}),new objj_method(sel_getUid("animateToFrame:"),function(_9,_a,_b){
with(_9){
var _c=objj_msgSend(objj_msgSend(CPViewAnimation,"alloc"),"initWithViewAnimations:",[objj_msgSend(CPDictionary,"dictionaryWithJSObject:",{CPViewAnimationTargetKey:target,CPViewAnimationStartFrameKey:targetFrame,CPViewAnimationEndFrameKey:_b})]);
objj_msgSend(_c,"setAnimationCurve:",CPAnimationLinear);
objj_msgSend(_c,"setDuration:",stepDuration);
objj_msgSend(_c,"startAnimation");
targetFrame=_b;
}
})]);
p;40;Frameworks/RestfulCappuccino/CRSupport.jt;4681;@STATIC;1.0;I;19;Foundation/CPDate.jI;21;Foundation/CPString.jI;28;Foundation/CPURLConnection.jI;25;Foundation/CPURLRequest.jt;4549;
objj_executeFile("Foundation/CPDate.j",NO);
objj_executeFile("Foundation/CPString.j",NO);
objj_executeFile("Foundation/CPURLConnection.j",NO);
objj_executeFile("Foundation/CPURLRequest.j",NO);
var _1=objj_getClass("CPDate");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPDate\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("year"),function(_3,_4){
with(_3){
return _3.getFullYear();
}
}),new objj_method(sel_getUid("month"),function(_5,_6){
with(_5){
return _5.getMonth()+1;
}
}),new objj_method(sel_getUid("day"),function(_7,_8){
with(_7){
return _7.getDate();
}
}),new objj_method(sel_getUid("toDateString"),function(_9,_a){
with(_9){
return objj_msgSend(CPString,"stringWithFormat:","%04d-%02d-%02d",objj_msgSend(_9,"year"),objj_msgSend(_9,"month"),objj_msgSend(_9,"day"));
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("dateWithDateString:"),function(_b,_c,_d){
with(_b){
return objj_msgSend(objj_msgSend(_b,"alloc"),"initWithString:",_d+" 12:00:00 +0000");
}
}),new objj_method(sel_getUid("dateWithDateTimeString:"),function(_e,_f,_10){
with(_e){
var _11=/^(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}).?\d*?(Z|\+\d{2}:\d{2})$$/,d=_10.match(new RegExp(_11)),_12=d[1]+" "+d[2]+" ";
if(d[3]=="Z"){
_12+="+0000";
}else{
_12+=d[3].replace(":","");
}
return objj_msgSend(objj_msgSend(_e,"alloc"),"initWithString:",_12);
}
})]);
var _1=objj_getClass("CPString");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPString\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("railsifiedString"),function(_13,_14){
with(_13){
var str=_13;
var _15=str.split("::");
var _16=new RegExp("([ABCDEFGHIJKLMNOPQRSTUVWXYZ])","g");
var fb=new RegExp("^_");
for(var i=0;i<_15.length;i++){
_15[i]=_15[i].replace(_16,"_$1").replace(fb,"");
}
str=_15.join("/").toLowerCase();
return str;
}
}),new objj_method(sel_getUid("cappifiedString"),function(_17,_18){
with(_17){
var _19=_17.charAt(0).toLowerCase()+_17.substring(1);
var _1a=_19.split("_");
for(var x=1;x<_1a.length;x++){
_1a[x]=_1a[x].charAt(0).toUpperCase()+_1a[x].substring(1);
}
_19=_1a.join("");
return _19;
}
}),new objj_method(sel_getUid("toJSON"),function(_1b,_1c){
with(_1b){
var str=_1b;
try{
var obj=JSON.parse(str);
}
catch(anException){
CPLog.warn("Could not convert to JSON: "+str);
}
if(obj){
return obj;
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("jsonFromQueryString:"),function(_1d,_1e,_1f){
with(_1d){
var _20=_1f.split("&");
var _21="{ ";
for(var i=0;i<_20.length;i++){
var _22=_20[i].split("=");
_21+="\""+_22[0]+"\": \""+_22[1]+"\"";
if((_20.length-i)>1){
_21+=", ";
}
}
_21+=" }";
return JSON.parse(_21);
}
}),new objj_method(sel_getUid("paramaterStringFromJSON:"),function(_23,_24,_25){
with(_23){
paramsArray=objj_msgSend(CPArray,"array");
for(var _26 in _25){
objj_msgSend(paramsArray,"addObject:",(escape(_26)+"="+escape(_25[_26])));
}
return paramsArray.join("&");
}
}),new objj_method(sel_getUid("paramaterStringFromCPDictionary:"),function(_27,_28,_29){
with(_27){
var _2a=objj_msgSend(CPArray,"array"),_2b=objj_msgSend(_29,"allKeys");
for(var i=0;i<objj_msgSend(_29,"count");++i){
objj_msgSend(_2a,"addObject:",(escape(_2b[i])+"="+escape(objj_msgSend(_29,"valueForKey:",_2b[i]))));
}
return _2a.join("&");
}
})]);
var _1=objj_getClass("CPURLConnection");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPURLConnection\"");
}
var _2=_1.isa;
class_addMethods(_2,[new objj_method(sel_getUid("sendSynchronousRequest:"),function(_2c,_2d,_2e){
with(_2c){
try{
var _2f=new CFHTTPRequest();
_2f.open(objj_msgSend(_2e,"HTTPMethod"),objj_msgSend(objj_msgSend(_2e,"URL"),"absoluteString"),NO);
var _30=objj_msgSend(_2e,"allHTTPHeaderFields"),key=nil,_31=objj_msgSend(_30,"keyEnumerator");
while(key=objj_msgSend(_31,"nextObject")){
_2f.setRequestHeader(key,objj_msgSend(_30,"objectForKey:",key));
}
_2f.send(objj_msgSend(_2e,"HTTPBody"));
return objj_msgSend(CPArray,"arrayWithObjects:",_2f.status(),_2f.responseText());
}
catch(anException){
}
return nil;
}
})]);
var _1=objj_getClass("CPURLRequest");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPURLRequest\"");
}
var _2=_1.isa;
class_addMethods(_2,[new objj_method(sel_getUid("requestJSONWithURL:"),function(_32,_33,_34){
with(_32){
var _35=objj_msgSend(_32,"requestWithURL:",_34);
objj_msgSend(_35,"setValue:forHTTPHeaderField:","application/json","Accept");
objj_msgSend(_35,"setValue:forHTTPHeaderField:","application/json","Content-Type");
return _35;
}
})]);
p;48;Frameworks/RestfulCappuccino/RestfulCappuccino.jt;23203;@STATIC;1.0;I;21;Foundation/CPObject.jI;19;Foundation/CPDate.jI;21;Foundation/CPString.jI;28;Foundation/CPURLConnection.jI;25;Foundation/CPURLRequest.ji;11;CRSupport.jt;23028;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Foundation/CPDate.j",NO);
objj_executeFile("Foundation/CPString.j",NO);
objj_executeFile("Foundation/CPURLConnection.j",NO);
objj_executeFile("Foundation/CPURLRequest.j",NO);
objj_executeFile("CRSupport.j",YES);
var _1=objj_allocateClassPair(CPObject,"RestfulCappuccinoNotification"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("requestor"),new objj_ivar("modelName"),new objj_ivar("eventType"),new objj_ivar("eventParameters"),new objj_ivar("eventData")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("requestor"),function(_3,_4){
with(_3){
return requestor;
}
}),new objj_method(sel_getUid("setRequestor:"),function(_5,_6,_7){
with(_5){
requestor=_7;
}
}),new objj_method(sel_getUid("modelName"),function(_8,_9){
with(_8){
return modelName;
}
}),new objj_method(sel_getUid("setModelName:"),function(_a,_b,_c){
with(_a){
modelName=_c;
}
}),new objj_method(sel_getUid("eventType"),function(_d,_e){
with(_d){
return eventType;
}
}),new objj_method(sel_getUid("setEventType:"),function(_f,_10,_11){
with(_f){
eventType=_11;
}
}),new objj_method(sel_getUid("eventParameters"),function(_12,_13){
with(_12){
return eventParameters;
}
}),new objj_method(sel_getUid("setEventParameters:"),function(_14,_15,_16){
with(_14){
eventParameters=_16;
}
}),new objj_method(sel_getUid("eventData"),function(_17,_18){
with(_17){
return eventData;
}
}),new objj_method(sel_getUid("setEventData:"),function(_19,_1a,_1b){
with(_19){
eventData=_1b;
}
})]);
var _1c="id",_1d=objj_msgSend(CPDictionary,"dictionary"),_1e=objj_msgSend(objj_msgSend(RestfulCappuccinoNotification,"alloc"),"init");
RestfulCappuccinoResourceWillLoad="RestfulCappucinoResourceWillLoad";
RestfulCappuccinoResourceDidLoad="RestfulCappuccinoResourceDidLoad";
RestfulCappuccinoResourcesWillLoad="RestfulCappuccinoResourcesWillLoad";
RestfulCappuccinoResourcesDidLoad="RestfulCappuccinoResourcesDidLoad";
RestfulCappuccinoResourceWillSave="RestfulCappuccinoResourceWillSave";
RestfulCappuccinoResourceDidSave="RestfulCappuccinoResourceDidSave";
RestfulCappuccinoResourceDidNotSave="RestfulCappuccinoResourceDidNotSave";
RestfulCappuccinoResourceWillDestroy="RestfulCappuccinoResourceWillDestroy";
RestfulCappuccinoResourceDidDestroy="RestfulCappuccinoResourceDidDestroy";
RestfulCappuccinoResourceDidNotDestroy="RestfulCappuccinoResourceDidNotDestroy";
var _1=objj_allocateClassPair(CPObject,"RestfulCappuccino"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("identifier")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("identifier"),function(_1f,_20){
with(_1f){
return identifier;
}
}),new objj_method(sel_getUid("setIdentifier:"),function(_21,_22,_23){
with(_21){
identifier=_23;
}
}),new objj_method(sel_getUid("attributes"),function(_24,_25){
with(_24){
CPLog.warn("This method must be declared in your class to save properly.");
return {};
}
}),new objj_method(sel_getUid("attributeNames"),function(_26,_27){
with(_26){
if(objj_msgSend(_1d,"objectForKey:",objj_msgSend(_26,"className"))){
return objj_msgSend(_1d,"objectForKey:",objj_msgSend(_26,"className"));
}
var _28=objj_msgSend(CPArray,"array"),_29=class_copyIvarList(objj_msgSend(_26,"class"));
for(var i=0;i<_29.length;i++){
objj_msgSend(_28,"addObject:",_29[i].name);
}
objj_msgSend(_1d,"setObject:forKey:",_28,objj_msgSend(_26,"className"));
return _28;
}
}),new objj_method(sel_getUid("setAttributes:"),function(_2a,_2b,_2c){
with(_2a){
for(var _2d in _2c){
if(_2d==objj_msgSend(objj_msgSend(_2a,"class"),"identifierKey")){
objj_msgSend(_2a,"setIdentifier:",_2c[_2d].toString());
}else{
var _2e=objj_msgSend(_2d,"cappifiedString");
if(objj_msgSend(objj_msgSend(_2a,"attributeNames"),"containsObject:",_2e)){
var _2f=_2c[_2d];
switch(typeof _2f){
case "boolean":
if(_2f){
objj_msgSend(_2a,"setValue:forKey:",YES,_2e);
}else{
objj_msgSend(_2a,"setValue:forKey:",NO,_2e);
}
break;
case "number":
objj_msgSend(_2a,"setValue:forKey:",_2f,_2e);
break;
case "string":
if(_2f.match(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.?\d*?(Z|\+\d{2}:\d{2})$/)){
objj_msgSend(_2a,"setValue:forKey:",objj_msgSend(CPDate,"dateWithDateTimeString:",_2f),_2e);
}else{
if(_2f.length==7&&_2f.charAt(0)=="#"){
_2f=objj_msgSend(_2f,"stringByReplacingCharactersInRange:withString:",CPMakeRange(0,1),"");
objj_msgSend(_2a,"setValue:forKey:",objj_msgSend(CPColor,"colorWithHexString:",_2f),_2e);
}else{
objj_msgSend(_2a,"setValue:forKey:",_2f,_2e);
}
}
break;
case "object":
if(_2f==null){
objj_msgSend(_2a,"setValue:forKey:",nil,_2e);
}else{
if(_2f.length!=null){
var _30=objj_msgSend(CPArray,"array");
for(var i=0;i<_2f.length;i++){
var _31=objj_msgSend(CPClassFromString(objj_msgSend(_2a,"className")),"new:",_2f[i]);
objj_msgSend(_30,"addObject:",_31);
}
objj_msgSend(_2a,"setValue:forKey:",_30,_2e);
}else{
var _32=objj_msgSend(CPDictionary,"dictionaryWithJSObject:",_2f);
if(_32==null){
objj_msgSend(_2a,"setValue:forKey:",nil,_2e);
break;
}else{
if(objj_msgSend(objj_msgSend(_32,"valueForKey:","type"),"isEqual:","image")){
var _33=CGSizeMake(objj_msgSend(_32,"valueForKey:","width"),objj_msgSend(_32,"valueForKey:","height")),_34=objj_msgSend(Globals,"getBaseURL")+"/images/"+objj_msgSend(_32,"valueForKey:","path"),_35=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:",_34,_33);
objj_msgSend(_2a,"setValue:forKey:",_35,_2e);
}
}
}
}
break;
}
}
}
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("restfulNotification"),function(_36,_37){
with(_36){
return _1e;
}
}),new objj_method(sel_getUid("addObserver:"),function(_38,_39,_3a){
with(_38){
var _3b=objj_msgSend(CPNotificationCenter,"defaultCenter");
if(objj_msgSend(_3a,"respondsToSelector:",sel_getUid("resourceWillLoad:"))){
objj_msgSend(_3b,"removeObserver:name:object:",_3a,RestfulCappuccinoResourceWillLoad,_38);
objj_msgSend(_3b,"addObserver:selector:name:object:",_3a,sel_getUid("resourceWillLoad:"),RestfulCappuccinoResourceWillLoad,_38);
}
if(objj_msgSend(_3a,"respondsToSelector:",sel_getUid("resourceDidLoad:"))){
objj_msgSend(_3b,"removeObserver:name:object:",_3a,RestfulCappuccinoResourceDidLoad,_38);
objj_msgSend(_3b,"addObserver:selector:name:object:",_3a,sel_getUid("resourceDidLoad:"),RestfulCappuccinoResourceDidLoad,_38);
}
if(objj_msgSend(_3a,"respondsToSelector:",sel_getUid("resourcesWillLoad:"))){
objj_msgSend(_3b,"removeObserver:name:object:",_3a,RestfulCappuccinoResourcesWillLoad,_38);
objj_msgSend(_3b,"addObserver:selector:name:object:",_3a,sel_getUid("resourcesWillLoad:"),RestfulCappuccinoResourcesWillLoad,_38);
}
if(objj_msgSend(_3a,"respondsToSelector:",sel_getUid("resourcesDidLoad:"))){
objj_msgSend(_3b,"removeObserver:name:object:",_3a,RestfulCappuccinoResourcesDidLoad,_38);
objj_msgSend(_3b,"addObserver:selector:name:object:",_3a,sel_getUid("resourcesDidLoad:"),RestfulCappuccinoResourcesDidLoad,_38);
}
if(objj_msgSend(_3a,"respondsToSelector:",sel_getUid("resourceWillSave:"))){
objj_msgSend(_3b,"removeObserver:name:object:",_3a,RestfulCappuccinoResourceWillSave,_38);
objj_msgSend(_3b,"addObserver:selector:name:object:",_3a,sel_getUid("resourceWillSave:"),RestfulCappuccinoResourceWillSave,_38);
}
if(objj_msgSend(_3a,"respondsToSelector:",sel_getUid("resourceDidSave:"))){
objj_msgSend(_3b,"removeObserver:name:object:",_3a,RestfulCappuccinoResourceDidSave,_38);
objj_msgSend(_3b,"addObserver:selector:name:object:",_3a,sel_getUid("resourceDidSave:"),RestfulCappuccinoResourceDidSave,_38);
}
if(objj_msgSend(_3a,"respondsToSelector:",sel_getUid("resourceDidNotSave:"))){
objj_msgSend(_3b,"removeObserver:name:object:",_3a,RestfulCappuccinoResourceDidNotSave,_38);
objj_msgSend(_3b,"addObserver:selector:name:object:",_3a,sel_getUid("resourceDidNotSave:"),RestfulCappuccinoResourceDidNotSave,_38);
}
if(objj_msgSend(_3a,"respondsToSelector:",sel_getUid("resourceWillDestroy:"))){
objj_msgSend(_3b,"removeObserver:name:object:",_3a,RestfulCappuccinoResourceWillDestroy,_38);
objj_msgSend(_3b,"addObserver:selector:name:object:",_3a,sel_getUid("resourceWillDestroy:"),RestfulCappuccinoResourceWillDestroy,_38);
}
if(objj_msgSend(_3a,"respondsToSelector:",sel_getUid("resourceDidDestroy:"))){
objj_msgSend(_3b,"removeObserver:name:object:",_3a,RestfulCappuccinoResourceDidDestroy,_38);
objj_msgSend(_3b,"addObserver:selector:name:object:",_3a,sel_getUid("resourceDidDestroy:"),RestfulCappuccinoResourceDidDestroy,_38);
}
if(objj_msgSend(_3a,"respondsToSelector:",sel_getUid("resourceDidNotDestroy:"))){
objj_msgSend(_3b,"removeObserver:name:object:",_3a,RestfulCappuccinoResourceDidNotDestroy,_38);
objj_msgSend(_3b,"addObserver:selector:name:object:",_3a,sel_getUid("resourceDidNotDestroy:"),RestfulCappuccinoResourceDidNotDestroy,_38);
}
}
}),new objj_method(sel_getUid("removeObserver:"),function(_3c,_3d,_3e){
with(_3c){
var _3f=objj_msgSend(CPNotificationCenter,"defaultCenter");
objj_msgSend(_3f,"removeObserver:name:object:",_3e,RestfulCappuccinoResourceWillLoad,_3c);
objj_msgSend(_3f,"removeObserver:name:object:",_3e,RestfulCappuccinoResourceDidLoad,_3c);
objj_msgSend(_3f,"removeObserver:name:object:",_3e,RestfulCappuccinoResourcesWillLoad,_3c);
objj_msgSend(_3f,"removeObserver:name:object:",_3e,RestfulCappuccinoResourcesDidLoad,_3c);
objj_msgSend(_3f,"removeObserver:name:object:",_3e,RestfulCappuccinoResourceWillSave,_3c);
objj_msgSend(_3f,"removeObserver:name:object:",_3e,RestfulCappuccinoResourceDidSave,_3c);
objj_msgSend(_3f,"removeObserver:name:object:",_3e,RestfulCappuccinoResourceDidNotSave,_3c);
objj_msgSend(_3f,"removeObserver:name:object:",_3e,RestfulCappuccinoResourceWillDestroy,_3c);
objj_msgSend(_3f,"removeObserver:name:object:",_3e,RestfulCappuccinoResourceDidDestroy,_3c);
objj_msgSend(_3f,"removeObserver:name:object:",_3e,RestfulCappuccinoResourceDidNotDestroy,_3c);
}
}),new objj_method(sel_getUid("identifierKey"),function(_40,_41){
with(_40){
return _1c;
}
}),new objj_method(sel_getUid("resourcePath"),function(_42,_43){
with(_42){
return objj_msgSend(CPURL,"URLWithString:","/"+objj_msgSend(_42,"railsName")+"s");
}
}),new objj_method(sel_getUid("railsName"),function(_44,_45){
with(_44){
return objj_msgSend(objj_msgSend(_44,"className"),"railsifiedString");
}
}),new objj_method(sel_getUid("new"),function(_46,_47){
with(_46){
return objj_msgSend(_46,"new:",nil);
}
}),new objj_method(sel_getUid("new:"),function(_48,_49,_4a){
with(_48){
var _4b=objj_msgSend(objj_msgSend(_48,"alloc"),"init");
if(!_4a){
_4a={};
}
objj_msgSend(_4b,"setAttributes:",_4a);
return _4b;
}
})]);
var _1=objj_getClass("RestfulCappuccino");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"RestfulCappuccino\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("save"),function(_4c,_4d){
with(_4c){
return objj_msgSend(_4c,"saveWithRequestor:",nil);
}
}),new objj_method(sel_getUid("saveWithRequestor:"),function(_4e,_4f,_50){
with(_4e){
var _51=objj_msgSend(_4e,"resourceWillSaveWithRequestor:",_50);
if(!_51){
return NO;
}
var _52=objj_msgSend(CPURLConnection,"sendSynchronousRequest:",_51);
if(_52[0]>=400){
objj_msgSend(_4e,"resourceDidNotSaveWithResponse:andRequestor:",_52[1],_50);
return NO;
}else{
objj_msgSend(_4e,"resourceDidSaveWithResponse:andRequestor:",_52[1],_50);
return YES;
}
}
}),new objj_method(sel_getUid("saveAsync"),function(_53,_54){
with(_53){
objj_msgSend(_53,"saveAsyncWithRequestor:",nil);
}
}),new objj_method(sel_getUid("saveAsyncWithRequestor:"),function(_55,_56,_57){
with(_55){
var _58=objj_msgSend(_55,"resourceWillSaveWithRequestor:",_57);
if(!_58){
return NO;
}
var _59=objj_msgSend(objj_msgSend(CPURLConnection,"alloc"),"initWithRequest:delegate:startImmediately:",_58,objj_msgSend(_55,"class"),NO);
_59.requestor=_57;
_59.eventType=_58.eventType;
_59.modelTarget=_55;
objj_msgSend(_59,"start");
}
}),new objj_method(sel_getUid("destroy"),function(_5a,_5b){
with(_5a){
return objj_msgSend(_5a,"destroyWithRequestor:",nil);
}
}),new objj_method(sel_getUid("destroyWithRequestor:"),function(_5c,_5d,_5e){
with(_5c){
var _5f=objj_msgSend(_5c,"resourceWillDestroyWithRequestor:",_5e);
if(!_5f){
return NO;
}
var _60=objj_msgSend(CPURLConnection,"sendSynchronousRequest:",_5f);
if(_60[0]==200){
objj_msgSend(_5c,"resourceDidDestroyWithRequestor:",_5e);
return YES;
}else{
objj_msgSend(_5c,"resourceDidNotDestroyWithRequestor:",_5e);
return NO;
}
}
}),new objj_method(sel_getUid("destroyAsync"),function(_61,_62){
with(_61){
objj_msgSend(_61,"destroyAsyncWithRequestor:",nil);
}
}),new objj_method(sel_getUid("destroyAsyncWithRequestor:"),function(_63,_64,_65){
with(_63){
var _66=objj_msgSend(_63,"resourceWillDestroyWithRequestor:",_65);
if(!_66){
return NO;
}
var _67=objj_msgSend(objj_msgSend(CPURLConnection,"alloc"),"initWithRequest:delegate:startImmediately:",_66,objj_msgSend(_63,"class"),NO);
_67.requestor=_65;
_67.eventType=_66.eventType;
_67.modelTarget=_63;
objj_msgSend(_67,"start");
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("all"),function(_68,_69){
with(_68){
return objj_msgSend(_68,"findWithParameters:andRequestor:",nil,nil);
}
}),new objj_method(sel_getUid("allWithRequestor:"),function(_6a,_6b,_6c){
with(_6a){
return objj_msgSend(_6a,"findWithParameters:andRequestor:",nil,_6c);
}
}),new objj_method(sel_getUid("allAsync"),function(_6d,_6e){
with(_6d){
objj_msgSend(_6d,"findAsyncWithParameters:andRequestor:",nil,nil);
}
}),new objj_method(sel_getUid("allAsyncWithRequestor:"),function(_6f,_70,_71){
with(_6f){
objj_msgSend(_6f,"findAsyncWithParameters:andRequestor:",nil,_71);
}
}),new objj_method(sel_getUid("findWithParameters:"),function(_72,_73,_74){
with(_72){
return objj_msgSend(_72,"findWithParameters:andRequestor:",_74,_72);
}
}),new objj_method(sel_getUid("findWithParameters:andRequestor:"),function(_75,_76,_77,_78){
with(_75){
var _79=objj_msgSend(_75,"resourcesWillLoadWithParameters:andRequestor:",_77,_78);
if(!_79){
return NO;
}
var _7a=objj_msgSend(CPURLConnection,"sendSynchronousRequest:",_79);
if(_7a[0]>=400){
return nil;
}else{
return objj_msgSend(_75,"resourcesDidLoadWithResponse:parameters:andRequestor:",_7a[1],_77,_78);
}
}
}),new objj_method(sel_getUid("findAsyncWithParameters:"),function(_7b,_7c,_7d){
with(_7b){
objj_msgSend(_7b,"findAsyncWithParameters:andRequestor:",_7d,nil);
}
}),new objj_method(sel_getUid("findAsyncWithParameters:andRequestor:"),function(_7e,_7f,_80,_81){
with(_7e){
var _82=objj_msgSend(_7e,"resourcesWillLoadWithParameters:andRequestor:",_80,_81);
if(!_82){
return NO;
}
var _83=objj_msgSend(objj_msgSend(CPURLConnection,"alloc"),"initWithRequest:delegate:startImmediately:",_82,objj_msgSend(_7e,"class"),NO);
_83.requestor=_81;
_83.eventType=_82.eventType;
_83.eventParameters=_80;
objj_msgSend(_83,"start");
}
}),new objj_method(sel_getUid("create:"),function(_84,_85,_86){
with(_84){
return objj_msgSend(_84,"createWithAttributes:andRequestor:",_86,nil);
}
}),new objj_method(sel_getUid("createWithAttributes:andRequestor:"),function(_87,_88,_89,_8a){
with(_87){
var _8b=objj_msgSend(_87,"new:",_89);
if(objj_msgSend(_8b,"saveWithRequestor:",_8a)){
return _8b;
}else{
return nil;
}
}
}),new objj_method(sel_getUid("createAsync:"),function(_8c,_8d,_8e){
with(_8c){
var _8f=objj_msgSend(_8c,"new:",_8e);
objj_msgSend(_8f,"saveAsync");
}
}),new objj_method(sel_getUid("createAsyncWithParameters:andRequestor:"),function(_90,_91,_92,_93){
with(_90){
var _94=objj_msgSend(_90,"new:",attributes);
objj_msgSend(_94,"saveAsyncWithRequestor:",_93);
}
}),new objj_method(sel_getUid("connection:didReceiveData:"),function(_95,_96,_97,_98){
with(_95){
switch(_97.eventType){
case "Load":
objj_msgSend(_95,"resourcesDidLoadWithResponse:parameters:andRequestor:",_98,_97.eventParameters,_97.requestor);
break;
case "Save":
objj_msgSend(_97.modelTarget,"resourceDidSaveWithResponse:andRequestor:",_98,_97.requestor);
break;
case "Create":
objj_msgSend(_97.modelTarget,"resourceDidSaveWithResponse:andRequestor:",_98,_97.requestor);
break;
case "Update":
objj_msgSend(_97.modelTarget,"resourceDidSaveWithResponse:andRequestor:",_98,_97.requestor);
break;
case "Destroy":
objj_msgSend(_97.modelTarget,"resourceDidDestroyWithRequestor:",_97.requestor);
break;
}
}
})]);
var _1=objj_getClass("RestfulCappuccino");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"RestfulCappuccino\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("resourceWillSaveWithRequestor:"),function(_99,_9a,_9b){
with(_99){
objj_msgSend(_1e,"setRequestor:",_9b);
objj_msgSend(_1e,"setModelName:",objj_msgSend(_99,"className"));
objj_msgSend(_1e,"setEventData:",_99);
if(identifier){
var _9c=objj_msgSend(objj_msgSend(_99,"class"),"resourcePath")+"/"+identifier;
objj_msgSend(_1e,"setEventType:","Update");
}else{
var _9c=objj_msgSend(objj_msgSend(_99,"class"),"resourcePath");
objj_msgSend(_1e,"setEventType:","Create");
}
if(!_9c){
return nil;
}
var _9d=objj_msgSend(CPURLRequest,"requestJSONWithURL:",_9c);
_9d.eventType=objj_msgSend(_1e,"eventType");
objj_msgSend(_9d,"setHTTPMethod:",identifier?"PUT":"POST");
objj_msgSend(_9d,"setHTTPBody:",objj_msgSend(CPString,"JSONFromObject:",objj_msgSend(_99,"attributes")));
objj_msgSend(_9d,"setValue:forHTTPHeaderField:","foo","If-Modified-Since");
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:",RestfulCappuccinoResourceWillSave,_99);
return _9d;
}
}),new objj_method(sel_getUid("resourceDidSaveWithResponse:andRequestor:"),function(_9e,_9f,_a0,_a1){
with(_9e){
objj_msgSend(_1e,"setRequestor:",_a1);
objj_msgSend(_1e,"setModelName:",objj_msgSend(_9e,"className"));
if(objj_msgSend(_a0,"length")>1){
var _a2=objj_msgSend(_a0,"toJSON");
}
if(identifier){
objj_msgSend(_1e,"setEventType:","Update");
}else{
objj_msgSend(_1e,"setEventType:","Create");
}
objj_msgSend(_9e,"setAttributes:",_a2);
objj_msgSend(_1e,"setEventData:",_9e);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:",RestfulCappuccinoResourceDidSave,_9e);
}
}),new objj_method(sel_getUid("resourceDidNotSaveWithResponse:andRequestor:"),function(_a3,_a4,_a5,_a6){
with(_a3){
objj_msgSend(_1e,"setRequestor:",_a6);
objj_msgSend(_1e,"setModelName:",objj_msgSend(_a3,"className"));
objj_msgSend(_1e,"setEventData:",_a5);
if(identifier){
objj_msgSend(_1e,"setEventType:","Update");
}else{
objj_msgSend(_1e,"setEventType:","Create");
}
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:",RestfulCappuccinoResourceDidNotSave,_a3);
}
}),new objj_method(sel_getUid("resourceWillDestroyWithRequestor:"),function(_a7,_a8,_a9){
with(_a7){
objj_msgSend(_1e,"setRequestor:",_a9);
objj_msgSend(_1e,"setModelName:",objj_msgSend(_a7,"className"));
objj_msgSend(_1e,"setEventData:",[identifier]);
objj_msgSend(_1e,"setEventType:","Destroy");
var _aa=objj_msgSend(objj_msgSend(_a7,"class"),"resourcePath")+"/"+identifier;
if(!_aa){
return nil;
}
var _ab=objj_msgSend(CPURLRequest,"requestJSONWithURL:",_aa);
_ab.eventType="Destroy";
objj_msgSend(_ab,"setHTTPMethod:","DELETE");
objj_msgSend(_ab,"setValue:forHTTPHeaderField:","foo","If-Modified-Since");
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:",RestfulCappuccinoResourceWillDestroy,_a7);
return _ab;
}
}),new objj_method(sel_getUid("resourceDidDestroyWithRequestor:"),function(_ac,_ad,_ae){
with(_ac){
objj_msgSend(_1e,"setRequestor:",_ae);
objj_msgSend(_1e,"setModelName:",objj_msgSend(_ac,"className"));
objj_msgSend(_1e,"setEventData:",[identifier]);
objj_msgSend(_1e,"setEventType:","Destroy");
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:",RestfulCappuccinoResourceDidDestroy,_ac);
}
}),new objj_method(sel_getUid("resourceDidNotDestroyWithRequestor:"),function(_af,_b0,_b1){
with(_af){
objj_msgSend(_1e,"setRequestor:",_b1);
objj_msgSend(_1e,"setModelName:",objj_msgSend(_af,"className"));
objj_msgSend(_1e,"setEventData:",[identifier]);
objj_msgSend(_1e,"setEventType:","Delete");
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:",RestfulCappuccinoResourceDidNotDestroy,_af);
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("resourceWillLoad"),function(_b2,_b3){
with(_b2){
return objj_msgSend(_b2,"resourceWillLoad:",nil);
}
}),new objj_method(sel_getUid("resourceWillLoad:"),function(_b4,_b5,_b6){
with(_b4){
var _b7=objj_msgSend(_b4,"resourcePath");
if(_b6){
if(_b6.isa&&objj_msgSend(_b6,"isKindOfClass:",CPDictionary)){
_b7+=("?"+objj_msgSend(CPString,"paramaterStringFromCPDictionary:",_b6));
}else{
_b7+=("?"+objj_msgSend(CPString,"paramaterStringFromJSON:",_b6));
}
}
if(!_b7){
return nil;
}
var _b8=objj_msgSend(CPURLRequest,"requestJSONWithURL:",_b7);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:",CappuccinoRestfulResourceWillLoad,_b4);
return _b8;
}
}),new objj_method(sel_getUid("resourceDidLoad:"),function(_b9,_ba,_bb){
with(_b9){
var _bc=objj_msgSend(_bb,"toJSON"),_bd=_bc[objj_msgSend(_b9,"railsName")],_be=objj_msgSend(_b9,"new");
objj_msgSend(_be,"setAttributes:",_bd);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:",RestfulCappuccinoResourceDidLoad,_be);
return _be;
}
}),new objj_method(sel_getUid("resourcesWillLoadWithParameters:andRequestor:"),function(_bf,_c0,_c1,_c2){
with(_bf){
var _c3=objj_msgSend(_bf,"resourcePath");
if(_c1){
if(_c1.isa&&objj_msgSend(_c1,"isKindOfClass:",CPDictionary)){
_c3+=("?"+objj_msgSend(CPString,"paramaterStringFromCPDictionary:",_c1));
}else{
_c3+=("?"+objj_msgSend(CPString,"paramaterStringFromJSON:",_c1));
}
}
if(!_c3){
return nil;
}
objj_msgSend(_1e,"setRequestor:",_c2);
objj_msgSend(_1e,"setModelName:",objj_msgSend(_bf,"className"));
objj_msgSend(_1e,"setEventType:","Load");
objj_msgSend(_1e,"setEventParameters:",_c1);
objj_msgSend(_1e,"setEventData:",nil);
var _c4=objj_msgSend(CPURLRequest,"requestJSONWithURL:",_c3);
_c4.eventType=objj_msgSend(_1e,"eventType");
_c4.eventParameters=objj_msgSend(_1e,"eventParameters");
objj_msgSend(_c4,"setHTTPMethod:","GET");
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:",RestfulCappuccinoResourcesWillLoad,_bf);
return _c4;
}
}),new objj_method(sel_getUid("resourcesDidLoadWithResponse:parameters:andRequestor:"),function(_c5,_c6,_c7,_c8,_c9){
with(_c5){
var _ca=objj_msgSend(CPArray,"array");
if(objj_msgSend(objj_msgSend(_c7,"stringByTrimmingWhitespace"),"length")>0){
var _cb=objj_msgSend(_c7,"toJSON");
if(_cb.length!=null){
for(var i=0;i<_cb.length;i++){
var _cc=_cb[i];
objj_msgSend(_ca,"addObject:",objj_msgSend(_c5,"new:",_cc));
}
}else{
objj_msgSend(_ca,"addObject:",objj_msgSend(_c5,"new:",_cb));
}
}
objj_msgSend(_1e,"setRequestor:",_c9);
objj_msgSend(_1e,"setModelName:",objj_msgSend(_c5,"className"));
objj_msgSend(_1e,"setEventType:","Load");
objj_msgSend(_1e,"setEventParameters:",_c8);
objj_msgSend(_1e,"setEventData:",_ca);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:",RestfulCappuccinoResourcesDidLoad,_c5);
return _ca;
}
})]);
p;30;KCAlertBox/KCNotificationBox.jt;3719;@STATIC;1.0;i;39;../Frameworks/EKActivityIndicatorView.jt;3656;
objj_executeFile("../Frameworks/EKActivityIndicatorView.j",YES);
var _1=nil;
var _2=objj_allocateClassPair(CPWindowController,"KCNotificationBox"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("messageTextField"),new objj_ivar("spinner"),new objj_ivar("statusImageView")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("init"),function(_4,_5){
with(_4){
var _6=objj_msgSend(objj_msgSend(CPPanel,"alloc"),"initWithContentRect:styleMask:",CGRectMake(0,0,100,90),CPHUDBackgroundWindowMask);
_4=objj_msgSendSuper({receiver:_4,super_class:objj_getClass("KCNotificationBox").super_class},"initWithWindow:",_6);
if(_4){
objj_msgSend(_6,"setFloatingPanel:",YES);
objj_msgSend(_6,"setMovableByWindowBackground:",NO);
var _7=objj_msgSend(_6,"contentView");
messageTextField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CPRectMake(0,60,100,30));
objj_msgSend(messageTextField,"setAlignment:",CPCenterTextAlignment);
objj_msgSend(messageTextField,"setStringValue:","Message");
objj_msgSend(messageTextField,"setTextShadowColor:",objj_msgSend(CPColor,"lightGrayColor"));
objj_msgSend(messageTextField,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(messageTextField,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_7,"addSubview:",messageTextField);
spinner=objj_msgSend(objj_msgSend(EKActivityIndicatorView,"alloc"),"initWithFrame:",CGRectMake(30,0,40,40));
objj_msgSend(spinner,"setColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_7,"addSubview:",spinner);
statusImageView=objj_msgSend(objj_msgSend(CPImageView,"alloc"),"initWithFrame:",CGRectMake(30,0,40,40));
objj_msgSend(_7,"addSubview:",statusImageView);
}
return _4;
}
}),new objj_method(sel_getUid("showActivityWithMessage:"),function(_8,_9,_a){
with(_8){
objj_msgSend(messageTextField,"setStringValue:",_a);
objj_msgSend(spinner,"startAnimating");
objj_msgSend(_8,"show");
}
}),new objj_method(sel_getUid("show"),function(_b,_c){
with(_b){
objj_msgSend(objj_msgSend(CPApp,"mainWindow"),"setIgnoresMouseEvents:",YES);
objj_msgSend(objj_msgSend(_b,"window"),"center");
objj_msgSend(objj_msgSend(_b,"window"),"orderFront:",_b);
}
}),new objj_method(sel_getUid("closeWithSuccess"),function(_d,_e){
with(_d){
var _f=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_status_done.png",CGSizeMake(19,19));
objj_msgSend(_d,"closeWithImage:",_f);
}
}),new objj_method(sel_getUid("closeWithError"),function(_10,_11){
with(_10){
var _12=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_status_error.png",CGSizeMake(19,19));
objj_msgSend(_10,"closeWithImage:",_12);
}
}),new objj_method(sel_getUid("closeWithUnknown"),function(_13,_14){
with(_13){
var _15=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_status_unknown.png",CGSizeMake(19,19));
objj_msgSend(_13,"closeWithImage:",_15);
}
}),new objj_method(sel_getUid("closeWithImage:"),function(_16,_17,_18){
with(_16){
objj_msgSend(statusImageView,"setImage:",_18);
objj_msgSend(_16,"closeWindow:",_16);
}
}),new objj_method(sel_getUid("closeWindow:"),function(_19,_1a,_1b){
with(_19){
if(objj_msgSend(spinner,"isAnimating")){
objj_msgSend(spinner,"stopAnimating");
}
objj_msgSend(statusImageView,"setImage:",nil);
objj_msgSend(objj_msgSend(CPApp,"mainWindow"),"setIgnoresMouseEvents:",NO);
objj_msgSend(objj_msgSend(_19,"window"),"close");
}
})]);
class_addMethods(_3,[new objj_method(sel_getUid("sharedNotificationBox"),function(_1c,_1d){
with(_1c){
if(!_1){
_1=objj_msgSend(objj_msgSend(KCNotificationBox,"alloc"),"init");
}
return _1;
}
})]);
p;44;KCCalendar/KCCalendarToolbarViewController.jt;4580;@STATIC;1.0;t;4561;
var _1=objj_allocateClassPair(CPViewController,"KCCalendarToolbarViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dayTabViewItem"),new objj_ivar("monthDayTextField"),new objj_ivar("weekDayTextField"),new objj_ivar("monthYearTextField"),new objj_ivar("timespanTabViewItem"),new objj_ivar("fromDayTextField"),new objj_ivar("fromDateTextField"),new objj_ivar("toDayTextField"),new objj_ivar("toDateTextField")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("viewDidLoad"),function(_3,_4){
with(_3){
objj_msgSend(objj_msgSend(_3,"view"),"setBackgroundColor:",objj_msgSend(CPColor,"clearColor"));
objj_msgSend(objj_msgSend(_3,"view"),"setHidden:",NO);
objj_msgSend(_3,"initializeTimespanView");
objj_msgSend(_3,"initializeTextField:",monthDayTextField);
objj_msgSend(_3,"initializeTextField:",weekDayTextField);
objj_msgSend(_3,"initializeTextField:",monthYearTextField);
var _5=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",objj_msgSend(objj_msgSend(_3,"view"),"frame"));
objj_msgSend(_5,"setAutoresizingMask:",CPViewMinXMargin|CPViewMaxXMargin|CPViewMinYMargin|CPViewMaxYMargin);
objj_msgSend(_5,"setBordered:",NO);
objj_msgSend(_5,"setAction:",sel_getUid("openCalendar:"));
objj_msgSend(objj_msgSend(_3,"view"),"addSubview:",_5);
objj_msgSend(_3,"setDate:",objj_msgSend(CPDate,"date"));
}
}),new objj_method(sel_getUid("initializeTextField:"),function(_6,_7,_8){
with(_6){
var _9=objj_msgSend(CPColor,"darkGrayShadowColor"),_a=CGSizeMake(0,1);
objj_msgSend(_8,"setTextShadowColor:",_9);
objj_msgSend(_8,"setTextShadowOffset:",_a);
}
}),new objj_method(sel_getUid("initializeTimespanView"),function(_b,_c){
with(_b){
var _d=objj_msgSend(objj_msgSend(_b,"view"),"tabViewItemAtIndex:",1),_e=objj_msgSend(_d,"view");
fromDayTextField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CPRectMake(2,4,85,31));
objj_msgSend(fromDayTextField,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","5E5E5E"));
objj_msgSend(fromDayTextField,"setAlignment:",CPRightTextAlignment);
objj_msgSend(fromDayTextField,"setFont:",objj_msgSend(CPFont,"fontWithName:size:","Lucida Grande",13));
objj_msgSend(_b,"initializeTextField:",fromDayTextField);
objj_msgSend(_e,"addSubview:",fromDayTextField);
fromDateTextField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CPRectMake(89,-3,216,33));
objj_msgSend(fromDateTextField,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","5E5E5E"));
objj_msgSend(fromDateTextField,"setFont:",objj_msgSend(CPFont,"fontWithName:size:","Lucida Grande",22));
objj_msgSend(_b,"initializeTextField:",fromDateTextField);
objj_msgSend(_e,"addSubview:",fromDateTextField);
toDayTextField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CPRectMake(45,28,85,38));
objj_msgSend(toDayTextField,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","5E5E5E"));
objj_msgSend(toDayTextField,"setAlignment:",CPRightTextAlignment);
objj_msgSend(toDayTextField,"setFont:",objj_msgSend(CPFont,"fontWithName:size:","Lucida Grande",13));
objj_msgSend(_b,"initializeTextField:",toDayTextField);
objj_msgSend(_e,"addSubview:",toDayTextField);
toDateTextField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CPRectMake(132,21,216,33));
objj_msgSend(toDateTextField,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","5E5E5E"));
objj_msgSend(toDateTextField,"setFont:",objj_msgSend(CPFont,"fontWithName:size:","Lucida Grande",22));
objj_msgSend(_b,"initializeTextField:",toDateTextField);
objj_msgSend(_e,"addSubview:",toDateTextField);
}
}),new objj_method(sel_getUid("setDate:"),function(_f,_10,_11){
with(_f){
objj_msgSend(monthDayTextField,"setStringValue:",_11.getDate()+".");
objj_msgSend(weekDayTextField,"setStringValue:",objj_msgSend(_11,"weekdayName"));
objj_msgSend(monthYearTextField,"setStringValue:",objj_msgSend(_11,"monthName")+", "+_11.getFullYear());
objj_msgSend(objj_msgSend(_f,"view"),"selectTabViewItemAtIndex:",0);
}
}),new objj_method(sel_getUid("setTimespanFrom:to:"),function(_12,_13,_14,_15){
with(_12){
objj_msgSend(fromDayTextField,"setStringValue:",objj_msgSend(_14,"weekdayName"));
objj_msgSend(fromDateTextField,"setStringValue:",_14.getDate()+". "+objj_msgSend(_14,"shortMonthName")+" "+_14.getFullYear());
objj_msgSend(toDayTextField,"setStringValue:",objj_msgSend(_15,"weekdayName"));
objj_msgSend(toDateTextField,"setStringValue:",_15.getDate()+". "+objj_msgSend(_15,"shortMonthName")+" "+_15.getFullYear());
objj_msgSend(objj_msgSend(_12,"view"),"selectTabViewItemAtIndex:",1);
}
})]);
p;37;KCCalendar/KCCalendarViewController.jt;8949;@STATIC;1.0;I;21;Foundation/CPObject.ji;21;../Frameworks/date.jsi;22;KCDaysViewController.jt;8851;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("../Frameworks/date.js",YES);
objj_executeFile("KCDaysViewController.j",YES);
var _1=objj_allocateClassPair(CPViewController,"KCCalendarViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("mMonthAndYearTextField"),new objj_ivar("mDaysView"),new objj_ivar("mSelectedDay"),new objj_ivar("mSelectedMonth"),new objj_ivar("mDaysViewRect"),new objj_ivar("mCurrentMonthIndex"),new objj_ivar("mDaysViews"),new objj_ivar("mDayLabelWidth"),new objj_ivar("frame")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_8,_9,_a){
with(_8){
_8=objj_msgSendSuper({receiver:_8,super_class:objj_getClass("KCCalendarViewController").super_class},"init");
if(_8){
mSelectedDay=new Date();
mSelectedMonth=mSelectedDay;
mDayLabelWidth=(CGRectGetWidth(_a)-40-40)/7;
mDaysViewRect=CGRectMake(20,75,CGRectGetWidth(_a)-40,6*20);
mCurrentMonthIndex=0;
mDaysViews=objj_msgSend(objj_msgSend(CPMutableArray,"alloc"),"init");
frame=_a;
}
return _8;
}
}),new objj_method(sel_getUid("loadView"),function(_b,_c){
with(_b){
var _d=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",frame);
objj_msgSend(_b,"setView:",_d);
mMonthAndYearTextField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(0,0,CGRectGetWidth(objj_msgSend(objj_msgSend(_b,"view"),"frame")),55));
objj_msgSend(mMonthAndYearTextField,"setBezeled:",NO);
objj_msgSend(mMonthAndYearTextField,"setBezelStyle:",CPTextFieldSquareBezel);
objj_msgSend(mMonthAndYearTextField,"setBordered:",NO);
objj_msgSend(mMonthAndYearTextField,"setEditable:",NO);
objj_msgSend(mMonthAndYearTextField,"setStringValue:",objj_msgSend(_b,"monthAndYearString"));
objj_msgSend(mMonthAndYearTextField,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","828c99"));
objj_msgSend(mMonthAndYearTextField,"setTextShadowColor:",objj_msgSend(CPColor,"colorWithHexString:","f4f6f7"));
objj_msgSend(mMonthAndYearTextField,"setTextShadowOffset:",CGSizeMake(0,2));
objj_msgSend(mMonthAndYearTextField,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",20));
objj_msgSend(mMonthAndYearTextField,"setAlignment:",CPCenterTextAlignment);
objj_msgSend(mMonthAndYearTextField,"setVerticalAlignment:",CPCenterTextAlignment);
objj_msgSend(objj_msgSend(_b,"view"),"addSubview:",mMonthAndYearTextField);
var _e=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(10,10,35,35));
objj_msgSend(_e,"setBordered:",NO);
objj_msgSend(_e,"setImageOffset:",10);
objj_msgSend(_e,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/btn_previous.png",CGSizeMake(35,35)));
objj_msgSend(_e,"setAlternateImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/btn_previous_highlighted.png",CGSizeMake(35,35)));
objj_msgSend(_e,"setAction:",sel_getUid("prevButtonPressed:"));
objj_msgSend(_e,"setTarget:",_b);
objj_msgSend(objj_msgSend(_b,"view"),"addSubview:",_e);
var _f=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(CGRectGetWidth(objj_msgSend(objj_msgSend(_b,"view"),"frame"))-45,10,35,35));
objj_msgSend(_f,"setBordered:",NO);
objj_msgSend(_f,"setImageOffset:",10);
objj_msgSend(_f,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/btn_next.png",CGSizeMake(35,35)));
objj_msgSend(_f,"setAlternateImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/btn_next_highlighted.png",CGSizeMake(35,35)));
objj_msgSend(_f,"setAction:",sel_getUid("nextButtonPressed:"));
objj_msgSend(_f,"setTarget:",_b);
objj_msgSend(objj_msgSend(_b,"view"),"addSubview:",_f);
var i=0;
for(i=0;i<objj_msgSend(objj_msgSend(_b,"shortDayNames"),"count");i++){
var _10=objj_msgSend(_b,"weekDayLabelWithFrame:",CGRectMake(60+i*mDayLabelWidth,55,mDayLabelWidth,20));
objj_msgSend(_10,"setStringValue:",objj_msgSend(objj_msgSend(_b,"shortDayNames"),"objectAtIndex:",i));
objj_msgSend(objj_msgSend(_b,"view"),"addSubview:",_10);
}
var _11=objj_msgSend(_b,"weekDayLabelWithFrame:",CGRectMake(20,55,mDayLabelWidth,20));
objj_msgSend(_11,"setStringValue:","CW");
objj_msgSend(objj_msgSend(_b,"view"),"addSubview:",_11);
var _12=objj_msgSend(objj_msgSend(KCDaysViewController,"alloc"),"initWithFrame:andDate:",mDaysViewRect,mSelectedDay);
objj_msgSend(_12,"setDelegate:",_b);
objj_msgSend(_12,"setDataSource:",_b);
objj_msgSend(mDaysViews,"addObject:",_12);
objj_msgSend(objj_msgSend(_b,"view"),"addSubview:",objj_msgSend(_12,"view"));
var _13=objj_msgSend(objj_msgSend(CPImageView,"alloc"),"initWithFrame:",CPMakeRect(52,CPRectGetHeight(frame)-145,2,140)),_14=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/verticalSeparator.png",CGSizeMake(2,100));
objj_msgSend(_13,"setImage:",_14);
objj_msgSend(objj_msgSend(_b,"view"),"addSubview:",_13);
}
}),new objj_method(sel_getUid("weekDayLabelWithFrame:"),function(_15,_16,_17){
with(_15){
var _18=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",_17);
objj_msgSend(_18,"setBezeled:",NO);
objj_msgSend(_18,"setBezelStyle:",CPTextFieldSquareBezel);
objj_msgSend(_18,"setBordered:",NO);
objj_msgSend(_18,"setEditable:",NO);
objj_msgSend(_18,"setTextColor:",objj_msgSend(CPColor,"lightGrayColor"));
objj_msgSend(_18,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",10));
objj_msgSend(_18,"setAlignment:",CPCenterTextAlignment);
return _18;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_19,_1a,_1b){
with(_19){
delegate=_1b;
}
}),new objj_method(sel_getUid("monthAndYearString"),function(_1c,_1d){
with(_1c){
return objj_msgSend(objj_msgSend(_1c,"longMonthNames"),"objectAtIndex:",mSelectedMonth.getMonth())+" "+(mSelectedMonth.getFullYear());
}
}),new objj_method(sel_getUid("setSelectedMonth:"),function(_1e,_1f,_20){
with(_1e){
mSelectedMonth=_20;
objj_msgSend(mMonthAndYearTextField,"setStringValue:",objj_msgSend(_1e,"monthAndYearString"));
}
}),new objj_method(sel_getUid("shortDayNames"),function(_21,_22){
with(_21){
var _23=["Mo.","Tu.","We.","Th.","Fr.","Sa.","Su."];
return objj_msgSend(objj_msgSend(CPArray,"alloc"),"initWithObjects:count:",_23,_23.length);
}
}),new objj_method(sel_getUid("longMonthNames"),function(_24,_25){
with(_24){
var _26=["January","February","March","April","May","June","July","August","September","October","November","December"];
return objj_msgSend(objj_msgSend(CPArray,"alloc"),"initWithObjects:count:",_26,_26.length);
}
}),new objj_method(sel_getUid("nextButtonPressed:"),function(_27,_28,_29){
with(_27){
var _2a=objj_msgSend(mDaysViews,"objectAtIndex:",mCurrentMonthIndex);
objj_msgSend(objj_msgSend(_2a,"view"),"removeFromSuperview");
var _2b=new Date(objj_msgSend(_2a,"date"));
if(mCurrentMonthIndex==objj_msgSend(mDaysViews,"count")-1){
var _2c=objj_msgSend(objj_msgSend(KCDaysViewController,"alloc"),"initWithFrame:andDate:",mDaysViewRect,_2b.add(1).months());
objj_msgSend(_2c,"setDelegate:",_27);
objj_msgSend(mDaysViews,"addObject:",_2c);
}
mCurrentMonthIndex++;
_2a=objj_msgSend(mDaysViews,"objectAtIndex:",mCurrentMonthIndex);
objj_msgSend(_2a,"setSelectedDay:",mSelectedDay);
objj_msgSend(objj_msgSend(_27,"view"),"addSubview:",objj_msgSend(_2a,"view"));
_2b=objj_msgSend(_2a,"date");
objj_msgSend(_27,"setSelectedMonth:",_2b);
}
}),new objj_method(sel_getUid("prevButtonPressed:"),function(_2d,_2e,_2f){
with(_2d){
var _30=objj_msgSend(mDaysViews,"objectAtIndex:",mCurrentMonthIndex);
objj_msgSend(objj_msgSend(_30,"view"),"removeFromSuperview");
var _31=new Date(objj_msgSend(_30,"date"));
if(mCurrentMonthIndex==0){
var _32=objj_msgSend(objj_msgSend(KCDaysViewController,"alloc"),"initWithFrame:andDate:",mDaysViewRect,_31.add(-1).months());
objj_msgSend(mDaysViews,"insertObject:atIndex:",_32,mCurrentMonthIndex);
objj_msgSend(_32,"setDelegate:",_2d);
}else{
mCurrentMonthIndex--;
}
_30=objj_msgSend(mDaysViews,"objectAtIndex:",mCurrentMonthIndex);
objj_msgSend(_30,"setSelectedDay:",mSelectedDay);
objj_msgSend(objj_msgSend(_2d,"view"),"addSubview:",objj_msgSend(_30,"view"));
_31=objj_msgSend(_30,"date");
objj_msgSend(_2d,"setSelectedMonth:",_31);
}
}),new objj_method(sel_getUid("selectedDay"),function(_33,_34){
with(_33){
return mSelectedDay;
}
}),new objj_method(sel_getUid("didSelectDay:"),function(_35,_36,day){
with(_35){
mSelectedDay=day;
objj_msgSend(delegate,"calendarView:didSelectDate:",_35,mSelectedDay);
}
}),new objj_method(sel_getUid("didSelectDaysFrom:to:"),function(_37,_38,_39,_3a){
with(_37){
mSelectedDay=_39;
objj_msgSend(delegate,"calendarView:didSelectDateRangeFrom:to:",_37,_39,_3a);
}
})]);
p;33;KCCalendar/KCDaysViewController.jt;7028;@STATIC;1.0;I;21;Foundation/CPObject.jt;6983;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPViewController,"KCDaysViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("dataSource"),new objj_ivar("mFrame"),new objj_ivar("mDate"),new objj_ivar("mSelectedButton"),new objj_ivar("mTodayButton"),new objj_ivar("mDayButtons")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("dataSource"),function(_8,_9){
with(_8){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_a,_b,_c){
with(_a){
dataSource=_c;
}
}),new objj_method(sel_getUid("initWithFrame:andDate:"),function(_d,_e,_f,_10){
with(_d){
_d=objj_msgSendSuper({receiver:_d,super_class:objj_getClass("KCDaysViewController").super_class},"init");
if(_d){
var _11=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",_f);
mFrame=_f;
mDate=_10;
mSelectedButton=nil;
mTodayButton=nil;
mDayButtons=objj_msgSend(objj_msgSend(CPMutableDictionary,"alloc"),"init");
var _12=Date.getDaysInMonth(_10.getYear(),_10.getMonth())+1,y=0,_13=(CPRectGetWidth(_f)-40)/7,_14=new Date();
var cw=objj_msgSend(_d,"calenderWeekOfDay:",1);
var _15=objj_msgSend(_d,"dayButtonWithFrame:",CPRectMake(0,0,_13,20));
objj_msgSend(_15,"setAction:",sel_getUid("calendarWeekButtonPressed:"));
objj_msgSend(_15,"setTitle:",objj_msgSend(CPString,"stringWithFormat:","%i",cw));
objj_msgSend(_11,"addSubview:",_15);
for(var i=1;i<_12;i++){
var _16=objj_msgSend(_d,"dayPosition:",i),_17=objj_msgSend(_d,"dayButtonWithFrame:",CPRectMake(40+_16*_13,y,_13,20));
objj_msgSend(_17,"setTitle:",objj_msgSend(CPString,"stringWithFormat:","%i",i));
if(_14.getDate()==i&&_10.getMonth()==_14.getMonth()){
objj_msgSend(_17,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","3676d2"));
objj_msgSend(_17,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12));
mTodayButton=_17;
mSelectedButton=_17;
}
objj_msgSend(mDayButtons,"setObject:forKey:",_17,i);
objj_msgSend(_11,"addSubview:",_17);
if(_16==6){
y=y+20;
if(i!=_12-1){
var _15=objj_msgSend(_d,"dayButtonWithFrame:",CPRectMake(0,y,_13,20));
objj_msgSend(_15,"setAction:",sel_getUid("calendarWeekButtonPressed:"));
var cw=objj_msgSend(_d,"calenderWeekOfDay:",i+1);
objj_msgSend(_15,"setTitle:",objj_msgSend(CPString,"stringWithFormat:","%i",cw));
objj_msgSend(_11,"addSubview:",_15);
}
}
}
objj_msgSend(_d,"setView:",_11);
}
return _d;
}
}),new objj_method(sel_getUid("dayButtonWithFrame:"),function(_18,_19,_1a){
with(_18){
var _1b=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",_1a);
objj_msgSend(_1b,"setBezelStyle:",CPTextFieldSquareBezel);
objj_msgSend(_1b,"setBordered:",NO);
objj_msgSend(_1b,"setTextColor:",objj_msgSend(CPColor,"lightGrayColor"));
objj_msgSend(_1b,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",12));
objj_msgSend(_1b,"setAlignment:",CPCenterTextAlignment);
objj_msgSend(_1b,"setTarget:",_18);
objj_msgSend(_1b,"setAction:",sel_getUid("dayButtonPressed:"));
return _1b;
}
}),new objj_method(sel_getUid("dayPosition:"),function(_1c,_1d,_1e){
with(_1c){
var _1f=new Date();
_1f.setFullYear(mDate.getFullYear(),mDate.getMonth(),_1e);
var _20=_1f.getDay()-1;
if(_20==-1){
_20=6;
}
return _20;
}
}),new objj_method(sel_getUid("calenderWeekOfDay:"),function(_21,_22,day){
with(_21){
var _23=new Date();
_23.setFullYear(mDate.getFullYear(),mDate.getMonth(),day);
return objj_msgSend(_23,"week");
}
}),new objj_method(sel_getUid("dayButtonPressed:"),function(_24,_25,_26){
with(_24){
objj_msgSend(_24,"selectButton:",_26);
var _27=new Date(mDate.getFullYear(),mDate.getMonth(),objj_msgSend(_26,"title"));
if(delegate&&objj_msgSend(delegate,"respondsToSelector:",sel_getUid("didSelectDay:"))){
objj_msgSend(delegate,"didSelectDay:",_27);
}
}
}),new objj_method(sel_getUid("calendarWeekButtonPressed:"),function(_28,_29,_2a){
with(_28){
objj_msgSend(_28,"selectButton:",_2a);
var _2b=parseInt(objj_msgSend(_2a,"title"));
var _2c=objj_msgSend(CPDate,"firstDayOfWeek:inYear:",_2b,mDate.getFullYear());
var _2d=objj_msgSend(CPDate,"lastDayOfWeek:inYear:",_2b,mDate.getFullYear());
if(delegate&&objj_msgSend(delegate,"respondsToSelector:",sel_getUid("didSelectDaysFrom:to:"))){
objj_msgSend(delegate,"didSelectDaysFrom:to:",_2c,_2d);
}
}
}),new objj_method(sel_getUid("selectButton:"),function(_2e,_2f,_30){
with(_2e){
if(objj_msgSend(mSelectedButton,"isEqual:",mTodayButton)){
objj_msgSend(mSelectedButton,"setTextColor:",objj_msgSend(CPColor,"darkGrayColor"));
objj_msgSend(mSelectedButton,"setTextShadowColor:",objj_msgSend(CPColor,"darkGrayShadowColor"));
objj_msgSend(mSelectedButton,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(mSelectedButton,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12));
}else{
objj_msgSend(mSelectedButton,"setTextColor:",objj_msgSend(CPColor,"lightGrayColor"));
objj_msgSend(mSelectedButton,"setTextShadowColor:",objj_msgSend(CPColor,"clearColor"));
objj_msgSend(mSelectedButton,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(mSelectedButton,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",12));
}
objj_msgSend(_30,"setTextColor:",objj_msgSend(CPColor,"blueColor"));
objj_msgSend(_30,"setTextShadowColor:",objj_msgSend(CPColor,"blueShadowColor"));
objj_msgSend(_30,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12));
mSelectedButton=_30;
}
}),new objj_method(sel_getUid("setSelectedDay:"),function(_31,_32,_33){
with(_31){
if(objj_msgSend(mSelectedButton,"isEqual:",mTodayButton)){
objj_msgSend(mSelectedButton,"setTextColor:",objj_msgSend(CPColor,"darkGrayColor"));
objj_msgSend(mSelectedButton,"setTextShadowColor:",objj_msgSend(CPColor,"darkGrayShadowColor"));
objj_msgSend(mSelectedButton,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(mSelectedButton,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12));
}else{
objj_msgSend(mSelectedButton,"setTextColor:",objj_msgSend(CPColor,"lightGrayColor"));
objj_msgSend(mSelectedButton,"setTextShadowColor:",objj_msgSend(CPColor,"clearColor"));
objj_msgSend(mSelectedButton,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(mSelectedButton,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",12));
}
if(mDate.getYear()==_33.getYear()&&mDate.getMonth()==_33.getMonth()){
var _34=objj_msgSend(mDayButtons,"objectForKey:",_33.getDate());
objj_msgSend(_34,"setTextColor:",objj_msgSend(CPColor,"blueColor"));
objj_msgSend(_34,"setTextShadowColor:",objj_msgSend(CPColor,"blueShadowColor"));
objj_msgSend(_34,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12));
mSelectedButton=_34;
}
}
}),new objj_method(sel_getUid("date"),function(_35,_36){
with(_35){
return mDate;
}
}),new objj_method(sel_getUid("animationShouldStart:"),function(_37,_38,_39){
with(_37){
return YES;
}
}),new objj_method(sel_getUid("animation:valueForProgress:"),function(_3a,_3b,_3c,_3d){
with(_3a){
return _3d;
}
})]);
p;18;Model/KCActivity.jt;2058;@STATIC;1.0;I;37;RestfulCappuccino/RestfulCappuccino.jt;1997;
objj_executeFile("RestfulCappuccino/RestfulCappuccino.j",NO);
var _1=objj_allocateClassPair(RestfulCappuccino,"KCActivity"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("activity"),new objj_ivar("project"),new objj_ivar("startDate"),new objj_ivar("endDate"),new objj_ivar("color")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("activity"),function(_3,_4){
with(_3){
return activity;
}
}),new objj_method(sel_getUid("setActivity:"),function(_5,_6,_7){
with(_5){
activity=_7;
}
}),new objj_method(sel_getUid("project"),function(_8,_9){
with(_8){
return project;
}
}),new objj_method(sel_getUid("setProject:"),function(_a,_b,_c){
with(_a){
project=_c;
}
}),new objj_method(sel_getUid("startDate"),function(_d,_e){
with(_d){
return startDate;
}
}),new objj_method(sel_getUid("setStartDate:"),function(_f,_10,_11){
with(_f){
startDate=_11;
}
}),new objj_method(sel_getUid("endDate"),function(_12,_13){
with(_12){
return endDate;
}
}),new objj_method(sel_getUid("setEndDate:"),function(_14,_15,_16){
with(_14){
endDate=_16;
}
}),new objj_method(sel_getUid("color"),function(_17,_18){
with(_17){
return color;
}
}),new objj_method(sel_getUid("setColor:"),function(_19,_1a,_1b){
with(_19){
color=_1b;
}
}),new objj_method(sel_getUid("attributes"),function(_1c,_1d){
with(_1c){
return {"activity":activity,"project":project,"start_date":objj_msgSend(startDate,"ISOString"),"end_date":objj_msgSend(endDate,"ISOString"),"color":"#"+objj_msgSend(color,"hexString")};
}
}),new objj_method(sel_getUid("duration"),function(_1e,_1f){
with(_1e){
var _20=endDate;
if(_20==nil){
_20=objj_msgSend(CPDate,"date");
}
return objj_msgSend(_20,"timeIntervalSince1970")-objj_msgSend(startDate,"timeIntervalSince1970");
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("resourcePath"),function(_21,_22){
with(_21){
var _23=objj_msgSend(CPString,"stringWithFormat:","%@/mirror/KCActivities",objj_msgSend(Globals,"getBaseURL"));
return objj_msgSend(CPURL,"URLWithString:",_23);
}
})]);
p;16;Model/KCExport.jt;1017;@STATIC;1.0;I;37;RestfulCappuccino/RestfulCappuccino.jt;957;
objj_executeFile("RestfulCappuccino/RestfulCappuccino.j",NO);
var _1=objj_allocateClassPair(RestfulCappuccino,"KCExport"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("name"),new objj_ivar("values")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("name"),function(_3,_4){
with(_3){
return name;
}
}),new objj_method(sel_getUid("setName:"),function(_5,_6,_7){
with(_5){
name=_7;
}
}),new objj_method(sel_getUid("values"),function(_8,_9){
with(_8){
return values;
}
}),new objj_method(sel_getUid("setValues:"),function(_a,_b,_c){
with(_a){
values=_c;
}
}),new objj_method(sel_getUid("attributes"),function(_d,_e){
with(_d){
return {"name":name,"values":values};
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("resourcePath"),function(_f,_10){
with(_f){
var _11=objj_msgSend(CPString,"stringWithFormat:","%@/mirror/KCExports",objj_msgSend(Globals,"getBaseURL"));
return objj_msgSend(CPURL,"URLWithString:",_11);
}
})]);
p;26;Model/KCImageTransformer.jt;583;@STATIC;1.0;t;565;
var _1=objj_allocateClassPair(CPValueTransformer,"KCImageTransformer"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("transformedValue:"),function(_3,_4,_5){
with(_3){
if(objj_msgSend(_5,"isKindOfClass:",objj_msgSend(CPImage,"class"))){
return _5;
}else{
return nil;
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("transformedValueClass"),function(_6,_7){
with(_6){
return objj_msgSend(CPImage,"self");
}
}),new objj_method(sel_getUid("allowsReverseTransformation"),function(_8,_9){
with(_8){
return NO;
}
})]);
p;21;Model/KCObservation.jt;1540;@STATIC;1.0;I;37;RestfulCappuccino/RestfulCappuccino.jt;1479;
objj_executeFile("RestfulCappuccino/RestfulCappuccino.j",NO);
var _1=objj_allocateClassPair(RestfulCappuccino,"KCObservation"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("label"),new objj_ivar("message"),new objj_ivar("timeStamp"),new objj_ivar("date")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("label"),function(_3,_4){
with(_3){
return label;
}
}),new objj_method(sel_getUid("setLabel:"),function(_5,_6,_7){
with(_5){
label=_7;
}
}),new objj_method(sel_getUid("message"),function(_8,_9){
with(_8){
return message;
}
}),new objj_method(sel_getUid("setMessage:"),function(_a,_b,_c){
with(_a){
message=_c;
}
}),new objj_method(sel_getUid("timeStamp"),function(_d,_e){
with(_d){
return timeStamp;
}
}),new objj_method(sel_getUid("setTimeStamp:"),function(_f,_10,_11){
with(_f){
timeStamp=_11;
}
}),new objj_method(sel_getUid("date"),function(_12,_13){
with(_12){
return date;
}
}),new objj_method(sel_getUid("setDate:"),function(_14,_15,_16){
with(_14){
date=_16;
}
}),new objj_method(sel_getUid("attributes"),function(_17,_18){
with(_17){
return {"label":label,"message":message,"time_stamp":objj_msgSend(timeStamp,"ISOString"),"date":objj_msgSend(date,"ISOString")};
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("resourcePath"),function(_19,_1a){
with(_19){
var _1b=objj_msgSend(CPString,"stringWithFormat:","%@/mirror/KCObservations",objj_msgSend(Globals,"getBaseURL"));
return objj_msgSend(CPURL,"URLWithString:",_1b);
}
})]);
p;17;Model/KCProject.jt;1042;@STATIC;1.0;I;37;RestfulCappuccino/RestfulCappuccino.jt;982;
objj_executeFile("RestfulCappuccino/RestfulCappuccino.j",NO);
var _1=objj_allocateClassPair(RestfulCappuccino,"KCProject"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("name"),new objj_ivar("color")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("name"),function(_3,_4){
with(_3){
return name;
}
}),new objj_method(sel_getUid("setName:"),function(_5,_6,_7){
with(_5){
name=_7;
}
}),new objj_method(sel_getUid("color"),function(_8,_9){
with(_8){
return color;
}
}),new objj_method(sel_getUid("setColor:"),function(_a,_b,_c){
with(_a){
color=_c;
}
}),new objj_method(sel_getUid("attributes"),function(_d,_e){
with(_d){
return {"name":name,"color":"#"+objj_msgSend(color,"hexString")};
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("resourcePath"),function(_f,_10){
with(_f){
var _11=objj_msgSend(CPString,"stringWithFormat:","%@/mirror/KCProjects",objj_msgSend(Globals,"getBaseURL"));
return objj_msgSend(CPURL,"URLWithString:",_11);
}
})]);
p;23;Model/KCResourceBlock.jt;5341;@STATIC;1.0;I;37;RestfulCappuccino/RestfulCappuccino.jt;5280;
objj_executeFile("RestfulCappuccino/RestfulCappuccino.j",NO);
var _1=objj_allocateClassPair(RestfulCappuccino,"KCResourceBlock"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("filePath"),new objj_ivar("color"),new objj_ivar("application"),new objj_ivar("windowTitle"),new objj_ivar("startDate"),new objj_ivar("endDate"),new objj_ivar("project"),new objj_ivar("activity"),new objj_ivar("thumbnail"),new objj_ivar("screenshot")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("filePath"),function(_3,_4){
with(_3){
return filePath;
}
}),new objj_method(sel_getUid("setFilePath:"),function(_5,_6,_7){
with(_5){
filePath=_7;
}
}),new objj_method(sel_getUid("color"),function(_8,_9){
with(_8){
return color;
}
}),new objj_method(sel_getUid("setColor:"),function(_a,_b,_c){
with(_a){
color=_c;
}
}),new objj_method(sel_getUid("application"),function(_d,_e){
with(_d){
return application;
}
}),new objj_method(sel_getUid("setApplication:"),function(_f,_10,_11){
with(_f){
application=_11;
}
}),new objj_method(sel_getUid("windowTitle"),function(_12,_13){
with(_12){
return windowTitle;
}
}),new objj_method(sel_getUid("setWindowTitle:"),function(_14,_15,_16){
with(_14){
windowTitle=_16;
}
}),new objj_method(sel_getUid("startDate"),function(_17,_18){
with(_17){
return startDate;
}
}),new objj_method(sel_getUid("setStartDate:"),function(_19,_1a,_1b){
with(_19){
startDate=_1b;
}
}),new objj_method(sel_getUid("endDate"),function(_1c,_1d){
with(_1c){
return endDate;
}
}),new objj_method(sel_getUid("setEndDate:"),function(_1e,_1f,_20){
with(_1e){
endDate=_20;
}
}),new objj_method(sel_getUid("project"),function(_21,_22){
with(_21){
return project;
}
}),new objj_method(sel_getUid("setProject:"),function(_23,_24,_25){
with(_23){
project=_25;
}
}),new objj_method(sel_getUid("activity"),function(_26,_27){
with(_26){
return activity;
}
}),new objj_method(sel_getUid("setActivity:"),function(_28,_29,_2a){
with(_28){
activity=_2a;
}
}),new objj_method(sel_getUid("thumbnail"),function(_2b,_2c){
with(_2b){
return thumbnail;
}
}),new objj_method(sel_getUid("setThumbnail:"),function(_2d,_2e,_2f){
with(_2d){
thumbnail=_2f;
}
}),new objj_method(sel_getUid("screenshot"),function(_30,_31){
with(_30){
return screenshot;
}
}),new objj_method(sel_getUid("setScreenshot:"),function(_32,_33,_34){
with(_32){
screenshot=_34;
}
}),new objj_method(sel_getUid("attributes"),function(_35,_36){
with(_35){
return {"file_path":filePath,"color":"#"+objj_msgSend(color,"hexString"),"window_title":windowTitle,"application":application,"start_date":objj_msgSend(startDate,"ISOString"),"end_date":objj_msgSend(endDate,"ISOString"),"project":project,"activity":activity};
}
}),new objj_method(sel_getUid("date"),function(_37,_38){
with(_37){
return objj_msgSend(CPString,"stringWithFormat:","%@ - %@",objj_msgSend(startDate,"formatToTime"),objj_msgSend(endDate,"formatToTime"));
}
}),new objj_method(sel_getUid("fileName"),function(_39,_3a){
with(_39){
var _3b=objj_msgSend(filePath,"stringByReplacingOccurrencesOfString:withString:","\\","/");
return objj_msgSend(_3b,"lastPathComponent");
}
}),new objj_method(sel_getUid("color"),function(_3c,_3d){
with(_3c){
if(objj_msgSend(application,"isEqualToString:","Idle")){
return objj_msgSend(CPColor,"colorWithWhite:alpha:",0.9,0.3);
}
return color;
}
}),new objj_method(sel_getUid("strokeColor"),function(_3e,_3f){
with(_3e){
if(objj_msgSend(application,"isEqualToString:","Idle")){
return objj_msgSend(CPColor,"colorWithWhite:alpha:",0.9,0.5);
}
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",objj_msgSend(color,"redComponent")-0.1,objj_msgSend(color,"greenComponent")-0.1,objj_msgSend(color,"blueComponent")-0.1,1);
}
}),new objj_method(sel_getUid("path"),function(_40,_41){
with(_40){
return filePath;
}
}),new objj_method(sel_getUid("applicationName"),function(_42,_43){
with(_42){
return objj_msgSend(application,"capitalizedString");
}
}),new objj_method(sel_getUid("information"),function(_44,_45){
with(_44){
if(filePath=="null"||objj_msgSend(_44,"isBrowser")){
return windowTitle;
}else{
return objj_msgSend(_44,"fileName");
}
}
}),new objj_method(sel_getUid("durationString"),function(_46,_47){
with(_46){
var _48=objj_msgSend(_46,"duration");
var _49=Math.floor(_48/60/60),_4a=Math.floor(_48/60-_49*60),_4b=_48-(_4a*60+_49*60*60);
if(_49>0){
return objj_msgSend(CPString,"stringWithFormat:","%i hours, %i minutes, %i seconds",_49,_4a,_4b);
}else{
return objj_msgSend(CPString,"stringWithFormat:","%i minutes, %i seconds",_4a,_4b);
}
}
}),new objj_method(sel_getUid("duration"),function(_4c,_4d){
with(_4c){
return objj_msgSend(endDate,"timeIntervalSince1970")-objj_msgSend(startDate,"timeIntervalSince1970");
}
}),new objj_method(sel_getUid("hidden"),function(_4e,_4f){
with(_4e){
return NO;
}
}),new objj_method(sel_getUid("isBrowser"),function(_50,_51){
with(_50){
var _52=objj_msgSend("chrome safari firefox iexplorer","rangeOfString:options:",application,CPCaseInsensitiveSearch);
return (_52.location==CPNotFound)?NO:YES;
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("resourcePath"),function(_53,_54){
with(_53){
var _55=objj_msgSend(CPString,"stringWithFormat:","%@/mirror/KCResourceBlocks",objj_msgSend(Globals,"getBaseURL"));
return objj_msgSend(CPURL,"URLWithString:",_55);
}
})]);
p;26;Model/KCResourceDuration.jt;1081;@STATIC;1.0;I;37;RestfulCappuccino/RestfulCappuccino.jt;1020;
objj_executeFile("RestfulCappuccino/RestfulCappuccino.j",NO);
var _1=objj_allocateClassPair(RestfulCappuccino,"KCResourceDuration"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("date"),new objj_ivar("duration")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("date"),function(_3,_4){
with(_3){
return date;
}
}),new objj_method(sel_getUid("setDate:"),function(_5,_6,_7){
with(_5){
date=_7;
}
}),new objj_method(sel_getUid("duration"),function(_8,_9){
with(_8){
return duration;
}
}),new objj_method(sel_getUid("setDuration:"),function(_a,_b,_c){
with(_a){
duration=_c;
}
}),new objj_method(sel_getUid("attributes"),function(_d,_e){
with(_d){
return {"date":objj_msgSend(endDate,"ISOString"),"duration":duration};
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("resourcePath"),function(_f,_10){
with(_f){
var _11=objj_msgSend(CPString,"stringWithFormat:","%@/mirror/KCResourceDurations",objj_msgSend(Globals,"getBaseURL"));
return objj_msgSend(CPURL,"URLWithString:",_11);
}
})]);
p;50;StopWatch/KCStopWatchConfigurationViewController.jt;5693;@STATIC;1.0;t;5674;
var _1=objj_allocateClassPair(CPViewController,"KCStopWatchConfigurationViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("recordView"),new objj_ivar("projectPopUpButton"),new objj_ivar("activityTextField"),new objj_ivar("recButton"),new objj_ivar("stopButton"),new objj_ivar("addProjectView"),new objj_ivar("projectTextField"),new objj_ivar("colorWell"),new objj_ivar("projects"),new objj_ivar("delegate"),new objj_ivar("dataSource")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("dataSource"),function(_8,_9){
with(_8){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_a,_b,_c){
with(_a){
dataSource=_c;
}
}),new objj_method(sel_getUid("viewDidLoad"),function(_d,_e){
with(_d){
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_d,sel_getUid("projectsWillLoad:"),"RestfulCappuccinoResourcesWillLoad",KCProject);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_d,sel_getUid("projectsDidLoad:"),"RestfulCappuccinoResourcesDidLoad",KCProject);
objj_msgSend(recButton,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","../Resources/Images/icn_rec.png",CPMakeSize(15,15)));
objj_msgSend(stopButton,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","../Resources/Images/icn_stop.png",CPMakeSize(15,15)));
var _f=objj_msgSend(dataSource,"isStopWatchInRecordMode");
objj_msgSend(_d,"setRecordMode:",_f);
if(_f){
objj_msgSend(projectTextField,"setStringValue:",objj_msgSend(dataSource,"projectOfStopWatch"));
objj_msgSend(activityTextField,"setStringValue:",objj_msgSend(dataSource,"activityOfStopWatch"));
}
objj_msgSend(projectPopUpButton,"setPullsDown:",NO);
objj_msgSend(KCProject,"allAsync");
objj_msgSend(addProjectView,"setHidden:",YES);
objj_msgSend(recordView,"setHidden:",NO);
}
}),new objj_method(sel_getUid("recButtonPressed:"),function(_10,_11,_12){
with(_10){
objj_msgSend(_10,"setRecordMode:",YES);
var _13=objj_msgSend(projects,"objectAtIndex:",objj_msgSend(projectPopUpButton,"selectedIndex"));
objj_msgSend(delegate,"willStartRecordingWithProject:andActivity:",_13,objj_msgSend(activityTextField,"stringValue"));
}
}),new objj_method(sel_getUid("stopButtonPressed:"),function(_14,_15,_16){
with(_14){
objj_msgSend(_14,"setRecordMode:",NO);
objj_msgSend(delegate,"willStopRecording");
objj_msgSend(_14,"clean");
}
}),new objj_method(sel_getUid("addButtonPressed:"),function(_17,_18,_19){
with(_17){
objj_msgSend(addProjectView,"setHidden:",NO);
objj_msgSend(recordView,"setHidden:",YES);
}
}),new objj_method(sel_getUid("okButtonPressed:"),function(_1a,_1b,_1c){
with(_1a){
var _1d=objj_msgSend(projectTextField,"stringValue");
if(_1d==""){
objj_msgSend(objj_msgSend(CPAlert,"alertWithError:","Please enter a name for the project!"),"runModal");
}else{
if(objj_msgSend(objj_msgSend(projectPopUpButton,"itemTitles"),"containsObject:",_1d)){
objj_msgSend(objj_msgSend(CPAlert,"alertWithError:","This project already exists, please enter another name!"),"runModal");
}else{
var _1e=objj_msgSend(KCProject,"new:",{name:objj_msgSend(projectTextField,"stringValue")});
objj_msgSend(_1e,"setColor:",objj_msgSend(colorWell,"color"));
objj_msgSend(_1e,"saveAsync");
objj_msgSend(projects,"addObject:",_1e);
objj_msgSend(projectPopUpButton,"addItemWithTitle:",objj_msgSend(projectTextField,"stringValue"));
objj_msgSend(projectPopUpButton,"selectItemWithTitle:",objj_msgSend(projectTextField,"stringValue"));
objj_msgSend(projectTextField,"setStringValue:","");
objj_msgSend(addProjectView,"setHidden:",YES);
objj_msgSend(recordView,"setHidden:",NO);
}
}
}
}),new objj_method(sel_getUid("cancelButtonPressed:"),function(_1f,_20,_21){
with(_1f){
if(objj_msgSend(projects,"count")==0){
objj_msgSend(_1f,"stopButtonPressed:",nil);
}else{
objj_msgSend(projectTextField,"setStringValue:","");
objj_msgSend(addProjectView,"setHidden:",YES);
objj_msgSend(recordView,"setHidden:",NO);
}
}
}),new objj_method(sel_getUid("projectsWillLoad:"),function(_22,_23,_24){
with(_22){
objj_msgSend(projectPopUpButton,"addItemWithTitle:","Loading Projects");
objj_msgSend(projectPopUpButton,"setEnabled:",NO);
}
}),new objj_method(sel_getUid("projectsDidLoad:"),function(_25,_26,_27){
with(_25){
objj_msgSend(projectPopUpButton,"removeAllItems");
objj_msgSend(projectPopUpButton,"setEnabled:",YES);
projects=objj_msgSend(objj_msgSend(objj_msgSend(_27,"object"),"restfulNotification"),"eventData");
if(objj_msgSend(projects,"count")==0){
objj_msgSend(addProjectView,"setHidden:",NO);
objj_msgSend(recordView,"setHidden:",YES);
}else{
objj_msgSend(addProjectView,"setHidden:",YES);
objj_msgSend(recordView,"setHidden:",NO);
for(var i=0;i<objj_msgSend(projects,"count");i++){
objj_msgSend(projectPopUpButton,"addItemWithTitle:",objj_msgSend(objj_msgSend(projects,"objectAtIndex:",i),"name"));
}
objj_msgSend(projectPopUpButton,"selectItemAtIndex:",0);
}
}
}),new objj_method(sel_getUid("setRecordMode:"),function(_28,_29,_2a){
with(_28){
objj_msgSend(recButton,"setEnabled:",!_2a);
objj_msgSend(stopButton,"setEnabled:",_2a);
objj_msgSend(projectTextField,"setEnabled:",!_2a);
objj_msgSend(activityTextField,"setEnabled:",!_2a);
objj_msgSend(projectPopUpButton,"setEnabled:",!_2a);
}
}),new objj_method(sel_getUid("clean"),function(_2b,_2c){
with(_2b){
objj_msgSend(projectTextField,"setStringValue:","");
objj_msgSend(activityTextField,"setStringValue:","");
}
})]);
p;27;StopWatch/KCStopWatchView.jt;1003;@STATIC;1.0;t;985;
var _1=objj_allocateClassPair(CPView,"KCStopWatchView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("drawRect:"),function(_3,_4,_5){
with(_3){
_5=CGRectInset(_5,1.5,1.5);
var _6=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort");
var _7=[235/255,239/255,222/255,1,235/255,239/255,222/255,1,227/255,234/255,205/255,1,227/255,234/255,205/255,1];
var _8=CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(),_7,[0,0.5,0.5,1],4);
CGContextBeginPath(_6);
CGContextDrawLinearGradient(_6,_8,CGPointMake(CPRectGetMidX(_5),0),CGPointMake(CPRectGetMidX(_5),_5.size.height),0);
CGContextSetStrokeColor(_6,objj_msgSend(CPColor,"colorWithHexString:","939885"));
CGContextSetShadowWithColor(_6,CGSizeMake(0,0.5),0.5,objj_msgSend(CPColor,"whiteColor"));
var _9=CGPathWithRoundedRectangleInRect(_5,5,5,YES,YES,YES,YES);
CGContextAddPath(_6,_9);
CGContextClosePath(_6);
CGContextDrawPath(_6,kCGPathFillStroke);
}
})]);
p;37;StopWatch/KCStopWatchViewController.jt;5131;@STATIC;1.0;i;17;KCStopWatchView.jt;5090;
objj_executeFile("KCStopWatchView.j",YES);
var _1=objj_allocateClassPair(CPViewController,"KCStopWatchViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("startTimeTextField"),new objj_ivar("currentTimeTextField"),new objj_ivar("projectTextField"),new objj_ivar("activityTextField"),new objj_ivar("statusView"),new objj_ivar("updateTimer"),new objj_ivar("startDate"),new objj_ivar("fadeInAnimation"),new objj_ivar("fadeOutAnimation")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCibName:bundle:externalNameTable:"),function(_3,_4,_5,_6,_7){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("KCStopWatchViewController").super_class},"initWithCibName:bundle:externalNameTable:",_5,_6,_7);
if(_3){
backgroundView=objj_msgSend(objj_msgSend(KCStopWatchView,"alloc"),"initWithFrame:",objj_msgSend(objj_msgSend(_3,"view"),"frame"));
objj_msgSend(objj_msgSend(_3,"view"),"addSubview:positioned:relativeTo:",backgroundView,CPWindowBelow,currentTimeTextField);
objj_msgSend(startTimeTextField,"setTextShadowColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(startTimeTextField,"setTextShadowOffset:",CGSizeMake(0,2));
objj_msgSend(currentTimeTextField,"setTextShadowColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(currentTimeTextField,"setTextShadowOffset:",CGSizeMake(0,2));
objj_msgSend(activityTextField,"setTextShadowColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(activityTextField,"setTextShadowOffset:",CGSizeMake(0,2));
objj_msgSend(projectTextField,"setTextShadowColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(projectTextField,"setTextShadowOffset:",CGSizeMake(0,2));
objj_msgSend(statusView,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_rec.png",CGSizeMake(7,7)));
objj_msgSend(statusView,"setAlphaValue:",0);
var _8=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",objj_msgSend(objj_msgSend(_3,"view"),"frame"));
objj_msgSend(_8,"setAutoresizingMask:",CPViewMinXMargin|CPViewMaxXMargin|CPViewMinYMargin|CPViewMaxYMargin);
objj_msgSend(_8,"setBordered:",NO);
objj_msgSend(_8,"setAction:",sel_getUid("openStopWatch:"));
objj_msgSend(objj_msgSend(_3,"view"),"addSubview:",_8);
fadeInAnimation=objj_msgSend(_3,"initFadeInAnimation");
fadeOutAnimation=objj_msgSend(_3,"initFadeOutAnimation");
}
return _3;
}
}),new objj_method(sel_getUid("startRecordingAtTime:withProject:andActivity:"),function(_9,_a,_b,_c,_d){
with(_9){
if(_b==null){
return;
}
startDate=_b;
objj_msgSend(activityTextField,"setStringValue:",_d);
objj_msgSend(projectTextField,"setStringValue:",_c);
objj_msgSend(startTimeTextField,"setStringValue:",objj_msgSend(startDate,"formatToTime"));
updateTimer=objj_msgSend(CPTimer,"scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:",1,_9,sel_getUid("updateTimerFired:"),nil,YES);
fadeOutAnimation=objj_msgSend(_9,"initFadeOutAnimation");
fadeInAnimation=objj_msgSend(_9,"initFadeInAnimation");
objj_msgSend(fadeInAnimation,"startAnimation");
}
}),new objj_method(sel_getUid("stopRecording"),function(_e,_f){
with(_e){
objj_msgSend(updateTimer,"invalidate");
objj_msgSend(startTimeTextField,"setStringValue:","00:00:00");
objj_msgSend(currentTimeTextField,"setStringValue:","00:00:00");
objj_msgSend(activityTextField,"setStringValue:","- - - - - - - - - - -");
objj_msgSend(projectTextField,"setStringValue:","- - - - - - - - - - -");
objj_msgSend(fadeInAnimation,"stopAnimation");
fadeInAnimation=nil;
objj_msgSend(fadeOutAnimation,"stopAnimation");
fadeOutAnimation=nil;
objj_msgSend(statusView,"setAlphaValue:",0);
}
}),new objj_method(sel_getUid("updateTimerFired:"),function(_10,_11,_12){
with(_10){
var _13=objj_msgSend(objj_msgSend(CPDate,"date"),"timeIntervalSinceDate:",startDate),_14=_13/3600,_15=(_13%3600)/60,_16=(_13%3600)%60;
objj_msgSend(currentTimeTextField,"setStringValue:",objj_msgSend(CPString,"stringWithFormat:","%02d:%02d:%02d",_14,_15,_16));
}
}),new objj_method(sel_getUid("initFadeInAnimation"),function(_17,_18){
with(_17){
var _19=objj_msgSend(objj_msgSend(LPViewAnimation,"alloc"),"initWithViewAnimations:",[{"target":statusView,"animations":[[LPFadeAnimationKey,0,1]]}]);
objj_msgSend(_19,"setAnimationCurve:",CPAnimationEaseIn);
objj_msgSend(_19,"setDuration:",0.9);
objj_msgSend(_19,"setDelegate:",_17);
objj_msgSend(_19,"setShouldUseCSSAnimations:",YES);
return _19;
}
}),new objj_method(sel_getUid("initFadeOutAnimation"),function(_1a,_1b){
with(_1a){
var _1c=objj_msgSend(objj_msgSend(LPViewAnimation,"alloc"),"initWithViewAnimations:",[{"target":statusView,"animations":[[LPFadeAnimationKey,1,0]]}]);
objj_msgSend(_1c,"setAnimationCurve:",CPAnimationEaseOut);
objj_msgSend(_1c,"setDuration:",0.9);
objj_msgSend(_1c,"setDelegate:",_1a);
objj_msgSend(_1c,"setShouldUseCSSAnimations:",YES);
return _1c;
}
}),new objj_method(sel_getUid("animationDidEnd:"),function(_1d,_1e,_1f){
with(_1d){
if(objj_msgSend(statusView,"alphaValue")==0){
objj_msgSend(fadeInAnimation,"startAnimation");
}else{
objj_msgSend(fadeOutAnimation,"startAnimation");
}
}
})]);
p;31;Visualization/KCButtonBarView.jt;1940;@STATIC;1.0;t;1921;
var _1=objj_allocateClassPair(CPView,"KCButtonBarView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("drawRect:"),function(_3,_4,_5){
with(_3){
objj_msgSend(_3,"setBackgroundColor:",objj_msgSend(CPColor,"whiteColor"));
var _6=objj_msgSend(_3,"bounds");
var _7=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort"),_8=[228/255,228/255,228/255,1,177/255,177/255,177/255,1],_9=CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(),_8,[0,1],2);
CGContextSetLineWidth(_7,1);
CGContextSetStrokeColor(_7,objj_msgSend(CPColor,"lightGrayColor"));
CGContextBeginPath(_7);
var _a=CGPathWithRoundedRectangleInRect(_6,7,7,NO,NO,NO,NO);
CGContextAddPath(_7,_a);
CGContextDrawLinearGradient(_7,_9,CGPointMake(CPRectGetMidX(_6),0),CGPointMake(CPRectGetMidX(_6),CPRectGetHeight(_6)),0);
CGContextClosePath(_7);
CGContextDrawPath(_7,kCGPathFillStroke);
}
}),new objj_method(sel_getUid("setLeftButtons:"),function(_b,_c,_d){
with(_b){
var x=5;
for(i=0;i<objj_msgSend(_d,"count");i++){
var _e=objj_msgSend(_d,"objectAtIndex:",i);
if(objj_msgSend(_e,"isKindOfClass:",objj_msgSend(CPButton,"class"))){
objj_msgSend(_e,"setFrame:",CGRectMake(x,2,35,26));
objj_msgSend(_e,"setImagePosition:",CPImageOverlaps);
objj_msgSend(_e,"setBordered:",NO);
objj_msgSend(_b,"addSubview:",_e);
x+=CGRectGetWidth(objj_msgSend(_e,"frame"));
}
}
}
}),new objj_method(sel_getUid("setRightButtons:"),function(_f,_10,_11){
with(_f){
var x=15;
for(i=0;i<objj_msgSend(_11,"count");i++){
var _12=objj_msgSend(_11,"objectAtIndex:",i);
if(objj_msgSend(_12,"isKindOfClass:",objj_msgSend(CPButton,"class"))){
objj_msgSend(_12,"setFrame:",CGRectMake(CGRectGetWidth(objj_msgSend(_f,"frame"))-x-35,2,35,26));
objj_msgSend(_12,"setImagePosition:",CPImageOverlaps);
objj_msgSend(_12,"setBordered:",NO);
objj_msgSend(_f,"addSubview:",_12);
x+=CGRectGetWidth(objj_msgSend(_12,"frame"));
}
}
}
})]);
p;39;Visualization/KCDetailsViewController.jt;15937;@STATIC;1.0;i;17;KCLineChartView.ji;13;KCImageView.ji;17;KCButtonBarView.ji;14;KCImageLayer.ji;30;KCScreenshotWindowController.ji;29;../Model/KCResourceDuration.ji;42;PieChart/KCApplicationPieChartController.jt;15720;
objj_executeFile("KCLineChartView.j",YES);
objj_executeFile("KCImageView.j",YES);
objj_executeFile("KCButtonBarView.j",YES);
objj_executeFile("KCImageLayer.j",YES);
objj_executeFile("KCScreenshotWindowController.j",YES);
objj_executeFile("../Model/KCResourceDuration.j",YES);
objj_executeFile("PieChart/KCApplicationPieChartController.j",YES);
var _1=objj_allocateClassPair(CPViewController,"KCDetailsViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dataSource"),new objj_ivar("delegate"),new objj_ivar("resourceTableBackgroundView"),new objj_ivar("resourceTableView"),new objj_ivar("resourceButtonBar"),new objj_ivar("summaryBoxView"),new objj_ivar("applicationImageView"),new objj_ivar("applicationTextField"),new objj_ivar("fileNameSummaryTextField"),new objj_ivar("windowTitleTextField"),new objj_ivar("beginDateTextField"),new objj_ivar("endDateTextField"),new objj_ivar("durationTextField"),new objj_ivar("openSummaryLinkButton"),new objj_ivar("maximizeScreenshotButton"),new objj_ivar("screenshotView"),new objj_ivar("screenshotBackgroundView"),new objj_ivar("resourceBoxView"),new objj_ivar("extensionImageView"),new objj_ivar("fileNameResourceTextField"),new objj_ivar("filePathTextField"),new objj_ivar("resourceBoxLineChartView"),new objj_ivar("openResourceLinkButton"),new objj_ivar("lineChartValues"),new objj_ivar("currentIdentifier"),new objj_ivar("screenshotSheetController"),new objj_ivar("thumbnailLayer")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("viewDidLoad"),function(_3,_4){
with(_3){
var _5=objj_msgSend(CPButtonBar,"minusButton");
objj_msgSend(_5,"setAction:",sel_getUid("removeItemButtonPressed:"));
objj_msgSend(_5,"setTarget:",_3);
objj_msgSend(_5,"setEnabled:",YES);
objj_msgSend(resourceButtonBar,"setLeftButtons:",[_5]);
objj_msgSend(CPShadowView,"shadowViewEnclosingView:withWeight:",resourceTableBackgroundView,CPHeavyShadow);
objj_msgSend(summaryBoxView,"setBackgroundColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(summaryBoxView,"setClipsToBounds:",NO);
summaryBoxView=objj_msgSend(CPShadowView,"shadowViewEnclosingView:withWeight:",summaryBoxView,CPHeavyShadow);
objj_msgSend(summaryBoxView,"setClipsToBounds:",NO);
objj_msgSend(screenshotBackgroundView,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/screenshot_border.png",CGSizeMake(183,147)));
var _6=objj_msgSend(CALayer,"layer");
objj_msgSend(screenshotView,"setWantsLayer:",YES);
objj_msgSend(screenshotView,"setLayer:",_6);
thumbnailLayer=objj_msgSend(objj_msgSend(KCImageLayer,"alloc"),"init");
objj_msgSend(thumbnailLayer,"setBackgroundColor:",objj_msgSend(CPColor,"redColor"));
objj_msgSend(thumbnailLayer,"setBounds:",objj_msgSend(_6,"bounds"));
objj_msgSend(thumbnailLayer,"setAnchorPoint:",CGPointMakeZero());
objj_msgSend(thumbnailLayer,"setPosition:",CGPointMake(0,0));
objj_msgSend(_6,"addSublayer:",thumbnailLayer);
objj_msgSend(thumbnailLayer,"setNeedsDisplay");
objj_msgSend(_6,"setNeedsDisplay");
objj_msgSend(resourceBoxView,"setBackgroundColor:",objj_msgSend(CPColor,"whiteColor"));
resourceBoxView=objj_msgSend(CPShadowView,"shadowViewEnclosingView:withWeight:",resourceBoxView,CPHeavyShadow);
lineChartValues=objj_msgSend(objj_msgSend(CPMutableArray,"alloc"),"init");
objj_msgSend(resourceBoxLineChartView,"setDataSource:",_3);
objj_msgSend(resourceBoxLineChartView,"setDelegate:",_3);
objj_msgSend(KCResourceDuration,"addObserver:",_3);
var _7=objj_msgSend(CPSortDescriptor,"sortDescriptorWithKey:ascending:","date",NO);
objj_msgSend(resourceTableView,"setSortDescriptors:",objj_msgSend(CPArray,"arrayWithObject:",_7));
}
}),new objj_method(sel_getUid("reloadData"),function(_8,_9){
with(_8){
objj_msgSend(resourceTableView,"reloadData");
}
}),new objj_method(sel_getUid("willSelectRowAtIndex:"),function(_a,_b,_c){
with(_a){
objj_msgSend(resourceTableView,"selectRowIndexes:byExtendingSelection:",objj_msgSend(CPIndexSet,"indexSetWithIndex:",_c),NO);
objj_msgSend(resourceTableView,"scrollRowToVisible:",_c);
objj_msgSend(_a,"didSelectRowAtIndex:",_c);
}
}),new objj_method(sel_getUid("didSelectRowAtIndex:"),function(_d,_e,_f){
with(_d){
currentIdentifier=objj_msgSend(dataSource,"identifierForResourceBlockAtIndex:filtered:",_f,YES);
objj_msgSend(delegate,"willSelectZoomElementAtIndex:",_f);
var _10=objj_msgSend(dataSource,"resourceBlockAtIndex:filtered:",_f,YES);
objj_msgSend(applicationImageView,"setImage:",objj_msgSend(_d,"applicationImageForApplication:",objj_msgSend(_10,"application")));
objj_msgSend(applicationTextField,"setStringValue:",objj_msgSend(objj_msgSend(_10,"application"),"capitalizedString"));
objj_msgSend(fileNameSummaryTextField,"setStringValue:",objj_msgSend(_10,"fileName"));
objj_msgSend(windowTitleTextField,"setStringValue:",objj_msgSend(_10,"windowTitle"));
objj_msgSend(durationTextField,"setStringValue:",objj_msgSend(_10,"durationString"));
objj_msgSend(openSummaryLinkButton,"setAlternateTitle:",objj_msgSend(_10,"filePath"));
var _11=objj_msgSend(_10,"startDate"),_12=objj_msgSend(CPString,"stringWithFormat:","%@:%@:%@",_11.getHours(),_11.getMinutes(),_11.getSeconds());
objj_msgSend(beginDateTextField,"setStringValue:",_12);
var _13=objj_msgSend(_10,"endDate"),_14=objj_msgSend(CPString,"stringWithFormat:","%@:%@:%@",_13.getHours(),_13.getMinutes(),_13.getSeconds());
objj_msgSend(endDateTextField,"setStringValue:",_14);
if(objj_msgSend(_10,"thumbnail")!=nil){
objj_msgSend(screenshotView,"setHidden:",NO);
objj_msgSend(screenshotBackgroundView,"setHidden:",NO);
objj_msgSend(objj_msgSend(_10,"thumbnail"),"load");
objj_msgSend(thumbnailLayer,"setImage:",objj_msgSend(_10,"thumbnail"));
objj_msgSend(thumbnailLayer,"setNeedsDisplay");
}else{
objj_msgSend(screenshotView,"setHidden:",YES);
objj_msgSend(screenshotBackgroundView,"setHidden:",YES);
}
if(objj_msgSend(_10,"filePath")=="null"){
objj_msgSend(resourceBoxView,"setHidden:",YES);
}else{
objj_msgSend(lineChartValues,"removeAllObjects");
objj_msgSend(resourceBoxLineChartView,"reloadData");
objj_msgSend(extensionImageView,"setImage:",objj_msgSend(_d,"extensionImageForPath:",objj_msgSend(_10,"filePath")));
objj_msgSend(fileNameResourceTextField,"setStringValue:",objj_msgSend(_10,"fileName"));
objj_msgSend(filePathTextField,"setStringValue:",objj_msgSend(_10,"filePath"));
objj_msgSend(openResourceLinkButton,"setAlternateTitle:",objj_msgSend(_10,"filePath"));
objj_msgSend(resourceBoxView,"setHidden:",NO);
}
}
}),new objj_method(sel_getUid("applicationImageForApplication:"),function(_15,_16,_17){
with(_15){
if(_17==nil||_17==""){
return nil;
}
return objj_msgSend(CPImage,"applicationImageNamed:size:",objj_msgSend(_17,"stringByReplacingOccurrencesOfString:withString:","+",""),CGSizeMake(128,128));
}
}),new objj_method(sel_getUid("extensionImageForPath:"),function(_18,_19,_1a){
with(_18){
var _1b;
if(objj_msgSend(_1a,"hasPrefix:","http://")){
_1b="html";
}else{
var _1c=objj_msgSend(_1a,"stringByReplacingOccurrencesOfString:withString:","\\","/");
_1b=objj_msgSend(_1c,"pathExtension");
}
return objj_msgSend(CPImage,"extensionImageNamed:size:",_1b,CGSizeMake(64,64));
}
}),new objj_method(sel_getUid("lightboxActionButtons"),function(_1d,_1e){
with(_1d){
var _1f=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/btn_close_window.png",CGSizeMake(35,37)),_20=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(0,0,35,37));
objj_msgSend(_20,"setBordered:",NO);
objj_msgSend(_20,"setImage:",_1f);
objj_msgSend(_20,"setTarget:",_1d);
objj_msgSend(_20,"setAction:",sel_getUid("closeScreenshotButtonPressed:"));
var _21=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/btn_download.png",CGSizeMake(35,37)),_22=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(37,0,35,37));
objj_msgSend(_22,"setBordered:",NO);
objj_msgSend(_22,"setImage:",_21);
objj_msgSend(_22,"setTarget:",_1d);
objj_msgSend(_22,"setAction:",sel_getUid("downloadScreenshotButtonPressed:"));
return objj_msgSend(CPArray,"arrayWithObjects:",_20,_22,nil);
}
}),new objj_method(sel_getUid("openResource:"),function(_23,_24,_25){
with(_23){
CPLog("open: "+objj_msgSend(_25,"alternateTitle"));
window.open(objj_msgSend(_25,"alternateTitle"));
}
}),new objj_method(sel_getUid("removeItemButtonPressed:"),function(_26,_27,_28){
with(_26){
objj_msgSend(delegate,"deleteResourceBlocksAtIndexes:",objj_msgSend(resourceTableView,"selectedRowIndexes"));
objj_msgSend(resourceTableView,"reloadData");
}
}),new objj_method(sel_getUid("maximizeScreenshotButtonPressed:"),function(_29,_2a,_2b){
with(_29){
var _2c=objj_msgSend(dataSource,"resourceBlockAtIndex:filtered:",objj_msgSend(resourceTableView,"selectedRow"),YES),_2d=objj_msgSend(_2c,"screenshot"),_2e=objj_msgSend(_2d,"size"),_2f=CGRectMake(0,0,_2e.width,_2e.height),_30=CGRectOffset(objj_msgSend(objj_msgSend(CPLightbox,"sharedLightbox"),"resizedRect:",_2f),17,17),_31=CGRectInset(_30,-17,-17);
var _32=objj_msgSend(objj_msgSend(CPWindow,"alloc"),"initWithContentRect:styleMask:",_31,CPBorderlessWindowMask),_33=objj_msgSend(_32,"contentView");
imageView=objj_msgSend(objj_msgSend(CPImageView,"alloc"),"initWithFrame:",_30);
objj_msgSend(imageView,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(imageView,"setImageScaling:",CPScaleProportionally);
objj_msgSend(imageView,"setImageAlignment:",CPImageAlignCenter);
objj_msgSend(imageView,"setImage:",_2d);
objj_msgSend(imageView,"setBackgroundColor:",objj_msgSend(CPColor,"colorWithCalibratedWhite:alpha:",1,0.7));
objj_msgSend(_33,"addSubview:",imageView);
objj_msgSend(objj_msgSend(CPLightbox,"sharedLightbox"),"setActionButtons:",objj_msgSend(_29,"lightboxActionButtons"));
objj_msgSend(objj_msgSend(CPLightbox,"sharedLightbox"),"setBackgroundColor:",objj_msgSend(CPColor,"colorWithCalibratedWhite:alpha:",0,0.5));
objj_msgSend(objj_msgSend(CPLightbox,"sharedLightbox"),"runModalForWindow:",_32);
}
}),new objj_method(sel_getUid("closeScreenshotButtonPressed:"),function(_34,_35,_36){
with(_34){
objj_msgSend(objj_msgSend(CPLightbox,"sharedLightbox"),"stopModal");
}
}),new objj_method(sel_getUid("downloadScreenshotButtonPressed:"),function(_37,_38,_39){
with(_37){
var _3a=objj_msgSend(dataSource,"resourceBlockAtIndex:filtered:",objj_msgSend(resourceTableView,"selectedRow"),YES);
window.open(objj_msgSend(objj_msgSend(_3a,"screenshot"),"filename"));
}
}),new objj_method(sel_getUid("tableView:willDisplayView:forTableColumn:row:"),function(_3b,_3c,_3d,_3e,_3f,_40){
with(_3b){
if(objj_msgSend(_3f,"identifier")=="color"){
var _41=objj_msgSend(dataSource,"colorForResourceBlockAtIndex:filtered:",_40,YES);
objj_msgSend(_3e,"setBackgroundColor:",_41);
}
}
}),new objj_method(sel_getUid("tableView:shouldSelectRow:"),function(_42,_43,_44,_45){
with(_42){
objj_msgSend(_42,"didSelectRowAtIndex:",_45);
return YES;
}
}),new objj_method(sel_getUid("numberOfRowsInTableView:"),function(_46,_47,_48){
with(_46){
return objj_msgSend(dataSource,"numberOfResourceBlocksFiltered:",YES);
}
}),new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"),function(_49,_4a,_4b,_4c,_4d){
with(_49){
if(objj_msgSend(_4c,"identifier")=="date"){
return objj_msgSend(dataSource,"dateForResourceBlockAtIndex:filtered:",_4d,YES);
}else{
if(objj_msgSend(_4c,"identifier")=="application"){
return objj_msgSend(dataSource,"applicationForResourceBlockAtIndex:filtered:",_4d,YES);
}else{
if(objj_msgSend(_4c,"identifier")=="information"){
return objj_msgSend(dataSource,"informationForResourceBlockAtIndex:filtered:",_4d,YES);
}
}
}
return nil;
}
}),new objj_method(sel_getUid("tableView:sortDescriptorsDidChange:"),function(_4e,_4f,_50,_51){
with(_4e){
objj_msgSend(delegate,"willChangeSortDescriptors:",objj_msgSend(_50,"sortDescriptors"));
objj_msgSend(_50,"reloadData");
}
}),new objj_method(sel_getUid("resourcesDidLoad:"),function(_52,_53,_54){
with(_52){
var _55=objj_msgSend(objj_msgSend(objj_msgSend(_54,"object"),"restfulNotification"),"eventParameters");
if(_55==nil||currentIdentifier!=_55.id){
return;
}
lineChartValues=objj_msgSend(objj_msgSend(objj_msgSend(_54,"object"),"restfulNotification"),"eventData");
objj_msgSend(resourceBoxLineChartView,"reloadData");
}
}),new objj_method(sel_getUid("imageDidLoad:"),function(_56,_57,_58){
with(_56){
var _59=objj_msgSend(objj_msgSend(objj_msgSend(_58,"object"),"restfulNotification"),"eventParameters");
if(_59==nil||currentIdentifier!=_59.id){
return;
}
screenshot=objj_msgSend(objj_msgSend(objj_msgSend(_58,"object"),"restfulNotification"),"eventData");
}
}),new objj_method(sel_getUid("lineChartView:loadDataButtonPressed:"),function(_5a,_5b,_5c,_5d){
with(_5a){
objj_msgSend(KCResourceDuration,"findAsyncWithParameters:",{id:currentIdentifier});
}
}),new objj_method(sel_getUid("numberOfSetsInChart:"),function(_5e,_5f,_60){
with(_5e){
return 1;
}
}),new objj_method(sel_getUid("chart:numberOfValuesInSet:"),function(_61,_62,_63,_64){
with(_61){
return lineChartValues.length;
}
}),new objj_method(sel_getUid("chart:valueForIndex:set:"),function(_65,_66,_67,_68,_69){
with(_65){
if(lineChartValues.length>0){
return objj_msgSend(lineChartValues[_68],"duration");
}
return 0;
}
}),new objj_method(sel_getUid("chart:labelValueForIndex:"),function(_6a,_6b,_6c,_6d){
with(_6a){
return ""+objj_msgSend(objj_msgSend(lineChartValues[_6d],"date"),"formatToDate");
}
}),new objj_method(sel_getUid("chart:durationValueForIndex:"),function(_6e,_6f,_70,_71){
with(_6e){
return objj_msgSend(lineChartValues[_71],"duration");
}
})]);
var _1=objj_allocateClassPair(CALayer,"KCImageLayer"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_scale"),new objj_ivar("_image"),new objj_ivar("_imageLayer")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("init"),function(_72,_73){
with(_72){
_72=objj_msgSendSuper({receiver:_72,super_class:objj_getClass("KCImageLayer").super_class},"init");
if(_72){
_scale=1;
_imageLayer=objj_msgSend(CALayer,"layer");
objj_msgSend(_imageLayer,"setDelegate:",_72);
objj_msgSend(_72,"addSublayer:",_imageLayer);
}
return _72;
}
}),new objj_method(sel_getUid("setBounds:"),function(_74,_75,_76){
with(_74){
objj_msgSendSuper({receiver:_74,super_class:objj_getClass("KCImageLayer").super_class},"setBounds:",_76);
objj_msgSend(_imageLayer,"setPosition:",CGPointMake(CGRectGetMidX(_76),CGRectGetMidY(_76)));
}
}),new objj_method(sel_getUid("setImage:"),function(_77,_78,_79){
with(_77){
if(_image==_79){
return;
}
_image=_79;
if(_image){
objj_msgSend(_imageLayer,"setBounds:",CGRectMake(0,0,objj_msgSend(_image,"size").width,objj_msgSend(_image,"size").height));
var _7a=objj_msgSend(_77,"bounds"),_7b=objj_msgSend(_imageLayer,"bounds"),_7c=Math.max(CGRectGetWidth(_7a)/CGRectGetWidth(_7b),CGRectGetHeight(_7a)/CGRectGetHeight(_7b));
objj_msgSend(_77,"setScale:",_7c);
}
objj_msgSend(_imageLayer,"setNeedsDisplay");
}
}),new objj_method(sel_getUid("setScale:"),function(_7d,_7e,_7f){
with(_7d){
if(_scale==_7f){
return;
}
_scale=_7f;
objj_msgSend(_imageLayer,"setAffineTransform:",CGAffineTransformScale(CGAffineTransformMakeRotation(0),_scale,_scale));
}
}),new objj_method(sel_getUid("drawInContext:"),function(_80,_81,_82){
with(_80){
CGContextSetFillColor(_82,objj_msgSend(CPColor,"grayColor"));
CGContextFillRect(_82,objj_msgSend(_80,"bounds"));
}
}),new objj_method(sel_getUid("imageDidLoad:"),function(_83,_84,_85){
with(_83){
objj_msgSend(_imageLayer,"setNeedsDisplay");
}
}),new objj_method(sel_getUid("drawLayer:inContext:"),function(_86,_87,_88,_89){
with(_86){
var _8a=objj_msgSend(_88,"bounds");
if(objj_msgSend(_image,"loadStatus")!=CPImageLoadStatusCompleted){
objj_msgSend(_image,"setDelegate:",_86);
}else{
CGContextDrawImage(_89,_8a,_image);
}
}
})]);
p;28;Visualization/KCImageLayer.jt;1684;@STATIC;1.0;I;16;AppKit/CALayer.jt;1644;
objj_executeFile("AppKit/CALayer.j",NO);
var _1=objj_allocateClassPair(CALayer,"KCImageLayer"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_image"),new objj_ivar("_imageLayer")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("init"),function(_3,_4){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("KCImageLayer").super_class},"init");
if(_3){
_imageLayer=objj_msgSend(CALayer,"layer");
objj_msgSend(_imageLayer,"setDelegate:",_3);
objj_msgSend(_imageLayer,"setBounds:",CGRectMake(0,0,170,128));
objj_msgSend(_3,"addSublayer:",_imageLayer);
}
return _3;
}
}),new objj_method(sel_getUid("setBounds:"),function(_5,_6,_7){
with(_5){
objj_msgSendSuper({receiver:_5,super_class:objj_getClass("KCImageLayer").super_class},"setBounds:",_7);
objj_msgSend(_imageLayer,"setPosition:",CGPointMake(CGRectGetMidX(_7),CGRectGetMidY(_7)));
}
}),new objj_method(sel_getUid("setImage:"),function(_8,_9,_a){
with(_8){
if(_image==_a){
return;
}
_image=_a;
objj_msgSend(_imageLayer,"setNeedsDisplay");
}
}),new objj_method(sel_getUid("drawInContext:"),function(_b,_c,_d){
with(_b){
CGContextSetFillColor(_d,objj_msgSend(CPColor,"clearColor"));
CGContextFillRect(_d,objj_msgSend(_b,"bounds"));
}
}),new objj_method(sel_getUid("imageDidLoad:"),function(_e,_f,_10){
with(_e){
objj_msgSend(_imageLayer,"setNeedsDisplay");
}
}),new objj_method(sel_getUid("drawLayer:inContext:"),function(_11,_12,_13,_14){
with(_11){
var _15=objj_msgSend(_13,"bounds");
if(objj_msgSend(_image,"loadStatus")!=CPImageLoadStatusCompleted){
objj_msgSend(_image,"setDelegate:",_11);
}else{
CGContextDrawImage(_14,_15,_image);
}
}
})]);
p;27;Visualization/KCImageView.jt;543;@STATIC;1.0;t;525;
var _1=objj_allocateClassPair(CPImageView,"KCImageView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("setImage:"),function(_3,_4,_5){
with(_3){
objj_msgSend(_5,"setDelegate:",_3);
objj_msgSendSuper({receiver:_3,super_class:objj_getClass("KCImageView").super_class},"setImage:",_5);
}
}),new objj_method(sel_getUid("imageDidError:"),function(_6,_7,_8){
with(_6){
var _9=objj_msgSend(CPImage,"failureImageWithSize:",objj_msgSend(_8,"size"));
objj_msgSend(_6,"setImage:",_9);
}
})]);
p;31;Visualization/KCLineChartView.jt;4664;@STATIC;1.0;I;13;LPKit/LPKit.jt;4627;
objj_executeFile("LPKit/LPKit.j",NO);
var _1=objj_allocateClassPair(CPView,"KCLineChartView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dataSource"),new objj_ivar("delegate"),new objj_ivar("lineChartView"),new objj_ivar("chartViewHoverLabel"),new objj_ivar("loadDataButton")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("dataSource"),function(_3,_4){
with(_3){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_5,_6,_7){
with(_5){
dataSource=_7;
}
}),new objj_method(sel_getUid("delegate"),function(_8,_9){
with(_8){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_a,_b,_c){
with(_a){
delegate=_c;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_d,_e,_f){
with(_d){
_d=objj_msgSendSuper({receiver:_d,super_class:objj_getClass("KCLineChartView").super_class},"initWithFrame:",_f);
if(_d){
objj_msgSend(_d,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(_d,"initLineChartView");
objj_msgSend(_d,"initHoverLabel");
}
return _d;
}
}),new objj_method(sel_getUid("initLineChartView"),function(_10,_11){
with(_10){
var _12=CPRectInset(objj_msgSend(_10,"bounds"),0,15);
_12=CPRectOffset(_12,0,-15);
lineChartView=objj_msgSend(objj_msgSend(LPChartView,"alloc"),"initWithFrame:",_12);
objj_msgSend(lineChartView,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(lineChartView,"setDrawView:",objj_msgSend(objj_msgSend(LPChartDrawView,"alloc"),"init"));
objj_msgSend(lineChartView,"setDelegate:",_10);
objj_msgSend(lineChartView,"setDisplayLabels:",YES);
objj_msgSend(lineChartView,"setDisplayGrid:",YES);
objj_msgSend(_10,"addSubview:",lineChartView);
loadDataButton=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",_12);
objj_msgSend(loadDataButton,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(loadDataButton,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_load.png",CGSizeMake(100,100)));
objj_msgSend(loadDataButton,"setAlternateImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/icn_load_highlighted.png",CGSizeMake(100,100)));
objj_msgSend(loadDataButton,"setImagePosition:",CPImageOnly);
objj_msgSend(loadDataButton,"setBordered:",NO);
objj_msgSend(loadDataButton,"setBackgroundColor:",objj_msgSend(CPColor,"colorWithWhite:alpha:",0.2,0.1));
objj_msgSend(loadDataButton,"setAction:",sel_getUid("loadDataButtonPressed:"));
objj_msgSend(loadDataButton,"setTarget:",_10);
objj_msgSend(_10,"addSubview:",loadDataButton);
}
}),new objj_method(sel_getUid("initHoverLabel"),function(_13,_14){
with(_13){
chartViewHoverLabel=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","Please select a point in the line chart",300);
objj_msgSend(chartViewHoverLabel,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(chartViewHoverLabel,"setCenter:",CGPointMake(CPRectGetMidX(objj_msgSend(_13,"bounds")),CPRectGetMaxY(objj_msgSend(_13,"bounds"))-10));
objj_msgSend(chartViewHoverLabel,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(chartViewHoverLabel,"setBezeled:",NO);
objj_msgSend(chartViewHoverLabel,"setBordered:",NO);
objj_msgSend(chartViewHoverLabel,"setEditable:",NO);
objj_msgSend(chartViewHoverLabel,"setAlignment:",CPCenterTextAlignment);
objj_msgSend(chartViewHoverLabel,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","5E5E5E"));
objj_msgSend(_13,"addSubview:",chartViewHoverLabel);
}
}),new objj_method(sel_getUid("setDataSource:"),function(_15,_16,_17){
with(_15){
_15.dataSource=_17;
objj_msgSend(lineChartView,"setDataSource:",_17);
}
}),new objj_method(sel_getUid("reloadData"),function(_18,_19){
with(_18){
if(objj_msgSend(dataSource,"chart:numberOfValuesInSet:",lineChartView,0)==0){
objj_msgSend(loadDataButton,"setHidden:",NO);
}else{
objj_msgSend(loadDataButton,"setHidden:",YES);
}
objj_msgSend(lineChartView,"reloadData");
}
}),new objj_method(sel_getUid("chart:didMouseOverItemAtIndex:"),function(_1a,_1b,_1c,_1d){
with(_1a){
var _1e="";
if(_1d>=0){
var _1f=objj_msgSend(dataSource,"chart:labelValueForIndex:",_1c,_1d),_20=objj_msgSend(dataSource,"chart:durationValueForIndex:",_1c,_1d),_21=objj_msgSend(CPString,"stringOfTimeInterval:",_20);
_1e+="Date: "+_1f+"  ||  Duration: "+_21;
}
objj_msgSend(chartViewHoverLabel,"setStringValue:",_1e);
}
}),new objj_method(sel_getUid("loadDataButtonPressed:"),function(_22,_23,_24){
with(_22){
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("lineChartView:loadDataButtonPressed:"))){
objj_msgSend(delegate,"lineChartView:loadDataButtonPressed:",_22,_24);
}
}
})]);
p;42;Visualization/KCObersationViewController.jt;3522;@STATIC;1.0;I;27;MessageBoard/MessageBoard.ji;19;KCObservationView.jt;3447;
objj_executeFile("MessageBoard/MessageBoard.j",NO);
objj_executeFile("KCObservationView.j",YES);
var _1=objj_allocateClassPair(CPViewController,"KCObersationViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dataSource"),new objj_ivar("createObservationView"),new objj_ivar("currentObservationLabelTextField"),new objj_ivar("currentObservationTextField"),new objj_ivar("observationScrollView"),new objj_ivar("stackView"),new objj_ivar("stackViewArray")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("dataSource"),function(_3,_4){
with(_3){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_5,_6,_7){
with(_5){
dataSource=_7;
}
}),new objj_method(sel_getUid("viewDidLoad"),function(_8,_9){
with(_8){
objj_msgSend(createObservationView,"setBackgroundColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(CPShadowView,"shadowViewEnclosingView:withWeight:",createObservationView,CPHeavyShadow);
stackViewArray=objj_msgSend(objj_msgSend(CPMutableArray,"alloc"),"init");
var _a=CGRectInset(objj_msgSend(objj_msgSend(observationScrollView,"contentView"),"frame"),0,5);
_a=CGRectOffset(_a,0,9);
stackView=objj_msgSend(objj_msgSend(TNStackView,"alloc"),"initWithFrame:",_a);
objj_msgSend(stackView,"setDataSource:",stackViewArray);
objj_msgSend(stackView,"setPadding:",15);
objj_msgSend(observationScrollView,"setDocumentView:",stackView);
}
}),new objj_method(sel_getUid("reloadData"),function(_b,_c){
with(_b){
}
}),new objj_method(sel_getUid("commitButtonPressed:"),function(_d,_e,_f){
with(_d){
if(objj_msgSend(currentObservationTextField,"stringValue")==""){
return;
}
objj_msgSend(_d,"addObservation:withLabel:",objj_msgSend(currentObservationTextField,"stringValue"),objj_msgSend(currentObservationLabelTextField,"stringValue"));
objj_msgSend(currentObservationLabelTextField,"setStringValue:","");
objj_msgSend(currentObservationTextField,"setStringValue:","");
}
}),new objj_method(sel_getUid("clearButtonPressed:"),function(_10,_11,_12){
with(_10){
objj_msgSend(currentObservationTextField,"setStringValue:","");
}
}),new objj_method(sel_getUid("willDeleteObservationView:"),function(_13,_14,_15){
with(_13){
objj_msgSend(stackView,"removeView:",_15);
}
}),new objj_method(sel_getUid("addObservation:withLabel:"),function(_16,_17,_18,_19){
with(_16){
var _1a=objj_msgSend(KCObservation,"new:",{label:_19,message:_18});
objj_msgSend(_1a,"setDate:",objj_msgSend(dataSource,"startDate"));
objj_msgSend(_1a,"setTimeStamp:",objj_msgSend(CPDate,"date"));
objj_msgSend(_1a,"saveAsync");
objj_msgSend(_16,"addObservation:",_1a);
}
}),new objj_method(sel_getUid("addObservation:"),function(_1b,_1c,_1d){
with(_1b){
var _1e=objj_msgSend(objj_msgSend(KCObservationView,"alloc"),"initWithObservation:",_1d);
objj_msgSend(_1e,"setDelegate:",_1b);
objj_msgSend(stackViewArray,"addObject:",_1e);
objj_msgSend(stackView,"reload");
}
}),new objj_method(sel_getUid("observationsDidLoad:"),function(_1f,_20,_21){
with(_1f){
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"removeObserver:name:object:",_1f,"RestfulCappuccinoResourcesDidLoad",KCObservation);
objj_msgSend(stackView,"removeAllViews:",_1f);
observationsArray=objj_msgSend(objj_msgSend(objj_msgSend(_21,"object"),"restfulNotification"),"eventData");
for(var i=0;i<objj_msgSend(observationsArray,"count");i++){
objj_msgSend(_1f,"addObservation:",objj_msgSend(observationsArray,"objectAtIndex:",i));
}
}
})]);
p;33;Visualization/KCObservationView.jt;6678;@STATIC;1.0;t;6659;
var _1=objj_allocateClassPair(CPView,"KCObservationView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("titleLabel"),new objj_ivar("textLabel"),new objj_ivar("dateLabel"),new objj_ivar("timeLabel"),new objj_ivar("lineView"),new objj_ivar("deleteButton"),new objj_ivar("observation")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("initWithObservation:"),function(_8,_9,_a){
with(_8){
_8=objj_msgSendSuper({receiver:_8,super_class:objj_getClass("KCObservationView").super_class},"initWithFrame:",CGRectMake(0,0,500,30));
if(_8){
_8.observation=_a;
objj_msgSend(_8,"setBackgroundColor:",CPShadowViewHeavyBackgroundColor);
objj_msgSend(_8,"setAutoresizingMask:",CPViewWidthSizable);
timeLabel=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(14,10,70,50));
objj_msgSend(timeLabel,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","5E5E5E"));
objj_msgSend(timeLabel,"setAlignment:",CPCenterTextAlignment);
objj_msgSend(timeLabel,"setTextShadowColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(timeLabel,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(timeLabel,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",24));
objj_msgSend(timeLabel,"setStringValue:",objj_msgSend(objj_msgSend(observation,"timeStamp"),"formatToShortTime"));
objj_msgSend(_8,"addSubview:",timeLabel);
dateLabel=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(14,40,70,50));
objj_msgSend(dateLabel,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","5E5E5E"));
objj_msgSend(dateLabel,"setAlignment:",CPCenterTextAlignment);
objj_msgSend(dateLabel,"setTextShadowColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(dateLabel,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(dateLabel,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",11));
objj_msgSend(dateLabel,"setStringValue:",objj_msgSend(objj_msgSend(observation,"timeStamp"),"formatToDate"));
objj_msgSend(_8,"addSubview:",dateLabel);
titleLabel=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(100,10,380,20));
objj_msgSend(titleLabel,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","5E5E5E"));
objj_msgSend(titleLabel,"setTextShadowColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(titleLabel,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(titleLabel,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",14));
objj_msgSend(titleLabel,"setStringValue:",objj_msgSend(observation,"label"));
objj_msgSend(_8,"addSubview:",titleLabel);
textLabel=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(100,35,380,200));
objj_msgSend(textLabel,"setBezeled:",NO);
objj_msgSend(textLabel,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(textLabel,"setLineBreakMode:",CPLineBreakByWordWrapping);
objj_msgSend(textLabel,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","5E5E5E"));
objj_msgSend(textLabel,"setStringValue:",objj_msgSend(observation,"message"));
objj_msgSend(_8,"addSubview:",textLabel);
lineView=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",CGRectMake(90,10,1,30));
objj_msgSend(lineView,"setBackgroundColor:",objj_msgSend(CPColor,"colorWithHexString:","d4d4d4"));
objj_msgSend(_8,"addSubview:",lineView);
deleteButton=objj_msgSend(CPButton,"buttonWithTitle:","Delete");
objj_msgSend(deleteButton,"setAutoresizingMask:",CPViewMinXMargin);
objj_msgSend(deleteButton,"setFrame:",CGRectMake(0,0,70,25));
objj_msgSend(deleteButton,"setHidden:",YES);
objj_msgSend(deleteButton,"setAction:",sel_getUid("deleteButtonPressed:"));
objj_msgSend(deleteButton,"setTarget:",_8);
objj_msgSend(_8,"addSubview:",deleteButton);
}
return _8;
}
}),new objj_method(sel_getUid("layout"),function(_b,_c){
with(_b){
var _d=20,_e=CGRectGetWidth(objj_msgSend(_b,"frame"));
objj_msgSend(textLabel,"sizeToFit");
_d+=CGRectGetHeight(objj_msgSend(textLabel,"frame"));
if(objj_msgSend(titleLabel,"stringValue")!=""){
_d+=25;
objj_msgSend(textLabel,"setFrameOrigin:",CGPointMake(100,35));
}else{
objj_msgSend(titleLabel,"removeFromSuperview");
objj_msgSend(textLabel,"setFrameOrigin:",CGPointMake(100,10));
}
_d=Math.max(_d,70);
objj_msgSend(_b,"setFrameSize:",CGSizeMake(_e,_d));
objj_msgSend(lineView,"setFrameSize:",CGSizeMake(1,_d-20));
objj_msgSend(deleteButton,"setCenter:",CGPointMake(_e-50,_d/2));
}
}),new objj_method(sel_getUid("mouseEntered:"),function(_f,_10,_11){
with(_f){
objj_msgSend(deleteButton,"setHidden:",NO);
}
}),new objj_method(sel_getUid("mouseExited:"),function(_12,_13,_14){
with(_12){
objj_msgSend(deleteButton,"setHidden:",YES);
}
}),new objj_method(sel_getUid("deleteButtonPressed:"),function(_15,_16,_17){
with(_15){
objj_msgSend(delegate,"willDeleteObservationView:",_15);
objj_msgSend(observation,"destroyAsync");
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("initialize"),function(_18,_19){
with(_18){
var _1a=objj_msgSend(CPBundle,"bundleForClass:",objj_msgSend(CPShadowView,"class"));
CPShadowViewHeavyBackgroundColor=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPNinePartImage,"alloc"),"initWithImageSlices:",[objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Shadow/CPShadowViewHeavyTopLeft.png",CGSizeMake(17,17)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Shadow/CPShadowViewHeavyTop.png",CGSizeMake(1,17)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Shadow/CPShadowViewHeavyTopRight.png",CGSizeMake(17,17)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Shadow/CPShadowViewHeavyLeft.png",CGSizeMake(17,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Shadow/CPShadowViewHeavyCenter.png",CGSizeMake(1,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Shadow/CPShadowViewHeavyRight.png",CGSizeMake(17,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Shadow/CPShadowViewHeavyBottomLeft.png",CGSizeMake(17,17)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Shadow/CPShadowViewHeavyBottom.png",CGSizeMake(1,17)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/Shadow/CPShadowViewHeavyBottomRight.png",CGSizeMake(17,17))]));
}
})]);
p;44;Visualization/KCScreenshotWindowController.jt;2332;@STATIC;1.0;t;2313;
var _1=objj_allocateClassPair(CPWindowController,"KCScreenshotWindowController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("imageView"),new objj_ivar("image")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("loadWindow"),function(_3,_4){
with(_3){
var _5=objj_msgSend(objj_msgSend(CPWindow,"alloc"),"initWithContentRect:styleMask:",CGRectMake(0,0,800,600),CPDocModalWindowMask|CPResizableWindowMask);
imageView=objj_msgSend(objj_msgSend(CPImageView,"alloc"),"initWithFrame:",CGRectMake(0,0,400,300));
objj_msgSend(imageView,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(imageView,"setImageScaling:",CPScaleProportionally);
objj_msgSend(imageView,"setImageAlignment:",CPImageAlignCenter);
objj_msgSend(_5,"setContentView:",imageView);
var _6=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(0,0,800,600));
objj_msgSend(_6,"setBordered:",NO);
objj_msgSend(_6,"setTarget:",_3);
objj_msgSend(_6,"setAction:",sel_getUid("close"));
objj_msgSend(_6,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(imageView,"addSubview:",_6);
objj_msgSend(_3,"setWindow:",_5);
}
}),new objj_method(sel_getUid("windowDidLoad"),function(_7,_8){
with(_7){
objj_msgSend(image,"setDelegate:",_7);
objj_msgSend(imageView,"setImage:",image);
if(objj_msgSend(image,"loadStatus")==CPImageLoadStatusInitialized){
objj_msgSend(image,"load");
}
}
}),new objj_method(sel_getUid("setImage:"),function(_9,_a,_b){
with(_9){
image=_b;
var _c=objj_msgSend(_b,"size"),_d=_c.width/_c.height;
var _e=objj_msgSend(objj_msgSend(CPApp,"mainWindow"),"frame"),_f=_e.size;
var _10=nil;
if(_c.width>_f.width){
_10=CGSizeMake(_f.width-50,(_f.width-50)/_d);
}else{
if(_c.height>_f.height){
_10=CGSizeMake((_f.height-50)/_d,_f.height-50);
}else{
_10=CGSizeMake(_c.width-50,_c.height-50);
}
}
objj_msgSend(objj_msgSend(_9,"window"),"setFrameSize:",_10);
}
}),new objj_method(sel_getUid("open"),function(_11,_12){
with(_11){
objj_msgSend(CPApp,"beginSheet:modalForWindow:modalDelegate:didEndSelector:contextInfo:",objj_msgSend(_11,"window"),objj_msgSend(CPApp,"mainWindow"),_11,nil,nil);
}
}),new objj_method(sel_getUid("close"),function(_13,_14){
with(_13){
image=nil;
objj_msgSend(CPApp,"endSheet:returnCode:",objj_msgSend(_13,"window"),nil);
}
})]);
p;42;Visualization/KCStatisticsViewController.jt;2654;@STATIC;1.0;i;38;PieChart/KCProjectPieChartController.jt;2592;
objj_executeFile("PieChart/KCProjectPieChartController.j",YES);
var _1=objj_allocateClassPair(CPViewController,"KCStatisticsViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dataSource"),new objj_ivar("applicationPieChartTitle"),new objj_ivar("applicationPieChartView"),new objj_ivar("projectPieChartTitle"),new objj_ivar("projectPieChartView"),new objj_ivar("applicationPieChartController"),new objj_ivar("projectPieChartController")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("dataSource"),function(_3,_4){
with(_3){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_5,_6,_7){
with(_5){
dataSource=_7;
}
}),new objj_method(sel_getUid("viewDidLoad"),function(_8,_9){
with(_8){
objj_msgSend(applicationPieChartTitle,"setTextColor:",objj_msgSend(CPColor,"colorWithWhite:alpha:",1,1));
objj_msgSend(applicationPieChartTitle,"setTextShadowColor:",objj_msgSend(CPColor,"colorWithWhite:alpha:",0.3,0.7));
objj_msgSend(applicationPieChartTitle,"setTextShadowOffset:",CGSizeMake(0,-1));
applicationPieChartController=objj_msgSend(objj_msgSend(KCApplicationPieChartController,"alloc"),"initWithCibName:bundle:","KCPieChartVisualizationView",nil);
objj_msgSend(applicationPieChartController,"setDataSource:",dataSource);
objj_msgSend(applicationPieChartView,"addSubview:",objj_msgSend(applicationPieChartController,"view"));
objj_msgSend(applicationPieChartView,"setBackgroundColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(CPShadowView,"shadowViewEnclosingView:withWeight:",applicationPieChartView,CPHeavyShadow);
objj_msgSend(projectPieChartTitle,"setTextColor:",objj_msgSend(CPColor,"colorWithWhite:alpha:",1,1));
objj_msgSend(projectPieChartTitle,"setTextShadowColor:",objj_msgSend(CPColor,"colorWithWhite:alpha:",0.3,0.7));
objj_msgSend(projectPieChartTitle,"setTextShadowOffset:",CGSizeMake(0,-1));
projectPieChartController=objj_msgSend(objj_msgSend(KCProjectPieChartController,"alloc"),"initWithCibName:bundle:","KCProjectPieChartVisualizationView",nil);
objj_msgSend(projectPieChartController,"setDataSource:",dataSource);
objj_msgSend(projectPieChartView,"addSubview:",objj_msgSend(projectPieChartController,"view"));
objj_msgSend(projectPieChartView,"setBackgroundColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(CPShadowView,"shadowViewEnclosingView:withWeight:",projectPieChartView,CPHeavyShadow);
}
}),new objj_method(sel_getUid("reloadData"),function(_a,_b){
with(_a){
objj_msgSend(applicationPieChartController,"reloadData");
objj_msgSend(projectPieChartController,"reloadData");
}
})]);
p;45;Visualization/KCVisualizationViewController.jt;8099;@STATIC;1.0;I;13;LPKit/LPKit.ji;12;KCZoomView.ji;25;KCDetailsViewController.ji;28;KCStatisticsViewController.ji;28;KCObersationViewController.ji;38;TimeLine/KCTimeLineVisualizationView.ji;48;TimeLine/KCTimeLineVisualizationViewController.jt;7853;
objj_executeFile("LPKit/LPKit.j",NO);
objj_executeFile("KCZoomView.j",YES);
objj_executeFile("KCDetailsViewController.j",YES);
objj_executeFile("KCStatisticsViewController.j",YES);
objj_executeFile("KCObersationViewController.j",YES);
objj_executeFile("TimeLine/KCTimeLineVisualizationView.j",YES);
objj_executeFile("TimeLine/KCTimeLineVisualizationViewController.j",YES);
var _1=objj_allocateClassPair(CPViewController,"KCVisualizationViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("resourceBlocksController"),new objj_ivar("timeLineView"),new objj_ivar("timeLineVisualizationViewController"),new objj_ivar("tabView"),new objj_ivar("statisticsViewController"),new objj_ivar("detailsViewController"),new objj_ivar("observationViewController"),new objj_ivar("statisticsScrollView"),new objj_ivar("weekViewController"),new objj_ivar("weekView"),new objj_ivar("logoImageView"),new objj_ivar("activityController"),new objj_ivar("resourceBlocks"),new objj_ivar("allResourceBlocks"),new objj_ivar("activities"),new objj_ivar("allActivities"),new objj_ivar("zoomView"),new objj_ivar("startDate"),new objj_ivar("endDate"),new objj_ivar("rangeStartDate"),new objj_ivar("rangeEndDate"),new objj_ivar("weekMode")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("resourceBlocks"),function(_3,_4){
with(_3){
return resourceBlocks;
}
}),new objj_method(sel_getUid("setResourceBlocks:"),function(_5,_6,_7){
with(_5){
resourceBlocks=_7;
}
}),new objj_method(sel_getUid("allResourceBlocks"),function(_8,_9){
with(_8){
return allResourceBlocks;
}
}),new objj_method(sel_getUid("setAllResourceBlocks:"),function(_a,_b,_c){
with(_a){
allResourceBlocks=_c;
}
}),new objj_method(sel_getUid("activities"),function(_d,_e){
with(_d){
return activities;
}
}),new objj_method(sel_getUid("setActivities:"),function(_f,_10,_11){
with(_f){
activities=_11;
}
}),new objj_method(sel_getUid("allActivities"),function(_12,_13){
with(_12){
return allActivities;
}
}),new objj_method(sel_getUid("setAllActivities:"),function(_14,_15,_16){
with(_14){
allActivities=_16;
}
}),new objj_method(sel_getUid("viewDidLoad"),function(_17,_18){
with(_17){
objj_msgSend(tabView,"setBackgroundColor:",objj_msgSend(CPColor,"clearColor"));
zoomView=objj_msgSend(objj_msgSend(KCZoomView,"alloc"),"initWithFrame:",CPRectMake(0,150,CPRectGetWidth(objj_msgSend(objj_msgSend(_17,"view"),"frame")),100));
objj_msgSend(zoomView,"setDataSource:",_17);
objj_msgSend(zoomView,"setDelegate:",_17);
objj_msgSend(objj_msgSend(_17,"view"),"addSubview:positioned:relativeTo:",zoomView,CPWindowBelow,timeLineView);
var _19=objj_msgSend(tabView,"tabViewItemAtIndex:",1);
objj_msgSend(_19,"setView:",statisticsScrollView);
weekViewController=objj_msgSend(objj_msgSend(KCStatisticsViewController,"alloc"),"initWithCibName:bundle:","KCStatisticsView",nil);
objj_msgSend(weekViewController,"setDataSource:",_17);
weekView=objj_msgSend(weekViewController,"view");
}
}),new objj_method(sel_getUid("setStartDate:"),function(_1a,_1b,_1c){
with(_1a){
objj_msgSend(_1a,"setStartDate:andEndDate:",objj_msgSend(CPDate,"beginOfDay:",_1c),objj_msgSend(CPDate,"endOfDay:",_1c));
}
}),new objj_method(sel_getUid("setStartDate:andEndDate:"),function(_1d,_1e,_1f,_20){
with(_1d){
startDate=_1f;
endDate=_20;
rangeStartDate=startDate;
rangeEndDate=_20;
objj_msgSend(timeLineVisualizationViewController,"changeZoomRangeLabelsToStartDate:endDate:",rangeStartDate,rangeEndDate);
objj_msgSend(timeLineVisualizationViewController,"resetRangeSlider");
objj_msgSend(_1d,"requestData");
}
}),new objj_method(sel_getUid("reloadData"),function(_21,_22){
with(_21){
if(objj_msgSend(resourceBlocks,"count")>0){
objj_msgSend(logoImageView,"setHidden:",YES);
if(weekMode){
objj_msgSend(_21,"hideDayViews:",YES);
objj_msgSend(weekView,"setFrame:",CPRectMake(0,60,CPRectGetWidth(objj_msgSend(objj_msgSend(_21,"view"),"frame")),CPRectGetHeight(objj_msgSend(objj_msgSend(_21,"view"),"frame"))-65));
objj_msgSend(objj_msgSend(_21,"view"),"addSubview:",weekView);
objj_msgSend(weekViewController,"reloadData");
}else{
objj_msgSend(_21,"hideDayViews:",NO);
objj_msgSend(weekView,"removeFromSuperview");
}
}else{
objj_msgSend(logoImageView,"setHidden:",NO);
objj_msgSend(weekView,"removeFromSuperview");
if(weekMode){
objj_msgSend(_21,"hideDayViews:",YES);
}else{
objj_msgSend(_21,"hideDayViews:",NO);
}
objj_msgSend(tabView,"setHidden:",YES);
}
objj_msgSend(zoomView,"setNeedsDisplay:",YES);
objj_msgSend(timeLineView,"setNeedsDisplay:",YES);
if(objj_msgSend(objj_msgSend(tabView,"selectedTabViewItem"),"label")==" Statistics "){
objj_msgSend(statisticsViewController,"reloadData");
}else{
if(objj_msgSend(objj_msgSend(tabView,"selectedTabViewItem"),"label")==" Details "){
objj_msgSend(detailsViewController,"reloadData");
}else{
objj_msgSend(observationViewController,"reloadData");
}
}
}
}),new objj_method(sel_getUid("tabView:willSelectTabViewItem:"),function(_23,_24,_25,_26){
with(_23){
if(objj_msgSend(_26,"label")==" Statistics "){
objj_msgSend(statisticsViewController,"reloadData");
}else{
if(objj_msgSend(_26,"label")==" Details "){
objj_msgSend(detailsViewController,"reloadData");
}else{
objj_msgSend(observationViewController,"reloadData");
}
}
}
}),new objj_method(sel_getUid("reloadButtonPressed:"),function(_27,_28,_29){
with(_27){
objj_msgSend(_27,"requestData");
}
}),new objj_method(sel_getUid("requestData"),function(_2a,_2b){
with(_2a){
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_2a,sel_getUid("resourceBlocksDidLoad:"),"RestfulCappuccinoResourcesDidLoad",KCResourceBlock);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_2a,sel_getUid("activitiesDidLoad:"),"RestfulCappuccinoResourcesDidLoad",KCActivity);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",observationViewController,sel_getUid("observationsDidLoad:"),"RestfulCappuccinoResourcesDidLoad",KCObservation);
objj_msgSend(objj_msgSend(KCNotificationBox,"sharedNotificationBox"),"showActivityWithMessage:","Loading");
var _2c=objj_msgSend(startDate,"ISOString"),_2d=objj_msgSend(endDate,"ISOString");
objj_msgSend(KCResourceBlock,"findAsyncWithParameters:",{start_date:_2c,end_date:_2d});
objj_msgSend(KCActivity,"findAsyncWithParameters:",{start_date:_2c,end_date:_2d});
objj_msgSend(KCObservation,"findAsyncWithParameters:",{start_date:_2c,end_date:_2d});
}
}),new objj_method(sel_getUid("resourceBlocksDidLoad:"),function(_2e,_2f,_30){
with(_2e){
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"removeObserver:name:object:",_2e,"RestfulCappuccinoResourcesDidLoad",KCResourceBlock);
objj_msgSend(objj_msgSend(KCNotificationBox,"sharedNotificationBox"),"closeWithSuccess");
allResourceBlocks=nil;
allResourceBlocks=objj_msgSend(objj_msgSend(objj_msgSend(_30,"object"),"restfulNotification"),"eventData");
resourceBlocks=objj_msgSend(CPArray,"arrayWithArray:",allResourceBlocks);
objj_msgSend(timeLineVisualizationViewController,"reloadData");
objj_msgSend(_2e,"reloadData");
}
}),new objj_method(sel_getUid("activitiesDidLoad:"),function(_31,_32,_33){
with(_31){
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"removeObserver:name:object:",_31,"RestfulCappuccinoResourcesDidLoad",KCActivity);
allActivities=nil;
allActivities=objj_msgSend(objj_msgSend(objj_msgSend(_33,"object"),"restfulNotification"),"eventData");
activities=objj_msgSend(CPArray,"arrayWithArray:",allActivities);
objj_msgSend(zoomView,"drawActivities");
}
}),new objj_method(sel_getUid("setWeekMode:"),function(_34,_35,_36){
with(_34){
weekMode=_36;
}
}),new objj_method(sel_getUid("hideDayViews:"),function(_37,_38,_39){
with(_37){
objj_msgSend(timeLineView,"setHidden:",_39);
objj_msgSend(tabView,"setHidden:",_39);
objj_msgSend(zoomView,"setHidden:",_39);
}
})]);
p;56;Visualization/KCVisualizationViewController_DataSource.jt;5606;@STATIC;1.0;i;31;KCVisualizationViewController.jt;5551;
objj_executeFile("KCVisualizationViewController.j",YES);
var _1=objj_getClass("KCVisualizationViewController");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"KCVisualizationViewController\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("numberOfResourceBlocksFiltered:"),function(_3,_4,_5){
with(_3){
if(_5){
return objj_msgSend(resourceBlocks,"count");
}else{
return objj_msgSend(allResourceBlocks,"count");
}
}
}),new objj_method(sel_getUid("identifierForResourceBlockAtIndex:filtered:"),function(_6,_7,_8,_9){
with(_6){
if(_9){
return objj_msgSend(objj_msgSend(resourceBlocks,"objectAtIndex:",_8),"identifier");
}else{
return objj_msgSend(objj_msgSend(allResourceBlocks,"objectAtIndex:",_8),"identifier");
}
}
}),new objj_method(sel_getUid("startDateForResourceBlockAtIndex:filtered:"),function(_a,_b,_c,_d){
with(_a){
if(_d){
return objj_msgSend(objj_msgSend(resourceBlocks,"objectAtIndex:",_c),"startDate");
}else{
return objj_msgSend(objj_msgSend(allResourceBlocks,"objectAtIndex:",_c),"startDate");
}
}
}),new objj_method(sel_getUid("endDateForResourceBlockAtIndex:filtered:"),function(_e,_f,_10,_11){
with(_e){
if(_11){
return objj_msgSend(objj_msgSend(resourceBlocks,"objectAtIndex:",_10),"endDate");
}else{
return objj_msgSend(objj_msgSend(allResourceBlocks,"objectAtIndex:",_10),"endDate");
}
}
}),new objj_method(sel_getUid("colorForResourceBlockAtIndex:filtered:"),function(_12,_13,_14,_15){
with(_12){
if(_15){
return objj_msgSend(objj_msgSend(resourceBlocks,"objectAtIndex:",_14),"color");
}else{
return objj_msgSend(objj_msgSend(allResourceBlocks,"objectAtIndex:",_14),"color");
}
}
}),new objj_method(sel_getUid("applicationForResourceBlockAtIndex:filtered:"),function(_16,_17,_18,_19){
with(_16){
if(_19){
return objj_msgSend(objj_msgSend(resourceBlocks,"objectAtIndex:",_18),"application");
}else{
return objj_msgSend(objj_msgSend(allResourceBlocks,"objectAtIndex:",_18),"application");
}
}
}),new objj_method(sel_getUid("durationForResourceBlockAtIndex:filtered:"),function(_1a,_1b,_1c,_1d){
with(_1a){
if(_1d){
return objj_msgSend(objj_msgSend(resourceBlocks,"objectAtIndex:",_1c),"duration");
}else{
return objj_msgSend(objj_msgSend(allResourceBlocks,"objectAtIndex:",_1c),"duration");
}
}
}),new objj_method(sel_getUid("dateForResourceBlockAtIndex:filtered:"),function(_1e,_1f,_20,_21){
with(_1e){
if(_21){
return objj_msgSend(objj_msgSend(resourceBlocks,"objectAtIndex:",_20),"date");
}else{
return objj_msgSend(objj_msgSend(allResourceBlocks,"objectAtIndex:",_20),"date");
}
}
}),new objj_method(sel_getUid("informationForResourceBlockAtIndex:filtered:"),function(_22,_23,_24,_25){
with(_22){
if(_25){
return objj_msgSend(objj_msgSend(resourceBlocks,"objectAtIndex:",_24),"information");
}else{
return objj_msgSend(objj_msgSend(allResourceBlocks,"objectAtIndex:",_24),"information");
}
}
}),new objj_method(sel_getUid("resourceBlockAtIndex:filtered:"),function(_26,_27,_28,_29){
with(_26){
if(_29){
return objj_msgSend(resourceBlocks,"objectAtIndex:",_28);
}else{
return objj_msgSend(allResourceBlocks,"objectAtIndex:",_28);
}
}
}),new objj_method(sel_getUid("numberOfActivitiesFiltered:"),function(_2a,_2b,_2c){
with(_2a){
if(_2c){
return objj_msgSend(activities,"count");
}else{
return objj_msgSend(allActivities,"count");
}
}
}),new objj_method(sel_getUid("labelOfActivityAtIndex:filtered:"),function(_2d,_2e,_2f,_30){
with(_2d){
if(_30){
return objj_msgSend(objj_msgSend(activities,"objectAtIndex:",_2f),"activity");
}else{
return objj_msgSend(objj_msgSend(allActivities,"objectAtIndex:",_2f),"activity");
}
}
}),new objj_method(sel_getUid("projectOfActivityAtIndex:filtered:"),function(_31,_32,_33,_34){
with(_31){
if(_34){
return objj_msgSend(objj_msgSend(activities,"objectAtIndex:",_33),"project");
}else{
return objj_msgSend(objj_msgSend(allActivities,"objectAtIndex:",_33),"project");
}
}
}),new objj_method(sel_getUid("startDateOfActivityAtIndex:filtered:"),function(_35,_36,_37,_38){
with(_35){
if(_38){
return objj_msgSend(objj_msgSend(activities,"objectAtIndex:",_37),"startDate");
}else{
return objj_msgSend(objj_msgSend(allActivities,"objectAtIndex:",_37),"startDate");
}
}
}),new objj_method(sel_getUid("endDateOfActivityAtIndex:filtered:"),function(_39,_3a,_3b,_3c){
with(_39){
var _3d=nil;
if(_3c){
_3d=objj_msgSend(objj_msgSend(activities,"objectAtIndex:",_3b),"endDate");
}else{
_3d=objj_msgSend(objj_msgSend(allActivities,"objectAtIndex:",_3b),"endDate");
}
if(_3d==nil){
_3d=objj_msgSend(CPDate,"date");
}
return _3d;
}
}),new objj_method(sel_getUid("durationOfActivityAtIndex:filtered:"),function(_3e,_3f,_40,_41){
with(_3e){
if(_41){
return objj_msgSend(objj_msgSend(activities,"objectAtIndex:",_40),"duration");
}else{
return objj_msgSend(objj_msgSend(allActivities,"objectAtIndex:",_40),"duration");
}
}
}),new objj_method(sel_getUid("colorOfActivityAtIndex:filtered:"),function(_42,_43,_44,_45){
with(_42){
if(_45){
return objj_msgSend(objj_msgSend(activities,"objectAtIndex:",_44),"color");
}else{
return objj_msgSend(objj_msgSend(allActivities,"objectAtIndex:",_44),"color");
}
}
}),new objj_method(sel_getUid("startRangeOfVisualizationView:"),function(_46,_47,_48){
with(_46){
return rangeStartDate;
}
}),new objj_method(sel_getUid("endRangeOfVisualizationView:"),function(_49,_4a,_4b){
with(_49){
return rangeEndDate;
}
}),new objj_method(sel_getUid("startDate"),function(_4c,_4d){
with(_4c){
return startDate;
}
}),new objj_method(sel_getUid("endDate"),function(_4e,_4f){
with(_4e){
return objj_msgSend(CPDate,"endOfDay:",startDate);
}
})]);
p;54;Visualization/KCVisualizationViewController_Delegate.jt;3269;@STATIC;1.0;i;31;KCVisualizationViewController.jt;3214;
objj_executeFile("KCVisualizationViewController.j",YES);
var _1=60*60*24;
var _2=objj_getClass("KCVisualizationViewController");
if(!_2){
throw new SyntaxError("*** Could not find definition for class \"KCVisualizationViewController\"");
}
var _3=_2.isa;
class_addMethods(_2,[new objj_method(sel_getUid("datesForZoomRange:"),function(_4,_5,_6){
with(_4){
if(startDate!=nil){
var _7=_1/(CPRectGetWidth(objj_msgSend(timeLineView,"frame"))-100),_8=_6.location*_7,_9=_8+(_6.length*_7),_a=objj_msgSend(startDate,"timeIntervalSince1970")+_8,_b=objj_msgSend(startDate,"timeIntervalSince1970")+_9;
rangeStartDate=objj_msgSend(CPDate,"dateWithTimeIntervalSince1970:",_a);
rangeEndDate=objj_msgSend(CPDate,"dateWithTimeIntervalSince1970:",_b);
return objj_msgSend(CPArray,"arrayWithObjects:",rangeStartDate,rangeEndDate,nil);
}
}
}),new objj_method(sel_getUid("willChangeZoomRange:"),function(_c,_d,_e){
with(_c){
var _f=objj_msgSend(_c,"datesForZoomRange:",_e);
if(objj_msgSend(_f,"count")!=2){
return NO;
}
var _10=objj_msgSend(_f,"objectAtIndex:",0),_11=objj_msgSend(_f,"objectAtIndex:",1);
objj_msgSend(_c,"filterResourceBlocksWithStartDate:andEndDate:",_10,_11);
objj_msgSend(_c,"filterActivitiesWithStartDate:andEndDate:",_10,_11);
objj_msgSend(timeLineVisualizationViewController,"changeZoomRangeLabelsToStartDate:endDate:",_10,_11);
objj_msgSend(_c,"reloadData");
return YES;
}
}),new objj_method(sel_getUid("filterResourceBlocksWithStartDate:andEndDate:"),function(_12,_13,_14,_15){
with(_12){
objj_msgSend(resourceBlocks,"removeAllObjects");
for(var i=0;i<objj_msgSend(allResourceBlocks,"count");i++){
var _16=objj_msgSend(allResourceBlocks,"objectAtIndex:",i);
if((objj_msgSend(_16,"startDate")>_14||objj_msgSend(_16,"endDate")>_14)&&(objj_msgSend(_16,"startDate")<_15||objj_msgSend(_16,"endDate")<_15)){
objj_msgSend(resourceBlocks,"addObject:",_16);
}
}
}
}),new objj_method(sel_getUid("filterActivitiesWithStartDate:andEndDate:"),function(_17,_18,_19,_1a){
with(_17){
objj_msgSend(activities,"removeAllObjects");
for(var i=0;i<objj_msgSend(allActivities,"count");i++){
var _1b=objj_msgSend(allActivities,"objectAtIndex:",i);
if((objj_msgSend(_1b,"startDate")>_19||objj_msgSend(_1b,"endDate")>_19)&&(objj_msgSend(_1b,"startDate")<_1a||objj_msgSend(_1b,"endDate")<_1a)){
objj_msgSend(activities,"addObject:",_1b);
}
}
}
}),new objj_method(sel_getUid("willChangeSortDescriptors:"),function(_1c,_1d,_1e){
with(_1c){
resourceBlocks=objj_msgSend(resourceBlocks,"sortedArrayUsingDescriptors:",_1e);
}
}),new objj_method(sel_getUid("deleteResourceBlocksAtIndexes:"),function(_1f,_20,_21){
with(_1f){
var _22=objj_msgSend(resourceBlocks,"objectsAtIndexes:",_21);
if(objj_msgSend(_22,"count")==0){
return;
}
for(var i=0;i<objj_msgSend(_22,"count");i++){
var _23=objj_msgSend(_22,"objectAtIndex:",i);
objj_msgSend(_23,"destroyAsync");
}
objj_msgSend(resourceBlocks,"removeObjectsAtIndexes:",_21);
}
}),new objj_method(sel_getUid("willSelectZoomElementAtIndex:"),function(_24,_25,_26){
with(_24){
objj_msgSend(zoomView,"willSelectZoomElementAtIndex:",_26);
}
}),new objj_method(sel_getUid("willSelectRowAtIndex:"),function(_27,_28,_29){
with(_27){
objj_msgSend(detailsViewController,"willSelectRowAtIndex:",_29);
}
})]);
p;33;Visualization/KCZoomElementView.jt;2489;@STATIC;1.0;I;13;LPKit/LPKit.jt;2452;
objj_executeFile("LPKit/LPKit.j",NO);
var _1=objj_allocateClassPair(CPView,"KCZoomElementView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("color"),new objj_ivar("strokeColor"),new objj_ivar("animation")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("color"),function(_8,_9){
with(_8){
return color;
}
}),new objj_method(sel_getUid("setColor:"),function(_a,_b,_c){
with(_a){
color=_c;
}
}),new objj_method(sel_getUid("strokeColor"),function(_d,_e){
with(_d){
return strokeColor;
}
}),new objj_method(sel_getUid("setStrokeColor:"),function(_f,_10,_11){
with(_f){
strokeColor=_11;
}
}),new objj_method(sel_getUid("drawRect:"),function(_12,_13,_14){
with(_12){
var _15=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort");
CGContextBeginPath(_15);
CGContextSetFillColor(_15,color);
CGContextSetStrokeColor(_15,strokeColor);
var _16=Math.min(CGRectGetWidth(_14)/2,10),_17=CGPathWithRoundedRectangleInRect(_14,_16,_16,NO,YES,YES,NO);
CGContextAddPath(_15,_17);
CGContextClosePath(_15);
CGContextDrawPath(_15,kCGPathFillStroke);
objj_msgSend(_12,"select");
}
}),new objj_method(sel_getUid("select"),function(_18,_19){
with(_18){
animation=objj_msgSend(_18,"viewAnimationWithOffset:",20);
objj_msgSend(animation,"setDuration:",0.2);
objj_msgSend(animation,"setDelegate:",nil);
objj_msgSend(animation,"startAnimation");
}
}),new objj_method(sel_getUid("deselect"),function(_1a,_1b){
with(_1a){
animation=objj_msgSend(_1a,"viewAnimationWithOffset:",-20);
objj_msgSend(animation,"setDuration:",0.2);
objj_msgSend(animation,"setDelegate:",_1a);
objj_msgSend(animation,"startAnimation");
}
}),new objj_method(sel_getUid("viewAnimationWithOffset:"),function(_1c,_1d,_1e){
with(_1c){
var pos=objj_msgSend(_1c,"frameOrigin");
animation=objj_msgSend(objj_msgSend(LPViewAnimation,"alloc"),"initWithViewAnimations:",[{"target":_1c,"animations":[[LPOriginAnimationKey,CGPointMake(pos.x,pos.y),CGPointMake(pos.x,pos.y+_1e)]]}]);
objj_msgSend(animation,"setAnimationCurve:",CPAnimationEaseInOut);
objj_msgSend(animation,"setShouldUseCSSAnimations:",YES);
return animation;
}
}),new objj_method(sel_getUid("animationDidEnd:"),function(_1f,_20,_21){
with(_1f){
objj_msgSend(_1f,"removeFromSuperview");
}
})]);
p;26;Visualization/KCZoomView.jt;6485;@STATIC;1.0;i;19;KCZoomElementView.jt;6442;
objj_executeFile("KCZoomElementView.j",YES);
var _1=objj_allocateClassPair(CPView,"KCZoomView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dataSource"),new objj_ivar("delegate"),new objj_ivar("zoomElementArray"),new objj_ivar("activityDescriptionArray"),new objj_ivar("zoomElementView")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("dataSource"),function(_3,_4){
with(_3){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_5,_6,_7){
with(_5){
dataSource=_7;
}
}),new objj_method(sel_getUid("delegate"),function(_8,_9){
with(_8){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_a,_b,_c){
with(_a){
delegate=_c;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_d,_e,_f){
with(_d){
_d=objj_msgSendSuper({receiver:_d,super_class:objj_getClass("KCZoomView").super_class},"initWithFrame:",_f);
if(_d){
objj_msgSend(_d,"setAutoresizingMask:",CPViewWidthSizable);
zoomElementArray=objj_msgSend(objj_msgSend(CPMutableArray,"alloc"),"init");
activityDescriptionArray=objj_msgSend(objj_msgSend(CPMutableArray,"alloc"),"init");
}
return _d;
}
}),new objj_method(sel_getUid("drawActivities"),function(_10,_11){
with(_10){
objj_msgSend(_10,"drawActivities:",nil);
}
}),new objj_method(sel_getUid("drawActivities:"),function(_12,_13,_14){
with(_12){
var _15=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort");
if(_15==nil){
return;
}
if(_14==nil){
_14=objj_msgSend(_12,"frame");
}
for(var i=0;i<objj_msgSend(activityDescriptionArray,"count");i++){
objj_msgSend(objj_msgSend(activityDescriptionArray,"objectAtIndex:",i),"removeFromSuperview");
}
objj_msgSend(activityDescriptionArray,"removeAllObjects");
var _16=objj_msgSend(dataSource,"startRangeOfVisualizationView:",_12),_17=objj_msgSend(dataSource,"endRangeOfVisualizationView:",_12);
var _18=CPRectGetWidth(_14)/(objj_msgSend(_17,"timeIntervalSince1970")-objj_msgSend(_16,"timeIntervalSince1970")),_19=objj_msgSend(dataSource,"numberOfActivitiesFiltered:",YES);
for(var j=0;j<_19;j++){
var _1a=objj_msgSend(dataSource,"startDateOfActivityAtIndex:filtered:",j,YES),_1b=objj_msgSend(dataSource,"endDateOfActivityAtIndex:filtered:",j,YES),_1c=objj_msgSend(dataSource,"colorOfActivityAtIndex:filtered:",j,YES),_1d=objj_msgSend(dataSource,"labelOfActivityAtIndex:filtered:",j,YES);
var _1e=Math.floor((objj_msgSend(_1a,"timeIntervalSince1970")-objj_msgSend(_16,"timeIntervalSince1970"))*_18),_1f=Math.ceil((objj_msgSend(_1b,"timeIntervalSince1970")-objj_msgSend(_1a,"timeIntervalSince1970"))*_18),_20=CPRectMake(_1e,0,_1f,97);
if(!objj_msgSend(_1c,"isKindOfClass:",objj_msgSend(CPColor,"class"))){
_1c=objj_msgSend(CPColor,"randomColor");
}
CGContextBeginPath(_15);
CGContextSetLineWidth(_15,1);
CGContextSetFillColor(_15,objj_msgSend(_1c,"colorWithAlphaComponent:",0.25));
CGContextSetStrokeColor(_15,objj_msgSend(_1c,"colorWithAlphaComponent:",0.5));
CGContextAddRect(_15,_20);
CGContextClosePath(_15);
CGContextDrawPath(_15,kCGPathFillStroke);
var _21=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CPRectMake(_1e,70,_1f,20));
objj_msgSend(_21,"setStringValue:",_1d);
objj_msgSend(_21,"setTextColor:",objj_msgSend(CPColor,"grayColor"));
objj_msgSend(_21,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",11));
objj_msgSend(activityDescriptionArray,"addObject:",_21);
objj_msgSend(_12,"addSubview:",_21);
}
}
}),new objj_method(sel_getUid("drawResourceBlocks:"),function(_22,_23,_24){
with(_22){
var _25=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort");
if(_25==nil){
return;
}
if(_24==nil){
_24=objj_msgSend(_22,"frame");
}
var _26=objj_msgSend(dataSource,"startRangeOfVisualizationView:",_22),_27=objj_msgSend(dataSource,"endRangeOfVisualizationView:",_22);
var _28=CPRectGetWidth(_24)/(objj_msgSend(_27,"timeIntervalSince1970")-objj_msgSend(_26,"timeIntervalSince1970"));
objj_msgSend(zoomElementView,"removeFromSuperview");
objj_msgSend(zoomElementArray,"removeAllObjects");
var _29=objj_msgSend(dataSource,"numberOfResourceBlocksFiltered:",YES);
for(var i=0;i<_29;i++){
var _2a=objj_msgSend(dataSource,"resourceBlockAtIndex:filtered:",i,YES),_2b=objj_msgSend(_2a,"startDate"),_2c=objj_msgSend(_2a,"endDate"),_2d=objj_msgSend(_2a,"color"),_2e=objj_msgSend(_2a,"strokeColor");
var _2f=Math.floor((objj_msgSend(_2b,"timeIntervalSince1970")-objj_msgSend(_26,"timeIntervalSince1970"))*_28),_30=Math.ceil((objj_msgSend(_2c,"timeIntervalSince1970")-objj_msgSend(_2b,"timeIntervalSince1970"))*_28),_31=CPRectMake(_2f,0,_30,40);
CGContextBeginPath(_25);
CGContextSetFillColor(_25,_2d);
CGContextSetStrokeColor(_25,_2e);
var _32=Math.min(_30/2,10),_33=CGPathWithRoundedRectangleInRect(_31,_32,_32,NO,YES,YES,NO);
CGContextAddPath(_25,_33);
CGContextClosePath(_25);
CGContextDrawPath(_25,kCGPathFillStroke);
objj_msgSend(zoomElementArray,"addObject:",_31);
}
if(objj_msgSend(zoomElementArray,"count")>0){
objj_msgSend(_22,"willSelectZoomElementAtIndex:",0);
objj_msgSend(delegate,"willSelectRowAtIndex:",0);
}
}
}),new objj_method(sel_getUid("drawRect:"),function(_34,_35,_36){
with(_34){
objj_msgSend(_34,"drawActivities:",_36);
objj_msgSend(_34,"drawResourceBlocks:",_36);
}
}),new objj_method(sel_getUid("willSelectZoomElementAtIndex:"),function(_37,_38,_39){
with(_37){
var _3a=objj_msgSend(zoomElementArray,"objectAtIndex:",_39),_3b=objj_msgSend(objj_msgSend(dataSource,"resourceBlockAtIndex:filtered:",_39,YES),"color"),_3c=objj_msgSend(objj_msgSend(dataSource,"resourceBlockAtIndex:filtered:",_39,YES),"strokeColor");
objj_msgSend(zoomElementView,"deselect");
var _3d=objj_msgSend(dataSource,"resourceBlockAtIndex:filtered:",_39,YES);
if(!objj_msgSend(objj_msgSend(_3d,"application"),"isEqualToString:","Idle")){
zoomElementView=objj_msgSend(objj_msgSend(KCZoomElementView,"alloc"),"initWithFrame:",_3a);
objj_msgSend(zoomElementView,"setColor:",_3b);
objj_msgSend(zoomElementView,"setStrokeColor:",_3c);
objj_msgSend(_37,"addSubview:",zoomElementView);
}
}
}),new objj_method(sel_getUid("mouseUp:"),function(_3e,_3f,_40){
with(_3e){
var _41=objj_msgSend(_3e,"convertPoint:fromView:",objj_msgSend(_40,"locationInWindow"),nil);
for(var i=0;i<objj_msgSend(zoomElementArray,"count");i++){
var _42=objj_msgSend(zoomElementArray,"objectAtIndex:",i);
if(_41.x>=CGRectGetMinX(_42)&&_41.x<=CGRectGetMaxX(_42)){
objj_msgSend(_3e,"willSelectZoomElementAtIndex:",i);
objj_msgSend(delegate,"willSelectRowAtIndex:",i);
return;
}
}
}
})]);
p;56;Visualization/PieChart/KCApplicationPieChartController.jt;8711;@STATIC;1.0;I;21;Foundation/CPObject.ji;16;KCPieChartView.ji;22;KCPieChartLegendView.ji;19;KCPieChartElement.jt;8594;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("KCPieChartView.j",YES);
objj_executeFile("KCPieChartLegendView.j",YES);
objj_executeFile("KCPieChartElement.j",YES);
var _1=objj_allocateClassPair(CPViewController,"KCApplicationPieChartController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dataSource"),new objj_ivar("pieChartView"),new objj_ivar("applicationNameTextField"),new objj_ivar("durationTextField"),new objj_ivar("visitsTextField"),new objj_ivar("timePerVisitTextField"),new objj_ivar("totalNumberOfApplicationsTextField"),new objj_ivar("totalDurationTextField"),new objj_ivar("totalDuration"),new objj_ivar("categories"),new objj_ivar("legendView")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("dataSource"),function(_3,_4){
with(_3){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_5,_6,_7){
with(_5){
dataSource=_7;
}
}),new objj_method(sel_getUid("initWithCibName:bundle:"),function(_8,_9,_a,_b){
with(_8){
_8=objj_msgSendSuper({receiver:_8,super_class:objj_getClass("KCApplicationPieChartController").super_class},"initWithCibName:bundle:",_a,_b);
if(_8){
totalDuration=0;
categories=objj_msgSend(objj_msgSend(CPMutableArray,"alloc"),"init");
}
return _8;
}
}),new objj_method(sel_getUid("loadView"),function(_c,_d){
with(_c){
objj_msgSendSuper({receiver:_c,super_class:objj_getClass("KCApplicationPieChartController").super_class},"loadView");
objj_msgSend(pieChartView,"setDelegate:",_c);
objj_msgSend(pieChartView,"setDataSource:",_c);
legendView=objj_msgSend(objj_msgSend(KCPieChartLegendView,"alloc"),"initWithFrame:",CGRectMake(15,CPRectGetHeight(objj_msgSend(objj_msgSend(_c,"view"),"frame"))-60,550,65));
objj_msgSend(legendView,"setDataSource:",_c);
objj_msgSend(legendView,"setDelegate:",_c);
objj_msgSend(objj_msgSend(_c,"view"),"addSubview:",legendView);
}
}),new objj_method(sel_getUid("reloadData"),function(_e,_f){
with(_e){
objj_msgSend(_e,"clear");
totalDuration=0;
objj_msgSend(categories,"removeAllObjects");
var _10=objj_msgSend(objj_msgSend(CPMutableDictionary,"alloc"),"init"),_11=objj_msgSend(dataSource,"numberOfResourceBlocksFiltered:",YES);
for(var i=0;i<_11;i++){
var _12=objj_msgSend(dataSource,"applicationForResourceBlockAtIndex:filtered:",i,YES),_13=objj_msgSend(dataSource,"durationForResourceBlockAtIndex:filtered:",i,YES),_14=nil;
if(!objj_msgSend(_10,"containsKey:",_12)){
_14=objj_msgSend(objj_msgSend(KCPieChartElement,"alloc"),"initWithCategory:",_12);
objj_msgSend(_10,"setObject:forKey:",_14,_12);
}else{
_14=objj_msgSend(_10,"objectForKey:",_12);
}
objj_msgSend(_14,"addDuration:",_13);
objj_msgSend(_14,"addVisit");
totalDuration+=_13;
}
var _15=objj_msgSend(CPSortDescriptor,"sortDescriptorWithKey:ascending:","duration",NO);
categories=objj_msgSend(objj_msgSend(_10,"allValues"),"sortedArrayUsingDescriptors:",objj_msgSend(CPArray,"arrayWithObject:",_15));
if(objj_msgSend(categories,"count")>15){
var _16=0,_17=0;
for(var i=objj_msgSend(categories,"count")-1;i>=14;i--){
var _14=objj_msgSend(categories,"objectAtIndex:",i);
_16+=objj_msgSend(_14,"duration");
_17+=objj_msgSend(_14,"visits");
objj_msgSend(categories,"removeObjectAtIndex:",i);
}
var _18=objj_msgSend(objj_msgSend(KCPieChartElement,"alloc"),"initWithCategory:","Others");
objj_msgSend(_18,"addDuration:",_16);
objj_msgSend(_18,"setVisits:",_17);
objj_msgSend(categories,"addObject:",_18);
}
objj_msgSend(pieChartView,"setNeedsDisplay:",YES);
objj_msgSend(legendView,"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("clear"),function(_19,_1a){
with(_19){
objj_msgSend(totalNumberOfApplicationsTextField,"setStringValue:","");
objj_msgSend(totalDurationTextField,"setStringValue:","");
objj_msgSend(applicationNameTextField,"setStringValue:","");
objj_msgSend(durationTextField,"setStringValue:","");
}
}),new objj_method(sel_getUid("colorForCategory:"),function(_1b,_1c,_1d){
with(_1b){
if(objj_msgSend(_1d,"isEqualToString:","EXCEL")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.278,0.651,0.216,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","WINWORD")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.196,0.565,0.824,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","explorer")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.953,0.863,0.435,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","OUTLOOK")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.961,0.843,0.22,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","POWERPNT")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.894,0.353,0.149,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","iexplore")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0,0.388,0.89,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","KnowSelf")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.733,0.733,0.733,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","WebSearch")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.373,0.969,0.569,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","AcroRd32")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.804,0.129,0.098,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","Idle")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.714,0.91,0.973,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","chrome")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.412,0.612,0.827,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","firefox")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.835,0.361,0.11,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","VISIO")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0,0.267,0.659,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","communicator")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0,0.757,0.827,1);
}else{
if(objj_msgSend(_1d,"isEqualToString:","calc")){
return objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.545,0.761,0.278,1);
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
return nil;
}
}),new objj_method(sel_getUid("numberOfPiesInPieChart:"),function(_1e,_1f,_20){
with(_1e){
return objj_msgSend(categories,"count");
}
}),new objj_method(sel_getUid("percentageOfPieChart:atIndex:"),function(_21,_22,_23,_24){
with(_21){
var _25=objj_msgSend(categories,"objectAtIndex:",_24);
return objj_msgSend(_25,"duration")/totalDuration*100;
}
}),new objj_method(sel_getUid("colorOfPieChart:atIndex:"),function(_26,_27,_28,_29){
with(_26){
var _2a=objj_msgSend(categories,"objectAtIndex:",_29),_2b=objj_msgSend(_26,"colorForCategory:",objj_msgSend(_2a,"category"));
if(_2b){
return _2b;
}else{
return objj_msgSend(CPColor,"colorAtIndex:",_29);
}
}
}),new objj_method(sel_getUid("keyOfPieChart:atIndex:"),function(_2c,_2d,_2e,_2f){
with(_2c){
return objj_msgSend(objj_msgSend(categories,"objectAtIndex:",_2f),"category");
}
}),new objj_method(sel_getUid("willSelectPieChartAtIndex:"),function(_30,_31,_32){
with(_30){
objj_msgSend(pieChartView,"selectPieAtIndex:",_32);
}
}),new objj_method(sel_getUid("didSelectPieChartAtIndex:"),function(_33,_34,_35){
with(_33){
var _36=objj_msgSend(categories,"objectAtIndex:",_35);
objj_msgSend(totalNumberOfApplicationsTextField,"setIntegerValue:",objj_msgSend(categories,"count"));
objj_msgSend(totalDurationTextField,"setStringValue:",objj_msgSend(_33,"stringFromTimeInterval:withSeconds:",totalDuration,NO));
objj_msgSend(applicationNameTextField,"setStringValue:",objj_msgSend(objj_msgSend(_36,"category"),"capitalizedString"));
objj_msgSend(durationTextField,"setStringValue:",objj_msgSend(_33,"stringFromTimeInterval:withSeconds:",objj_msgSend(_36,"duration"),NO));
objj_msgSend(visitsTextField,"setStringValue:",objj_msgSend(_36,"visits"));
objj_msgSend(timePerVisitTextField,"setStringValue:",objj_msgSend(_33,"stringFromTimeInterval:withSeconds:",objj_msgSend(_36,"averageTimePerVisit"),YES));
objj_msgSend(pieChartView,"setImage:",objj_msgSend(CPImage,"applicationImageNamed:size:",objj_msgSend(_36,"category"),CPSizeMake(64,64)));
}
}),new objj_method(sel_getUid("stringFromTimeInterval:withSeconds:"),function(_37,_38,_39,_3a){
with(_37){
var _3b=Math.floor(_39/60/60),_3c=Math.floor(_39/60-_3b*60),_3d="";
if(_3b>0){
_3d+=objj_msgSend(CPString,"stringWithFormat:","%i hours, ",_3b);
}
if(_3a){
var _3e=_39-(_3b*60*60)-(_3c*60);
if(_3c==0&&_3b==0){
_3d+=objj_msgSend(CPString,"stringWithFormat:","%i sec",_3e);
}else{
_3d+=objj_msgSend(CPString,"stringWithFormat:","%i min, %i sec",_3c,_3e);
}
}else{
_3d+=objj_msgSend(CPString,"stringWithFormat:","%i min",_3c);
}
return _3d;
}
})]);
p;42;Visualization/PieChart/KCPieChartElement.jt;1532;@STATIC;1.0;t;1513;
var _1=objj_allocateClassPair(CPObject,"KCPieChartElement"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("category"),new objj_ivar("duration"),new objj_ivar("visits"),new objj_ivar("color")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("category"),function(_3,_4){
with(_3){
return category;
}
}),new objj_method(sel_getUid("setCategory:"),function(_5,_6,_7){
with(_5){
category=_7;
}
}),new objj_method(sel_getUid("duration"),function(_8,_9){
with(_8){
return duration;
}
}),new objj_method(sel_getUid("setDuration:"),function(_a,_b,_c){
with(_a){
duration=_c;
}
}),new objj_method(sel_getUid("visits"),function(_d,_e){
with(_d){
return visits;
}
}),new objj_method(sel_getUid("setVisits:"),function(_f,_10,_11){
with(_f){
visits=_11;
}
}),new objj_method(sel_getUid("color"),function(_12,_13){
with(_12){
return color;
}
}),new objj_method(sel_getUid("setColor:"),function(_14,_15,_16){
with(_14){
color=_16;
}
}),new objj_method(sel_getUid("initWithCategory:"),function(_17,_18,_19){
with(_17){
_17=objj_msgSendSuper({receiver:_17,super_class:objj_getClass("KCPieChartElement").super_class},"init");
if(_17){
_17.category=_19;
_17.duration=0;
_17.visits=0;
}
return _17;
}
}),new objj_method(sel_getUid("addDuration:"),function(_1a,_1b,_1c){
with(_1a){
_1a.duration+=_1c;
}
}),new objj_method(sel_getUid("addVisit"),function(_1d,_1e){
with(_1d){
_1d.visits++;
}
}),new objj_method(sel_getUid("averageTimePerVisit"),function(_1f,_20){
with(_1f){
return duration/visits;
}
})]);
p;50;Visualization/PieChart/KCPieChartInformationView.jt;1146;@STATIC;1.0;t;1127;
var _1=objj_allocateClassPair(CPView,"KCPieChartInformationView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("drawRect:"),function(_3,_4,_5){
with(_3){
_5=CGRectInset(_5,7,7);
var _6=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort");
var _7=CGRectGetMinX(_5)+10,_8=CGRectGetMidX(_5),_9=CGRectGetMaxX(_5),_a=CGRectGetMinY(_5),_b=CGRectGetMidY(_5),_c=CGRectGetMaxY(_5),_d=10;
CGContextBeginPath(_6);
CGContextSetFillColor(_6,objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",0.88,0.88,0.88,1));
CGContextSetStrokeColor(_6,objj_msgSend(CPColor,"darkGrayColor"));
CGContextSetShadowWithColor(_6,CGSizeMake(0,0),5,objj_msgSend(CPColor,"blackColor"));
CGContextMoveToPoint(_6,_7,_b-10);
CGContextAddArcToPoint(_6,_7,_a,_8,_a,_d);
CGContextAddArcToPoint(_6,_9,_a,_9,_b,_d);
CGContextAddArcToPoint(_6,_9,_c,_8,_c,_d);
CGContextAddArcToPoint(_6,_7,_c,_7,_b+10,_d);
CGContextAddLineToPoint(_6,_7,_b+10);
CGContextAddLineToPoint(_6,_7-10,_b);
CGContextAddLineToPoint(_6,_7,_b-10);
CGContextClosePath(_6);
CGContextStrokePath(_6);
CGContextFillPath(_6);
}
})]);
p;52;Visualization/PieChart/KCPieChartLegendElementView.jt;2621;@STATIC;1.0;t;2602;
var _1=objj_allocateClassPair(CPView,"KCPieChartLegendElementView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("color"),new objj_ivar("title"),new objj_ivar("tag"),new objj_ivar("titleTextField")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("color"),function(_8,_9){
with(_8){
return color;
}
}),new objj_method(sel_getUid("setColor:"),function(_a,_b,_c){
with(_a){
color=_c;
}
}),new objj_method(sel_getUid("title"),function(_d,_e){
with(_d){
return title;
}
}),new objj_method(sel_getUid("setTitle:"),function(_f,_10,_11){
with(_f){
title=_11;
}
}),new objj_method(sel_getUid("tag"),function(_12,_13){
with(_12){
return tag;
}
}),new objj_method(sel_getUid("setTag:"),function(_14,_15,_16){
with(_14){
tag=_16;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_17,_18,_19){
with(_17){
_17=objj_msgSendSuper({receiver:_17,super_class:objj_getClass("KCPieChartLegendElementView").super_class},"initWithFrame:",_19);
if(_17){
titleTextField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(CGRectGetHeight(_19),0,CGRectGetWidth(_19)-CGRectGetHeight(_19),CGRectGetHeight(_19)));
objj_msgSend(titleTextField,"setVerticalAlignment:",CPCenterVerticalTextAlignment);
objj_msgSend(titleTextField,"setTextColor:",objj_msgSend(CPColor,"colorWithHexString:","5E5E5E"));
objj_msgSend(_17,"addSubview:",titleTextField);
}
return _17;
}
}),new objj_method(sel_getUid("drawRect:"),function(_1a,_1b,_1c){
with(_1a){
var _1d=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort"),_1e=CGRectMake(0,0,CGRectGetHeight(_1c),CGRectGetHeight(_1c)),_1e=CGRectInset(_1e,2.5,2.5);
CGContextBeginPath(_1d);
CGContextSetLineWidth(_1d,2);
CGContextSetStrokeColor(_1d,objj_msgSend(CPColor,"colorWithRed:green:blue:alpha:",objj_msgSend(color,"redComponent")-0.1,objj_msgSend(color,"greenComponent")-0.1,objj_msgSend(color,"blueComponent")-0.1,1));
CGContextSetFillColor(_1d,color);
var _1f=CGPathWithRoundedRectangleInRect(_1e,5,5,YES,YES,YES,YES);
CGContextAddPath(_1d,_1f);
CGContextClosePath(_1d);
CGContextDrawPath(_1d,kCGPathFillStroke);
}
}),new objj_method(sel_getUid("setTitle:"),function(_20,_21,_22){
with(_20){
_20.title=_22;
objj_msgSend(titleTextField,"setStringValue:",_22);
}
}),new objj_method(sel_getUid("mouseUp:"),function(_23,_24,_25){
with(_23){
objj_msgSend(delegate,"willSelectPieChartAtIndex:",tag);
}
})]);
p;45;Visualization/PieChart/KCPieChartLegendView.jt;1799;@STATIC;1.0;i;29;KCPieChartLegendElementView.jt;1746;
objj_executeFile("KCPieChartLegendElementView.j",YES);
var _1=objj_allocateClassPair(CPView,"KCPieChartLegendView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("dataSource")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("dataSource"),function(_8,_9){
with(_8){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_a,_b,_c){
with(_a){
dataSource=_c;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_d,_e,_f){
with(_d){
_d=objj_msgSendSuper({receiver:_d,super_class:objj_getClass("KCPieChartLegendView").super_class},"initWithFrame:",_f);
if(_d){
}
return _d;
}
}),new objj_method(sel_getUid("drawRect:"),function(_10,_11,_12){
with(_10){
objj_msgSend(_10,"clearView");
var _13=objj_msgSend(dataSource,"numberOfPiesInPieChart:",_10),y=-20;
for(var i=0;i<_13;i++){
if(!(i%5)){
y+=20;
}
var _14=objj_msgSend(dataSource,"colorOfPieChart:atIndex:",_10,i),_15=objj_msgSend(dataSource,"keyOfPieChart:atIndex:",_10,i);
var _16=objj_msgSend(objj_msgSend(KCPieChartLegendElementView,"alloc"),"initWithFrame:",CGRectMake((i%5)*100,y,100,20));
objj_msgSend(_16,"setDelegate:",delegate);
objj_msgSend(_16,"setTag:",i);
objj_msgSend(_16,"setColor:",_14);
objj_msgSend(_16,"setTitle:",_15);
objj_msgSend(_10,"addSubview:",_16);
}
}
}),new objj_method(sel_getUid("clearView"),function(_17,_18){
with(_17){
var _19=objj_msgSend(_17,"subviews");
for(var i=0;i<objj_msgSend(_19,"count");i++){
var _1a=objj_msgSend(_19,"objectAtIndex:",i);
objj_msgSend(_1a,"removeFromSuperview");
}
}
})]);
p;46;Visualization/PieChart/KCPieChartOverlayView.jt;2960;@STATIC;1.0;t;2941;
var _1=objj_allocateClassPair(CPView,"KCPieChartOverlayView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("imageView")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("KCPieChartOverlayView").super_class},"initWithFrame:",_5);
if(_3){
imageView=objj_msgSend(objj_msgSend(KCImageView,"alloc"),"init");
var _6=objj_msgSend(objj_msgSend(CPBox,"alloc"),"initWithFrame:",CGRectMake(CGRectGetMidX(objj_msgSend(_3,"frame"))-50,CGRectGetMidY(objj_msgSend(_3,"frame"))-50,100,100));
objj_msgSend(_6,"setBorderColor:",objj_msgSend(CPColor,"darkGrayColor"));
objj_msgSend(_6,"setFillColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_6,"setBorderType:",CPLineBorder);
objj_msgSend(_6,"setBorderWidth:",1);
objj_msgSend(_6,"setCornerRadius:",50);
objj_msgSend(_6,"setContentViewMargins:",CPMakeSize(15,15));
objj_msgSend(_6,"setContentView:",imageView);
objj_msgSend(_3,"addSubview:",_6);
}
return _3;
}
}),new objj_method(sel_getUid("drawRect:"),function(_7,_8,_9){
with(_7){
var _a=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort");
var _b=CGRectGetMinX(_9)+9,_c=CGRectGetMidX(_9),_d=CGRectGetMaxX(_9)-9,_e=CGRectGetMinY(_9)+9,_f=CGRectGetMidY(_9),_10=CGRectGetMaxY(_9)-9,_11=(CGRectGetWidth(_9)-18)/2;
CGContextMoveToPoint(_a,CGRectGetMinX(_9),CGRectGetMinY(_9));
var _12=CGPathWithRoundedRectangleInRect(_9,0,0,NO,NO,NO,NO);
CGContextSetFillColor(_a,objj_msgSend(CPColor,"whiteColor"));
CGContextSetShadowWithColor(_a,CGSizeMake(0,0),4,objj_msgSend(CPColor,"blackColor"));
CGContextAddPath(_a,_12);
CGContextMoveToPoint(_a,_b,_f);
CGContextAddArcToPoint(_a,_b,_10,_c,_10,_11);
CGContextAddArcToPoint(_a,_d,_10,_d,_f,_11);
CGContextAddArcToPoint(_a,_d,_e,_c,_e,_11);
CGContextAddArcToPoint(_a,_b,_e,_b,_f,_11);
CGContextClosePath(_a);
CGContextDrawPath(_a,kCGPathFill);
CGContextBeginPath(_a);
CGContextSetStrokeColor(_a,objj_msgSend(CPColor,"darkGrayColor"));
CGContextSetLineWidth(_a,1);
CGContextMoveToPoint(_a,_d+4,_f);
CGContextAddArcToPoint(_a,_d+4,_f-10,_d-6,_f-10,2);
CGContextAddArcToPoint(_a,_d-6,_f-10,_d-14,_f,5);
CGContextAddLineToPoint(_a,_d-14,_f);
CGContextAddArcToPoint(_a,_d-6,_f+10,_d+4,_f+10,5);
CGContextAddArcToPoint(_a,_d+4,_f+10,_d+4,_f,2);
CGContextClosePath(_a);
CGContextDrawPath(_a,kCGPathStroke);
CGContextBeginPath(_a);
CGContextSetFillColor(_a,objj_msgSend(CPColor,"whiteColor"));
CGContextMoveToPoint(_a,_d+4,_f);
CGContextAddArcToPoint(_a,_d+4,_f-10,_d-6,_f-10,2);
CGContextAddArcToPoint(_a,_d-6,_f-10,_d-14,_f,5);
CGContextAddLineToPoint(_a,_d-14,_f);
CGContextAddArcToPoint(_a,_d-6,_f+10,_d+4,_f+10,5);
CGContextAddArcToPoint(_a,_d+4,_f+10,_d+4,_f,2);
CGContextClosePath(_a);
CGContextDrawPath(_a,kCGPathFill);
}
}),new objj_method(sel_getUid("setImage:"),function(_13,_14,_15){
with(_13){
objj_msgSend(imageView,"setImage:",_15);
}
})]);
p;39;Visualization/PieChart/KCPieChartView.jt;5502;@STATIC;1.0;i;23;KCPieChartOverlayView.jt;5455;
objj_executeFile("KCPieChartOverlayView.j",YES);
var _1=objj_allocateClassPair(CPView,"KCPieChartView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dataSource"),new objj_ivar("delegate"),new objj_ivar("selectionAngle"),new objj_ivar("oldSelectionAngle"),new objj_ivar("animationAngle"),new objj_ivar("bounceCount"),new objj_ivar("timer"),new objj_ivar("overlayView")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("dataSource"),function(_3,_4){
with(_3){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_5,_6,_7){
with(_5){
dataSource=_7;
}
}),new objj_method(sel_getUid("delegate"),function(_8,_9){
with(_8){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_a,_b,_c){
with(_a){
delegate=_c;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_d,_e,_f){
with(_d){
_d=objj_msgSendSuper({receiver:_d,super_class:objj_getClass("KCPieChartView").super_class},"initWithFrame:",_f);
if(_d){
var _10=CPRectMake(0,0,CPRectGetWidth(_f),CPRectGetHeight(_f));
overlayView=objj_msgSend(objj_msgSend(KCPieChartOverlayView,"alloc"),"initWithFrame:",_10);
objj_msgSend(overlayView,"setBackgroundColor:",objj_msgSend(CPColor,"clearColor"));
objj_msgSend(_d,"addSubview:",overlayView);
piePathArray=objj_msgSend(objj_msgSend(CPMutableArray,"alloc"),"init");
selectionAngle=0;
oldSelectionAngle=0;
animationAngle=0;
bounceCount=10;
}
return _d;
}
}),new objj_method(sel_getUid("drawRect:"),function(_11,_12,_13){
with(_11){
var _14=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort"),_15=CPPointMake(CPRectGetWidth(_13)/2,CPRectGetHeight(_13)/2),_16=objj_msgSend(dataSource,"numberOfPiesInPieChart:",_11),_17=oldSelectionAngle/180*Math.PI-animationAngle/180*Math.PI;
for(var i=0;i<_16;i++){
var _18=objj_msgSend(dataSource,"percentageOfPieChart:atIndex:",_11,i),_19=_18/100*360;
_19=_19/180*Math.PI+_17;
color=objj_msgSend(dataSource,"colorOfPieChart:atIndex:",_11,i);
CGContextBeginPath(_14);
CGContextMoveToPoint(_14,_15.x,_15.y);
CGContextSetFillColor(_14,color);
CGContextSetStrokeColor(_14,objj_msgSend(CPColor,"darkGrayColor"));
CGContextAddArc(_14,_15.x,_15.y,CGRectGetWidth(_13)/2-10,_17,_19,YES);
CGContextClosePath(_14);
CGContextDrawPath(_14,kCGPathFillStroke);
_17=_19;
}
}
}),new objj_method(sel_getUid("setNeedsDisplay:"),function(_1a,_1b,_1c){
with(_1a){
if(objj_msgSend(dataSource,"numberOfPiesInPieChart:",_1a)>0){
animationAngle=0;
oldSelectionAngle=0;
oldSelectionAngle=objj_msgSend(_1a,"angleOfSegment:",0)*-1;
objj_msgSend(delegate,"didSelectPieChartAtIndex:",0);
}else{
objj_msgSend(overlayView,"setImage:",nil);
}
objj_msgSendSuper({receiver:_1a,super_class:objj_getClass("KCPieChartView").super_class},"setNeedsDisplay:",_1c);
}
}),new objj_method(sel_getUid("mouseDown:"),function(_1d,_1e,_1f){
with(_1d){
var _20=objj_msgSend(dataSource,"numberOfPiesInPieChart:",_1d);
if(objj_msgSend(timer,"isValid")||_20==0){
return;
}
var _21=objj_msgSend(_1d,"convertPointFromBase:",objj_msgSend(_1f,"locationInWindow")),_22=objj_msgSend(_1d,"center"),_23=CGPointMake(_21.x-_22.x,_21.y-_22.y),_24=Math.atan2(_23.y,_23.x)/(2*Math.PI);
var _25=_24*360,_26=objj_msgSend(_1d,"segmentAtAngle:",_25);
objj_msgSend(_1d,"selectPieAtIndex:",_26);
}
}),new objj_method(sel_getUid("selectPieAtIndex:"),function(_27,_28,_29){
with(_27){
var _2a=objj_msgSend(_27,"angleOfSegment:",_29);
objj_msgSend(delegate,"didSelectPieChartAtIndex:",_29);
if(_2a>180){
_2a-=360;
}
timer=objj_msgSend(CPTimer,"scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:",0.01,_27,sel_getUid("animationTimerFired:"),_2a,YES);
}
}),new objj_method(sel_getUid("animationTimerFired:"),function(_2b,_2c,_2d){
with(_2b){
var _2e=objj_msgSend(_2d,"userInfo");
if(_2e<0){
animationAngle-=5;
if(animationAngle<=_2e){
objj_msgSend(_2b,"animationWillEndWithAngle:timer:",_2e,_2d);
}
}else{
animationAngle+=5;
if(animationAngle>=_2e){
objj_msgSend(_2b,"animationWillEndWithAngle:timer:",_2e,_2d);
}
}
objj_msgSendSuper({receiver:_2b,super_class:objj_getClass("KCPieChartView").super_class},"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("animationWillEndWithAngle:timer:"),function(_2f,_30,_31,_32){
with(_2f){
objj_msgSend(_32,"invalidate");
oldSelectionAngle-=_31;
oldSelectionAngle=objj_msgSend(_2f,"normalizeAngle:",oldSelectionAngle);
animationAngle=0;
}
}),new objj_method(sel_getUid("normalizeAngle:"),function(_33,_34,_35){
with(_33){
if(_35>180){
_35-=360;
}else{
if(oldSelectionAngle<-180){
_35+=360;
}
}
return _35;
}
}),new objj_method(sel_getUid("segmentAtAngle:"),function(_36,_37,_38){
with(_36){
if(_38<0){
_38=360+_38;
}
var _39=oldSelectionAngle,_3a=0,_3b=objj_msgSend(dataSource,"numberOfPiesInPieChart:",_36);
for(var i=0;i<_3b;i++){
_39+=_3a;
if(_39>360){
_39-=360;
}
_3a=objj_msgSend(dataSource,"percentageOfPieChart:atIndex:",_36,i)*360/100;
if((_38>_39)&&(_38<(_39+_3a))){
return i;
}
}
return 0;
}
}),new objj_method(sel_getUid("angleOfSegment:"),function(_3c,_3d,_3e){
with(_3c){
var _3f=objj_msgSend(dataSource,"numberOfPiesInPieChart:",_3c);
if(_3f==0){
return 0;
}
if(_3e>(_3f-1)){
return 0;
}
var _40=oldSelectionAngle,_41=0,_42=0;
for(var i=0;i<=_3e;i++){
_40+=_41;
_41=objj_msgSend(dataSource,"percentageOfPieChart:atIndex:",_3c,i)*360/100;
_42=_40+(_41/2);
}
if(_42>180){
_42-=360;
}
return _42;
}
}),new objj_method(sel_getUid("setImage:"),function(_43,_44,_45){
with(_43){
objj_msgSend(overlayView,"setImage:",_45);
}
})]);
p;52;Visualization/PieChart/KCProjectPieChartController.jt;6246;@STATIC;1.0;I;21;Foundation/CPObject.ji;16;KCPieChartView.ji;22;KCPieChartLegendView.ji;19;KCPieChartElement.jt;6129;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("KCPieChartView.j",YES);
objj_executeFile("KCPieChartLegendView.j",YES);
objj_executeFile("KCPieChartElement.j",YES);
var _1=objj_allocateClassPair(CPViewController,"KCProjectPieChartController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dataSource"),new objj_ivar("pieChartView"),new objj_ivar("projectTextField"),new objj_ivar("durationTextField"),new objj_ivar("visitsTextField"),new objj_ivar("timePerVisitTextField"),new objj_ivar("totalNumberOfProjectsTextField"),new objj_ivar("totalDurationTextField"),new objj_ivar("totalDuration"),new objj_ivar("categories"),new objj_ivar("legendView")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("dataSource"),function(_3,_4){
with(_3){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_5,_6,_7){
with(_5){
dataSource=_7;
}
}),new objj_method(sel_getUid("initWithCibName:bundle:"),function(_8,_9,_a,_b){
with(_8){
_8=objj_msgSendSuper({receiver:_8,super_class:objj_getClass("KCProjectPieChartController").super_class},"initWithCibName:bundle:",_a,_b);
if(_8){
totalDuration=0;
categories=objj_msgSend(objj_msgSend(CPMutableArray,"alloc"),"init");
}
return _8;
}
}),new objj_method(sel_getUid("loadView"),function(_c,_d){
with(_c){
objj_msgSendSuper({receiver:_c,super_class:objj_getClass("KCProjectPieChartController").super_class},"loadView");
objj_msgSend(pieChartView,"setDelegate:",_c);
objj_msgSend(pieChartView,"setDataSource:",_c);
legendView=objj_msgSend(objj_msgSend(KCPieChartLegendView,"alloc"),"initWithFrame:",CGRectMake(15,CPRectGetHeight(objj_msgSend(objj_msgSend(_c,"view"),"frame"))-60,550,65));
objj_msgSend(legendView,"setDataSource:",_c);
objj_msgSend(legendView,"setDelegate:",_c);
objj_msgSend(objj_msgSend(_c,"view"),"addSubview:",legendView);
}
}),new objj_method(sel_getUid("reloadData"),function(_e,_f){
with(_e){
objj_msgSend(_e,"clear");
totalDuration=0;
objj_msgSend(categories,"removeAllObjects");
var _10=objj_msgSend(objj_msgSend(CPMutableDictionary,"alloc"),"init"),_11=objj_msgSend(dataSource,"numberOfActivitiesFiltered:",YES);
for(var i=0;i<_11;i++){
var _12=objj_msgSend(dataSource,"projectOfActivityAtIndex:filtered:",i,YES),_13=objj_msgSend(dataSource,"durationOfActivityAtIndex:filtered:",i,YES),_14=nil;
if(!objj_msgSend(_10,"containsKey:",_12)){
_14=objj_msgSend(objj_msgSend(KCPieChartElement,"alloc"),"initWithCategory:",_12);
objj_msgSend(_14,"setColor:",objj_msgSend(dataSource,"colorOfActivityAtIndex:filtered:",i,YES));
objj_msgSend(_10,"setObject:forKey:",_14,_12);
}else{
_14=objj_msgSend(_10,"objectForKey:",_12);
}
objj_msgSend(_14,"addDuration:",_13);
objj_msgSend(_14,"addVisit");
totalDuration+=_13;
}
var _15=objj_msgSend(CPSortDescriptor,"sortDescriptorWithKey:ascending:","duration",NO);
categories=objj_msgSend(objj_msgSend(_10,"allValues"),"sortedArrayUsingDescriptors:",objj_msgSend(CPArray,"arrayWithObject:",_15));
if(objj_msgSend(categories,"count")>15){
var _16=0,_17=0;
for(var i=objj_msgSend(categories,"count")-1;i>=14;i--){
var _14=objj_msgSend(categories,"objectAtIndex:",i);
_16+=objj_msgSend(_14,"duration");
_17+=objj_msgSend(_14,"visits");
objj_msgSend(categories,"removeObjectAtIndex:",i);
}
var _18=objj_msgSend(objj_msgSend(KCPieChartElement,"alloc"),"initWithCategory:","Others");
objj_msgSend(_18,"addDuration:",_16);
objj_msgSend(_18,"setVisits:",_17);
objj_msgSend(categories,"addObject:",_18);
}
objj_msgSend(pieChartView,"setNeedsDisplay:",YES);
objj_msgSend(legendView,"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("clear"),function(_19,_1a){
with(_19){
objj_msgSend(totalNumberOfProjectsTextField,"setStringValue:","");
objj_msgSend(totalDurationTextField,"setStringValue:","");
objj_msgSend(projectTextField,"setStringValue:","");
objj_msgSend(durationTextField,"setStringValue:","");
}
}),new objj_method(sel_getUid("numberOfPiesInPieChart:"),function(_1b,_1c,_1d){
with(_1b){
return objj_msgSend(categories,"count");
}
}),new objj_method(sel_getUid("percentageOfPieChart:atIndex:"),function(_1e,_1f,_20,_21){
with(_1e){
var _22=objj_msgSend(categories,"objectAtIndex:",_21);
return objj_msgSend(_22,"duration")/totalDuration*100;
}
}),new objj_method(sel_getUid("colorOfPieChart:atIndex:"),function(_23,_24,_25,_26){
with(_23){
var _27=objj_msgSend(categories,"objectAtIndex:",_26);
return objj_msgSend(_27,"color");
}
}),new objj_method(sel_getUid("keyOfPieChart:atIndex:"),function(_28,_29,_2a,_2b){
with(_28){
return objj_msgSend(objj_msgSend(categories,"objectAtIndex:",_2b),"category");
}
}),new objj_method(sel_getUid("willSelectPieChartAtIndex:"),function(_2c,_2d,_2e){
with(_2c){
objj_msgSend(pieChartView,"selectPieAtIndex:",_2e);
}
}),new objj_method(sel_getUid("didSelectPieChartAtIndex:"),function(_2f,_30,_31){
with(_2f){
var _32=objj_msgSend(categories,"objectAtIndex:",_31);
objj_msgSend(totalNumberOfProjectsTextField,"setIntegerValue:",objj_msgSend(categories,"count"));
objj_msgSend(totalDurationTextField,"setStringValue:",objj_msgSend(_2f,"stringFromTimeInterval:withSeconds:",totalDuration,NO));
objj_msgSend(projectTextField,"setStringValue:",objj_msgSend(objj_msgSend(_32,"category"),"capitalizedString"));
objj_msgSend(durationTextField,"setStringValue:",objj_msgSend(_2f,"stringFromTimeInterval:withSeconds:",objj_msgSend(_32,"duration"),NO));
objj_msgSend(visitsTextField,"setStringValue:",objj_msgSend(_32,"visits"));
objj_msgSend(timePerVisitTextField,"setStringValue:",objj_msgSend(_2f,"stringFromTimeInterval:withSeconds:",objj_msgSend(_32,"averageTimePerVisit"),NO));
}
}),new objj_method(sel_getUid("stringFromTimeInterval:withSeconds:"),function(_33,_34,_35,_36){
with(_33){
var _37=Math.floor(_35/60/60),_38=Math.floor(_35/60-_37*60),_39="";
if(_37>0){
_39+=objj_msgSend(CPString,"stringWithFormat:","%i hours, ",_37);
}
if(_36){
var _3a=_35-(_37*60*60)-(_38*60);
if(_38==0&&_37==0){
_39+=objj_msgSend(CPString,"stringWithFormat:","%i sec",_3a);
}else{
_39+=objj_msgSend(CPString,"stringWithFormat:","%i min, %i sec",_38,_3a);
}
}else{
_39+=objj_msgSend(CPString,"stringWithFormat:","%i min",_38);
}
return _39;
}
})]);
p;38;Visualization/TimeLine/KCRangeSlider.jt;5367;@STATIC;1.0;t;5348;
var _1=objj_allocateClassPair(CPView,"KCRangeSlider"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("leftGrip"),new objj_ivar("rightGrip"),new objj_ivar("resizeLeft"),new objj_ivar("resizeRight"),new objj_ivar("move"),new objj_ivar("startTextField"),new objj_ivar("endTextField"),new objj_ivar("oldFrame")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_8,_9,_a){
with(_8){
_8=objj_msgSendSuper({receiver:_8,super_class:objj_getClass("KCRangeSlider").super_class},"initWithFrame:",_a);
if(_8){
objj_msgSend(_8,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(_8,"setClipsToBounds:",NO);
resizeLeft=NO;
resizeRight=NO;
move=NO;
var _b=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/rangeSlider_center.png",CGSizeMake(1,38))),_c=CGRectInset(objj_msgSend(_8,"bounds"),21,0),_d=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",_c);
objj_msgSend(_d,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(_d,"setBackgroundColor:",_b);
_d._DOMElement.style["cursor"]="move";
objj_msgSend(_8,"addSubview:",_d);
leftGrip=objj_msgSend(objj_msgSend(CPImageView,"alloc"),"initWithFrame:",CGRectMake(2,CPRectGetHeight(_a)/2-19,21,38));
objj_msgSend(leftGrip,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/rangeSlider_left.png",CGSizeMake(21,38)));
objj_msgSend(leftGrip,"setAutoresizingMask:",CPViewMaxXMargin);
leftGrip._DOMElement.style["cursor"]="e-resize";
objj_msgSend(_8,"addSubview:",leftGrip);
rightGrip=objj_msgSend(objj_msgSend(CPImageView,"alloc"),"initWithFrame:",CGRectMake(CGRectGetWidth(_a)-21,CPRectGetHeight(_a)/2-19,21,38));
objj_msgSend(rightGrip,"setAutoresizingMask:",CPViewMinXMargin);
objj_msgSend(rightGrip,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/rangeSlider_right.png",CGSizeMake(21,38)));
rightGrip._DOMElement.style["cursor"]="w-resize";
objj_msgSend(_8,"addSubview:",rightGrip);
startTextField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(-45,-20,60,20));
objj_msgSend(startTextField,"setTextColor:",objj_msgSend(CPColor,"darkGrayColor"));
objj_msgSend(startTextField,"setTextShadowColor:",objj_msgSend(CPColor,"darkGrayShadowColor"));
objj_msgSend(startTextField,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(startTextField,"setAlignment:",CPRightTextAlignment);
objj_msgSend(startTextField,"setAutoresizingMask:",CPViewMaxXMargin);
objj_msgSend(_8,"addSubview:",startTextField);
endTextField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(CGRectGetWidth(_a)-15,-20,60,20));
objj_msgSend(endTextField,"setTextColor:",objj_msgSend(CPColor,"darkGrayColor"));
objj_msgSend(endTextField,"setTextShadowColor:",objj_msgSend(CPColor,"darkGrayShadowColor"));
objj_msgSend(endTextField,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(endTextField,"setAutoresizingMask:",CPViewMinXMargin);
objj_msgSend(_8,"addSubview:",endTextField);
}
return _8;
}
}),new objj_method(sel_getUid("mouseDown:"),function(_e,_f,_10){
with(_e){
var _11=objj_msgSend(_e,"convertPoint:fromView:",objj_msgSend(_10,"locationInWindow"),nil);
var _12=objj_msgSend(leftGrip,"hitTest:",_11),_13=objj_msgSend(rightGrip,"hitTest:",_11);
if(_12==leftGrip){
resizeLeft=YES;
}else{
if(_13==rightGrip){
resizeRight=YES;
}else{
move=YES;
}
}
oldFrame=objj_msgSend(_e,"frame");
}
}),new objj_method(sel_getUid("mouseUp:"),function(_14,_15,_16){
with(_14){
resizeLeft=NO;
resizeRight=NO;
move=NO;
objj_msgSend(startTextField,"setStringValue:","");
objj_msgSend(endTextField,"setStringValue:","");
var _17=objj_msgSend(delegate,"willChangeZoomRange:",CPMakeRange(CPRectGetMinX(objj_msgSend(_14,"frame"))-35,CPRectGetWidth(objj_msgSend(_14,"frame"))-30));
if(!_17){
objj_msgSend(_14,"setFrame:",oldFrame);
}
}
}),new objj_method(sel_getUid("mouseDragged:"),function(_18,_19,_1a){
with(_18){
var _1b=objj_msgSend(_18,"frame");
if(resizeLeft){
_1b=CGRectInset(_1b,objj_msgSend(_1a,"deltaX")/2,0);
_1b=CGRectOffset(_1b,objj_msgSend(_1a,"deltaX")/2,0);
}else{
if(resizeRight){
_1b=CGRectInset(_1b,-objj_msgSend(_1a,"deltaX")/2,0);
_1b=CGRectOffset(_1b,objj_msgSend(_1a,"deltaX")/2,0);
}else{
_1b=CGRectOffset(_1b,objj_msgSend(_1a,"deltaX"),0);
}
}
if(objj_msgSend(_18,"isRectValid:",_1b)){
var _1c=objj_msgSend(delegate,"datesForZoomRange:",CPMakeRange(CPRectGetMinX(_1b)-35,CPRectGetWidth(_1b)-30));
if(objj_msgSend(_1c,"count")==2){
startDate=objj_msgSend(_1c,"objectAtIndex:",0),endDate=objj_msgSend(_1c,"objectAtIndex:",1);
objj_msgSend(startTextField,"setStringValue:",objj_msgSend(startDate,"formatToShortTime"));
objj_msgSend(endTextField,"setStringValue:",objj_msgSend(endDate,"formatToShortTime"));
objj_msgSend(_18,"setFrame:",_1b);
}
}
}
}),new objj_method(sel_getUid("isRectValid:"),function(_1d,_1e,_1f){
with(_1d){
var _20=objj_msgSend(objj_msgSend(_1d,"superview"),"frame");
if(CPRectGetWidth(_1f)>35&&CPRectGetMinX(_1f)>=35&&CPRectGetMaxX(_1f)<=CPRectGetMaxX(_20)-35){
return YES;
}
return NO;
}
})]);
p;44;Visualization/TimeLine/KCTimeLineScaleView.jt;2021;@STATIC;1.0;i;16;KCTimeLineView.ji;15;KCRangeSlider.jt;1961;
objj_executeFile("KCTimeLineView.j",YES);
objj_executeFile("KCRangeSlider.j",YES);
var _1=objj_allocateClassPair(CPView,"KCTimeLineScaleView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dataSource")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("dataSource"),function(_3,_4){
with(_3){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_5,_6,_7){
with(_5){
dataSource=_7;
}
}),new objj_method(sel_getUid("drawRect:"),function(_8,_9,_a){
with(_8){
var _b=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort"),_c=objj_msgSend(dataSource,"rangeStartDate"),_d=objj_msgSend(dataSource,"rangeEndDate");
var _e=(objj_msgSend(_d,"timeIntervalSince1970")-objj_msgSend(_c,"timeIntervalSince1970"))/60,_f=CGRectGetWidth(_a)/_e;
var _10=objj_msgSend(CPDate,"dateWithTimeIntervalSince1970:",objj_msgSend(_c,"timeIntervalSince1970")),_11=objj_msgSend(_10,"hours");
_10.set({hour:_11,minute:0,second:0,millisecond:0});
var _12=(objj_msgSend(_10,"timeIntervalSince1970")-objj_msgSend(_c,"timeIntervalSince1970"))/60,x=Math.round(_12*_f),y=CGRectGetHeight(_a)-6;
while(_11<=24){
CGContextBeginPath(_b);
CGContextMoveToPoint(_b,x+0.5,y);
CGContextAddLineToPoint(_b,x+0.5,y-10);
CGContextClosePath(_b);
CGContextSetLineWidth(_b,1);
CGContextSetStrokeColor(_b,objj_msgSend(CPColor,"lightGrayColor"));
CGContextSetShadowWithColor(_b,CPSizeMake(1,0),1,objj_msgSend(CPColor,"whiteColor"));
CGContextDrawPath(_b,kCGPathStroke);
for(var i=1;i<4;i++){
var _13=Math.round(x+_f*15*i),_14=CGRectGetHeight(_a)-6;
CGContextBeginPath(_b);
CGContextMoveToPoint(_b,_13+0.5,_14);
CGContextAddLineToPoint(_b,_13+0.5,_14-6);
CGContextClosePath(_b);
CGContextSetLineWidth(_b,1);
CGContextSetStrokeColor(_b,objj_msgSend(CPColor,"lightGrayColor"));
CGContextSetShadowWithColor(_b,CPSizeMake(1,0),1,objj_msgSend(CPColor,"whiteColor"));
CGContextDrawPath(_b,kCGPathStroke);
}
x+=Math.round(_f*60);
_11++;
}
}
})]);
p;39;Visualization/TimeLine/KCTimeLineView.jt;1564;@STATIC;1.0;t;1545;
var _1=60*60*24;
var _2=objj_allocateClassPair(CPView,"KCTimeLineView"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("dataSource")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("dataSource"),function(_4,_5){
with(_4){
return dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_6,_7,_8){
with(_6){
dataSource=_8;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_9,_a,_b){
with(_9){
_9=objj_msgSendSuper({receiver:_9,super_class:objj_getClass("KCTimeLineView").super_class},"initWithFrame:",_b);
if(_9){
objj_msgSend(_9,"setAutoresizingMask:",CPViewWidthSizable);
}
return _9;
}
}),new objj_method(sel_getUid("drawRect:"),function(_c,_d,_e){
with(_c){
var _f=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort");
_e=CGRectInset(_e,0.5,0.5);
var _10=(CPRectGetWidth(_e))/_1,_11=objj_msgSend(dataSource,"numberOfResourceBlocksFiltered:",NO);
for(var i=0;i<_11;i++){
var _12=objj_msgSend(dataSource,"startDateForResourceBlockAtIndex:filtered:",i,NO),_13=objj_msgSend(dataSource,"endDateForResourceBlockAtIndex:filtered:",i,NO),_14=objj_msgSend(dataSource,"colorForResourceBlockAtIndex:filtered:",i,NO);
resourceX=(objj_msgSend(_12,"timeIntervalSince1970")-objj_msgSend(_12,"timeIntervalOfDaySince1970"))*_10,resourceWidth=(objj_msgSend(_13,"timeIntervalSince1970")-objj_msgSend(_12,"timeIntervalSince1970"))*_10,resourceRect=CPRectMake(resourceX,0,resourceWidth,CPRectGetHeight(_e));
CGContextSetFillColor(_f,_14);
CGContextFillRect(_f,resourceRect);
}
}
})]);
p;52;Visualization/TimeLine/KCTimeLineVisualizationView.jt;1081;@STATIC;1.0;t;1062;
var _1=objj_allocateClassPair(CPView,"KCTimeLineVisualizationView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("drawRect:"),function(_3,_4,_5){
with(_3){
var _6=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort");
var _7=[0.88,0.88,0.88,1,0.88,0.88,0.88,1,70/255,70/255,70/255,1,103/255,103/255,103/255,0],_8=CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(),_7,[0,0.95,0.951,1],4);
CGContextBeginPath(_6);
CGContextDrawLinearGradient(_6,_8,CGPointMake(CPRectGetMidX(_5),0),CGPointMake(CPRectGetMidX(_5),CPRectGetHeight(_5)),0);
CGContextAddRect(_6,_5);
CGContextClosePath(_6);
CGContextDrawPath(_6,0);
CGContextBeginPath(_6);
CGContextMoveToPoint(_6,0,0);
CGContextAddLineToPoint(_6,CPRectGetWidth(_5),0);
CGContextSetStrokeColor(_6,objj_msgSend(CPColor,"blackColor"));
CGContextSetShadowWithColor(_6,CPSizeMake(0,0.5),5,objj_msgSend(CPColor,"colorWithHexString:","b8b8b8"));
CGContextSetLineWidth(_6,1);
CGContextClosePath(_6);
CGContextDrawPath(_6,kCGPathStroke);
}
})]);
p;62;Visualization/TimeLine/KCTimeLineVisualizationViewController.jt;4768;@STATIC;1.0;i;16;KCTimeLineView.ji;15;KCRangeSlider.ji;21;KCTimeLineScaleView.jt;4682;
objj_executeFile("KCTimeLineView.j",YES);
objj_executeFile("KCRangeSlider.j",YES);
objj_executeFile("KCTimeLineScaleView.j",YES);
var _1=objj_allocateClassPair(CPViewController,"KCTimeLineVisualizationViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("dataSource"),new objj_ivar("timeLineView"),new objj_ivar("rangeSlider"),new objj_ivar("scaleView"),new objj_ivar("startDateTextField"),new objj_ivar("endDateTextField"),new objj_ivar("rangeStartDate"),new objj_ivar("rangeEndDate")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("rangeStartDate"),function(_3,_4){
with(_3){
return rangeStartDate;
}
}),new objj_method(sel_getUid("setRangeStartDate:"),function(_5,_6,_7){
with(_5){
rangeStartDate=_7;
}
}),new objj_method(sel_getUid("rangeEndDate"),function(_8,_9){
with(_8){
return rangeEndDate;
}
}),new objj_method(sel_getUid("setRangeEndDate:"),function(_a,_b,_c){
with(_a){
rangeEndDate=_c;
}
}),new objj_method(sel_getUid("viewDidLoad"),function(_d,_e){
with(_d){
var _f=objj_msgSend(objj_msgSend(_d,"view"),"frame"),_10=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPThreePartImage,"alloc"),"initWithImageSlices:isVertical:",[objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/timeLine_left.png",CGSizeMake(8,32)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/timeLine_center.png",CGSizeMake(40,32)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Images/timeLine_right.png",CGSizeMake(8,32))],NO));
var _11=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",CPRectMake(50,42,CPRectGetWidth(_f)-100,32));
objj_msgSend(_11,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(_11,"setBackgroundColor:",_10);
objj_msgSend(objj_msgSend(_d,"view"),"addSubview:",_11);
timeLineView=objj_msgSend(objj_msgSend(KCTimeLineView,"alloc"),"initWithFrame:",CPRectMake(50,43,CPRectGetWidth(_f)-100,30));
objj_msgSend(timeLineView,"setDataSource:",dataSource);
objj_msgSend(objj_msgSend(_d,"view"),"addSubview:",timeLineView);
rangeSlider=objj_msgSend(objj_msgSend(KCRangeSlider,"alloc"),"initWithFrame:",CPRectMake(35,38,CPRectGetWidth(_f)-70,38));
objj_msgSend(rangeSlider,"setDelegate:",delegate);
objj_msgSend(objj_msgSend(_d,"view"),"addSubview:",rangeSlider);
startDateTextField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CPRectMake(10,CPRectGetHeight(_f)-35,100,25));
objj_msgSend(startDateTextField,"setTextColor:",objj_msgSend(CPColor,"darkGrayColor"));
objj_msgSend(startDateTextField,"setTextShadowColor:",objj_msgSend(CPColor,"darkGrayShadowColor"));
objj_msgSend(startDateTextField,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(startDateTextField,"setStringValue:","test");
objj_msgSend(objj_msgSend(_d,"view"),"addSubview:",startDateTextField);
endDateTextField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CPRectMake(CPRectGetWidth(_f)-110,CPRectGetHeight(_f)-35,100,25));
objj_msgSend(endDateTextField,"setAutoresizingMask:",CPViewMinXMargin);
objj_msgSend(endDateTextField,"setTextColor:",objj_msgSend(CPColor,"darkGrayColor"));
objj_msgSend(endDateTextField,"setTextShadowColor:",objj_msgSend(CPColor,"darkGrayShadowColor"));
objj_msgSend(endDateTextField,"setTextShadowOffset:",CGSizeMake(0,1));
objj_msgSend(endDateTextField,"setAlignment:",CPRightTextAlignment);
objj_msgSend(endDateTextField,"setStringValue:","test");
objj_msgSend(objj_msgSend(_d,"view"),"addSubview:",endDateTextField);
scaleView=objj_msgSend(objj_msgSend(KCTimeLineScaleView,"alloc"),"initWithFrame:",CPRectMake(0,CPRectGetHeight(_f)-22,CPRectGetWidth(_f),20));
objj_msgSend(scaleView,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(scaleView,"setDataSource:",_d);
objj_msgSend(objj_msgSend(_d,"view"),"addSubview:",scaleView);
}
}),new objj_method(sel_getUid("changeZoomRangeLabelsToStartDate:endDate:"),function(_12,_13,_14,_15){
with(_12){
rangeStartDate=_14;
rangeEndDate=_15;
objj_msgSend(startDateTextField,"setStringValue:",objj_msgSend(rangeStartDate,"formatToTime"));
objj_msgSend(endDateTextField,"setStringValue:",objj_msgSend(rangeEndDate,"formatToTime"));
objj_msgSend(scaleView,"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("resetRangeSlider"),function(_16,_17){
with(_16){
objj_msgSend(rangeSlider,"setFrame:",CPRectMake(35,38,CPRectGetWidth(objj_msgSend(objj_msgSend(_16,"view"),"frame"))-70,38));
}
}),new objj_method(sel_getUid("reloadData"),function(_18,_19){
with(_18){
objj_msgSend(timeLineView,"setNeedsDisplay:",YES);
objj_msgSend(scaleView,"setNeedsDisplay:",YES);
}
})]);
e;