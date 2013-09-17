@STATIC;1.0;p;16;LPAnchorButton.jt;5735;@STATIC;1.0;t;5716;
LPAnchorButtonNoUnderline=0;
LPAnchorButtonNormalUnderline=1;
LPAnchorButtonHoverUnderline=2;
var _1=objj_allocateClassPair(CPControl,"LPAnchorButton"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_underlineMask"),new objj_ivar("_title"),new objj_ivar("_URL"),new objj_ivar("_DOMAnchorElement")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("underlineMask"),function(_3,_4){
with(_3){
return _underlineMask;
}
}),new objj_method(sel_getUid("setUnderlineMask:"),function(_5,_6,_7){
with(_5){
_underlineMask=_7;
}
}),new objj_method(sel_getUid("title"),function(_8,_9){
with(_8){
return _title;
}
}),new objj_method(sel_getUid("setTitle:"),function(_a,_b,_c){
with(_a){
_title=_c;
}
}),new objj_method(sel_getUid("init"),function(_d,_e){
with(_d){
if(_d=objj_msgSendSuper({receiver:_d,super_class:objj_getClass("LPAnchorButton").super_class},"init")){
_underlineMask=LPAnchorButtonNormalUnderline|LPAnchorButtonHoverUnderline;
}
return _d;
}
}),new objj_method(sel_getUid("setTitle:"),function(_f,_10,_11){
with(_f){
_title=_11;
objj_msgSend(_f,"setNeedsLayout");
}
}),new objj_method(sel_getUid("openURLOnClick:"),function(_12,_13,_14){
with(_12){
_URL=_14;
objj_msgSend(_12,"setNeedsLayout");
}
}),new objj_method(sel_getUid("setTextColor:"),function(_15,_16,_17){
with(_15){
objj_msgSend(_15,"setValue:forThemeAttribute:",_17,"text-color");
}
}),new objj_method(sel_getUid("setTextHoverColor:"),function(_18,_19,_1a){
with(_18){
objj_msgSend(_18,"setValue:forThemeAttribute:inState:",_1a,"text-color",CPThemeStateHighlighted);
}
}),new objj_method(sel_getUid("mouseEntered:"),function(_1b,_1c,_1d){
with(_1b){
objj_msgSend(_1b,"setThemeState:",CPThemeStateHighlighted);
}
}),new objj_method(sel_getUid("mouseExited:"),function(_1e,_1f,_20){
with(_1e){
objj_msgSend(_1e,"unsetThemeState:",CPThemeStateHighlighted);
}
}),new objj_method(sel_getUid("mouseDown:"),function(_21,_22,_23){
with(_21){
if(_URL){
objj_msgSend(objj_msgSend(objj_msgSend(_21,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
}else{
objj_msgSendSuper({receiver:_21,super_class:objj_getClass("LPAnchorButton").super_class},"mouseDown:",_23);
}
}
}),new objj_method(sel_getUid("sizeToFit"),function(_24,_25){
with(_24){
objj_msgSend(_24,"setFrameSize:",objj_msgSend((_title||" "),"sizeWithFont:",objj_msgSend(_24,"currentValueForThemeAttribute:","font")));
}
}),new objj_method(sel_getUid("rectForEphemeralSubviewNamed:"),function(_26,_27,_28){
with(_26){
return objj_msgSend(_26,"bounds");
}
}),new objj_method(sel_getUid("createEphemeralSubviewNamed:"),function(_29,_2a,_2b){
with(_29){
return objj_msgSend(objj_msgSend(_CPImageAndTextView,"alloc"),"initWithFrame:",CGRectMakeZero());
}
}),new objj_method(sel_getUid("layoutSubviews"),function(_2c,_2d){
with(_2c){
if(_URL){
if(!_DOMAnchorElement){
_DOMAnchorElement=document.createElement("a");
_DOMAnchorElement.target="_blank";
_DOMAnchorElement.style.position="absolute";
_DOMAnchorElement.style.zIndex="100";
_2c._DOMElement.appendChild(_DOMAnchorElement);
}
_DOMAnchorElement.href=typeof _URL=="string"?_URL:objj_msgSend(_URL,"absoluteString");
var _2e=objj_msgSend(_2c,"bounds");
_DOMAnchorElement.style.width=CGRectGetWidth(_2e)+"px";
_DOMAnchorElement.style.height=CGRectGetHeight(_2e)+"px";
}
var _2f="none";
if(((_themeState===CPThemeStateNormal||_themeState===CPThemeStateSelected)&&(_underlineMask&LPAnchorButtonNormalUnderline))||((_themeState&CPThemeStateHighlighted)&&(_underlineMask&LPAnchorButtonHoverUnderline))){
_2f="underline";
}
var _30=objj_msgSend(_2c,"layoutEphemeralSubviewNamed:positioned:relativeToEphemeralSubviewNamed:","content-view",CPWindowAbove,nil);
if(_30){
objj_msgSend(_30,"setText:",_title);
objj_msgSend(_30,"setTextColor:",objj_msgSend(_2c,"currentValueForThemeAttribute:","text-color"));
objj_msgSend(_30,"setFont:",objj_msgSend(_2c,"currentValueForThemeAttribute:","font"));
objj_msgSend(_30,"setAlignment:",objj_msgSend(_2c,"currentValueForThemeAttribute:","alignment"));
objj_msgSend(_30,"setVerticalAlignment:",objj_msgSend(_2c,"currentValueForThemeAttribute:","vertical-alignment"));
objj_msgSend(_30,"setLineBreakMode:",objj_msgSend(_2c,"currentValueForThemeAttribute:","line-break-mode"));
objj_msgSend(_30,"setTextShadowColor:",objj_msgSend(_2c,"currentValueForThemeAttribute:","text-shadow-color"));
objj_msgSend(_30,"setTextShadowOffset:",objj_msgSend(_2c,"currentValueForThemeAttribute:","text-shadow-offset"));
if(_30._DOMTextElement){
_30._DOMTextElement.style.setProperty("text-decoration",_2f,null);
}
if(_30._DOMTextShadowElement){
_30._DOMTextShadowElement.style.setProperty("text-decoration",_2f,null);
}
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("buttonWithTitle:"),function(_31,_32,_33){
with(_31){
var _34=objj_msgSend(objj_msgSend(_31,"alloc"),"init");
objj_msgSend(_34,"setTitle:",_33);
objj_msgSend(_34,"sizeToFit");
return _34;
}
})]);
var _35="LPAnchorButtonUnderlineMaskKey";
var _1=objj_getClass("LPAnchorButton");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"LPAnchorButton\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_36,_37,_38){
with(_36){
if(_36=objj_msgSendSuper({receiver:_36,super_class:objj_getClass("LPAnchorButton").super_class},"initWithCoder:",_38)){
_underlineMask=objj_msgSend(_38,"decodeIntForKey:",_35)||LPAnchorButtonNoUnderline;
}
return _36;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_39,_3a,_3b){
with(_39){
objj_msgSendSuper({receiver:_39,super_class:objj_getClass("LPAnchorButton").super_class},"encodeWithCoder:",_3b);
if(_underlineMask!==LPAnchorButtonNoUnderline){
objj_msgSend(_3b,"encodeInt:forKey:",_underlineMask,_35);
}
}
})]);
p;22;LPCalendarHeaderView.jt;9653;@STATIC;1.0;I;17;AppKit/CPButton.jI;18;AppKit/CPControl.jt;9589;
objj_executeFile("AppKit/CPButton.j",NO);
objj_executeFile("AppKit/CPControl.j",NO);
var _1=["January","February","March","April","May","June","July","August","September","October","November","December"],_2=["mon","tue","wed","thu","fri","sat","sun"],_3=["sun","mon","tue","wed","thu","fri","sat"];
var _4=objj_allocateClassPair(CPControl,"LPCalendarHeaderView"),_5=_4.isa;
class_addIvars(_4,[new objj_ivar("representedDate"),new objj_ivar("monthLabel"),new objj_ivar("prevButton"),new objj_ivar("nextButton"),new objj_ivar("dayLabels"),new objj_ivar("weekStartsOnMonday"),new objj_ivar("fastForwardEnabled")]);
objj_registerClassPair(_4);
class_addMethods(_4,[new objj_method(sel_getUid("prevButton"),function(_6,_7){
with(_6){
return prevButton;
}
}),new objj_method(sel_getUid("nextButton"),function(_8,_9){
with(_8){
return nextButton;
}
}),new objj_method(sel_getUid("weekStartsOnMonday"),function(_a,_b){
with(_a){
return weekStartsOnMonday;
}
}),new objj_method(sel_getUid("setWeekStartsOnMonday:"),function(_c,_d,_e){
with(_c){
weekStartsOnMonday=_e;
}
}),new objj_method(sel_getUid("fastForwardEnabled"),function(_f,_10){
with(_f){
return fastForwardEnabled;
}
}),new objj_method(sel_getUid("setFastForwardEnabled:"),function(_11,_12,_13){
with(_11){
fastForwardEnabled=_13;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_14,_15,_16){
with(_14){
if(_14=objj_msgSendSuper({receiver:_14,super_class:objj_getClass("LPCalendarHeaderView").super_class},"initWithFrame:",_16)){
monthLabel=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(0,8,_16.size.width,_16.size.height));
objj_msgSend(monthLabel,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(monthLabel,"setValue:forThemeAttribute:",CPCenterTextAlignment,"alignment");
objj_msgSend(monthLabel,"setHitTests:",NO);
objj_msgSend(_14,"addSubview:",monthLabel);
prevButton=objj_msgSend(objj_msgSend(LPCalendarHeaderArrowButton,"alloc"),"initWithFrame:",CGRectMake(6,9,0,0));
objj_msgSend(prevButton,"sizeToFit");
objj_msgSend(_14,"addSubview:",prevButton);
nextButton=objj_msgSend(objj_msgSend(LPCalendarHeaderArrowButton,"alloc"),"initWithFrame:",CGRectMake(CGRectGetMaxX(objj_msgSend(_14,"bounds"))-21,9,0,0));
objj_msgSend(nextButton,"sizeToFit");
objj_msgSend(nextButton,"setAutoresizingMask:",CPViewMinXMargin);
objj_msgSend(_14,"addSubview:",nextButton);
dayLabels=objj_msgSend(CPArray,"array");
for(var i=0;i<objj_msgSend(_2,"count");i++){
var _17=objj_msgSend(LPCalendarLabel,"labelWithTitle:",objj_msgSend(_2,"objectAtIndex:",i));
objj_msgSend(dayLabels,"addObject:",_17);
objj_msgSend(_14,"addSubview:",_17);
}
objj_msgSend(_14,"setNeedsLayout");
}
return _14;
}
}),new objj_method(sel_getUid("setDate:"),function(_18,_19,_1a){
with(_18){
if(objj_msgSend(representedDate,"isEqualToDate:",_1a)){
return;
}
representedDate=objj_msgSend(_1a,"copy");
objj_msgSend(monthLabel,"setStringValue:",objj_msgSend(CPString,"stringWithFormat:","%s %i",_1[representedDate.getUTCMonth()],representedDate.getUTCFullYear()));
}
}),new objj_method(sel_getUid("setWeekStartsOnMonday:"),function(_1b,_1c,_1d){
with(_1b){
weekStartsOnMonday=_1d;
var _1e=(_1d)?_2:_3;
for(var i=0;i<objj_msgSend(dayLabels,"count");i++){
objj_msgSend(objj_msgSend(dayLabels,"objectAtIndex:",i),"setTitle:",objj_msgSend(_1e,"objectAtIndex:",i));
}
objj_msgSend(_1b,"setNeedsLayout");
}
}),new objj_method(sel_getUid("layoutSubviews"),function(_1f,_20){
with(_1f){
var _21=objj_msgSend(_1f,"bounds"),_22=CGRectGetWidth(_21),_23=objj_msgSend(_1f,"superview"),_24=objj_msgSend(_1f,"themeState");
objj_msgSend(_1f,"setBackgroundColor:",objj_msgSend(_23,"valueForThemeAttribute:inState:","header-background-color",_24));
objj_msgSend(monthLabel,"setFont:",objj_msgSend(_23,"valueForThemeAttribute:inState:","header-font",_24));
objj_msgSend(monthLabel,"setTextColor:",objj_msgSend(_23,"valueForThemeAttribute:inState:","header-text-color",_24));
objj_msgSend(monthLabel,"setTextShadowColor:",objj_msgSend(_23,"valueForThemeAttribute:inState:","header-text-shadow-color",_24));
objj_msgSend(monthLabel,"setTextShadowOffset:",objj_msgSend(_23,"valueForThemeAttribute:inState:","header-text-shadow-offset",_24));
var _25=objj_msgSend(_23,"valueForThemeAttribute:inState:","header-button-offset",_24);
objj_msgSend(prevButton,"setFrameOrigin:",CGPointMake(_25.width,_25.height));
objj_msgSend(prevButton,"setValue:forThemeAttribute:inState:",objj_msgSend(_23,"valueForThemeAttribute:inState:","header-prev-button-image",_24),"bezel-color",CPThemeStateBordered);
objj_msgSend(nextButton,"setFrameOrigin:",CGPointMake(_22-16-_25.width,_25.height));
objj_msgSend(nextButton,"setValue:forThemeAttribute:inState:",objj_msgSend(_23,"valueForThemeAttribute:inState:","header-next-button-image",_24),"bezel-color",CPThemeStateBordered);
var _26=objj_msgSend(dayLabels,"count"),_27=_22/_26,_28=CGRectGetHeight(objj_msgSend(objj_msgSend(objj_msgSend(_1f,"subviews"),"objectAtIndex:",3),"bounds")),_29=objj_msgSend(_23,"valueForThemeAttribute:inState:","header-weekday-offset",_24),_2a=CGRectGetHeight(_21);
for(var i=0;i<_26;i++){
objj_msgSend(dayLabels[i],"setFrame:",CGRectMake(i*_27,_29,_27,_28));
}
}
})]);
class_addMethods(_5,[new objj_method(sel_getUid("themeClass"),function(_2b,_2c){
with(_2b){
return "lp-calendar-header-view";
}
})]);
var _4=objj_allocateClassPair(CPTextField,"LPCalendarLabel"),_5=_4.isa;
objj_registerClassPair(_4);
class_addMethods(_4,[new objj_method(sel_getUid("initWithFrame:"),function(_2d,_2e,_2f){
with(_2d){
if(_2d=objj_msgSendSuper({receiver:_2d,super_class:objj_getClass("LPCalendarLabel").super_class},"initWithFrame:",_2f)){
objj_msgSend(_2d,"setValue:forThemeAttribute:",CPCenterTextAlignment,"alignment");
}
return _2d;
}
}),new objj_method(sel_getUid("setTitle:"),function(_30,_31,_32){
with(_30){
objj_msgSend(_30,"setStringValue:",_32);
objj_msgSend(_30,"sizeToFit");
}
}),new objj_method(sel_getUid("didMoveToSuperview"),function(_33,_34){
with(_33){
objj_msgSend(_33,"setNeedsLayout");
}
}),new objj_method(sel_getUid("layoutSubviews"),function(_35,_36){
with(_35){
var _37=objj_msgSend(objj_msgSend(_35,"superview"),"superview"),_38=objj_msgSend(_35,"themeState");
objj_msgSend(_35,"setFont:",objj_msgSend(_37,"valueForThemeAttribute:inState:","header-weekday-label-font",_38));
objj_msgSend(_35,"setTextColor:",objj_msgSend(_37,"valueForThemeAttribute:inState:","header-weekday-label-color",_38));
objj_msgSend(_35,"setTextShadowColor:",objj_msgSend(_37,"valueForThemeAttribute:inState:","header-weekday-label-shadow-color",_38));
objj_msgSend(_35,"setTextShadowOffset:",objj_msgSend(_37,"valueForThemeAttribute:inState:","header-weekday-label-shadow-offset",_38));
objj_msgSendSuper({receiver:_35,super_class:objj_getClass("LPCalendarLabel").super_class},"layoutSubviews");
}
})]);
class_addMethods(_5,[new objj_method(sel_getUid("labelWithTitle:"),function(_39,_3a,_3b){
with(_39){
var _3c=objj_msgSend(objj_msgSend(LPCalendarLabel,"alloc"),"initWithFrame:",CGRectMakeZero());
objj_msgSend(_3c,"setTitle:",_3b);
return _3c;
}
})]);
LPCalendarFastForwardThreshold=1;
LPCalendarFastForwardDelay=0.1;
var _4=objj_allocateClassPair(CPButton,"LPCalendarHeaderArrowButton"),_5=_4.isa;
class_addIvars(_4,[new objj_ivar("startedTrackingAt"),new objj_ivar("didFastForward")]);
objj_registerClassPair(_4);
class_addMethods(_4,[new objj_method(sel_getUid("initWithFrame:"),function(_3d,_3e,_3f){
with(_3d){
if(_3d=objj_msgSendSuper({receiver:_3d,super_class:objj_getClass("LPCalendarHeaderArrowButton").super_class},"initWithFrame:",_3f)){
objj_msgSend(_3d,"setValue:forThemeAttribute:",CGSizeMake(16,16),"min-size");
objj_msgSend(_3d,"setValue:forThemeAttribute:",CGSizeMake(16,16),"max-size");
}
return _3d;
}
}),new objj_method(sel_getUid("incrementOriginBy:"),function(_40,_41,_42){
with(_40){
var _43=objj_msgSend(_40,"frame").origin;
_43.y+=_42;
objj_msgSend(_40,"setFrameOrigin:",_43);
}
}),new objj_method(sel_getUid("startTrackingAt:"),function(_44,_45,_46){
with(_44){
if(objj_msgSend(objj_msgSend(_44,"superview"),"fastForwardEnabled")){
startedTrackingAt=objj_msgSend(CPDate,"date");
didFastForward=NO;
objj_msgSend(CPTimer,"scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:",LPCalendarFastForwardThreshold,_44,"didHitFastForwardDelay",nil,NO);
}
return objj_msgSendSuper({receiver:_44,super_class:objj_getClass("LPCalendarHeaderArrowButton").super_class},"startTrackingAt:",_46);
}
}),new objj_method(sel_getUid("trackMouse:"),function(_47,_48,_49){
with(_47){
var _4a=objj_msgSend(_49,"type");
if(_4a===CPLeftMouseUp){
objj_msgSend(_47,"incrementOriginBy:",-1);
var _4b;
startedTrackingAt=nil;
if(didFastForward){
_4b=objj_msgSend(_47,"sendActionOn:",0);
}
objj_msgSendSuper({receiver:_47,super_class:objj_getClass("LPCalendarHeaderArrowButton").super_class},"trackMouse:",_49);
if(didFastForward){
objj_msgSend(_47,"sendActionOn:",_4b);
didFastForward=NO;
}
}else{
objj_msgSend(_47,"incrementOriginBy:",1);
objj_msgSendSuper({receiver:_47,super_class:objj_getClass("LPCalendarHeaderArrowButton").super_class},"trackMouse:",_49);
}
}
}),new objj_method(sel_getUid("didHitFastForwardDelay"),function(_4c,_4d){
with(_4c){
if(startedTrackingAt===nil){
return;
}
didFastForward=YES;
objj_msgSend(_4c,"sendAction:to:",objj_msgSend(_4c,"action"),objj_msgSend(_4c,"target"));
objj_msgSend(CPTimer,"scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:",LPCalendarFastForwardDelay,_4c,"didHitFastForwardDelay",nil,NO);
}
}),new objj_method(sel_getUid("isFastForwarding"),function(_4e,_4f){
with(_4e){
return (startedTrackingAt!==nil);
}
})]);
p;21;LPCalendarMonthView.jt;16997;@STATIC;1.0;I;18;AppKit/CPControl.jI;15;AppKit/CPView.jI;19;Foundation/CPDate.jt;16910;
objj_executeFile("AppKit/CPControl.j",NO);
objj_executeFile("AppKit/CPView.j",NO);
objj_executeFile("Foundation/CPDate.j",NO);
var _1=objj_msgSend(CPDate,"distantFuture");
var _2=objj_getClass("CPDate");
if(!_2){
throw new SyntaxError("*** Could not find definition for class \"CPDate\"");
}
var _3=_2.isa;
class_addMethods(_2,[new objj_method(sel_getUid("daysInMonth"),function(_4,_5){
with(_4){
return 32-new Date(_4.getFullYear(),_4.getMonth(),32).getDate();
}
})]);
class_addMethods(_3,[new objj_method(sel_getUid("dateAtMidnight:"),function(_6,_7,_8){
with(_6){
var _9=objj_msgSend(_8,"description"),_a=_8.getDay(),_b=objj_msgSend(objj_msgSend(CPDate,"alloc"),"initWithString:",_9.substr(0,10)+" 00:00:00 "+_9.substr(20));
while(_b.getDay()!=_a){
_b.setTime(_b.getTime()+60*60*1000);
}
return _b;
}
})]);
LPCalendarDayLength=1;
LPCalendarWeekLength=2;
var _c={};
var _2=objj_allocateClassPair(CPView,"LPCalendarMonthView"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("dayTiles"),new objj_ivar("date"),new objj_ivar("previousMonth"),new objj_ivar("nextMonth"),new objj_ivar("_dataIsDirty"),new objj_ivar("allowsMultipleSelection"),new objj_ivar("startSelectionIndex"),new objj_ivar("currentSelectionIndex"),new objj_ivar("selectionLengthType"),new objj_ivar("selection"),new objj_ivar("highlightCurrentPeriod"),new objj_ivar("weekStartsOnMonday"),new objj_ivar("_delegate"),new objj_ivar("calendarView"),new objj_ivar("hiddenRows")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("date"),function(_d,_e){
with(_d){
return date;
}
}),new objj_method(sel_getUid("setDate:"),function(_f,_10,_11){
with(_f){
date=_11;
}
}),new objj_method(sel_getUid("previousMonth"),function(_12,_13){
with(_12){
return previousMonth;
}
}),new objj_method(sel_getUid("nextMonth"),function(_14,_15){
with(_14){
return nextMonth;
}
}),new objj_method(sel_getUid("allowsMultipleSelection"),function(_16,_17){
with(_16){
return allowsMultipleSelection;
}
}),new objj_method(sel_getUid("setAllowsMultipleSelection:"),function(_18,_19,_1a){
with(_18){
allowsMultipleSelection=_1a;
}
}),new objj_method(sel_getUid("selectionLengthType"),function(_1b,_1c){
with(_1b){
return selectionLengthType;
}
}),new objj_method(sel_getUid("setSelectionLengthType:"),function(_1d,_1e,_1f){
with(_1d){
selectionLengthType=_1f;
}
}),new objj_method(sel_getUid("highlightCurrentPeriod"),function(_20,_21){
with(_20){
return highlightCurrentPeriod;
}
}),new objj_method(sel_getUid("setHighlightCurrentPeriod:"),function(_22,_23,_24){
with(_22){
highlightCurrentPeriod=_24;
}
}),new objj_method(sel_getUid("weekStartsOnMonday"),function(_25,_26){
with(_25){
return weekStartsOnMonday;
}
}),new objj_method(sel_getUid("setWeekStartsOnMonday:"),function(_27,_28,_29){
with(_27){
weekStartsOnMonday=_29;
}
}),new objj_method(sel_getUid("delegate"),function(_2a,_2b){
with(_2a){
return _delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_2c,_2d,_2e){
with(_2c){
_delegate=_2e;
}
}),new objj_method(sel_getUid("calendarView"),function(_2f,_30){
with(_2f){
return calendarView;
}
}),new objj_method(sel_getUid("setCalendarView:"),function(_31,_32,_33){
with(_31){
calendarView=_33;
}
}),new objj_method(sel_getUid("hiddenRows"),function(_34,_35){
with(_34){
return hiddenRows;
}
}),new objj_method(sel_getUid("setHiddenRows:"),function(_36,_37,_38){
with(_36){
hiddenRows=_38;
}
}),new objj_method(sel_getUid("initWithFrame:calendarView:"),function(_39,_3a,_3b,_3c){
with(_39){
if(_39=objj_msgSendSuper({receiver:_39,super_class:objj_getClass("LPCalendarMonthView").super_class},"initWithFrame:",_3b)){
calendarView=_3c;
selectionLengthType=LPCalendarDayLength;
selection=objj_msgSend(CPArray,"array");
weekStartsOnMonday=YES;
hiddenRows=[];
for(var i=0;i<42;i++){
objj_msgSend(_39,"addSubview:",objj_msgSend(LPCalendarDayView,"dayViewWithCalendarView:",_3c));
}
}
return _39;
}
}),new objj_method(sel_getUid("setAllTilesAsFiller"),function(_3d,_3e){
with(_3d){
objj_msgSend(_3d,"setDate:",objj_msgSend(CPDate,"distantFuture"));
}
}),new objj_method(sel_getUid("setDate:"),function(_3f,_40,_41){
with(_3f){
if(date&&date.getFullYear()===_41.getFullYear()&&date.getMonth()===_41.getMonth()){
return;
}
date=objj_msgSend(_41,"copy");
if(!objj_msgSend(_41,"isEqualToDate:",_1)){
date.setDate(1);
date=objj_msgSend(CPDate,"dateAtMidnight:",date);
_firstDay=objj_msgSend(date,"copy");
_firstDay.setDate(1);
previousMonth=new Date(_firstDay.getTime()-86400000);
nextMonth=new Date(_firstDay.getTime()+((objj_msgSend(date,"daysInMonth")+1)*86400000));
}
objj_msgSend(_3f,"reloadData");
}
}),new objj_method(sel_getUid("setSelectionLengthType:"),function(_42,_43,_44){
with(_42){
if(selectionLengthType===_44){
return;
}
selectionLengthType=_44;
objj_msgSend(_42,"reloadData");
}
}),new objj_method(sel_getUid("tileSize"),function(_45,_46){
with(_45){
var _47=objj_msgSend(calendarView,"currentValueForThemeAttribute:","tile-size");
if(_47){
return _47;
}else{
var _48=objj_msgSend(_45,"bounds");
return CGSizeMake(CGRectGetWidth(_48)/7,CGRectGetHeight(_48)/6);
}
}
}),new objj_method(sel_getUid("startOfWeekForDate:"),function(_49,_4a,_4b){
with(_49){
var day=_4b.getDay();
if(weekStartsOnMonday){
if(day==0){
day=6;
}else{
if(day>0){
day-=1;
}
}
}
return day;
}
}),new objj_method(sel_getUid("startAndEndOfWeekForDate:"),function(_4c,_4d,_4e){
with(_4c){
_cached=_c[_4e.toString()];
if(_cached){
return _cached;
}
var _4f=new Date(_4e.getTime()-(objj_msgSend(_4c,"startOfWeekForDate:",_4e)*86400000)),_50=new Date(_4f.getTime()+(6*86400000));
_c[_4e.toString()]=[_4f,_50];
return [_4f,_50];
}
}),new objj_method(sel_getUid("dateIsWithinCurrentPeriod:"),function(_51,_52,_53){
with(_51){
var _54=objj_msgSend(CPDate,"date");
_54=objj_msgSend(CPDate,"dateAtMidnight:",_54);
if(selectionLengthType===LPCalendarDayLength){
return objj_msgSend(_54,"description").substr(0,10)==objj_msgSend(_53,"description").substr(0,10);
}
if(selectionLengthType===LPCalendarWeekLength){
var _55=objj_msgSend(_51,"startAndEndOfWeekForDate:",_54);
return ((objj_msgSend(_55,"objectAtIndex:",0)<=_53)&&(objj_msgSend(_55,"objectAtIndex:",1)>=_53));
}
return NO;
}
}),new objj_method(sel_getUid("setHiddenRows:"),function(_56,_57,_58){
with(_56){
if(objj_msgSend(hiddenRows,"isEqualToArray:",_58)){
return;
}
hiddenRows=_58;
var _59=objj_msgSend(_56,"subviews"),_5a=0,_5b=!_58;
for(var _5c=0;_5c<6;_5c++){
var _5d=_5b||objj_msgSend(hiddenRows,"indexOfObject:",_5c)>-1;
for(var _5e=0;_5e<7;_5e++){
objj_msgSend(_59[_5a],"setHidden:",_5d);
_5a+=1;
}
}
}
}),new objj_method(sel_getUid("reloadData"),function(_5f,_60){
with(_5f){
if(!date){
return;
}
var _61=date.getTime()==_1.getTime(),_62=date,_63=objj_msgSend(_5f,"startOfWeekForDate:",_62),_64=objj_msgSend(_62,"daysInMonth");
var _65=objj_msgSend(previousMonth,"daysInMonth"),_66=_65-_63;
var _67=objj_msgSend(_5f,"subviews"),_68=0;
var _69=new Date(previousMonth.getFullYear(),previousMonth.getMonth(),_66);
for(var _6a=0;_6a<6;_6a++){
for(var _6b=0;_6b<7;_6b++){
var _6c=_67[_68];
_69.setTime(objj_msgSend(CPDate,"dateAtMidnight:",_69).getTime()+25*60*60*1000);
_69=objj_msgSend(CPDate,"dateAtMidnight:",_69);
if(!_6c._isHidden){
objj_msgSend(_6c,"setIsFillerTile:",(_61)?YES:_69.getMonth()!=_62.getMonth());
objj_msgSend(_6c,"setDate:",_69);
if(!_61){
objj_msgSend(_6c,"setHighlighted:",objj_msgSend(_5f,"dateIsWithinCurrentPeriod:",_69));
}
}
_68+=1;
}
}
}
}),new objj_method(sel_getUid("tile"),function(_6d,_6e){
with(_6d){
var _6f=objj_msgSend(_6d,"subviews"),_70=objj_msgSend(_6d,"tileSize"),_71=0;
if(objj_msgSend(_6f,"count")>0){
for(var _72=0;_72<6;_72++){
for(var _73=0;_73<7;_73++){
var _74=CGRectMake((_73*_70.width),_72*_70.height,_70.width,_70.height);
objj_msgSend(_6f[_71],"setFrame:",_74);
_71+=1;
}
}
}
}
}),new objj_method(sel_getUid("setNeedsLayout"),function(_75,_76){
with(_75){
objj_msgSend(_75,"tile");
}
}),new objj_method(sel_getUid("locationInViewForEvent:"),function(_77,_78,_79){
with(_77){
return objj_msgSend(_77,"convertPoint:fromView:",objj_msgSend(_79,"locationInWindow"),nil);
}
}),new objj_method(sel_getUid("indexOfTileAtPoint:"),function(_7a,_7b,_7c){
with(_7a){
var _7d=objj_msgSend(_7a,"tileSize");
var _7e=FLOOR(_7c.y/_7d.height),_7f=FLOOR(_7c.x/_7d.width);
if(_7f>6){
_7f=6;
}else{
if(_7f<0){
_7f=0;
}
}
if(_7e>5){
_7e=5;
}else{
if(_7e<0){
_7e=0;
}
}
var _80=(_7e*7)+_7f;
if(_80>41){
return 41;
}
return _80;
}
}),new objj_method(sel_getUid("mouseDown:"),function(_81,_82,_83){
with(_81){
var _84=objj_msgSend(_81,"locationInViewForEvent:",_83),_85=objj_msgSend(_81,"indexOfTileAtPoint:",_84),_86=objj_msgSend(objj_msgSend(_81,"subviews"),"objectAtIndex:",_85);
startSelectionIndex=_85;
objj_msgSend(_81,"makeSelectionWithIndex:end:",startSelectionIndex,nil);
}
}),new objj_method(sel_getUid("mouseDragged:"),function(_87,_88,_89){
with(_87){
var _8a=objj_msgSend(_87,"locationInViewForEvent:",_89),_8b=objj_msgSend(_87,"indexOfTileAtPoint:",_8a);
if(currentSelectionIndex==_8b){
return;
}
currentSelectionIndex=_8b;
if(!allowsMultipleSelection){
startSelectionIndex=currentSelectionIndex;
}
objj_msgSend(_87,"makeSelectionWithIndex:end:",startSelectionIndex,currentSelectionIndex);
}
}),new objj_method(sel_getUid("mouseUp:"),function(_8c,_8d,_8e){
with(_8c){
if(!currentSelectionIndex||startSelectionIndex==currentSelectionIndex){
var _8f=objj_msgSend(objj_msgSend(_8c,"superview"),"superview"),_90=objj_msgSend(objj_msgSend(_8c,"subviews"),"objectAtIndex:",startSelectionIndex),_91=objj_msgSend(_90,"date"),_92=_91.getMonth();
if(_92==date.getMonth()&&objj_msgSend(objj_msgSend(CPApp,"currentEvent"),"clickCount")===2&&objj_msgSend(_8f,"doubleAction")){
objj_msgSend(CPApp,"sendAction:to:from:",objj_msgSend(_8f,"doubleAction"),objj_msgSend(_8f,"target"),_8f);
}
if(_92==previousMonth.getMonth()){
objj_msgSend(_8f,"changeToMonth:",previousMonth);
}
if(_92==nextMonth.getMonth()){
objj_msgSend(_8f,"changeToMonth:",nextMonth);
}
}else{
currentSelectionIndex=nil;
}
}
}),new objj_method(sel_getUid("makeSelectionWithDate:end:"),function(_93,_94,_95,_96){
with(_93){
if(!_95){
objj_msgSend(selection,"removeAllObjects");
return;
}
_95=objj_msgSend(_95,"copy");
_96=objj_msgSend(_96,"copy");
if(!allowsMultipleSelection||_96===nil){
_96=_95;
}
if(selectionLengthType===LPCalendarWeekLength){
var _97=objj_msgSend(_93,"startAndEndOfWeekForDate:",_95);
_95=_97[0];
_96=_97[1];
}
_95=objj_msgSend(CPDate,"dateAtMidnight:",_95);
_96=objj_msgSend(CPDate,"dateAtMidnight:",_96);
if(_95>_96){
var _98=_95;
_95=_96;
_96=_98;
}
objj_msgSend(selection,"removeAllObjects");
var _99=objj_msgSend(_93,"subviews"),_9a=objj_msgSend(_99,"count");
for(var i=0;i<_9a;i++){
var _9b=_99[i],_9c=objj_msgSend(_9b,"date");
_9c=objj_msgSend(CPDate,"dateAtMidnight:",_9c);
if(_95&&_9c>=_95&&_9c<=_96){
objj_msgSend(selection,"addObject:",objj_msgSend(objj_msgSend(_9b,"date"),"copy"));
objj_msgSend(_9b,"setSelected:",YES);
}else{
objj_msgSend(_9b,"setSelected:",NO);
}
}
if(objj_msgSend(selection,"count")>0&&objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("didMakeSelection:"))){
objj_msgSend(_delegate,"didMakeSelection:",selection);
}
}
}),new objj_method(sel_getUid("makeSelectionWithIndex:end:"),function(_9d,_9e,_9f,_a0){
with(_9d){
var _a1=objj_msgSend(_9d,"subviews");
objj_msgSend(_9d,"makeSelectionWithDate:end:",(_9f>-1)?objj_msgSend(objj_msgSend(_a1,"objectAtIndex:",_9f),"date"):nil,(_a0>-1)?objj_msgSend(objj_msgSend(_a1,"objectAtIndex:",_a0),"date"):nil);
}
}),new objj_method(sel_getUid("drawRect:"),function(_a2,_a3,_a4){
with(_a2){
var _a5=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort"),_a6=objj_msgSend(_a2,"bounds"),_a7=CGRectGetWidth(_a6),_a8=CGRectGetHeight(_a6),_a9=objj_msgSend(_a2,"tileSize");
var _aa=function(_ab){
CGContextFillRect(_a5,CGRectMake(0,_ab,_a7,1));
},_ac=function(_ad){
CGContextFillRect(_a5,CGRectMake(_ad,0,1,_a8));
};
CGContextSetFillColor(_a5,objj_msgSend(calendarView,"currentValueForThemeAttribute:","grid-shadow-color"));
for(var i=1;i<6;i++){
_aa(_a9.height*i-1);
}
for(var i=1;i<7;i++){
_ac(_a9.width*i-1);
}
CGContextSetFillColor(_a5,objj_msgSend(calendarView,"currentValueForThemeAttribute:","grid-color"));
for(var i=1;i<6;i++){
_aa(_a9.height*i);
}
for(var i=1;i<7;i++){
_ac(_a9.width*i);
}
}
})]);
class_addMethods(_3,[new objj_method(sel_getUid("themeClass"),function(_ae,_af){
with(_ae){
return "lp-calendar-month-view";
}
}),new objj_method(sel_getUid("themeAttributes"),function(_b0,_b1){
with(_b0){
return objj_msgSend(CPDictionary,"dictionaryWithObjects:forKeys:",[nil],["grid-color"]);
}
})]);
var _2=objj_allocateClassPair(CPControl,"LPCalendarDayView"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("date"),new objj_ivar("textField"),new objj_ivar("isFillerTile"),new objj_ivar("isSelected"),new objj_ivar("isHighlighted"),new objj_ivar("calendarView")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("date"),function(_b2,_b3){
with(_b2){
return date;
}
}),new objj_method(sel_getUid("setDate:"),function(_b4,_b5,_b6){
with(_b4){
date=_b6;
}
}),new objj_method(sel_getUid("isFillerTile"),function(_b7,_b8){
with(_b7){
return isFillerTile;
}
}),new objj_method(sel_getUid("setIsFillerTile:"),function(_b9,_ba,_bb){
with(_b9){
isFillerTile=_bb;
}
}),new objj_method(sel_getUid("isSelected"),function(_bc,_bd){
with(_bc){
return isSelected;
}
}),new objj_method(sel_getUid("setSelected:"),function(_be,_bf,_c0){
with(_be){
isSelected=_c0;
}
}),new objj_method(sel_getUid("isHighlighted"),function(_c1,_c2){
with(_c1){
return isHighlighted;
}
}),new objj_method(sel_getUid("setHighlighted:"),function(_c3,_c4,_c5){
with(_c3){
isHighlighted=_c5;
}
}),new objj_method(sel_getUid("calendarView"),function(_c6,_c7){
with(_c6){
return calendarView;
}
}),new objj_method(sel_getUid("setCalendarView:"),function(_c8,_c9,_ca){
with(_c8){
calendarView=_ca;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_cb,_cc,_cd){
with(_cb){
if(_cb=objj_msgSendSuper({receiver:_cb,super_class:objj_getClass("LPCalendarDayView").super_class},"initWithFrame:",_cd)){
objj_msgSend(_cb,"setHitTests:",NO);
date=objj_msgSend(CPDate,"date");
textField=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMakeZero());
objj_msgSend(textField,"setAutoresizingMask:",CPViewMinXMargin|CPViewMaxXMargin|CPViewMinYMargin|CPViewMaxYMargin);
objj_msgSend(_cb,"addSubview:",textField);
}
return _cb;
}
}),new objj_method(sel_getUid("setSelected:"),function(_ce,_cf,_d0){
with(_ce){
if(isSelected===_d0){
return;
}
isSelected=_d0;
if(_d0){
objj_msgSend(_ce,"setThemeState:",CPThemeStateSelected);
}else{
objj_msgSend(_ce,"unsetThemeState:",CPThemeStateSelected);
}
}
}),new objj_method(sel_getUid("setIsFillerTile:"),function(_d1,_d2,_d3){
with(_d1){
if(isFillerTile===_d3){
return;
}
isFillerTile=_d3;
if(isFillerTile){
objj_msgSend(_d1,"setThemeState:",CPThemeStateDisabled);
}else{
objj_msgSend(_d1,"unsetThemeState:",CPThemeStateDisabled);
}
}
}),new objj_method(sel_getUid("setHighlighted:"),function(_d4,_d5,_d6){
with(_d4){
if(isHighlighted===_d6){
return;
}
isHighlighted=_d6;
if(_d6){
objj_msgSend(_d4,"setThemeState:",CPThemeStateHighlighted);
}else{
objj_msgSend(_d4,"unsetThemeState:",CPThemeStateHighlighted);
}
}
}),new objj_method(sel_getUid("setDate:"),function(_d7,_d8,_d9){
with(_d7){
if(date.getTime()===_d9.getTime()){
return;
}
date.setTime(_d9.getTime());
objj_msgSend(textField,"setStringValue:",objj_msgSend(date.getDate(),"stringValue"));
objj_msgSend(textField,"sizeToFit");
var _da=objj_msgSend(_d7,"bounds");
objj_msgSend(textField,"setCenter:",CGPointMake(CGRectGetMidX(_da),CGRectGetMidY(_da)));
}
}),new objj_method(sel_getUid("layoutSubviews"),function(_db,_dc){
with(_db){
var _dd=objj_msgSend(_db,"themeState");
objj_msgSend(_db,"setBackgroundColor:",objj_msgSend(calendarView,"valueForThemeAttribute:inState:","tile-bezel-color",_dd));
objj_msgSend(textField,"setFont:",objj_msgSend(calendarView,"valueForThemeAttribute:inState:","tile-font",_dd));
objj_msgSend(textField,"setTextColor:",objj_msgSend(calendarView,"valueForThemeAttribute:inState:","tile-text-color",_dd));
objj_msgSend(textField,"setTextShadowColor:",objj_msgSend(calendarView,"valueForThemeAttribute:inState:","tile-text-shadow-color",_dd));
objj_msgSend(textField,"setTextShadowOffset:",objj_msgSend(calendarView,"valueForThemeAttribute:inState:","tile-text-shadow-offset",_dd));
}
})]);
class_addMethods(_3,[new objj_method(sel_getUid("themeClass"),function(_de,_df){
with(_de){
return "lp-calendar-day-view";
}
}),new objj_method(sel_getUid("themeAttributes"),function(_e0,_e1){
with(_e0){
return objj_msgSend(CPDictionary,"dictionaryWithObjects:forKeys:",[nil,nil],["background-color","bezel-color"]);
}
}),new objj_method(sel_getUid("dayViewWithCalendarView:"),function(_e2,_e3,_e4){
with(_e2){
var _e5=objj_msgSend(objj_msgSend(_e2,"alloc"),"initWithFrame:",CGRectMakeZero());
objj_msgSend(_e5,"setCalendarView:",_e4);
return _e5;
}
})]);
p;16;LPCalendarView.jt;10521;@STATIC;1.0;I;18;AppKit/CPControl.jI;28;LPKit/LPCalendarHeaderView.jI;27;LPKit/LPCalendarMonthView.jI;19;LPKit/LPSlideView.jt;10389;
objj_executeFile("AppKit/CPControl.j",NO);
objj_executeFile("LPKit/LPCalendarHeaderView.j",NO);
objj_executeFile("LPKit/LPCalendarMonthView.j",NO);
objj_executeFile("LPKit/LPSlideView.j",NO);
var _1=objj_allocateClassPair(CPView,"LPCalendarView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("headerView"),new objj_ivar("slideView"),new objj_ivar("currentMonthView"),new objj_ivar("firstMonthView"),new objj_ivar("secondMonthView"),new objj_ivar("fullSelection"),new objj_ivar("_delegate"),new objj_ivar("_target"),new objj_ivar("_doubleAction")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("headerView"),function(_3,_4){
with(_3){
return headerView;
}
}),new objj_method(sel_getUid("fullSelection"),function(_5,_6){
with(_5){
return fullSelection;
}
}),new objj_method(sel_getUid("delegate"),function(_7,_8){
with(_7){
return _delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_9,_a,_b){
with(_9){
_delegate=_b;
}
}),new objj_method(sel_getUid("target"),function(_c,_d){
with(_c){
return _target;
}
}),new objj_method(sel_getUid("setTarget:"),function(_e,_f,_10){
with(_e){
_target=_10;
}
}),new objj_method(sel_getUid("doubleAction"),function(_11,_12){
with(_11){
return _doubleAction;
}
}),new objj_method(sel_getUid("setDoubleAction:"),function(_13,_14,_15){
with(_13){
_doubleAction=_15;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_16,_17,_18){
with(_16){
if(_16=objj_msgSendSuper({receiver:_16,super_class:objj_getClass("LPCalendarView").super_class},"initWithFrame:",_18)){
fullSelection=[nil,nil];
var _19=objj_msgSend(_16,"bounds");
objj_msgSend(_16,"setClipsToBounds:",NO);
headerView=objj_msgSend(objj_msgSend(LPCalendarHeaderView,"alloc"),"initWithFrame:",CGRectMake(0,0,CGRectGetWidth(_19),40));
objj_msgSend(objj_msgSend(headerView,"prevButton"),"setTarget:",_16);
objj_msgSend(objj_msgSend(headerView,"prevButton"),"setAction:",sel_getUid("didClickPrevButton:"));
objj_msgSend(objj_msgSend(headerView,"nextButton"),"setTarget:",_16);
objj_msgSend(objj_msgSend(headerView,"nextButton"),"setAction:",sel_getUid("didClickNextButton:"));
objj_msgSend(_16,"addSubview:",headerView);
slideView=objj_msgSend(objj_msgSend(LPSlideView,"alloc"),"initWithFrame:",CGRectMake(0,40,CGRectGetWidth(_19),CGRectGetHeight(_19)-40));
objj_msgSend(slideView,"setSlideDirection:",LPSlideViewVerticalDirection);
objj_msgSend(slideView,"setDelegate:",_16);
objj_msgSend(slideView,"setAnimationCurve:",CPAnimationEaseOut);
objj_msgSend(slideView,"setAnimationDuration:",0.2);
objj_msgSend(_16,"addSubview:",slideView);
bezelView=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",objj_msgSend(slideView,"frame"));
objj_msgSend(bezelView,"setHitTests:",NO);
objj_msgSend(_16,"addSubview:positioned:relativeTo:",bezelView,CPWindowBelow,nil);
firstMonthView=objj_msgSend(objj_msgSend(LPCalendarMonthView,"alloc"),"initWithFrame:calendarView:",objj_msgSend(slideView,"bounds"),_16);
objj_msgSend(firstMonthView,"setDelegate:",_16);
objj_msgSend(slideView,"addSubview:",firstMonthView);
secondMonthView=objj_msgSend(objj_msgSend(LPCalendarMonthView,"alloc"),"initWithFrame:calendarView:",objj_msgSend(slideView,"bounds"),_16);
objj_msgSend(secondMonthView,"setDelegate:",_16);
objj_msgSend(slideView,"addSubview:",secondMonthView);
currentMonthView=firstMonthView;
objj_msgSend(currentMonthView,"setNeedsLayout");
objj_msgSend(_16,"setMonth:",objj_msgSend(CPDate,"date"));
objj_msgSend(_16,"setNeedsLayout");
}
return _16;
}
}),new objj_method(sel_getUid("setTheme:"),function(_1a,_1b,_1c){
with(_1a){
objj_msgSendSuper({receiver:_1a,super_class:objj_getClass("LPCalendarView").super_class},"setTheme:",_1c);
objj_msgSend(_1a,"setNeedsLayout");
objj_msgSend(firstMonthView,"setNeedsLayout");
objj_msgSend(secondMonthView,"setNeedsLayout");
}
}),new objj_method(sel_getUid("selectDate:"),function(_1d,_1e,_1f){
with(_1d){
objj_msgSend(_1d,"setMonth:",_1f);
objj_msgSend(_1d,"makeSelectionWithDate:end:",_1f,_1f);
}
}),new objj_method(sel_getUid("setMonth:"),function(_20,_21,_22){
with(_20){
objj_msgSend(currentMonthView,"setDate:",_22);
objj_msgSend(headerView,"setDate:",_22);
}
}),new objj_method(sel_getUid("monthViewForMonth:"),function(_23,_24,_25){
with(_23){
var _26=objj_msgSend(firstMonthView,"isHidden")?firstMonthView:secondMonthView;
objj_msgSend(_26,"setHiddenRows:",[]);
objj_msgSend(_26,"setDate:",_25);
objj_msgSend(_26,"makeSelectionWithDate:end:",fullSelection[0],objj_msgSend(fullSelection,"lastObject"));
return _26;
}
}),new objj_method(sel_getUid("changeToMonth:"),function(_27,_28,_29){
with(_27){
var _2a=objj_msgSend(_27,"monthViewForMonth:",_29),_2b=currentMonthView;
if(objj_msgSend(currentMonthView,"date").getTime()>_29.getTime()){
var _2c=LPSlideViewPositiveDirection,_2d=0.335,_2e=[0,1];
}else{
var _2c=LPSlideViewNegativeDirection,_2d=0.34,_2e=[4,5];
}
currentMonthView=_2a;
objj_msgSend(currentMonthView,"setFrameOrigin:",CGPointMake(-500,-500));
objj_msgSend(currentMonthView,"setHidden:",NO);
objj_msgSend(currentMonthView,"setNeedsDisplay:",YES);
objj_msgSend(currentMonthView,"setNeedsLayout");
objj_msgSend(headerView,"setDate:",_29);
setTimeout(function(){
objj_msgSend(_2b,"setHiddenRows:",_2e);
objj_msgSend(slideView,"slideToView:direction:animationProgress:",_2a,_2c,_2d);
},10);
}
}),new objj_method(sel_getUid("setAllowsMultipleSelection:"),function(_2f,_30,_31){
with(_2f){
objj_msgSend(firstMonthView,"setAllowsMultipleSelection:",_31);
objj_msgSend(secondMonthView,"setAllowsMultipleSelection:",_31);
}
}),new objj_method(sel_getUid("setHighlightCurrentPeriod:"),function(_32,_33,_34){
with(_32){
objj_msgSend(firstMonthView,"setHighlightCurrentPeriod:",_34);
objj_msgSend(secondMonthView,"setHighlightCurrentPeriod:",_34);
}
}),new objj_method(sel_getUid("setSelectionLengthType:"),function(_35,_36,_37){
with(_35){
objj_msgSend(firstMonthView,"setSelectionLengthType:",_37);
objj_msgSend(secondMonthView,"setSelectionLengthType:",_37);
}
}),new objj_method(sel_getUid("setWeekStartsOnMonday:"),function(_38,_39,_3a){
with(_38){
objj_msgSend(headerView,"setWeekStartsOnMonday:",_3a);
objj_msgSend(firstMonthView,"setWeekStartsOnMonday:",_3a);
objj_msgSend(secondMonthView,"setWeekStartsOnMonday:",_3a);
}
}),new objj_method(sel_getUid("setFastForwardEnabled:"),function(_3b,_3c,_3d){
with(_3b){
objj_msgSend(headerView,"setFastForwardEnabled:",_3d);
}
}),new objj_method(sel_getUid("isFastForwardEnabled"),function(_3e,_3f){
with(_3e){
return objj_msgSend(headerView,"isFastForwardEnabled");
}
}),new objj_method(sel_getUid("layoutSubviews"),function(_40,_41){
with(_40){
var _42=CGRectGetWidth(objj_msgSend(_40,"bounds")),_43=objj_msgSend(_40,"currentValueForThemeAttribute:","header-height");
objj_msgSend(headerView,"setFrameSize:",CGSizeMake(_42,_43));
objj_msgSend(slideView,"setFrame:",CGRectMake(0,_43,_42,CGRectGetHeight(objj_msgSend(_40,"bounds"))-_43));
objj_msgSend(headerView,"setNeedsLayout");
objj_msgSend(bezelView,"setBackgroundColor:",objj_msgSend(_40,"currentValueForThemeAttribute:","bezel-color"));
var _44=objj_msgSend(_40,"currentValueForThemeAttribute:","bezel-inset"),_45=objj_msgSend(_40,"frame");
objj_msgSend(bezelView,"setFrame:",CGRectMake(0+_44.left,0+_44.top,_45.size.width-_44.left-_44.right,_45.size.height-_44.top-_44.bottom));
objj_msgSend(slideView,"setBackgroundColor:",objj_msgSend(_40,"currentValueForThemeAttribute:","background-color"));
}
}),new objj_method(sel_getUid("didClickPrevButton:"),function(_46,_47,_48){
with(_46){
objj_msgSend(_46,"_didClickHeaderButton:toMonth:",_48,objj_msgSend(currentMonthView,"previousMonth"));
}
}),new objj_method(sel_getUid("didClickNextButton:"),function(_49,_4a,_4b){
with(_49){
objj_msgSend(_49,"_didClickHeaderButton:toMonth:",_4b,objj_msgSend(currentMonthView,"nextMonth"));
}
}),new objj_method(sel_getUid("_didClickHeaderButton:toMonth:"),function(_4c,_4d,_4e,_4f){
with(_4c){
if(objj_msgSend(slideView,"isSliding")){
return;
}
if(objj_msgSend(_4e,"isFastForwarding")){
objj_msgSend(_4c,"setMonth:",_4f);
objj_msgSend(currentMonthView,"makeSelectionWithDate:end:",objj_msgSend(fullSelection,"objectAtIndex:",0),objj_msgSend(fullSelection,"lastObject"));
}else{
objj_msgSend(_4c,"changeToMonth:",_4f);
}
}
}),new objj_method(sel_getUid("makeSelectionWithDate:end:"),function(_50,_51,_52,_53){
with(_50){
objj_msgSend(currentMonthView,"makeSelectionWithDate:end:",_52,_53);
}
}),new objj_method(sel_getUid("didMakeSelection:"),function(_54,_55,_56){
with(_54){
if(objj_msgSend(_56,"count")<=1){
objj_msgSend(_56,"addObject:",nil);
}
if(objj_msgSend(fullSelection,"isEqualToArray:",_56)){
return;
}
fullSelection=objj_msgSend(CPArray,"arrayWithArray:",_56);
if(_delegate&&objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("calendarView:didMakeSelection:end:"))){
objj_msgSend(_delegate,"calendarView:didMakeSelection:end:",_54,objj_msgSend(fullSelection,"objectAtIndex:",0),objj_msgSend(fullSelection,"lastObject"));
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("themeClass"),function(_57,_58){
with(_57){
return "lp-calendar-view";
}
}),new objj_method(sel_getUid("themeAttributes"),function(_59,_5a){
with(_59){
return objj_msgSend(CPDictionary,"dictionaryWithObjects:forKeys:",[objj_msgSend(CPNull,"null"),CGInsetMakeZero(),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),CGSizeMake(0,0),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),40,objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),30,objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null")],["bezel-color","bezel-inset","grid-color","grid-shadow-color","tile-size","tile-font","tile-text-color","tile-text-shadow-color","tile-text-shadow-offset","tile-bezel-color","header-button-offset","header-prev-button-image","header-next-button-image","header-height","header-background-color","header-font","header-text-color","header-text-shadow-color","header-text-shadow-offset","header-alignment","header-weekday-offset","header-weekday-label-font","header-weekday-label-color","header-weekday-label-shadow-color","header-weekday-label-shadow-offset"]);
}
})]);
p;13;LPChartView.jt;18899;@STATIC;1.0;I;15;AppKit/CPView.jt;18859;
objj_executeFile("AppKit/CPView.j",NO);
var _1=objj_allocateClassPair(CPView,"LPChartView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dataSource"),new objj_ivar("delegate"),new objj_ivar("drawView"),new objj_ivar("fixedMaxValue"),new objj_ivar("labelViewHeight"),new objj_ivar("drawViewPadding"),new objj_ivar("gridView"),new objj_ivar("labelView"),new objj_ivar("displayLabels"),new objj_ivar("_data"),new objj_ivar("_maxValue"),new objj_ivar("_framesSet"),new objj_ivar("_currentSize"),new objj_ivar("_maxValuePosition"),new objj_ivar("_minValuePosition")]);
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
}),new objj_method(sel_getUid("drawView"),function(_d,_e){
with(_d){
return drawView;
}
}),new objj_method(sel_getUid("setDrawView:"),function(_f,_10,_11){
with(_f){
drawView=_11;
}
}),new objj_method(sel_getUid("fixedMaxValue"),function(_12,_13){
with(_12){
return fixedMaxValue;
}
}),new objj_method(sel_getUid("setFixedMaxValue:"),function(_14,_15,_16){
with(_14){
fixedMaxValue=_16;
}
}),new objj_method(sel_getUid("labelViewHeight"),function(_17,_18){
with(_17){
return labelViewHeight;
}
}),new objj_method(sel_getUid("setLabelViewHeight:"),function(_19,_1a,_1b){
with(_19){
labelViewHeight=_1b;
}
}),new objj_method(sel_getUid("drawViewPadding"),function(_1c,_1d){
with(_1c){
return drawViewPadding;
}
}),new objj_method(sel_getUid("setDrawViewPadding:"),function(_1e,_1f,_20){
with(_1e){
drawViewPadding=_20;
}
}),new objj_method(sel_getUid("gridView"),function(_21,_22){
with(_21){
return gridView;
}
}),new objj_method(sel_getUid("setGridView:"),function(_23,_24,_25){
with(_23){
gridView=_25;
}
}),new objj_method(sel_getUid("labelView"),function(_26,_27){
with(_26){
return labelView;
}
}),new objj_method(sel_getUid("displayLabels"),function(_28,_29){
with(_28){
return displayLabels;
}
}),new objj_method(sel_getUid("setDisplayLabels:"),function(_2a,_2b,_2c){
with(_2a){
displayLabels=_2c;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_2d,_2e,_2f){
with(_2d){
if(_2d=objj_msgSendSuper({receiver:_2d,super_class:objj_getClass("LPChartView").super_class},"initWithFrame:",_2f)){
objj_msgSend(_2d,"_setup");
}
return _2d;
}
}),new objj_method(sel_getUid("_setup"),function(_30,_31){
with(_30){
_maxValuePosition=1;
_minValuePosition=0;
gridView=objj_msgSend(objj_msgSend(LPChartGridView,"alloc"),"initWithFrame:",CGRectMakeZero());
objj_msgSend(gridView,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_30,"addSubview:",gridView);
var _32=objj_msgSend(_30,"bounds");
labelView=objj_msgSend(objj_msgSend(LPChartLabelView,"alloc"),"initWithFrame:",CGRectMake(drawViewPadding,CGRectGetHeight(_32)-labelViewHeight,CGRectGetWidth(_32)-(2*drawViewPadding),labelViewHeight));
objj_msgSend(_30,"addSubview:",labelView);
_currentSize=CGSizeMake(0,0);
fixedMaxValue=0;
labelViewHeight=20;
drawViewPadding=5;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_33,_34,_35){
with(_33){
dataSource=_35;
}
}),new objj_method(sel_getUid("setDrawView:"),function(_36,_37,_38){
with(_36){
if(_38===drawView){
return;
}
if(drawView){
objj_msgSend(drawView,"removeFromSuperview");
}
objj_msgSend(_36,"addSubview:positioned:relativeTo:",_38,CPWindowAbove,gridView);
drawView=_38;
var _39=CGRectInset(objj_msgSend(_36,"bounds"),drawViewPadding,drawViewPadding);
if(labelView){
_39.size.height-=CGRectGetHeight(objj_msgSend(labelView,"bounds"));
}
objj_msgSend(drawView,"setFrame:",_39);
objj_msgSend(drawView,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
_39.size.height+=1;
objj_msgSend(gridView,"setFrame:",_39);
if(objj_msgSend(_36,"window")){
objj_msgSend(_36,"reloadData");
}
}
}),new objj_method(sel_getUid("setGridView:"),function(_3a,_3b,_3c){
with(_3a){
if(gridView===_3c){
return;
}
objj_msgSend(_3c,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_3a,"replaceSubview:with:",gridView,_3c);
var _3d=objj_msgSend(drawView,"frame");
_3d.height-=1;
objj_msgSend(_3c,"setFrame:",_3d);
gridView=_3c;
}
}),new objj_method(sel_getUid("setDisplayLabels:"),function(_3e,_3f,_40){
with(_3e){
if(!displayLabels&&labelView){
var _41=objj_msgSend(drawView,"frame");
_41.size.height+=CGRectGetHeight(objj_msgSend(labelView,"bounds"));
objj_msgSend(drawView,"setFrame:",_41);
objj_msgSend(labelView,"removeFromSuperview");
}else{
labelView=objj_msgSend(objj_msgSend(LPChartLabelView,"alloc"),"initWithFrame:",CGRectMake(0,CGRectGetHeight(aFrame)-labelViewHeight,CGRectGetWidth(aFrame),labelViewHeight));
objj_msgSend(_3e,"addSubview:",labelView);
}
displayLabels=_40;
}
}),new objj_method(sel_getUid("setDisplayGrid:"),function(_42,_43,_44){
with(_42){
objj_msgSend(gridView,"setHidden:",!_44);
}
}),new objj_method(sel_getUid("setMaxValuePosition:minValuePosition:"),function(_45,_46,_47,_48){
with(_45){
_maxValuePosition=_47;
_minValuePosition=_48;
objj_msgSend(objj_msgSend(_45,"drawView"),"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("itemFrames"),function(_49,_4a){
with(_49){
return (dataSource&&drawView&&_data)?objj_msgSend(_49,"calculateItemFramesWithSets:maxValue:",_data,_maxValue):objj_msgSend(CPArray,"array");
}
}),new objj_method(sel_getUid("reloadData"),function(_4b,_4c){
with(_4b){
if(!dataSource||!drawView){
return;
}
_data=objj_msgSend(CPArray,"array");
_maxValue=fixedMaxValue;
var _4d=objj_msgSend(dataSource,"numberOfSetsInChart:",_4b);
for(var _4e=0;_4e<_4d;_4e++){
var row=[],_4f=objj_msgSend(dataSource,"chart:numberOfValuesInSet:",_4b,_4e);
for(var _50=0;_50<_4f;_50++){
var _51=objj_msgSend(dataSource,"chart:valueForIndex:set:",_4b,_50,_4e);
if(_51>_maxValue){
_maxValue=_51;
}
row.push(_51);
}
_data.push(row);
}
_currentSize=nil;
objj_msgSend(gridView,"setNeedsDisplay:",YES);
objj_msgSend(labelView,"reloadData");
objj_msgSend(drawView,"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("calculateItemFramesWithSets:maxValue:"),function(_52,_53,_54,_55){
with(_52){
var _56=objj_msgSend(drawView,"bounds").size,_57=(1-_maxValuePosition)*_56.height;
if(_minValuePosition!==0){
_56.height-=_minValuePosition*_56.height;
}
if(_maxValuePosition!==1){
_56.height-=_57;
}
if(_currentSize&&CGSizeEqualToSize(_currentSize,_56)){
return _framesSet;
}
_currentSize=_56;
_framesSet=objj_msgSend(CPArray,"array");
if(!_54.length){
return _framesSet;
}
if(_55===0){
_55=1;
}
var _58=_56.width,_59=_56.height-(2*drawViewPadding),_5a=_54[0].length,_5b=_58/_5a,_5c=_58-(_5a*_5b);
for(var _5d=0;_5d<_54.length;_5d++){
var _5e=_54[_5d],_5f=0,row=[];
for(var _60=0;_60<_5e.length;_60++){
var _61=_5e[_60],_62=CGRectMake(_5f,0,_5b,0);
if(_5c>0){
_62.size.width++;
_5c--;
}
_62.size.height=ROUND((_61/_55)*_59);
_62.origin.y=_59-CGRectGetHeight(_62)+drawViewPadding;
if(_maxValuePosition!==1){
_62.origin.y+=_57;
}
row.push(_62);
_5f+=CGRectGetWidth(_62);
}
_framesSet.push(row);
}
return _framesSet;
}
}),new objj_method(sel_getUid("horizontalLabelForIndex:"),function(_63,_64,_65){
with(_63){
return objj_msgSend(dataSource,"chart:labelValueForIndex:",_63,_65);
}
}),new objj_method(sel_getUid("mouseMoved:"),function(_66,_67,_68){
with(_66){
if(delegate&&objj_msgSend(delegate,"respondsToSelector:",sel_getUid("chart:didMouseOverItemAtIndex:"))){
var _69=objj_msgSend(_66,"itemFrames");
if(!_69.length){
return;
}
var _6a=_69[0],_6b=objj_msgSend(drawView,"convertPoint:fromView:",objj_msgSend(_68,"locationInWindow"),nil);
for(var i=0;i<_6a.length;i++){
var _6c=_6a[i];
if(_6c.origin.x<=_6b.x&&(_6c.origin.x+_6c.size.width)>_6b.x){
objj_msgSend(delegate,"chart:didMouseOverItemAtIndex:",_66,i);
return;
}
}
}
}
}),new objj_method(sel_getUid("mouseExited:"),function(_6d,_6e,_6f){
with(_6d){
if(delegate&&objj_msgSend(delegate,"respondsToSelector:",sel_getUid("chart:didMouseOverItemAtIndex:"))){
objj_msgSend(delegate,"chart:didMouseOverItemAtIndex:",_6d,-1);
}
}
}),new objj_method(sel_getUid("viewDidMoveToWindow"),function(_70,_71){
with(_70){
objj_msgSend(_70,"reloadData");
}
})]);
var _72="LPChartViewDataSourceKey",_73="LPChartViewDrawViewKey",_74="LPChartViewGridViewKey",_75="LPChartViewDisplayLabelsKey",_76="LPChartViewLabelViewKey",_77="LPChartViewDataKey",_78="LPChartViewMaxValueKey",_79="LPChartViewFramesSetKey",_7a="LPChartViewCurrentSizeKey",_7b="LPChartViewMaxValuePositionKey",_7c="LPChartViewMinValuePositionKey";
var _1=objj_getClass("LPChartView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"LPChartView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_7d,_7e,_7f){
with(_7d){
if(_7d=objj_msgSendSuper({receiver:_7d,super_class:objj_getClass("LPChartView").super_class},"initWithCoder:",_7f)){
dataSource=objj_msgSend(_7f,"decodeObjectForKey:",_72);
gridView=objj_msgSend(_7f,"decodeObjectForKey:",_74);
drawView=objj_msgSend(_7f,"decodeObjectForKey:",_73);
displayLabels=!objj_msgSend(_7f,"containsValueForKey:",_75)||objj_msgSend(_7f,"decodeObjectForKey:",_75);
labelView=objj_msgSend(_7f,"decodeObjectForKey:",_76);
_data=objj_msgSend(_7f,"decodeObjectForKey:",_77);
_maxValue=objj_msgSend(_7f,"decodeIntForKey:",_78);
_framesSet=objj_msgSend(_7f,"decodeObjectForKey:",_79);
_currentSize=objj_msgSend(_7f,"decodeSizeForKey:",_7a);
_maxValuePosition=objj_msgSend(_7f,"decodeIntForKey:",_7b);
_minValuePosition=objj_msgSend(_7f,"decodeFloatForKey:",_7c);
objj_msgSend(_7d,"_setup");
}
return _7d;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_80,_81,_82){
with(_80){
objj_msgSendSuper({receiver:_80,super_class:objj_getClass("LPChartView").super_class},"encodeWithCoder:",_82);
objj_msgSend(_82,"encodeObject:forKey:",dataSource,_72);
objj_msgSend(_82,"encodeObject:forKey:",drawView,_73);
objj_msgSend(_82,"encodeObject:forKey:",gridView,_74);
objj_msgSend(_82,"encodeBool:forKey:",displayLabels,_75);
objj_msgSend(_82,"encodeObject:forKey:",labelView,_76);
objj_msgSend(_82,"encodeObject:forKey:",_data,_77);
objj_msgSend(_82,"encodeInt:forKey:",_maxValue,_78);
objj_msgSend(_82,"encodeObject:forKey:",_framesSet,_79);
if(_currentSize){
objj_msgSend(_82,"encodeSize:forKey:",_currentSize,_7a);
}
objj_msgSend(_82,"encodeFloat:forKey:",_maxValuePosition,_7b);
objj_msgSend(_82,"encodeFloat:forKey:",_minValuePosition,_7c);
}
})]);
var _1=objj_allocateClassPair(CPView,"LPChartGridView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("gridColor")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("gridColor"),function(_83,_84){
with(_83){
return gridColor;
}
}),new objj_method(sel_getUid("setGridColor:"),function(_85,_86,_87){
with(_85){
gridColor=_87;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_88,_89,_8a){
with(_88){
if(_88=objj_msgSendSuper({receiver:_88,super_class:objj_getClass("LPChartGridView").super_class},"initWithFrame:",_8a)){
gridColor=objj_msgSend(CPColor,"colorWithWhite:alpha:",0,0.05);
objj_msgSend(_88,"setHitTests:",NO);
}
return _88;
}
}),new objj_method(sel_getUid("setGridColor:"),function(_8b,_8c,_8d){
with(_8b){
gridColor=_8d;
objj_msgSend(_8b,"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("drawRect:"),function(_8e,_8f,_90){
with(_8e){
if(itemFrames=objj_msgSend(objj_msgSend(_8e,"superview"),"itemFrames")){
var _91=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort"),_92=objj_msgSend(_8e,"bounds"),_93=CGRectGetWidth(_92),_94=CGRectGetHeight(_92),_95=1;
CGContextSetFillColor(_91,gridColor);
if(itemFrames.length){
for(var i=0;i<itemFrames[0].length;i++){
CGContextFillRect(_91,CGRectMake(FLOOR(itemFrames[0][i].origin.x),0,_95,_94));
}
}else{
CGContextFillRect(_91,CGRectMake(0,0,_95,_94));
}
CGContextFillRect(_91,CGRectMake(_93-_95,0,_95,_94));
CGContextFillRect(_91,CGRectMake(0,_94-_95,_93,_95));
CGContextFillRect(_91,CGRectMake(0,FLOOR(_94/2),_93,_95));
}
}
})]);
var _1=objj_allocateClassPair(CPView,"LPChartDrawView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_96,_97,_98){
with(_96){
if(_96=objj_msgSendSuper({receiver:_96,super_class:objj_getClass("LPChartDrawView").super_class},"initWithFrame:",_98)){
objj_msgSend(_96,"setHitTests:",NO);
}
return _96;
}
}),new objj_method(sel_getUid("drawRect:"),function(_99,_9a,_9b){
with(_99){
if(itemFrames=objj_msgSend(objj_msgSend(_99,"superview"),"itemFrames")){
var _9c=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort");
objj_msgSend(_99,"drawSetWithFrames:inContext:",itemFrames,_9c);
}
}
}),new objj_method(sel_getUid("drawSetWithFrames:inContext:"),function(_9d,_9e,_9f,_a0){
with(_9d){
CGContextSetStrokeColor(_a0,objj_msgSend(CPColor,"colorWithHexString:","4379ca"));
CGContextSetLineWidth(_a0,2);
for(var _a1=0;_a1<_9f.length;_a1++){
var _a2=_9f[_a1];
CGContextBeginPath(_a0);
for(var _a3=0;_a3<_a2.length;_a3++){
var _a4=_a2[_a3],_a5=CGPointMake(CGRectGetMidX(_a4),CGRectGetMinY(_a4));
if(_a3==0){
CGContextMoveToPoint(_a0,_a5.x,_a5.y);
}else{
CGContextAddLineToPoint(_a0,_a5.x,_a5.y);
}
}
CGContextStrokePath(_a0);
CGContextClosePath(_a0);
}
}
})]);
var _1=objj_allocateClassPair(CPView,"LPChartLabelView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("chart"),new objj_ivar("_labelPrototype"),new objj_ivar("_labelData"),new objj_ivar("_cachedLabels")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_a6,_a7,_a8){
with(_a6){
if(_a6=objj_msgSendSuper({receiver:_a6,super_class:objj_getClass("LPChartLabelView").super_class},"initWithFrame:",_a8)){
objj_msgSend(_a6,"setAutoresizingMask:",CPViewWidthSizable|CPViewMinYMargin);
objj_msgSend(_a6,"setHitTests:",NO);
objj_msgSend(_a6,"setLabelPrototype:",objj_msgSend(LPChartLabel,"labelWithItemIndex:",-1));
}
return _a6;
}
}),new objj_method(sel_getUid("setLabelPrototype:"),function(_a9,_aa,_ab){
with(_a9){
_labelPrototype=_ab;
_labelData=nil;
_cachedLabels=objj_msgSend(CPArray,"array");
objj_msgSend(_a9,"reloadData");
}
}),new objj_method(sel_getUid("newLabelWithItemIndex:"),function(_ac,_ad,_ae){
with(_ac){
if(_cachedLabels.length){
var _af=_cachedLabels.pop();
}else{
if(!_labelData){
if(_labelPrototype){
_labelData=objj_msgSend(CPKeyedArchiver,"archivedDataWithRootObject:",_labelPrototype);
}
}
var _af=objj_msgSend(CPKeyedUnarchiver,"unarchiveObjectWithData:",_labelData);
}
objj_msgSend(_af,"setItemIndex:",_ae);
return _af;
}
}),new objj_method(sel_getUid("reloadData"),function(_b0,_b1){
with(_b0){
if(chart){
var _b2=objj_msgSend(_b0,"subviews");
if(numberOfSubviews=_b2.length){
while(numberOfSubviews--){
objj_msgSend(_b2[numberOfSubviews],"removeFromSuperview");
if(_labelData){
_cachedLabels.push(_b2[numberOfSubviews]);
}
}
}
var _b3=objj_msgSend(chart,"itemFrames");
if(_b3&&_b3.length){
_b3=_b3[0];
for(var i=0,_b4=_b3.length;i<_b4;i++){
var _b5=objj_msgSend(_b0,"newLabelWithItemIndex:",i);
objj_msgSend(_b5,"setLabel:",objj_msgSend(chart,"horizontalLabelForIndex:",i));
objj_msgSend(_b0,"addSubview:",_b5);
}
}
objj_msgSend(_b0,"setNeedsLayout");
}
}
}),new objj_method(sel_getUid("viewDidMoveToSuperview"),function(_b6,_b7){
with(_b6){
chart=objj_msgSend(_b6,"superview");
}
}),new objj_method(sel_getUid("layoutSubviews"),function(_b8,_b9){
with(_b8){
var _ba=objj_msgSend(chart,"itemFrames");
if(!_ba){
return;
}
var _bb=objj_msgSend(_b8,"subviews"),_bc=_bb.length,_bd=objj_msgSend(_b8,"bounds"),_ba=_ba[0],_be=CGRectGetMinX(objj_msgSend(objj_msgSend(chart,"drawView"),"frame")),_bf=CGRectGetMidY(_bd);
while(_bc--){
var _c0=_bb[_bc];
objj_msgSend(_c0,"setCenter:",CGPointMake(CGRectGetMidX(_ba[_bc])+_be,_bf));
var _c1=objj_msgSend(_c0,"frame");
if(_c1.origin.x<0){
frameIsDirty=YES;
_c1.origin.x=0;
objj_msgSend(_c0,"setFrame:",_c1);
}else{
if(CGRectGetMaxX(_c1)>_bd.size.width){
frameIsDirty=YES;
_c1.origin.x-=CGRectGetMaxX(_c1)-_bd.size.width;
objj_msgSend(_c0,"setFrame:",_c1);
}
}
}
}
})]);
var _c2="LPChartLabelViewChartKey",_c3="LPChartLabelViewLabelPrototypeKey";
var _1=objj_getClass("LPChartLabelView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"LPChartLabelView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_c4,_c5,_c6){
with(_c4){
if(_c4=objj_msgSendSuper({receiver:_c4,super_class:objj_getClass("LPChartLabelView").super_class},"initWithCoder:",_c6)){
chart=objj_msgSend(_c6,"decodeObjectForKey:",_c2);
_labelPrototype=objj_msgSend(_c6,"decodeObjectForKey:",_c3);
_cachedLabels=objj_msgSend(CPArray,"array");
}
return _c4;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_c7,_c8,_c9){
with(_c7){
objj_msgSendSuper({receiver:_c7,super_class:objj_getClass("LPChartLabelView").super_class},"encodeWithCoder:",_c9);
objj_msgSend(_c9,"encodeObject:forKey:",chart,_c2);
objj_msgSend(_c9,"encodeObject:forKey:",_labelPrototype,_c3);
}
})]);
var _1=objj_allocateClassPair(CPTextField,"LPChartLabel"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_itemIndex")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("itemIndex"),function(_ca,_cb){
with(_ca){
return _itemIndex;
}
}),new objj_method(sel_getUid("setItemIndex:"),function(_cc,_cd,_ce){
with(_cc){
_itemIndex=_ce;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_cf,_d0,_d1){
with(_cf){
if(_cf=objj_msgSendSuper({receiver:_cf,super_class:objj_getClass("LPChartLabel").super_class},"initWithFrame:",_d1)){
objj_msgSend(_cf,"setHitTests:",NO);
}
return _cf;
}
}),new objj_method(sel_getUid("setLabel:"),function(_d2,_d3,_d4){
with(_d2){
if(_d4!==objj_msgSend(_d2,"stringValue")){
objj_msgSend(_d2,"setStringValue:",_d4);
objj_msgSend(_d2,"sizeToFit");
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("labelWithItemIndex:"),function(_d5,_d6,_d7){
with(_d5){
var _d8=objj_msgSend(objj_msgSend(_d5,"alloc"),"initWithFrame:",CGRectMakeZero());
objj_msgSend(_d8,"setItemIndex:",_d7);
return _d8;
}
})]);
var _d9="LPChartLabelItemIndexKey";
var _1=objj_getClass("LPChartLabel");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"LPChartLabel\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_da,_db,_dc){
with(_da){
if(_da=objj_msgSendSuper({receiver:_da,super_class:objj_getClass("LPChartLabel").super_class},"initWithCoder:",_dc)){
_itemIndex=objj_msgSend(_dc,"decodeIntForKey:",_d9);
}
return _da;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_dd,_de,_df){
with(_dd){
objj_msgSendSuper({receiver:_dd,super_class:objj_getClass("LPChartLabel").super_class},"encodeWithCoder:",_df);
objj_msgSend(_df,"encodeInt:forKey:",_itemIndex,_d9);
}
})]);
p;20;LPCookieController.jt;2475;@STATIC;1.0;I;21;Foundation/CPObject.jI;20;Foundation/CPRange.jt;2405;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Foundation/CPRange.j",NO);
var _1=nil;
var _2=objj_allocateClassPair(CPObject,"LPCookieController"),_3=_2.isa;
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("setValue:forKey:"),function(_4,_5,_6,_7){
with(_4){
return objj_msgSend(_4,"setValue:forKey:expirationDate:",_6,_7,nil);
}
}),new objj_method(sel_getUid("setValue:forKey:expirationDate:"),function(_8,_9,_a,_b,_c){
with(_8){
return objj_msgSend(_8,"setValue:forKey:expirationDate:path:",_a,_b,_c,nil);
}
}),new objj_method(sel_getUid("setValue:forKey:expirationDate:path:"),function(_d,_e,_f,_10,_11,_12){
with(_d){
return objj_msgSend(_d,"setValue:forKey:expirationDate:path:domain:",_f,_10,_11,_12,nil);
}
}),new objj_method(sel_getUid("setValue:forKey:expirationDate:path:domain:"),function(_13,_14,_15,_16,_17,_18,_19){
with(_13){
return objj_msgSend(_13,"setValue:forKey:expirationDate:path:domain:escape:",_15,_16,_17,_18,nil,YES);
}
}),new objj_method(sel_getUid("setValue:forKey:expirationDate:path:domain:escape:"),function(_1a,_1b,_1c,_1d,_1e,_1f,_20,_21){
with(_1a){
var _22="";
_22+=objj_msgSend(CPString,"stringWithFormat:","%s=%s; ",_1d,_21?escape(_1c):_1c);
if(_1e){
_22+=objj_msgSend(CPString,"stringWithFormat:","expires=%s; ",_1e.toUTCString());
}
_22+=objj_msgSend(CPString,"stringWithFormat:","path=%s; ",_1f||"/");
if(_20){
_22+=objj_msgSend(CPString,"stringWithFormat:","domain=%s; ",_20);
}
_22=objj_msgSend(_22,"substringToIndex:",objj_msgSend(_22,"length")-2);
document.cookie=_22;
}
}),new objj_method(sel_getUid("valueForKey:"),function(_23,_24,_25){
with(_23){
var _26=objj_msgSend(document.cookie,"componentsSeparatedByString:",";");
for(var i=0;i<objj_msgSend(_26,"count");i++){
var _27=objj_msgSend(_26,"objectAtIndex:",i),_28=objj_msgSend(_27,"rangeOfString:options:",objj_msgSend(CPString,"stringWithFormat:","%s=",_25),CPCaseInsensitiveSearch);
if(_28.length>0){
return objj_msgSend(_27,"substringFromIndex:",CPMaxRange(_28));
}
}
return nil;
}
}),new objj_method(sel_getUid("removeValueForKey:"),function(_29,_2a,_2b){
with(_29){
objj_msgSend(_29,"setValue:forKey:expirationDate:","",_2b,objj_msgSend(CPDate,"distantPast"));
}
})]);
class_addMethods(_3,[new objj_method(sel_getUid("sharedCookieController"),function(_2c,_2d){
with(_2c){
if(!_1){
_1=objj_msgSend(objj_msgSend(_2c,"alloc"),"init");
}
return _1;
}
})]);
p;17;LPCrashReporter.jt;10147;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPAlert.jI;24;LPKit/LPURLPostRequest.jI;28;LPKit/LPMultiLineTextField.jt;10018;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPAlert.j",NO);
objj_executeFile("LPKit/LPURLPostRequest.j",NO);
objj_executeFile("LPKit/LPMultiLineTextField.j",NO);
var _1=nil;
var _2=objj_allocateClassPair(CPObject,"LPCrashReporter"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("_exception"),new objj_ivar("alertMessage"),new objj_ivar("alertInformative")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("exception"),function(_4,_5){
with(_4){
return _exception;
}
}),new objj_method(sel_getUid("setException:"),function(_6,_7,_8){
with(_6){
_exception=_8;
}
}),new objj_method(sel_getUid("alertMessage"),function(_9,_a){
with(_9){
return alertMessage;
}
}),new objj_method(sel_getUid("setAlertMessage:"),function(_b,_c,_d){
with(_b){
alertMessage=_d;
}
}),new objj_method(sel_getUid("alertInformative"),function(_e,_f){
with(_e){
return alertInformative;
}
}),new objj_method(sel_getUid("setAlertInformative:"),function(_10,_11,_12){
with(_10){
alertInformative=_12;
}
}),new objj_method(sel_getUid("init"),function(_13,_14){
with(_13){
if(_13=objj_msgSendSuper({receiver:_13,super_class:objj_getClass("LPCrashReporter").super_class},"init")){
alertMessage=objj_msgSend(CPString,"stringWithFormat:","The application %@ crashed unexpectedly.",objj_msgSend(objj_msgSend(CPBundle,"mainBundle"),"objectForInfoDictionaryKey:","CPBundleName"));
alertInformative="Click Reload to load the application again or click Report to send a report to the developer.";
_15();
}
return _13;
}
}),new objj_method(sel_getUid("didCatchException:"),function(_16,_17,_18){
with(_16){
if(objj_msgSend(_16,"shouldInterceptException")){
if(_exception){
return;
}
_exception=_18;
var _19=objj_msgSend(objj_msgSend(LPCrashReporterOverlayWindow,"alloc"),"initWithContentRect:styleMask:",CGRectMakeZero(),CPBorderlessBridgeWindowMask);
objj_msgSend(_19,"setLevel:",CPNormalWindowLevel);
objj_msgSend(_19,"makeKeyAndOrderFront:",nil);
var _1a=objj_msgSend(objj_msgSend(CPAlert,"alloc"),"init");
objj_msgSend(_1a,"setDelegate:",_16);
objj_msgSend(_1a,"setAlertStyle:",CPCriticalAlertStyle);
objj_msgSend(_1a,"addButtonWithTitle:","Reload");
objj_msgSend(_1a,"addButtonWithTitle:","Report...");
objj_msgSend(_1a,"setMessageText:",alertMessage);
objj_msgSend(_1a,"setInformativeText:",alertInformative);
objj_msgSend(_1a,"runModal");
}else{
objj_msgSend(_18,"raise");
}
}
}),new objj_method(sel_getUid("shouldInterceptException"),function(_1b,_1c){
with(_1b){
return YES;
}
}),new objj_method(sel_getUid("alertDidEnd:returnCode:"),function(_1d,_1e,_1f,_20){
with(_1d){
switch(_20){
case 0:
location.reload();
break;
case 1:
var _21=objj_msgSend(objj_msgSend(LPCrashReporterReportWindow,"alloc"),"initWithContentRect:styleMask:",CGRectMake(0,0,460,309),CPTitledWindowMask|CPResizableWindowMask);
objj_msgSend(CPApp,"runModalForWindow:",_21);
break;
}
}
})]);
class_addMethods(_3,[new objj_method(sel_getUid("sharedErrorLogger"),function(_22,_23){
with(_22){
if(!_1){
_1=objj_msgSend(objj_msgSend(LPCrashReporter,"alloc"),"init");
}
return _1;
}
})]);
var _2=objj_allocateClassPair(CPWindow,"LPCrashReporterOverlayWindow"),_3=_2.isa;
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("initWithContentRect:styleMask:"),function(_24,_25,_26,_27){
with(_24){
if(_24=objj_msgSendSuper({receiver:_24,super_class:objj_getClass("LPCrashReporterOverlayWindow").super_class},"initWithContentRect:styleMask:",_26,_27)){
objj_msgSend(objj_msgSend(_24,"contentView"),"setBackgroundColor:",objj_msgSend(CPColor,"colorWithWhite:alpha:",0,0.4));
}
return _24;
}
})]);
var _2=objj_allocateClassPair(CPWindow,"LPCrashReporterReportWindow"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("informationLabel"),new objj_ivar("informationTextField"),new objj_ivar("descriptionLabel"),new objj_ivar("descriptionTextField"),new objj_ivar("sendButton"),new objj_ivar("cancelButton"),new objj_ivar("sendingLabel")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("initWithContentRect:styleMask:"),function(_28,_29,_2a,_2b){
with(_28){
if(_28=objj_msgSendSuper({receiver:_28,super_class:objj_getClass("LPCrashReporterReportWindow").super_class},"initWithContentRect:styleMask:",_2a,_2b)){
var _2c=objj_msgSend(_28,"contentView"),_2d=objj_msgSend(objj_msgSend(CPBundle,"mainBundle"),"objectForInfoDictionaryKey:","CPBundleName");
objj_msgSend(_28,"setMinSize:",_2a.size);
objj_msgSend(_28,"setTitle:",objj_msgSend(CPString,"stringWithFormat:","Problem Report for %@",_2d));
informationLabel=objj_msgSend(CPTextField,"labelWithTitle:","Problem and system information:");
objj_msgSend(informationLabel,"setFrameOrigin:",CGPointMake(12,12));
objj_msgSend(_2c,"addSubview:",informationLabel);
var _2e=objj_msgSend(CPString,"stringWithFormat:","User-Agent: %@\n\nException: %@",navigator.userAgent,objj_msgSend(objj_msgSend(LPCrashReporter,"sharedErrorLogger"),"exception"));
informationTextField=objj_msgSend(LPMultiLineTextField,"textFieldWithStringValue:placeholder:width:",_2e,"",0);
objj_msgSend(informationTextField,"setEditable:",NO);
objj_msgSend(informationTextField,"setSelectable:",YES);
objj_msgSend(informationTextField,"setFrame:",CGRectMake(12,31,CGRectGetWidth(_2a)-24,100));
objj_msgSend(informationTextField,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(_2c,"addSubview:",informationTextField);
descriptionLabel=objj_msgSend(CPTextField,"labelWithTitle:","Please describe what you were doing when the problem happened:");
objj_msgSend(descriptionLabel,"setFrameOrigin:",CGPointMake(12,141));
objj_msgSend(_2c,"addSubview:",descriptionLabel);
descriptionTextField=objj_msgSend(LPMultiLineTextField,"textFieldWithStringValue:placeholder:width:","","",0);
objj_msgSend(descriptionTextField,"setFrame:",CGRectMake(CGRectGetMinX(objj_msgSend(informationTextField,"frame")),CGRectGetMaxY(objj_msgSend(descriptionLabel,"frame"))+1,CGRectGetWidth(objj_msgSend(informationTextField,"frame")),100));
objj_msgSend(descriptionTextField,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_2c,"addSubview:",descriptionTextField);
sendButton=objj_msgSend(CPButton,"buttonWithTitle:",objj_msgSend(CPString,"stringWithFormat:","Send to %@",_2d));
objj_msgSend(sendButton,"setFrameOrigin:",CGPointMake(CGRectGetWidth(_2a)-CGRectGetWidth(objj_msgSend(sendButton,"frame"))-15,270));
objj_msgSend(sendButton,"setAutoresizingMask:",CPViewMinXMargin|CPViewMinYMargin);
objj_msgSend(sendButton,"setTarget:",_28);
objj_msgSend(sendButton,"setAction:",sel_getUid("didClickSendButton:"));
objj_msgSend(_2c,"addSubview:",sendButton);
objj_msgSend(_28,"setDefaultButton:",sendButton);
cancelButton=objj_msgSend(CPButton,"buttonWithTitle:","Cancel");
objj_msgSend(cancelButton,"setFrameSize:",CGSizeMake(80,CGRectGetHeight(objj_msgSend(cancelButton,"bounds"))));
objj_msgSend(cancelButton,"setFrameOrigin:",CGPointMake(CGRectGetMinX(objj_msgSend(sendButton,"frame"))-CGRectGetWidth(objj_msgSend(cancelButton,"frame"))-12,CGRectGetMinY(objj_msgSend(sendButton,"frame"))));
objj_msgSend(cancelButton,"setAutoresizingMask:",CPViewMinXMargin|CPViewMinYMargin);
objj_msgSend(cancelButton,"setTarget:",_28);
objj_msgSend(cancelButton,"setAction:",sel_getUid("didClickCancelButton:"));
objj_msgSend(_2c,"addSubview:",cancelButton);
sendingLabel=objj_msgSend(CPTextField,"labelWithTitle:","Sending Report...");
objj_msgSend(sendingLabel,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",11));
objj_msgSend(sendingLabel,"sizeToFit");
objj_msgSend(sendingLabel,"setFrameOrigin:",CGPointMake(12,CGRectGetMaxY(_2a)-35));
objj_msgSend(sendingLabel,"setHidden:",YES);
objj_msgSend(_2c,"addSubview:",sendingLabel);
}
return _28;
}
}),new objj_method(sel_getUid("orderFront:"),function(_2f,_30,_31){
with(_2f){
objj_msgSendSuper({receiver:_2f,super_class:objj_getClass("LPCrashReporterReportWindow").super_class},"orderFront:",_31);
objj_msgSend(_2f,"makeFirstResponder:",descriptionTextField);
}
}),new objj_method(sel_getUid("didClickSendButton:"),function(_32,_33,_34){
with(_32){
objj_msgSend(informationTextField,"setEnabled:",NO);
objj_msgSend(descriptionTextField,"setEnabled:",NO);
objj_msgSend(sendButton,"setEnabled:",NO);
objj_msgSend(cancelButton,"setEnabled:",NO);
objj_msgSend(informationLabel,"setAlphaValue:",0.5);
objj_msgSend(descriptionLabel,"setAlphaValue:",0.5);
objj_msgSend(sendingLabel,"setHidden:",NO);
var _35=objj_msgSend(CPURL,"URLWithString:",objj_msgSend(objj_msgSend(CPBundle,"mainBundle"),"objectForInfoDictionaryKey:","LPCrashReporterLoggingURL")||"/"),_36=objj_msgSend(LPURLPostRequest,"requestWithURL:",_35),_37=objj_msgSend(objj_msgSend(LPCrashReporter,"sharedErrorLogger"),"exception"),_38={"name":objj_msgSend(_37,"name"),"reason":objj_msgSend(_37,"reason"),"userAgent":navigator.userAgent,"description":objj_msgSend(descriptionTextField,"stringValue")};
objj_msgSend(_36,"setContent:",_38);
objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_36,_32);
}
}),new objj_method(sel_getUid("didClickCancelButton:"),function(_39,_3a,_3b){
with(_39){
objj_msgSend(objj_msgSend(LPCrashReporter,"sharedErrorLogger"),"alertDidEnd:returnCode:",nil,0);
}
}),new objj_method(sel_getUid("connection:didReceiveData:"),function(_3c,_3d,_3e,_3f){
with(_3c){
objj_msgSend(CPApp,"stopModal");
objj_msgSend(_3c,"orderOut:",nil);
var _40=objj_msgSend(objj_msgSend(CPAlert,"alloc"),"init");
objj_msgSend(_40,"setDelegate:",objj_msgSend(LPCrashReporter,"sharedErrorLogger"));
objj_msgSend(_40,"setAlertStyle:",CPInformationalAlertStyle);
objj_msgSend(_40,"addButtonWithTitle:","Thanks!");
objj_msgSend(_40,"setMessageText:","Your report has been sent.");
objj_msgSend(_40,"runModal");
}
})]);
var _41=objj_msgSend;
var _42=function(){
try{
objj_msgSend=_41;
return objj_msgSend.apply(this,arguments);
}
catch(anException){
CPLog.error(anException);
objj_msgSend(objj_msgSend(LPCrashReporter,"sharedErrorLogger"),"didCatchException:",anException);
return nil;
}
finally{
objj_msgSend=_42;
}
};
var _15=function(){
objj_msgSend=_42;
};
p;9;LPEmail.jt;1698;@STATIC;1.0;I;21;Foundation/CPObject.jt;1653;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=new RegExp("^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$");
var _2=objj_allocateClassPair(CPObject,"LPEmail"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("email")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("initWithString:"),function(_4,_5,_6){
with(_4){
if(_4=objj_msgSendSuper({receiver:_4,super_class:objj_getClass("LPEmail").super_class},"init")){
email=_6;
}
return _4;
}
}),new objj_method(sel_getUid("stringValue"),function(_7,_8){
with(_7){
return email;
}
}),new objj_method(sel_getUid("isValidEmail"),function(_9,_a){
with(_9){
return objj_msgSend(LPEmail,"emailWithStringIsValid:",email);
}
}),new objj_method(sel_getUid("isEqualToEmail:"),function(_b,_c,_d){
with(_b){
return objj_msgSend(objj_msgSend(_b,"stringValue"),"isEqualToString:",objj_msgSend(_d,"stringValue"));
}
})]);
class_addMethods(_3,[new objj_method(sel_getUid("emailWithString:"),function(_e,_f,_10){
with(_e){
return objj_msgSend(objj_msgSend(_e,"alloc"),"initWithString:",_10);
}
}),new objj_method(sel_getUid("emailWithStringIsValid:"),function(_11,_12,_13){
with(_11){
return _1.test(_13);
}
})]);
var _14="LPEmailKey";
var _2=objj_getClass("LPEmail");
if(!_2){
throw new SyntaxError("*** Could not find definition for class \"LPEmail\"");
}
var _3=_2.isa;
class_addMethods(_2,[new objj_method(sel_getUid("initWithCoder:"),function(_15,_16,_17){
with(_15){
if(_15){
email=objj_msgSend(_17,"decodeObjectForKey:",_14);
}
return _15;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_18,_19,_1a){
with(_18){
objj_msgSend(_1a,"encodeObject:forKey:",email,_14);
}
})]);
p;7;LPKit.jt;975;@STATIC;1.0;I;22;LPKit/LPAnchorButton.jI;22;LPKit/LPCalendarView.jI;19;LPKit/LPChartView.jI;26;LPKit/LPCookieController.jI;15;LPKit/LPEmail.jI;28;LPKit/LPLocationController.jI;28;LPKit/LPMultiLineTextField.jI;22;LPKit/LPPieChartView.jI;19;LPKit/LPSlideView.jI;19;LPKit/LPSparkLine.jI;16;LPKit/LPSwitch.jI;24;LPKit/LPURLPostRequest.jI;23;LPKit/LPViewAnimation.jt;609;
objj_executeFile("LPKit/LPAnchorButton.j",NO);
objj_executeFile("LPKit/LPCalendarView.j",NO);
objj_executeFile("LPKit/LPChartView.j",NO);
objj_executeFile("LPKit/LPCookieController.j",NO);
objj_executeFile("LPKit/LPEmail.j",NO);
objj_executeFile("LPKit/LPLocationController.j",NO);
objj_executeFile("LPKit/LPMultiLineTextField.j",NO);
objj_executeFile("LPKit/LPPieChartView.j",NO);
objj_executeFile("LPKit/LPSlideView.j",NO);
objj_executeFile("LPKit/LPSparkLine.j",NO);
objj_executeFile("LPKit/LPSwitch.j",NO);
objj_executeFile("LPKit/LPURLPostRequest.j",NO);
objj_executeFile("LPKit/LPViewAnimation.j",NO);
p;22;LPLocationController.jt;1864;@STATIC;1.0;I;21;Foundation/CPObject.jt;1819;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=nil;
var _2=objj_allocateClassPair(CPObject,"LPLocationController"),_3=_2.isa;
class_addIvars(_2,[new objj_ivar("currentHash"),new objj_ivar("observers")]);
objj_registerClassPair(_2);
class_addMethods(_2,[new objj_method(sel_getUid("init"),function(_4,_5){
with(_4){
if(_4=objj_msgSendSuper({receiver:_4,super_class:objj_getClass("LPLocationController").super_class},"init")){
observers=objj_msgSend(CPArray,"array");
currentHash=window.location.hash;
if(typeof window.onhashchange!=="undefined"){
window.onhashchange=function(){
objj_msgSend(_4,"updateLocation:",nil);
};
}else{
objj_msgSend(CPTimer,"scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:",0.1,_4,sel_getUid("updateLocation:"),nil,YES);
}
}
return _4;
}
}),new objj_method(sel_getUid("formattedHash"),function(_6,_7){
with(_6){
return objj_msgSend(window.location.hash,"substringFromIndex:",1);
}
}),new objj_method(sel_getUid("setLocation:"),function(_8,_9,_a){
with(_8){
window.location.hash=_a;
objj_msgSend(_8,"updateLocation:",nil);
}
}),new objj_method(sel_getUid("updateLocation:"),function(_b,_c,_d){
with(_b){
if(currentHash!==window.location.hash){
currentHash=window.location.hash;
var _e=objj_msgSend(_b,"formattedHash");
for(var i=0,_f=observers.length;i<_f;i++){
objj_msgSend(observers[i][0],"performSelector:withObject:",observers[i][1],_e);
}
}
}
}),new objj_method(sel_getUid("addObserver:selector:"),function(_10,_11,_12,_13){
with(_10){
objj_msgSend(observers,"addObject:",[_12,_13]);
objj_msgSend(_12,"performSelector:withObject:",_13,objj_msgSend(_10,"formattedHash"));
}
})]);
class_addMethods(_3,[new objj_method(sel_getUid("sharedLocationController"),function(_14,_15){
with(_14){
if(!_1){
_1=objj_msgSend(objj_msgSend(_14,"alloc"),"init");
}
return _1;
}
})]);
p;22;LPMultiLineTextField.jt;9262;@STATIC;1.0;I;20;AppKit/CPTextField.jt;9218;
objj_executeFile("AppKit/CPTextField.j",NO);
var _1=nil,_2=NO,_3=NO,_4=NO,_5;
var _6=objj_allocateClassPair(CPTextField,"LPMultiLineTextField"),_7=_6.isa;
class_addIvars(_6,[new objj_ivar("_DOMTextareaElement"),new objj_ivar("_hideOverflow")]);
objj_registerClassPair(_6);
class_addMethods(_6,[new objj_method(sel_getUid("_DOMTextareaElement"),function(_8,_9){
with(_8){
if(!_DOMTextareaElement){
_DOMTextareaElement=document.createElement("textarea");
_DOMTextareaElement.style.position="absolute";
_DOMTextareaElement.style.background="none";
_DOMTextareaElement.style.border="0";
_DOMTextareaElement.style.outline="0";
_DOMTextareaElement.style.zIndex="100";
_DOMTextareaElement.style.resize="none";
_DOMTextareaElement.style.padding="0";
_DOMTextareaElement.style.margin="0";
_DOMTextareaElement.style.overflow="auto";
_hideOverflow=NO;
_5=function(){
if(!_2){
objj_msgSend(objj_msgSend(_1,"window"),"makeFirstResponder:",nil);
return;
}
_1=nil;
objj_msgSend(objj_msgSend(CPRunLoop,"currentRunLoop"),"limitDateForMode:",CPDefaultRunLoopMode);
_3=YES;
};
_DOMTextareaElement.onblur=_5;
_8._DOMElement.appendChild(_DOMTextareaElement);
}
return _DOMTextareaElement;
}
}),new objj_method(sel_getUid("isScrollable"),function(_a,_b){
with(_a){
return !_hideOverflow;
}
}),new objj_method(sel_getUid("setScrollable:"),function(_c,_d,_e){
with(_c){
_hideOverflow=!_e;
objj_msgSend(_c,"_DOMTextareaElement").style.overflow=_e?"auto":"hidden";
}
}),new objj_method(sel_getUid("setEditable:"),function(_f,_10,_11){
with(_f){
objj_msgSend(_f,"_DOMTextareaElement").style.cursor=_11?"cursor":"default";
objj_msgSend(_f,"_DOMTextareaElement").disabled=!_11;
objj_msgSendSuper({receiver:_f,super_class:objj_getClass("LPMultiLineTextField").super_class},"setEditable:",_11);
}
}),new objj_method(sel_getUid("selectText:"),function(_12,_13,_14){
with(_12){
objj_msgSend(_12,"_DOMTextareaElement").select();
}
}),new objj_method(sel_getUid("layoutSubviews"),function(_15,_16){
with(_15){
objj_msgSendSuper({receiver:_15,super_class:objj_getClass("LPMultiLineTextField").super_class},"layoutSubviews");
var _17=objj_msgSend(_15,"layoutEphemeralSubviewNamed:positioned:relativeToEphemeralSubviewNamed:","content-view",CPWindowAbove,"bezel-view");
objj_msgSend(_17,"setHidden:",YES);
var _18=objj_msgSend(_15,"_DOMTextareaElement"),_19=objj_msgSend(_15,"currentValueForThemeAttribute:","content-inset"),_1a=objj_msgSend(_15,"bounds");
_18.style.top=_19.top+"px";
_18.style.bottom=_19.bottom+"px";
_18.style.left=_19.left+"px";
_18.style.right=_19.right+"px";
_18.style.width=(CGRectGetWidth(_1a)-_19.left-_19.right)+"px";
_18.style.height=(CGRectGetHeight(_1a)-_19.top-_19.bottom)+"px";
_18.style.color=objj_msgSend(objj_msgSend(_15,"currentValueForThemeAttribute:","text-color"),"cssString");
_18.style.font=objj_msgSend(objj_msgSend(_15,"currentValueForThemeAttribute:","font"),"cssString");
switch(objj_msgSend(_15,"currentValueForThemeAttribute:","alignment")){
case CPLeftTextAlignment:
_18.style.textAlign="left";
break;
case CPJustifiedTextAlignment:
_18.style.textAlign="justify";
break;
case CPCenterTextAlignment:
_18.style.textAlign="center";
break;
case CPRightTextAlignment:
_18.style.textAlign="right";
break;
default:
_18.style.textAlign="left";
}
if(objj_msgSend(_15,"hasThemeState:",CPTextFieldStatePlaceholder)){
_18.value=objj_msgSend(_15,"placeholderString");
}else{
_18.value=objj_msgSend(_15,"stringValue");
}
if(_hideOverflow){
_18.style.overflow="hidden";
}
}
}),new objj_method(sel_getUid("scrollWheel:"),function(_1b,_1c,_1d){
with(_1b){
var _1e=objj_msgSend(_1b,"_DOMTextareaElement");
_1e.scrollLeft+=_1d._deltaX;
_1e.scrollTop+=_1d._deltaY;
}
}),new objj_method(sel_getUid("mouseDown:"),function(_1f,_20,_21){
with(_1f){
if(objj_msgSend(_1f,"isEditable")&&objj_msgSend(_1f,"isEnabled")){
objj_msgSend(objj_msgSend(objj_msgSend(_1f,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
}else{
objj_msgSendSuper({receiver:_1f,super_class:objj_getClass("LPMultiLineTextField").super_class},"mouseDown:",_21);
}
}
}),new objj_method(sel_getUid("mouseDragged:"),function(_22,_23,_24){
with(_22){
return objj_msgSend(objj_msgSend(objj_msgSend(_24,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
}
}),new objj_method(sel_getUid("keyDown:"),function(_25,_26,_27){
with(_25){
if(objj_msgSend(_27,"keyCode")===CPTabKeyCode){
if(objj_msgSend(_27,"modifierFlags")&CPShiftKeyMask){
objj_msgSend(objj_msgSend(_25,"window"),"selectPreviousKeyView:",_25);
}else{
objj_msgSend(objj_msgSend(_25,"window"),"selectNextKeyView:",_25);
}
if(objj_msgSend(objj_msgSend(objj_msgSend(_25,"window"),"firstResponder"),"respondsToSelector:",sel_getUid("selectText:"))){
objj_msgSend(objj_msgSend(objj_msgSend(_25,"window"),"firstResponder"),"selectText:",_25);
}
objj_msgSend(objj_msgSend(objj_msgSend(_25,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",NO);
}else{
objj_msgSend(objj_msgSend(objj_msgSend(_25,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
}
objj_msgSend(objj_msgSend(CPRunLoop,"currentRunLoop"),"limitDateForMode:",CPDefaultRunLoopMode);
}
}),new objj_method(sel_getUid("keyUp:"),function(_28,_29,_2a){
with(_28){
var _2b=objj_msgSend(_28,"stringValue");
objj_msgSend(_28,"_setStringValue:",objj_msgSend(_28,"_DOMTextareaElement").value);
if(_2b!==objj_msgSend(_28,"stringValue")){
if(!_isEditing){
_isEditing=YES;
objj_msgSend(_28,"textDidBeginEditing:",objj_msgSend(CPNotification,"notificationWithName:object:userInfo:",CPControlTextDidBeginEditingNotification,_28,nil));
}
objj_msgSend(_28,"textDidChange:",objj_msgSend(CPNotification,"notificationWithName:object:userInfo:",CPControlTextDidChangeNotification,_28,nil));
}
objj_msgSend(objj_msgSend(objj_msgSend(_28,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
}
}),new objj_method(sel_getUid("performKeyEquivalent:"),function(_2c,_2d,_2e){
with(_2c){
objj_msgSend(objj_msgSend(objj_msgSend(_2c,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
return YES;
}
}),new objj_method(sel_getUid("becomeFirstResponder"),function(_2f,_30){
with(_2f){
objj_msgSend(_2f,"setThemeState:",CPThemeStateEditing);
objj_msgSend(_2f,"_updatePlaceholderState");
setTimeout(function(){
objj_msgSend(_2f,"_DOMTextareaElement").focus();
_1=_2f;
},0);
objj_msgSend(_2f,"textDidFocus:",objj_msgSend(CPNotification,"notificationWithName:object:userInfo:",CPTextFieldDidFocusNotification,_2f,nil));
_4=YES;
return YES;
}
}),new objj_method(sel_getUid("resignFirstResponder"),function(_31,_32){
with(_31){
objj_msgSend(_31,"unsetThemeState:",CPThemeStateEditing);
objj_msgSend(_31,"_updatePlaceholderState");
objj_msgSend(_31,"setStringValue:",objj_msgSend(_31,"stringValue"));
_2=YES;
if(_4){
objj_msgSend(_31,"_DOMTextareaElement").blur();
}
if(!_3){
_5();
}
_3=NO;
_2=NO;
_4=NO;
if(_isEditing){
_isEditing=NO;
objj_msgSend(_31,"textDidEndEditing:",objj_msgSend(CPNotification,"notificationWithName:object:userInfo:",CPControlTextDidEndEditingNotification,_31,nil));
if(objj_msgSend(_31,"sendsActionOnEndEditing")){
objj_msgSend(_31,"sendAction:to:",objj_msgSend(_31,"action"),objj_msgSend(_31,"target"));
}
}
objj_msgSend(_31,"textDidBlur:",objj_msgSend(CPNotification,"notificationWithName:object:userInfo:",CPTextFieldDidBlurNotification,_31,nil));
return YES;
}
}),new objj_method(sel_getUid("_setStringValue:"),function(_33,_34,_35){
with(_33){
objj_msgSend(_33,"willChangeValueForKey:","objectValue");
objj_msgSendSuper({receiver:_33,super_class:objj_getClass("LPMultiLineTextField").super_class},"setObjectValue:",String(_35));
objj_msgSend(_33,"_updatePlaceholderState");
objj_msgSend(_33,"didChangeValueForKey:","objectValue");
}
}),new objj_method(sel_getUid("setObjectValue:"),function(_36,_37,_38){
with(_36){
objj_msgSendSuper({receiver:_36,super_class:objj_getClass("LPMultiLineTextField").super_class},"setObjectValue:",_38);
if(_1===_36||objj_msgSend(objj_msgSend(_36,"window"),"firstResponder")===_36){
objj_msgSend(_36,"_DOMTextareaElement").value=_38;
}
objj_msgSend(_36,"_updatePlaceholderState");
}
}),new objj_method(sel_getUid("_setCurrentValueIsPlaceholder:"),function(_39,_3a,_3b){
with(_39){
if(!_originalPlaceholderString){
_originalPlaceholderString=objj_msgSend(_39,"placeholderString");
}
objj_msgSendSuper({receiver:_39,super_class:objj_getClass("LPMultiLineTextField").super_class},"_setCurrentValueIsPlaceholder:",_3b);
}
})]);
var _3c="LPMultiLineTextFieldScrollableKey";
var _6=objj_getClass("LPMultiLineTextField");
if(!_6){
throw new SyntaxError("*** Could not find definition for class \"LPMultiLineTextField\"");
}
var _7=_6.isa;
class_addMethods(_6,[new objj_method(sel_getUid("initWithCoder:"),function(_3d,_3e,_3f){
with(_3d){
if(_3d=objj_msgSendSuper({receiver:_3d,super_class:objj_getClass("LPMultiLineTextField").super_class},"initWithCoder:",_3f)){
var _40=objj_msgSend(_3f,"decodeBoolForKey:",_3c);
if(_40===NO){
objj_msgSend(_3d,"setScrollable:",NO);
}
}
return _3d;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_41,_42,_43){
with(_41){
objj_msgSendSuper({receiver:_41,super_class:objj_getClass("LPMultiLineTextField").super_class},"encodeWithCoder:",_43);
objj_msgSend(_43,"encodeBool:forKey:",objj_msgSend(_41,"isScrollable"),_3c);
}
})]);
p;16;LPPieChartView.jt;6408;@STATIC;1.0;I;15;AppKit/CPView.jt;6369;
objj_executeFile("AppKit/CPView.j",NO);
var _1=objj_allocateClassPair(CPView,"LPPieChartView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("dataSource"),new objj_ivar("delegate"),new objj_ivar("drawView"),new objj_ivar("values"),new objj_ivar("sum"),new objj_ivar("paths")]);
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
}),new objj_method(sel_getUid("drawView"),function(_d,_e){
with(_d){
return drawView;
}
}),new objj_method(sel_getUid("setDrawView:"),function(_f,_10,_11){
with(_f){
drawView=_11;
}
}),new objj_method(sel_getUid("paths"),function(_12,_13){
with(_12){
return paths;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_14,_15,_16){
with(_14){
if(_14=objj_msgSendSuper({receiver:_14,super_class:objj_getClass("LPPieChartView").super_class},"initWithFrame:",_16)){
objj_msgSend(_14,"setDrawView:",objj_msgSend(objj_msgSend(LPPieChartDrawView,"alloc"),"initWithFrame:",CGRectMakeZero()));
paths=objj_msgSend(CPArray,"array");
}
return _14;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_17,_18,_19){
with(_17){
dataSource=_19;
objj_msgSend(_17,"reloadData");
}
}),new objj_method(sel_getUid("setDelegate:"),function(_1a,_1b,_1c){
with(_1a){
delegate=_1c;
objj_msgSend(_1a,"reloadData");
}
}),new objj_method(sel_getUid("setDrawView:"),function(_1d,_1e,_1f){
with(_1d){
var _20=objj_msgSend(CPKeyedUnarchiver,"unarchiveObjectWithData:",objj_msgSend(CPKeyedArchiver,"archivedDataWithRootObject:",_1f));
if(!drawView){
objj_msgSend(_1d,"addSubview:",_20);
}else{
objj_msgSend(_1d,"replaceSubview:with:",drawView,_20);
}
drawView=_20;
objj_msgSend(drawView,"setFrame:",objj_msgSend(_1d,"bounds"));
objj_msgSend(drawView,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_1d,"reloadData");
}
}),new objj_method(sel_getUid("reloadData"),function(_21,_22){
with(_21){
if(dataSource&&drawView){
var _23=objj_msgSend(dataSource,"numberOfItemsInPieChartView:",_21),_24=objj_msgSend(CPArray,"array");
values=objj_msgSend(CPArray,"array");
sum=0;
for(var i=0;i<_23;i++){
var _25=objj_msgSend(dataSource,"pieChartView:floatValueForIndex:",_21,i);
objj_msgSend(values,"addObject:",_25);
sum+=_25;
}
objj_msgSend(_21,"setNeedsLayout");
objj_msgSend(drawView,"setNeedsDisplay:",YES);
}
}
}),new objj_method(sel_getUid("layoutSubviews"),function(_26,_27){
with(_26){
var _28=objj_msgSend(drawView,"bounds"),_29=MIN(CGRectGetWidth(_28),CGRectGetHeight(_28))/2,_2a=CGRectGetMidX(_28),_2b=CGRectGetMidY(_28),_2c=0;
paths=objj_msgSend(CPArray,"array");
for(var i=0;i<values.length;i++){
var _2d=values[i],_2e=(_2d/sum)*360;
var _2f=CGPathCreateMutable();
CGPathMoveToPoint(_2f,nil,_2a,_2b);
CGPathAddArc(_2f,nil,_2a,_2b,_29,_2c/(180/PI),(_2c+_2e)/(180/PI),YES);
CGPathAddLineToPoint(_2f,nil,_2a,_2b);
paths.push(_2f);
_2c+=_2e;
}
}
}),new objj_method(sel_getUid("indexOfValueAtPoint:"),function(_30,_31,_32){
with(_30){
var _33=CGBitmapGraphicsContextCreate();
if(_33.isPointInPath){
for(var i=0;i<paths.length;i++){
CGContextBeginPath(_33);
CGContextAddPath(_33,paths[i]);
CGContextClosePath(_33);
if(_33.isPointInPath(_32.x,_32.y)){
return i;
}
}
}
return -1;
}
}),new objj_method(sel_getUid("mouseMoved:"),function(_34,_35,_36){
with(_34){
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("pieChartView:mouseMovedOverIndex:"))){
var _37=objj_msgSend(_34,"convertPoint:fromView:",objj_msgSend(_36,"locationInWindow"),nil);
objj_msgSend(delegate,"pieChartView:mouseMovedOverIndex:",_34,objj_msgSend(_34,"indexOfValueAtPoint:",_37));
}
}
}),new objj_method(sel_getUid("mouseExited:"),function(_38,_39,_3a){
with(_38){
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("pieChartView:mouseMovedOverIndex:"))){
objj_msgSend(delegate,"pieChartView:mouseMovedOverIndex:",_38,-1);
}
}
})]);
var _3b="LPPieChartViewDrawView",_3c="LPPieChartViewValues",_3d="LPPieChartViewSum",_3e="LPPieChartViewPaths";
var _1=objj_getClass("LPPieChartView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"LPPieChartView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_3f,_40,_41){
with(_3f){
if(_3f){
drawView=objj_msgSend(_41,"decodeObjectForKey:",_3b);
values=objj_msgSend(_41,"decodeObjectForKey:",_3c);
sum=objj_msgSend(_41,"decodeFloatForKey:",_3d);
paths=objj_msgSend(_41,"decodeObjectForKey:",_3e);
}
return _3f;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_42,_43,_44){
with(_42){
objj_msgSend(_44,"encodeObject:forKey:",drawView,_3b);
objj_msgSend(_44,"encodeObject:forKey:",values,_3c);
objj_msgSend(_44,"encodeFloat:forKey:",sum,_3d);
objj_msgSend(_44,"encodeObject:forKey:",paths,_3e);
}
})]);
var _1=objj_allocateClassPair(CPView,"LPPieChartDrawView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("drawRect:"),function(_45,_46,_47){
with(_45){
if(objj_msgSend(_45,"superview")){
objj_msgSend(_45,"drawInContext:paths:",objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort"),objj_msgSend(objj_msgSend(_45,"superview"),"paths"));
}
}
}),new objj_method(sel_getUid("drawInContext:paths:"),function(_48,_49,_4a,_4b){
with(_48){
CGContextSetLineWidth(_4a,objj_msgSend(_48,"currentValueForThemeAttribute:","line-width"));
CGContextSetStrokeColor(_4a,objj_msgSend(_48,"currentValueForThemeAttribute:","stroke-color"));
var _4c=objj_msgSend(_48,"currentValueForThemeAttribute:","fill-colors");
for(var i=0;i<_4b.length;i++){
CGContextBeginPath(_4a);
CGContextAddPath(_4a,_4b[i]);
CGContextClosePath(_4a);
CGContextSetFillColor(_4a,_4c[i]);
CGContextFillPath(_4a);
CGContextStrokePath(_4a);
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("themeClass"),function(_4d,_4e){
with(_4d){
return "lp-piechart-drawview";
}
}),new objj_method(sel_getUid("themeAttributes"),function(_4f,_50){
with(_4f){
return objj_msgSend(CPDictionary,"dictionaryWithObjects:forKeys:",[[objj_msgSend(CPColor,"grayColor")],1,objj_msgSend(CPColor,"whiteColor")],["fill-colors","line-width","stroke-color"]);
}
})]);
p;13;LPSlideView.jt;5266;@STATIC;1.0;I;15;AppKit/CPView.jI;23;LPKit/LPViewAnimation.jt;5199;
objj_executeFile("AppKit/CPView.j",NO);
objj_executeFile("LPKit/LPViewAnimation.j",NO);
LPSlideViewHorizontalDirection=0;
LPSlideViewVerticalDirection=1;
LPSlideViewPositiveDirection=2;
LPSlideViewNegativeDirection=4;
var _1=objj_allocateClassPair(CPView,"LPSlideView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("slideDirection"),new objj_ivar("currentView"),new objj_ivar("previousView"),new objj_ivar("animationDuration"),new objj_ivar("animationCurve"),new objj_ivar("isSliding"),new objj_ivar("_delegate")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("slideDirection"),function(_3,_4){
with(_3){
return slideDirection;
}
}),new objj_method(sel_getUid("setSlideDirection:"),function(_5,_6,_7){
with(_5){
slideDirection=_7;
}
}),new objj_method(sel_getUid("currentView"),function(_8,_9){
with(_8){
return currentView;
}
}),new objj_method(sel_getUid("setCurrentView:"),function(_a,_b,_c){
with(_a){
currentView=_c;
}
}),new objj_method(sel_getUid("previousView"),function(_d,_e){
with(_d){
return previousView;
}
}),new objj_method(sel_getUid("setPreviousView:"),function(_f,_10,_11){
with(_f){
previousView=_11;
}
}),new objj_method(sel_getUid("animationDuration"),function(_12,_13){
with(_12){
return animationDuration;
}
}),new objj_method(sel_getUid("setAnimationDuration:"),function(_14,_15,_16){
with(_14){
animationDuration=_16;
}
}),new objj_method(sel_getUid("animationCurve"),function(_17,_18){
with(_17){
return animationCurve;
}
}),new objj_method(sel_getUid("setAnimationCurve:"),function(_19,_1a,_1b){
with(_19){
animationCurve=_1b;
}
}),new objj_method(sel_getUid("isSliding"),function(_1c,_1d){
with(_1c){
return isSliding;
}
}),new objj_method(sel_getUid("delegate"),function(_1e,_1f){
with(_1e){
return _delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_20,_21,_22){
with(_20){
_delegate=_22;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_23,_24,_25){
with(_23){
if(_23=objj_msgSendSuper({receiver:_23,super_class:objj_getClass("LPSlideView").super_class},"initWithFrame:",_25)){
animationCurve=CPAnimationEaseOut;
slideDirection=LPSlideViewHorizontalDirection;
animationDuration=0.2;
isSliding=NO;
}
return _23;
}
}),new objj_method(sel_getUid("addSubview:"),function(_26,_27,_28){
with(_26){
if(!currentView){
currentView=_28;
}else{
objj_msgSend(_28,"setHidden:",YES);
}
objj_msgSend(_28,"setFrame:",objj_msgSend(_26,"bounds"));
objj_msgSend(_28,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSendSuper({receiver:_26,super_class:objj_getClass("LPSlideView").super_class},"addSubview:",_28);
}
}),new objj_method(sel_getUid("slideToView:"),function(_29,_2a,_2b){
with(_29){
objj_msgSend(_29,"slideToView:direction:animationProgress:",_2b,nil,nil);
}
}),new objj_method(sel_getUid("slideToView:direction:"),function(_2c,_2d,_2e,_2f){
with(_2c){
objj_msgSend(_2c,"slideToView:direction:animationProgress:",_2e,_2f,nil);
}
}),new objj_method(sel_getUid("slideToView:direction:animationProgress:"),function(_30,_31,_32,_33,_34){
with(_30){
if(_32==currentView||isSliding){
return;
}
isSliding=YES;
if(_delegate&&objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("slideView:willMoveToView:"))){
objj_msgSend(_delegate,"slideView:willMoveToView:",_30,_32);
}
var _35=objj_msgSend(objj_msgSend(_30,"subviews"),"indexOfObject:",_32),_36=objj_msgSend(objj_msgSend(_30,"subviews"),"indexOfObject:",currentView),_37=objj_msgSend(_30,"frame").size;
objj_msgSend(_32,"setHidden:",NO);
var _38=CGPointMake(0,0),_39=CGPointMake(0,0);
if(slideDirection==LPSlideViewHorizontalDirection){
var _3a,_3b;
if((_33&&_33==LPSlideViewNegativeDirection)||(!_33&&_35<_36)){
_3a=-_37.width;
_3b=_37.width;
}
if((_33&&_33==LPSlideViewPositiveDirection)||(!_33&&_35>_36)){
_3a=_37.width;
_3b=-_37.width;
}
_38.x=_3a;
_39.x=_3b;
}else{
if(slideDirection==LPSlideViewVerticalDirection){
var _3c,_3d;
if((_33&&_33==LPSlideViewNegativeDirection)||(!_33&&_35>_36)){
_3c=_37.height;
_3d=-_37.height;
}
if((_33&&_33==LPSlideViewPositiveDirection)||(!_33&&_35<_36)){
_3c=-_37.height;
_3d=_37.height;
}
_38.y=_3c;
_39.y=_3d;
if(_34){
_38.y-=(_34*_38.y);
_39.y-=(_34*_39.y);
}
}
}
var _3e=objj_msgSend(objj_msgSend(LPViewAnimation,"alloc"),"initWithViewAnimations:",[{"target":_32,"animations":[[LPOriginAnimationKey,_38,CGPointMake(0,0)]]},{"target":currentView,"animations":[[LPOriginAnimationKey,CGPointMakeZero(),_39]]}]);
objj_msgSend(_3e,"setAnimationCurve:",animationCurve);
objj_msgSend(_3e,"setDuration:",animationDuration);
objj_msgSend(_3e,"setDelegate:",_30);
objj_msgSend(_3e,"startAnimation");
previousView=currentView;
currentView=_32;
}
}),new objj_method(sel_getUid("animationDidEnd"),function(_3f,_40){
with(_3f){
if(_delegate&&objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("slideView:didMoveToView:"))){
objj_msgSend(_delegate,"slideView:didMoveToView:",_3f,currentView);
}
objj_msgSend(previousView,"setHidden:",YES);
isSliding=NO;
}
}),new objj_method(sel_getUid("animationDidEnd:"),function(_41,_42,_43){
with(_41){
objj_msgSend(_41,"animationDidEnd");
}
}),new objj_method(sel_getUid("animationDidStop:"),function(_44,_45,_46){
with(_44){
objj_msgSend(_44,"animationDidEnd");
}
})]);
p;13;LPSparkLine.jt;4018;@STATIC;1.0;I;21;Foundation/CPObject.jt;3973;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPView,"LPSparkLine"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("data"),new objj_ivar("lineColor"),new objj_ivar("lineWeight"),new objj_ivar("shadowColor"),new objj_ivar("shadowOffset"),new objj_ivar("isEmpty")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("data"),function(_3,_4){
with(_3){
return data;
}
}),new objj_method(sel_getUid("setData:"),function(_5,_6,_7){
with(_5){
data=_7;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_8,_9,_a){
with(_8){
_8=objj_msgSendSuper({receiver:_8,super_class:objj_getClass("LPSparkLine").super_class},"initWithFrame:",_a);
if(_8){
lineWeight=1;
lineColor=objj_msgSend(CPColor,"blackColor");
shadowColor=nil;
shadowOffset=CGSizeMake(0,1);
}
return _8;
}
}),new objj_method(sel_getUid("drawRect:"),function(_b,_c,_d){
with(_b){
var _e=objj_msgSend(objj_msgSend(CPGraphicsContext,"currentContext"),"graphicsPort"),_f=objj_msgSend(_b,"bounds"),_10=CGRectGetHeight(_f)-(2*lineWeight),_11=CGRectGetWidth(_f)/(objj_msgSend(data,"count")-1),_12=Math.max.apply(Math,data);
CGContextBeginPath(_e);
if(isEmpty){
CGContextMoveToPoint(_e,0,_10/2);
CGContextAddLineToPoint(_e,CGRectGetWidth(_f),_10/2);
}else{
for(var i=0;i<objj_msgSend(data,"count");i++){
var x=i*_11,y=lineWeight+(_10-((objj_msgSend(data,"objectAtIndex:",i)/_12)*_10));
if(i===0){
CGContextMoveToPoint(_e,0,y);
}else{
CGContextAddLineToPoint(_e,x,y);
}
}
}
CGContextSetLineJoin(_e,kCGLineJoinRound);
CGContextSetLineWidth(_e,lineWeight);
CGContextSetStrokeColor(_e,lineColor);
CGContextSetShadowWithColor(_e,shadowOffset,0,shadowColor);
CGContextStrokePath(_e);
CGContextClosePath(_e);
}
}),new objj_method(sel_getUid("setData:"),function(_13,_14,_15){
with(_13){
isEmpty=YES;
for(var i=0;i<_15.length;i++){
if((_15[i]>0)&&(isEmpty)){
isEmpty=NO;
}
}
data=_15;
objj_msgSend(_13,"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("setLineColor:"),function(_16,_17,_18){
with(_16){
lineColor=_18;
objj_msgSend(_16,"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("setLineWeight:"),function(_19,_1a,_1b){
with(_19){
lineWeight=_1b;
objj_msgSend(_19,"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("setShadowColor:"),function(_1c,_1d,_1e){
with(_1c){
shadowColor=_1e;
objj_msgSend(_1c,"setNeedsDisplay:",YES);
}
}),new objj_method(sel_getUid("setShadowOffset:"),function(_1f,_20,_21){
with(_1f){
shadowOffset=_21;
objj_msgSend(_1f,"setNeedsDisplay:",YES);
}
})]);
var _22="LPSparkLineDataKey",_23="LPSparkLineLineColorKey",_24="LPSparkLineLineWeightKey",_25="LPSparkLineShadowColorKey",_26="LPSparkLineShadowOffsetKey",_27="LPSparkLineIsEmptyKey";
var _1=objj_getClass("LPSparkLine");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"LPSparkLine\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_28,_29,_2a){
with(_28){
if(_28=objj_msgSendSuper({receiver:_28,super_class:objj_getClass("LPSparkLine").super_class},"initWithCoder:",_2a)){
data=objj_msgSend(_2a,"decodeObjectForKey:",_22);
lineColor=objj_msgSend(_2a,"decodeObjectForKey:",_23);
lineWeight=objj_msgSend(_2a,"decodeFloatForKey:",_24);
shadowColor=objj_msgSend(_2a,"decodeObjectForKey:",_25);
shadowOffset=objj_msgSend(_2a,"decodeSizeForKey:",_26);
isEmpty=!objj_msgSend(_2a,"containsValueForKey:",_27)||objj_msgSend(_2a,"decodeObjectForKey:",_27);
}
return _28;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_2b,_2c,_2d){
with(_2b){
objj_msgSendSuper({receiver:_2b,super_class:objj_getClass("LPSparkLine").super_class},"encodeWithCoder:",_2d);
objj_msgSend(_2d,"encodeObject:forKey:",data,_22);
objj_msgSend(_2d,"encodeObject:forKey:",lineColor,_23);
objj_msgSend(_2d,"encodeFloat:forKey:",lineWeight,_24);
objj_msgSend(_2d,"encodeObject:forKey:",shadowColor,_25);
objj_msgSend(_2d,"encodeSize:forKey:",shadowOffset,_26);
objj_msgSend(_2d,"encodeBool:forKey:",isEmpty,_27);
}
})]);
p;10;LPSwitch.jt;10096;@STATIC;1.0;I;18;AppKit/CPControl.jI;23;LPKit/LPViewAnimation.jt;10025;
objj_executeFile("AppKit/CPControl.j",NO);
objj_executeFile("LPKit/LPViewAnimation.j",NO);
var _1=objj_allocateClassPair(CPControl,"LPSwitch"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("on"),new objj_ivar("dragStartPoint"),new objj_ivar("knob"),new objj_ivar("knobDragStartPoint"),new objj_ivar("isDragging"),new objj_ivar("animationDuration"),new objj_ivar("animationCurve"),new objj_ivar("offBackgroundView"),new objj_ivar("onBackgroundView"),new objj_ivar("offLabel"),new objj_ivar("onLabel"),new objj_ivar("animation")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("isOn"),function(_3,_4){
with(_3){
return on;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_5,_6,_7){
with(_5){
if(_5=objj_msgSendSuper({receiver:_5,super_class:objj_getClass("LPSwitch").super_class},"initWithFrame:",_7)){
offBackgroundView=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",objj_msgSend(_5,"bounds"));
objj_msgSend(offBackgroundView,"setHitTests:",NO);
objj_msgSend(_5,"addSubview:",offBackgroundView);
onBackgroundView=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",CGRectMake(0,0,0,CGRectGetHeight(objj_msgSend(_5,"bounds"))));
objj_msgSend(onBackgroundView,"setHitTests:",NO);
objj_msgSend(_5,"addSubview:",onBackgroundView);
knob=objj_msgSend(objj_msgSend(LPSwitchKnob,"alloc"),"initWithFrame:",CGRectMakeZero());
objj_msgSend(_5,"addSubview:",knob);
offLabel=objj_msgSend(CPTextField,"labelWithTitle:","Off");
objj_msgSend(_5,"addSubview:",offLabel);
onLabel=objj_msgSend(CPTextField,"labelWithTitle:","On");
objj_msgSend(_5,"addSubview:",onLabel);
animationDuration=0.2;
animationCurve=CPAnimationEaseOut;
objj_msgSend(_5,"layoutSubviews");
objj_msgSend(_5,"setNeedsLayout");
}
return _5;
}
}),new objj_method(sel_getUid("setOn:animated:"),function(_8,_9,_a,_b){
with(_8){
objj_msgSend(_8,"setOn:animated:sendAction:",_a,_b,YES);
}
}),new objj_method(sel_getUid("setOn:animated:sendAction:"),function(_c,_d,_e,_f,_10){
with(_c){
if(_10&&on!==_e){
on=_e;
objj_msgSend(_c,"sendAction:to:",_action,_target);
}else{
on=_e;
}
var _11=CGRectGetMinY(objj_msgSend(knob,"frame")),_12=CGRectMake((on)?objj_msgSend(knob,"maxX"):objj_msgSend(knob,"minX"),_11,CGRectGetWidth(objj_msgSend(knob,"frame")),CGRectGetHeight(objj_msgSend(knob,"frame"))),_13=CGRectMake(0,0,CGRectGetMinX(_12)+CGRectGetMidX(objj_msgSend(knob,"bounds")),CGRectGetHeight(objj_msgSend(onBackgroundView,"bounds"))),_14=objj_msgSend(_c,"labelOffset"),_15=CGRectMake(CGRectGetMaxX(_12)+_14.width,_14.height,CGRectGetWidth(objj_msgSend(offLabel,"bounds")),CGRectGetHeight(objj_msgSend(offLabel,"bounds"))),_16=CGRectMake(CGRectGetMinX(_12)-_14.width-CGRectGetWidth(objj_msgSend(onLabel,"bounds")),_14.height,CGRectGetWidth(objj_msgSend(onLabel,"bounds")),CGRectGetHeight(objj_msgSend(onLabel,"bounds")));
if(objj_msgSend(animation,"isAnimating")){
objj_msgSend(animation,"stopAnimation");
}
if(_f){
animation=objj_msgSend(objj_msgSend(LPViewAnimation,"alloc"),"initWithViewAnimations:",[{"target":knob,"animations":[[LPOriginAnimationKey,objj_msgSend(knob,"frame").origin,_12.origin]]},{"target":onBackgroundView,"animations":[[LPFrameAnimationKey,objj_msgSend(onBackgroundView,"frame"),_13]]},{"target":offLabel,"animations":[[LPOriginAnimationKey,objj_msgSend(offLabel,"frame").origin,_15.origin]]},{"target":onLabel,"animations":[[LPOriginAnimationKey,objj_msgSend(onLabel,"frame").origin,_16.origin]]}]);
objj_msgSend(animation,"setAnimationCurve:",animationCurve);
objj_msgSend(animation,"setDuration:",animationDuration);
objj_msgSend(animation,"setDelegate:",_c);
objj_msgSend(animation,"startAnimation");
}else{
objj_msgSend(knob,"setFrame:",_12);
objj_msgSend(onBackgroundView,"setFrame:",_13);
objj_msgSend(offLabel,"setFrame:",_15);
}
}
}),new objj_method(sel_getUid("mouseDown:"),function(_17,_18,_19){
with(_17){
if(!objj_msgSend(_17,"isEnabled")){
return;
}
dragStartPoint=objj_msgSend(_17,"convertPoint:fromView:",objj_msgSend(_19,"locationInWindow"),nil);
knobDragStartPoint=objj_msgSend(knob,"frame").origin;
isDragging=NO;
var _1a=objj_msgSend(knob,"convertPoint:fromView:",dragStartPoint,_17).x;
if(_1a>0&&_1a<CGRectGetWidth(objj_msgSend(knob,"bounds"))){
objj_msgSend(knob,"setHighlighted:",YES);
objj_msgSend(_17,"setNeedsLayout");
}
}
}),new objj_method(sel_getUid("mouseDragged:"),function(_1b,_1c,_1d){
with(_1b){
if(!objj_msgSend(_1b,"isEnabled")){
return;
}
isDragging=YES;
var _1e=objj_msgSend(_1b,"convertPoint:fromView:",objj_msgSend(_1d,"locationInWindow"),nil),_1f=knobDragStartPoint.x+(_1e.x-dragStartPoint.x),_20=objj_msgSend(knob,"minX"),_21=objj_msgSend(knob,"maxX"),_22=CGRectGetHeight(objj_msgSend(_1b,"bounds"));
if(_1f<_20){
_1f=_20;
}else{
if(_1f>_21){
_1f=_21;
}
}
objj_msgSend(onBackgroundView,"setFrameSize:",CGSizeMake(_1f+CGRectGetMidX(objj_msgSend(knob,"bounds")),_22));
objj_msgSend(knob,"setFrameOrigin:",CGPointMake(_1f,CGRectGetMinY(objj_msgSend(knob,"frame"))));
objj_msgSend(_1b,"setNeedsLayout");
}
}),new objj_method(sel_getUid("mouseUp:"),function(_23,_24,_25){
with(_23){
if(!objj_msgSend(_23,"isEnabled")){
return;
}
objj_msgSend(_23,"setOn:animated:",isDragging?CGRectGetMidX(objj_msgSend(_23,"bounds"))<CGRectGetMidX(objj_msgSend(knob,"frame")):!on,YES);
objj_msgSend(knob,"setHighlighted:",NO);
objj_msgSend(_23,"setNeedsLayout");
}
}),new objj_method(sel_getUid("labelOffset"),function(_26,_27){
with(_26){
var _28=objj_msgSend(_26,"currentValueForThemeAttribute:","label-offset");
return (_28)?_28:CGSizeMake(0,0);
}
}),new objj_method(sel_getUid("layoutSubviews"),function(_29,_2a){
with(_29){
objj_msgSend(offBackgroundView,"setBackgroundColor:",objj_msgSend(_29,"currentValueForThemeAttribute:","off-background-color"));
objj_msgSend(onBackgroundView,"setBackgroundColor:",objj_msgSend(_29,"currentValueForThemeAttribute:","on-background-color"));
objj_msgSend(knob,"setBackgroundColor:",objj_msgSend(_29,"valueForThemeAttribute:inState:","knob-background-color",objj_msgSend(knob,"themeState")));
objj_msgSend(knob,"setFrameSize:",objj_msgSend(_29,"currentValueForThemeAttribute:","knob-size"));
var _2b=objj_msgSend(_29,"labelOffset");
objj_msgSend(offLabel,"setFont:",objj_msgSend(_29,"currentValueForThemeAttribute:","off-label-font"));
objj_msgSend(offLabel,"setTextColor:",objj_msgSend(_29,"currentValueForThemeAttribute:","off-label-text-color"));
objj_msgSend(offLabel,"setTextShadowColor:",objj_msgSend(_29,"currentValueForThemeAttribute:","off-label-text-shadow-color"));
objj_msgSend(offLabel,"setTextShadowOffset:",objj_msgSend(_29,"currentValueForThemeAttribute:","off-label-text-shadow-offset"));
objj_msgSend(offLabel,"setFrameOrigin:",CGPointMake(CGRectGetMaxX(objj_msgSend(knob,"frame"))+_2b.width,_2b.height));
objj_msgSend(offLabel,"sizeToFit");
objj_msgSend(onLabel,"setFont:",objj_msgSend(_29,"currentValueForThemeAttribute:","on-label-font"));
objj_msgSend(onLabel,"setTextColor:",objj_msgSend(_29,"currentValueForThemeAttribute:","on-label-text-color"));
objj_msgSend(onLabel,"setTextShadowColor:",objj_msgSend(_29,"currentValueForThemeAttribute:","on-label-text-shadow-color"));
objj_msgSend(onLabel,"setTextShadowOffset:",objj_msgSend(_29,"currentValueForThemeAttribute:","on-label-text-shadow-offset"));
objj_msgSend(onLabel,"sizeToFit");
objj_msgSend(onLabel,"setFrameOrigin:",CGPointMake(CGRectGetMinX(objj_msgSend(knob,"frame"))-_2b.width-CGRectGetWidth(objj_msgSend(onLabel,"bounds")),CGRectGetMinY(objj_msgSend(offLabel,"frame"))));
}
}),new objj_method(sel_getUid("setEnabled:"),function(_2c,_2d,_2e){
with(_2c){
if(!_2e){
objj_msgSend(_2c,"setThemeState:",CPThemeStateDisabled);
objj_msgSend(knob,"setThemeState:",CPThemeStateDisabled);
}else{
objj_msgSend(_2c,"unsetThemeState:",CPThemeStateDisabled);
objj_msgSend(knob,"unsetThemeState:",CPThemeStateDisabled);
}
objj_msgSendSuper({receiver:_2c,super_class:objj_getClass("LPSwitch").super_class},"setEnabled:",_2e);
}
}),new objj_method(sel_getUid("setState:"),function(_2f,_30,_31){
with(_2f){
if(_31==CPOnState){
objj_msgSend(_2f,"setOn:animated:sendAction:",YES,YES,NO);
}else{
objj_msgSend(_2f,"setOn:animated:sendAction:",NO,YES,NO);
}
}
}),new objj_method(sel_getUid("state"),function(_32,_33){
with(_32){
return on?CPOnState:CPOffState;
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("themeClass"),function(_34,_35){
with(_34){
return "lp-switch";
}
}),new objj_method(sel_getUid("themeAttributes"),function(_36,_37){
with(_36){
return objj_msgSend(CPDictionary,"dictionaryWithObjects:forKeys:",[objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),CGSizeMake(30,24),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null"),objj_msgSend(CPNull,"null")],["off-background-color","on-background-color","knob-background-color","knob-size","label-offset","off-label-font","off-label-text-color","off-label-text-shadow-color","off-label-text-shadow-offset","on-label-font","on-label-text-color","on-label-text-shadow-color","on-label-text-shadow-offset"]);
}
})]);
var _1=objj_allocateClassPair(CPView,"LPSwitchKnob"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_38,_39,_3a){
with(_38){
if(_38=objj_msgSendSuper({receiver:_38,super_class:objj_getClass("LPSwitchKnob").super_class},"initWithFrame:",_3a)){
objj_msgSend(_38,"setHitTests:",NO);
}
return _38;
}
}),new objj_method(sel_getUid("setHighlighted:"),function(_3b,_3c,_3d){
with(_3b){
isHighlighted=_3d;
if(_3d){
objj_msgSend(_3b,"setThemeState:",CPThemeStateHighlighted);
}else{
objj_msgSend(_3b,"unsetThemeState:",CPThemeStateHighlighted);
}
}
}),new objj_method(sel_getUid("minX"),function(_3e,_3f){
with(_3e){
return 0;
}
}),new objj_method(sel_getUid("maxX"),function(_40,_41){
with(_40){
return CGRectGetWidth(objj_msgSend(objj_msgSend(_40,"superview"),"bounds"))-CGRectGetWidth(objj_msgSend(_40,"bounds"));
}
})]);
p;18;LPURLPostRequest.jt;1235;@STATIC;1.0;I;25;Foundation/CPURLRequest.jt;1186;
objj_executeFile("Foundation/CPURLRequest.j",NO);
var _1=objj_allocateClassPair(CPURLRequest,"LPURLPostRequest"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithURL:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("LPURLPostRequest").super_class},"initWithURL:",_5)){
objj_msgSend(_3,"setHTTPMethod:","POST");
objj_msgSend(_3,"setValue:forHTTPHeaderField:","application/x-www-form-urlencoded","Content-Type");
}
return _3;
}
}),new objj_method(sel_getUid("setContent:"),function(_6,_7,_8){
with(_6){
objj_msgSend(_6,"setContent:escape:",_8,YES);
}
}),new objj_method(sel_getUid("setContent:escape:"),function(_9,_a,_b,_c){
with(_9){
var _d="";
for(key in _b){
_d=objj_msgSend(_d,"stringByAppendingString:",objj_msgSend(CPString,"stringWithFormat:","%s=%s&",key,_c?encodeURIComponent(_b[key]):_b[key]));
}
_d=objj_msgSend(_d,"substringToIndex:",objj_msgSend(_d,"length")-1);
objj_msgSend(_9,"setHTTPBody:",_d);
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("requestWithURL:"),function(_e,_f,_10){
with(_e){
return objj_msgSend(objj_msgSend(_e,"alloc"),"initWithURL:",_10);
}
})]);
p;17;LPViewAnimation.jt;8134;@STATIC;1.0;I;21;Foundation/CPObject.jt;8089;
objj_executeFile("Foundation/CPObject.j",NO);
LPCSSAnimationsAreAvailable=NO;
var _1=["webkit","Moz","moz","o","ms"],_2=nil;
LPFadeAnimationKey="LPFadeAnimation";
LPFrameAnimationKey="LPFrameAnimation";
LPOriginAnimationKey="LPOriginAnimation";
LPTestCSSFeature=function(_3){
if(typeof document==="undefined"){
return NO;
}
if(!_2){
_2=document.createElement("div");
}
var _4=[_3];
for(var i=0;i<_1.length;i++){
_4.push(_1[i]+_3);
}
for(var i=0;i<_4.length;i++){
if(typeof _2.style[_4[i]]!=="undefined"){
return YES;
}
}
return NO;
};
LPCSSAnimationsAreAvailable=LPTestCSSFeature("AnimationName");
var _5=function(_6,_7,_8,_9){
if(_9){
_6.style[_8]=_6.style[_8]+", "+_7;
}else{
_6.style[_8]=_7;
}
};
var _a=objj_allocateClassPair(CPAnimation,"LPViewAnimation"),_b=_a.isa;
class_addIvars(_a,[new objj_ivar("_isAnimating"),new objj_ivar("_viewAnimations"),new objj_ivar("_animationDidEndTimeout"),new objj_ivar("_shouldUseCSSAnimations"),new objj_ivar("_c1"),new objj_ivar("_c2")]);
objj_registerClassPair(_a);
class_addMethods(_a,[new objj_method(sel_getUid("viewAnimations"),function(_c,_d){
with(_c){
return _viewAnimations;
}
}),new objj_method(sel_getUid("setViewAnimations:"),function(_e,_f,_10){
with(_e){
_viewAnimations=_10;
}
}),new objj_method(sel_getUid("shouldUseCSSAnimations"),function(_11,_12){
with(_11){
return _shouldUseCSSAnimations;
}
}),new objj_method(sel_getUid("setShouldUseCSSAnimations:"),function(_13,_14,_15){
with(_13){
_shouldUseCSSAnimations=_15;
}
}),new objj_method(sel_getUid("initWithViewAnimations:"),function(_16,_17,_18){
with(_16){
if(_16=objj_msgSend(_16,"initWithDuration:animationCurve:",1,CPAnimationLinear)){
_isAnimating=NO;
_viewAnimations=_18;
_shouldUseCSSAnimations=NO;
}
return _16;
}
}),new objj_method(sel_getUid("setAnimationCurve:"),function(_19,_1a,_1b){
with(_19){
objj_msgSendSuper({receiver:_19,super_class:objj_getClass("LPViewAnimation").super_class},"setAnimationCurve:",_1b);
_c1=[];
_c2=[];
objj_msgSend(_timingFunction,"getControlPointAtIndex:values:",1,_c1);
objj_msgSend(_timingFunction,"getControlPointAtIndex:values:",2,_c2);
}
}),new objj_method(sel_getUid("startAnimation"),function(_1c,_1d){
with(_1c){
if(LPCSSAnimationsAreAvailable&&_shouldUseCSSAnimations){
if(_isAnimating){
return;
}
_isAnimating=YES;
var i=_viewAnimations.length;
while(i--){
var _1e=_viewAnimations[i],_1f=_1e["target"];
objj_msgSend(_1c,"target:setCSSAnimationDuration:",_1f,_duration);
objj_msgSend(_1c,"target:setCSSAnimationCurve:",_1f,_animationCurve);
var x=_1e["animations"].length;
while(x--){
var _20=_1e["animations"][x],_21=_20[0],_22=_20[1],end=_20[2];
if(_21===LPFadeAnimationKey){
objj_msgSend(_1f,"setAlphaValue:",_22);
objj_msgSend(_1c,"target:addCSSAnimationPropertyForKey:append:",_1f,_21,x!==0);
setTimeout(function(_23,_24){
_23._DOMElement.style["-webkit-transform"]="translate3d(0px, 0px, 0px)";
objj_msgSend(_23,"setAlphaValue:",_24);
},0,_1f,end);
}else{
if(_21===LPOriginAnimationKey){
if(!CGPointEqualToPoint(_22,end)){
objj_msgSend(_1f,"setFrameOrigin:",_22);
objj_msgSend(_1c,"target:addCSSAnimationPropertyForKey:append:",_1f,_21,x!==0);
setTimeout(function(_25,_26,_27){
var x=_27.x-_26.x,y=_27.y-_26.y;
_25._DOMElement.style["-webkit-transform"]="translate3d("+x+"px, "+y+"px, 0px)";
setTimeout(function(){
objj_msgSend(_1c,"_clearCSS");
_25._DOMElement.style["-webkit-transform"]="translate3d(0px, 0px, 0px)";
objj_msgSend(_25,"setFrameOrigin:",_27);
},(1000*_duration)+100);
},0,_1f,_22,end);
}
}else{
if(_21===LPFrameAnimationKey){
CPLog.error("LPViewAnimation does not currently support CSS frame animations. This should fall back to the regular javascript animation.");
}
}
}
}
}
if(_animationDidEndTimeout){
clearTimeout(_animationDidEndTimeout);
}
_animationDidEndTimeout=setTimeout(function(_28){
_isAnimating=NO;
objj_msgSend(_28,"_clearCSS");
if(objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("animationDidEnd:"))){
objj_msgSend(_delegate,"animationDidEnd:",_28);
}
},(1000*_duration)+100,_1c);
}else{
var i=_viewAnimations.length;
while(i--){
var _1e=_viewAnimations[i],_1f=_1e["target"];
var x=_1e["animations"].length;
while(x--){
var _20=_1e["animations"][x],_21=_20[0],_22=_20[1],end=_20[2];
switch(_21){
case LPFadeAnimationKey:
objj_msgSend(_1f,"setAlphaValue:",_22);
break;
case LPOriginAnimationKey:
objj_msgSend(_1f,"setFrameOrigin:",_22);
break;
case LPFrameAnimationKey:
objj_msgSend(_1f,"setFrame:",_22);
break;
}
}
}
objj_msgSendSuper({receiver:_1c,super_class:objj_getClass("LPViewAnimation").super_class},"startAnimation");
}
}
}),new objj_method(sel_getUid("setCurrentProgress:"),function(_29,_2a,_2b){
with(_29){
_progress=_2b;
var _2c=_2d(_progress,_c1[0],_c1[1],_c2[0],_c2[1],_duration),i=_viewAnimations.length;
while(i--){
var _2e=_viewAnimations[i],_2f=_2e["target"],x=_2e["animations"].length;
while(x--){
var _30=_2e["animations"][x],_31=_30[0],_32=_30[1],end=_30[2];
switch(_31){
case LPFadeAnimationKey:
objj_msgSend(_2f,"setAlphaValue:",(_2c*(end-_32))+_32);
break;
case LPOriginAnimationKey:
objj_msgSend(_2f,"setFrameOrigin:",CGPointMake(_32.x+(_2c*(end.x-_32.x)),_32.y+(_2c*(end.y-_32.y))));
break;
case LPFrameAnimationKey:
objj_msgSend(_2f,"setFrame:",CGRectMake(_32.origin.x+(_2c*(end.origin.x-_32.origin.x)),_32.origin.y+(_2c*(end.origin.y-_32.origin.y)),_32.size.width+(_2c*(end.size.width-_32.size.width)),_32.size.height+(_2c*(end.size.height-_32.size.height))));
}
}
}
}
}),new objj_method(sel_getUid("isAnimating"),function(_33,_34){
with(_33){
if(LPCSSAnimationsAreAvailable&&_shouldUseCSSAnimations){
return _isAnimating;
}else{
return objj_msgSendSuper({receiver:_33,super_class:objj_getClass("LPViewAnimation").super_class},"isAnimating");
}
}
}),new objj_method(sel_getUid("stopAnimation"),function(_35,_36){
with(_35){
if(LPCSSAnimationsAreAvailable&&_shouldUseCSSAnimations){
}else{
objj_msgSendSuper({receiver:_35,super_class:objj_getClass("LPViewAnimation").super_class},"stopAnimation");
}
}
}),new objj_method(sel_getUid("_clearCSS"),function(_37,_38){
with(_37){
for(var i=0;i<_viewAnimations.length;i++){
_viewAnimations[i]["target"]._DOMElement.style["-webkit-transition-property"]="none";
}
}
}),new objj_method(sel_getUid("target:setCSSAnimationDuration:"),function(_39,_3a,_3b,_3c){
with(_39){
_3b._DOMElement.style["-webkit-transition-duration"]=_3c+"s";
}
}),new objj_method(sel_getUid("target:setCSSAnimationCurve:"),function(_3d,_3e,_3f,_40){
with(_3d){
var _41=nil;
switch(_40){
case CPAnimationLinear:
_41="linear";
break;
case CPAnimationEaseIn:
_41="ease-in";
break;
case CPAnimationEaseOut:
_41="ease-out";
break;
case CPAnimationEaseInOut:
_41="ease-in-out";
break;
}
_3f._DOMElement.style["-webkit-transition-timing-function"]=_41;
}
}),new objj_method(sel_getUid("target:addCSSAnimationPropertyForKey:append:"),function(_42,_43,_44,_45,_46){
with(_42){
var _47=nil;
switch(_45){
case LPFadeAnimationKey:
_47="-webkit-transform, opacity";
break;
case LPOriginAnimationKey:
_47="-webkit-transform";
break;
case LPFrameAnimationKey:
_47="top, left, width, height";
break;
default:
_47="none";
}
_5(_44._DOMElement,_47,"-webkit-transition-property",_46);
}
})]);
var _2d=_2d=function(t,p1x,p1y,p2x,p2y,_48){
var ax=0,bx=0,cx=0,ay=0,by=0,cy=0;
sampleCurveX=function(t){
return ((ax*t+bx)*t+cx)*t;
};
sampleCurveY=function(t){
return ((ay*t+by)*t+cy)*t;
};
sampleCurveDerivativeX=function(t){
return (3*ax*t+2*bx)*t+cx;
};
solveEpsilon=function(_49){
return 1/(200*_49);
};
solve=function(x,_4a){
return sampleCurveY(solveCurveX(x,_4a));
};
solveCurveX=function(x,_4b){
var t0,t1,t2,x2,d2,i;
fabs=function(n){
if(n>=0){
return n;
}else{
return 0-n;
}
};
for(t2=x,i=0;i<8;i++){
x2=sampleCurveX(t2)-x;
if(fabs(x2)<_4b){
return t2;
}
d2=sampleCurveDerivativeX(t2);
if(fabs(d2)<0.000001){
break;
}
t2=t2-x2/d2;
}
t0=0;
t1=1;
t2=x;
if(t2<t0){
return t0;
}
if(t2>t1){
return t1;
}
while(t0<t1){
x2=sampleCurveX(t2);
if(fabs(x2-x)<_4b){
return t2;
}
if(x>x2){
t0=t2;
}else{
t1=t2;
}
t2=(t1-t0)*0.5+t0;
}
return t2;
};
cx=3*p1x;
bx=3*(p2x-p1x)-cx;
ax=1-cx-bx;
cy=3*p1y;
by=3*(p2y-p1y)-cy;
ay=1-cy-by;
return solve(t,solveEpsilon(_48));
};
e;