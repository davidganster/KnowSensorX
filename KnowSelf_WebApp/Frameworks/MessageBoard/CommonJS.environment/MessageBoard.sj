@STATIC;1.0;p;14;MessageBoard.jt;200;@STATIC;1.0;i;13;TNStackView.ji;16;TNMessageBoard.ji;15;TNMessageView.jt;123;
objj_executeFile("TNStackView.j",YES);
objj_executeFile("TNMessageBoard.j",YES);
objj_executeFile("TNMessageView.j",YES);
p;16;TNMessageBoard.jt;3545;@STATIC;1.0;I;23;Foundation/Foundation.jI;22;AppKit/CPTableColumn.jI;20;AppKit/CPTableView.ji;15;TNMessageView.jt;3426;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/CPTableColumn.j",NO);
objj_executeFile("AppKit/CPTableView.j",NO);
objj_executeFile("TNMessageView.j",YES);
var _1=objj_allocateClassPair(CPTableView,"TNMessageBoard"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_messages"),new objj_ivar("_dataView")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("TNMessageBoard").super_class},"initWithFrame:",_5)){
_messages=objj_msgSend(CPArray,"array");
objj_msgSend(_3,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_3,"setColumnAutoresizingStyle:",CPTableViewLastColumnOnlyAutoresizingStyle);
objj_msgSend(_3,"setAllowsColumnReordering:",NO);
objj_msgSend(_3,"setAllowsColumnResizing:",NO);
objj_msgSend(_3,"setAllowsEmptySelection:",YES);
objj_msgSend(_3,"setAllowsMultipleSelection:",NO);
objj_msgSend(_3,"setDataSource:",_3);
objj_msgSend(_3,"setDelegate:",_3);
objj_msgSend(_3,"setHeaderView:",nil);
objj_msgSend(_3,"setCornerView:",nil);
var _6=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","messages");
objj_msgSend(_6,"setWidth:",800);
objj_msgSend(objj_msgSend(_6,"headerView"),"setStringValue:","Messages");
objj_msgSend(_3,"addTableColumn:",_6);
_dataView=objj_msgSend(objj_msgSend(TNMessageView,"alloc"),"initWithFrame:",CPRectMake(0,0,100,100));
}
return _3;
}
}),new objj_method(sel_getUid("addMessage:from:date:color:"),function(_7,_8,_9,_a,_b,_c){
with(_7){
objj_msgSend(_7,"addMessage:from:date:color:avatar:position:",_9,_a,_b,_c,nil,nil);
}
}),new objj_method(sel_getUid("addMessage:from:date:color:avatar:position:"),function(_d,_e,_f,_10,_11,_12,_13,_14){
with(_d){
var _15=objj_msgSend(CPDictionary,"dictionaryWithObjectsAndKeys:",_10,"author",_f,"message",_11,"date",_14,"position",_12,"color",_13,"avatar");
objj_msgSend(_messages,"addObject:",_15);
objj_msgSend(_d,"reloadData");
}
}),new objj_method(sel_getUid("reload"),function(_16,_17){
with(_16){
CPLog.warn("TNMessageBoard reload is deprecated. please use reloadData");
objj_msgSend(_16,"reloadData");
}
}),new objj_method(sel_getUid("removeAllMessages:"),function(_18,_19,_1a){
with(_18){
CPLog.warn("TNMessageBoard removeAllMessages: is deprecated. please use removeAllViews:");
objj_msgSend(_18,"removeAllViews:",_1a);
}
}),new objj_method(sel_getUid("removeAllViews:"),function(_1b,_1c,_1d){
with(_1b){
objj_msgSend(_messages,"removeAllObjects");
objj_msgSend(_1b,"reloadData");
}
}),new objj_method(sel_getUid("numberOfRowsInTableView:"),function(_1e,_1f,_20){
with(_1e){
return objj_msgSend(_messages,"count");
}
}),new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"),function(_21,_22,_23,_24,_25){
with(_21){
return objj_msgSend(_messages,"objectAtIndex:",_25);
}
}),new objj_method(sel_getUid("tableView:dataViewForTableColumn:row:"),function(_26,_27,_28,_29,_2a){
with(_26){
return _dataView;
}
}),new objj_method(sel_getUid("tableView:heightOfRow:"),function(_2b,_2c,_2d,_2e){
with(_2b){
return objj_msgSend(TNMessageView,"sizeOfMessageViewWithText:inWidth:",objj_msgSend(objj_msgSend(_messages,"objectAtIndex:",_2e),"objectForKey:","message"),(objj_msgSend(_2b,"frameSize").width));
}
}),new objj_method(sel_getUid("tableView:shouldSelectRow:"),function(_2f,_30,_31,_32){
with(_2f){
return NO;
}
})]);
p;15;TNMessageView.jt;20094;@STATIC;1.0;I;23;Foundation/Foundation.jI;16;AppKit/CPColor.jI;16;AppKit/CPImage.jI;20;AppKit/CPImageView.jI;20;AppKit/CPImageView.jI;20;AppKit/CPTextField.jt;19929;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/CPColor.j",NO);
objj_executeFile("AppKit/CPImage.j",NO);
objj_executeFile("AppKit/CPImageView.j",NO);
objj_executeFile("AppKit/CPImageView.j",NO);
objj_executeFile("AppKit/CPTextField.j",NO);
TNMessageViewAvatarPositionRight="TNMessageViewAvatarPositionRight";
TNMessageViewAvatarPositionLeft="TNMessageViewAvatarPositionLeft";
TNMessageViewBubbleColorNormal=1;
TNMessageViewBubbleColorAlt=2;
TNMessageViewBubbleColorNotice=3;
var _1=objj_allocateClassPair(CPView,"TNMessageView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_imageDefaultAvatar"),new objj_ivar("_imageViewAvatar"),new objj_ivar("_author"),new objj_ivar("_message"),new objj_ivar("_subject"),new objj_ivar("_timestamp"),new objj_ivar("_fieldAuthor"),new objj_ivar("_fieldTimestamp"),new objj_ivar("_viewContainer"),new objj_ivar("_bgColor"),new objj_ivar("_position"),new objj_ivar("_fieldMessage")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("TNMessageView").super_class},"initWithFrame:",_5)){
_author="";
_subject="";
_message="";
_timestamp="";
_bgColor=TNMessageViewBubbleColorNormal;
objj_msgSend(_3,"setAutoresizingMask:",CPViewWidthSizable);
var _6=objj_msgSend(CPBundle,"bundleForClass:",objj_msgSend(_3,"class"));
_imageDefaultAvatar=objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(_6,"pathForResource:","user-unknown.png"),CPSizeMake(36,36));
_position=TNMessageViewAvatarPositionLeft;
_viewContainer=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",CGRectMake(50,10,CGRectGetWidth(_5)-60,80));
objj_msgSend(_viewContainer,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
_imageViewAvatar=objj_msgSend(objj_msgSend(CPImageView,"alloc"),"initWithFrame:",CGRectMake(6,CGRectGetHeight(_5)-46,36,36));
objj_msgSend(_imageViewAvatar,"setImageScaling:",CPScaleProportionally);
objj_msgSend(_imageViewAvatar,"setImage:",_imageDefaultAvatar);
_fieldAuthor=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(20,10,CGRectGetWidth(objj_msgSend(_viewContainer,"frame"))-30,20));
objj_msgSend(_fieldAuthor,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12));
objj_msgSend(_fieldAuthor,"setTextColor:",objj_msgSend(CPColor,"grayColor"));
objj_msgSend(_fieldAuthor,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(_fieldAuthor,"setSelectable:",YES);
_fieldMessage=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(20,30,CGRectGetWidth(objj_msgSend(_viewContainer,"frame"))-40,CGRectGetHeight(objj_msgSend(_viewContainer,"frame"))));
objj_msgSend(_fieldMessage,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_fieldMessage,"setLineBreakMode:",CPLineBreakByWordWrapping);
objj_msgSend(_fieldMessage,"setSelectable:",YES);
_fieldTimestamp=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(CGRectGetWidth(objj_msgSend(_viewContainer,"frame"))-210,10,190,20));
objj_msgSend(_fieldTimestamp,"setAutoresizingMask:",CPViewMinXMargin);
objj_msgSend(_fieldTimestamp,"setValue:forThemeAttribute:inState:",objj_msgSend(CPColor,"colorWithHexString:","f2f0e4"),"text-shadow-color",CPThemeStateNormal);
objj_msgSend(_fieldTimestamp,"setValue:forThemeAttribute:inState:",objj_msgSend(CPFont,"systemFontOfSize:",9),"font",CPThemeStateNormal);
objj_msgSend(_fieldTimestamp,"setValue:forThemeAttribute:inState:",objj_msgSend(CPColor,"colorWithHexString:","808080"),"text-color",CPThemeStateNormal);
objj_msgSend(_fieldTimestamp,"setAlignment:",CPRightTextAlignment);
objj_msgSend(_fieldTimestamp,"setSelectable:",YES);
objj_msgSend(_viewContainer,"addSubview:",_fieldAuthor);
objj_msgSend(_viewContainer,"addSubview:",_fieldMessage);
objj_msgSend(_viewContainer,"addSubview:",_fieldTimestamp);
objj_msgSend(_3,"addSubview:",_imageViewAvatar);
objj_msgSend(_3,"addSubview:",_viewContainer);
}
return _3;
}
}),new objj_method(sel_getUid("setObjectValue:"),function(_7,_8,_9){
with(_7){
objj_msgSend(_fieldAuthor,"setStringValue:",objj_msgSend(_9,"objectForKey:","author"));
objj_msgSend(_fieldMessage,"setStringValue:",objj_msgSend(_9,"objectForKey:","message"));
objj_msgSend(_fieldTimestamp,"setStringValue:",objj_msgSend(_9,"objectForKey:","date"));
objj_msgSend(_imageViewAvatar,"setImage:",objj_msgSend(_9,"objectForKey:","avatar")||_imageDefaultAvatar);
_position=objj_msgSend(_9,"objectForKey:","position")||TNMessageViewAvatarPositionLeft;
_bgColor=objj_msgSend(_9,"objectForKey:","color")||TNMessageViewBubbleColorNormal;
CPLog.debug(_9);
objj_msgSend(_7,"layout");
}
}),new objj_method(sel_getUid("layout"),function(_a,_b){
with(_a){
switch(_position){
case TNMessageViewAvatarPositionLeft:
objj_msgSend(_viewContainer,"setFrameOrigin:",CPPointMake(50,10));
objj_msgSend(_imageViewAvatar,"setFrame:",CGRectMake(6,CGRectGetHeight(objj_msgSend(_a,"frame"))-46,36,36));
objj_msgSend(_imageViewAvatar,"setAutoresizingMask:",CPViewMinYMargin);
break;
case TNMessageViewAvatarPositionRight:
objj_msgSend(_viewContainer,"setFrameOrigin:",CPPointMake(10,10));
objj_msgSend(_imageViewAvatar,"setFrame:",CGRectMake(CGRectGetWidth(objj_msgSend(_a,"frame"))-46,CGRectGetHeight(objj_msgSend(_a,"frame"))-46,36,36));
objj_msgSend(_imageViewAvatar,"setAutoresizingMask:",CPViewMinXMargin|CPViewMinYMargin);
break;
}
switch(_bgColor){
case TNMessageViewBubbleColorNormal:
objj_msgSend(_viewContainer,"setBackgroundColor:",(_position==TNMessageViewAvatarPositionLeft)?_c:_d);
break;
case TNMessageViewBubbleColorAlt:
objj_msgSend(_viewContainer,"setBackgroundColor:",(_position==TNMessageViewAvatarPositionLeft)?_e:_f);
break;
case TNMessageViewBubbleColorNotice:
objj_msgSend(_viewContainer,"setBackgroundColor:",(_position==TNMessageViewAvatarPositionLeft)?_10:_11);
break;
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("sizeOfMessageViewWithText:inWidth:"),function(_12,_13,_14,_15){
with(_12){
var _16=objj_msgSend(_14,"sizeWithFont:inWidth:",objj_msgSend(CPFont,"systemFontOfSize:",12),(_15-100));
return _16.height+65;
}
})]);
var _1=objj_getClass("TNMessageView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"TNMessageView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_17,_18,_19){
with(_17){
if(_17=objj_msgSendSuper({receiver:_17,super_class:objj_getClass("TNMessageView").super_class},"initWithCoder:",_19)){
_author=objj_msgSend(_19,"decodeObjectForKey:","_author");
_bgColor=objj_msgSend(_19,"decodeObjectForKey:","_bgColor");
_fieldAuthor=objj_msgSend(_19,"decodeObjectForKey:","_fieldAuthor");
_fieldMessage=objj_msgSend(_19,"decodeObjectForKey:","_fieldMessage");
_fieldTimestamp=objj_msgSend(_19,"decodeObjectForKey:","_fieldTimestamp");
_imageDefaultAvatar=objj_msgSend(_19,"decodeObjectForKey:","_imageDefaultAvatar");
_imageViewAvatar=objj_msgSend(_19,"decodeObjectForKey:","_imageViewAvatar");
_message=objj_msgSend(_19,"decodeObjectForKey:","_message");
_position=objj_msgSend(_19,"decodeObjectForKey:","_position");
_subject=objj_msgSend(_19,"decodeObjectForKey:","_subject");
_timestamp=objj_msgSend(_19,"decodeObjectForKey:","_timestamp");
_viewContainer=objj_msgSend(_19,"decodeObjectForKey:","_viewContainer");
}
return _17;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_1a,_1b,_1c){
with(_1a){
objj_msgSendSuper({receiver:_1a,super_class:objj_getClass("TNMessageView").super_class},"encodeWithCoder:",_1c);
objj_msgSend(_1c,"encodeObject:forKey:",_author,"_author");
objj_msgSend(_1c,"encodeObject:forKey:",_bgColor,"_bgColor");
objj_msgSend(_1c,"encodeObject:forKey:",_fieldAuthor,"_fieldAuthor");
objj_msgSend(_1c,"encodeObject:forKey:",_fieldMessage,"_fieldMessage");
objj_msgSend(_1c,"encodeObject:forKey:",_fieldTimestamp,"_fieldTimestamp");
objj_msgSend(_1c,"encodeObject:forKey:",_imageDefaultAvatar,"_imageDefaultAvatar");
objj_msgSend(_1c,"encodeObject:forKey:",_imageViewAvatar,"_imageViewAvatar");
objj_msgSend(_1c,"encodeObject:forKey:",_message,"_message");
objj_msgSend(_1c,"encodeObject:forKey:",_position,"_position");
objj_msgSend(_1c,"encodeObject:forKey:",_subject,"_subject");
objj_msgSend(_1c,"encodeObject:forKey:",_timestamp,"_timestamp");
objj_msgSend(_1c,"encodeObject:forKey:",_viewContainer,"_viewContainer");
}
})]);
var _c=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPNinePartImage,"alloc"),"initWithImageSlices:",[objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/1.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/2.png"),CPSizeMake(1,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/3.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/4.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/5.png"),CPSizeMake(1,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/6.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/7.png"),CPSizeMake(24,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/8.png"),CPSizeMake(1,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/9.png"),CPSizeMake(24,16)),])),_e=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPNinePartImage,"alloc"),"initWithImageSlices:",[objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/1.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/2.png"),CPSizeMake(1,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/3.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/4.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/5.png"),CPSizeMake(1,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/6.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/7.png"),CPSizeMake(24,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/8.png"),CPSizeMake(1,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/9.png"),CPSizeMake(24,16)),])),_10=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPNinePartImage,"alloc"),"initWithImageSlices:",[objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/1.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/2.png"),CPSizeMake(1,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/3.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/4.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/5.png"),CPSizeMake(1,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/6.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/7.png"),CPSizeMake(24,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/8.png"),CPSizeMake(1,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/9.png"),CPSizeMake(24,16)),])),_d=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPNinePartImage,"alloc"),"initWithImageSlices:",[objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/1.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/2.png"),CPSizeMake(1,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/3.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/4.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/5.png"),CPSizeMake(1,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/6.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/7-alt.png"),CPSizeMake(24,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/8.png"),CPSizeMake(1,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","Bubble/9-alt.png"),CPSizeMake(24,16)),])),_f=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPNinePartImage,"alloc"),"initWithImageSlices:",[objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/1.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/2.png"),CPSizeMake(1,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/3.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/4.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/5.png"),CPSizeMake(1,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/6.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/7-alt.png"),CPSizeMake(24,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/8.png"),CPSizeMake(1,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleAlt/9-alt.png"),CPSizeMake(24,16)),])),_11=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPNinePartImage,"alloc"),"initWithImageSlices:",[objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/1.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/2.png"),CPSizeMake(1,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/3.png"),CPSizeMake(24,14)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/4.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/5.png"),CPSizeMake(1,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/6.png"),CPSizeMake(24,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/7-alt.png"),CPSizeMake(24,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/8.png"),CPSizeMake(1,16)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:",objj_msgSend(objj_msgSend(CPBundle,"bundleForClass:",TNMessageView),"pathForResource:","BubbleNotice/9-alt.png"),CPSizeMake(24,16)),]));
p;13;TNStackView.jt;3530;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/CPView.jt;3463;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/CPView.j",NO);
var _1=objj_allocateClassPair(CPView,"TNStackView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_dataSource"),new objj_ivar("_padding"),new objj_ivar("_reversed"),new objj_ivar("_stackedViews")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("dataSource"),function(_3,_4){
with(_3){
return _dataSource;
}
}),new objj_method(sel_getUid("setDataSource:"),function(_5,_6,_7){
with(_5){
_dataSource=_7;
}
}),new objj_method(sel_getUid("padding"),function(_8,_9){
with(_8){
return _padding;
}
}),new objj_method(sel_getUid("setPadding:"),function(_a,_b,_c){
with(_a){
_padding=_c;
}
}),new objj_method(sel_getUid("isReversed"),function(_d,_e){
with(_d){
return _reversed;
}
}),new objj_method(sel_getUid("setReversed:"),function(_f,_10,_11){
with(_f){
_reversed=_11;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_12,_13,_14){
with(_12){
if(_12=objj_msgSendSuper({receiver:_12,super_class:objj_getClass("TNStackView").super_class},"initWithFrame:",_14)){
_dataSource=objj_msgSend(CPArray,"array");
_stackedViews=objj_msgSend(CPArray,"array");
_padding=0;
_reversed=NO;
objj_msgSend(_12,"setAutoresizingMask:",CPViewWidthSizable);
}
return _12;
}
}),new objj_method(sel_getUid("_nextPosition"),function(_15,_16){
with(_15){
var _17=objj_msgSend(_stackedViews,"lastObject"),_18;
if(_17){
_18=objj_msgSend(_17,"frame");
_18.origin.y=CPRectGetMaxY(_18)+_padding;
_18.origin.x=_padding;
}else{
_18=CGRectMake(_padding,_padding,CPRectGetWidth(objj_msgSend(_15,"bounds"))-(_padding*2),0);
}
return _18;
}
}),new objj_method(sel_getUid("reload"),function(_19,_1a){
with(_19){
var _1b=objj_msgSend(_19,"frame");
_1b.size.height=0;
objj_msgSend(_19,"setFrame:",_1b);
for(var i=0;i<objj_msgSend(_dataSource,"count");i++){
var _1c=objj_msgSend(_dataSource,"objectAtIndex:",i);
if(objj_msgSend(_1c,"superview")){
objj_msgSend(_1c,"removeFromSuperview");
}
}
objj_msgSend(_stackedViews,"removeAllObjects");
objj_msgSend(_19,"layout");
}
}),new objj_method(sel_getUid("layout"),function(_1d,_1e){
with(_1d){
var _1f=objj_msgSend(_1d,"frame"),_20=_reversed?objj_msgSend(_dataSource,"copy").reverse():_dataSource;
_1f.size.height=0;
for(var i=0;i<objj_msgSend(_20,"count");i++){
var _21=objj_msgSend(_20,"objectAtIndex:",i),_22=objj_msgSend(_1d,"_nextPosition");
_22.size.height=objj_msgSend(_21,"frameSize").height;
objj_msgSend(_21,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(_21,"setFrame:",_22);
if(objj_msgSend(_21,"respondsToSelector:",sel_getUid("layout"))){
objj_msgSend(_21,"layout");
}
objj_msgSend(_1d,"addSubview:",_21);
objj_msgSend(_stackedViews,"addObject:",_21);
_1f.size.height+=objj_msgSend(_21,"frame").size.height+_padding;
}
_1f.size.height+=_padding;
objj_msgSend(_1d,"setFrame:",_1f);
}
}),new objj_method(sel_getUid("removeAllViews:"),function(_23,_24,_25){
with(_23){
for(var i=0;i<objj_msgSend(_dataSource,"count");i++){
objj_msgSend(objj_msgSend(_dataSource,"objectAtIndex:",i),"removeFromSuperview");
}
objj_msgSend(_dataSource,"removeAllObjects");
objj_msgSend(_23,"reload");
}
}),new objj_method(sel_getUid("removeView:"),function(_26,_27,_28){
with(_26){
objj_msgSend(_28,"removeFromSuperview");
objj_msgSend(_dataSource,"removeObject:",_28);
objj_msgSend(_26,"reload");
}
}),new objj_method(sel_getUid("reverse:"),function(_29,_2a,_2b){
with(_29){
_reversed=!_reversed;
objj_msgSend(_29,"reload");
}
})]);
e;