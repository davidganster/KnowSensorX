var ObjectiveJ={};
(function(_1,_2){
if(!this.JSON){
JSON={};
}
(function(){
function f(n){
return n<10?"0"+n:n;
};
if(typeof Date.prototype.toJSON!=="function"){
Date.prototype.toJSON=function(_3){
return this.getUTCFullYear()+"-"+f(this.getUTCMonth()+1)+"-"+f(this.getUTCDate())+"T"+f(this.getUTCHours())+":"+f(this.getUTCMinutes())+":"+f(this.getUTCSeconds())+"Z";
};
String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(_4){
return this.valueOf();
};
}
var cx=new RegExp("[\\u0000\\u00ad\\u0600-\\u0604\\u070f\\u17b4\\u17b5\\u200c-\\u200f\\u2028-\\u202f\\u2060-\\u206f\\ufeff\\ufff0-\\uffff]","g");
var _5=new RegExp("[\\\\\\\"\\x00-\\x1f\\x7f-\\x9f\\u00ad\\u0600-\\u0604\\u070f\\u17b4\\u17b5\\u200c-\\u200f\\u2028-\\u202f\\u2060-\\u206f\\ufeff\\ufff0-\\uffff]","g");
var _6,_7,_8={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r","\"":"\\\"","\\":"\\\\"},_9;
function _a(_b){
_5.lastIndex=0;
return _5.test(_b)?"\""+_b.replace(_5,function(a){
var c=_8[a];
return typeof c==="string"?c:"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4);
})+"\"":"\""+_b+"\"";
};
function _c(_d,_e){
var i,k,v,_f,_10=_6,_11,_12=_e[_d];
if(_12&&typeof _12==="object"&&typeof _12.toJSON==="function"){
_12=_12.toJSON(_d);
}
if(typeof _9==="function"){
_12=_9.call(_e,_d,_12);
}
switch(typeof _12){
case "string":
return _a(_12);
case "number":
return isFinite(_12)?String(_12):"null";
case "boolean":
case "null":
return String(_12);
case "object":
if(!_12){
return "null";
}
_6+=_7;
_11=[];
if(Object.prototype.toString.apply(_12)==="[object Array]"){
_f=_12.length;
for(i=0;i<_f;i+=1){
_11[i]=_c(i,_12)||"null";
}
v=_11.length===0?"[]":_6?"[\n"+_6+_11.join(",\n"+_6)+"\n"+_10+"]":"["+_11.join(",")+"]";
_6=_10;
return v;
}
if(_9&&typeof _9==="object"){
_f=_9.length;
for(i=0;i<_f;i+=1){
k=_9[i];
if(typeof k==="string"){
v=_c(k,_12);
if(v){
_11.push(_a(k)+(_6?": ":":")+v);
}
}
}
}else{
for(k in _12){
if(Object.hasOwnProperty.call(_12,k)){
v=_c(k,_12);
if(v){
_11.push(_a(k)+(_6?": ":":")+v);
}
}
}
}
v=_11.length===0?"{}":_6?"{\n"+_6+_11.join(",\n"+_6)+"\n"+_10+"}":"{"+_11.join(",")+"}";
_6=_10;
return v;
}
};
if(typeof JSON.stringify!=="function"){
JSON.stringify=function(_13,_14,_15){
var i;
_6="";
_7="";
if(typeof _15==="number"){
for(i=0;i<_15;i+=1){
_7+=" ";
}
}else{
if(typeof _15==="string"){
_7=_15;
}
}
_9=_14;
if(_14&&typeof _14!=="function"&&(typeof _14!=="object"||typeof _14.length!=="number")){
throw new Error("JSON.stringify");
}
return _c("",{"":_13});
};
}
if(typeof JSON.parse!=="function"){
JSON.parse=function(_16,_17){
var j;
function _18(_19,key){
var k,v,_1a=_19[key];
if(_1a&&typeof _1a==="object"){
for(k in _1a){
if(Object.hasOwnProperty.call(_1a,k)){
v=_18(_1a,k);
if(v!==_29){
_1a[k]=v;
}else{
delete _1a[k];
}
}
}
}
return _17.call(_19,key,_1a);
};
cx.lastIndex=0;
if(cx.test(_16)){
_16=_16.replace(cx,function(a){
return "\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4);
});
}
if(/^[\],:{}\s]*$/.test(_16.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,"]").replace(/(?:^|:|,)(?:\s*\[)+/g,""))){
j=eval("("+_16+")");
return typeof _17==="function"?_18({"":j},""):j;
}
throw new SyntaxError("JSON.parse");
};
}
}());
var _1b=new RegExp("([^%]+|%(?:\\d+\\$)?[\\+\\-\\ \\#0]*[0-9\\*]*(.[0-9\\*]+)?[hlL]?[cbBdieEfgGosuxXpn%@])","g");
var _1c=new RegExp("(%)(?:(\\d+)\\$)?([\\+\\-\\ \\#0]*)([0-9\\*]*)((?:.[0-9\\*]+)?)([hlL]?)([cbBdieEfgGosuxXpn%@])");
_2.sprintf=function(_1d){
var _1d=arguments[0],_1e=_1d.match(_1b),_1f=0,_20="",arg=1;
for(var i=0;i<_1e.length;i++){
var t=_1e[i];
if(_1d.substring(_1f,_1f+t.length)!=t){
return _20;
}
_1f+=t.length;
if(t.charAt(0)!=="%"){
_20+=t;
}else{
if(t==="%%"){
_20+="%";
}else{
var _21=t.match(_1c);
if(_21.length!=8||_21[0]!=t){
return _20;
}
var _22=_21[1],_23=_21[2],_24=_21[3],_25=_21[4],_26=_21[5],_27=_21[6],_28=_21[7];
if(_23===_29||_23===null||_23===""){
_23=arg++;
}else{
_23=Number(_23);
}
var _2a=null;
if(_25=="*"){
_2a=arguments[_23];
}else{
if(_25!=""){
_2a=Number(_25);
}
}
var _2b=null;
if(_26==".*"){
_2b=arguments[_23];
}else{
if(_26!=""){
_2b=Number(_26.substring(1));
}
}
var _2c=(_24.indexOf("-")>=0);
var _2d=(_24.indexOf("0")>=0);
var _2e="";
if(RegExp("[bBdiufeExXo]").test(_28)){
var num=Number(arguments[_23]);
var _2f="";
if(num<0){
_2f="-";
}else{
if(_24.indexOf("+")>=0){
_2f="+";
}else{
if(_24.indexOf(" ")>=0){
_2f=" ";
}
}
}
if(_28=="d"||_28=="i"||_28=="u"){
var _30=String(Math.abs(Math.floor(num)));
_2e=_31(_2f,"",_30,"",_2a,_2c,_2d);
}
if(_28=="f"){
var _30=String((_2b!=null)?Math.abs(num).toFixed(_2b):Math.abs(num));
var _32=(_24.indexOf("#")>=0&&_30.indexOf(".")<0)?".":"";
_2e=_31(_2f,"",_30,_32,_2a,_2c,_2d);
}
if(_28=="e"||_28=="E"){
var _30=String(Math.abs(num).toExponential(_2b!=null?_2b:21));
var _32=(_24.indexOf("#")>=0&&_30.indexOf(".")<0)?".":"";
_2e=_31(_2f,"",_30,_32,_2a,_2c,_2d);
}
if(_28=="x"||_28=="X"){
var _30=String(Math.abs(num).toString(16));
var _33=(_24.indexOf("#")>=0&&num!=0)?"0x":"";
_2e=_31(_2f,_33,_30,"",_2a,_2c,_2d);
}
if(_28=="b"||_28=="B"){
var _30=String(Math.abs(num).toString(2));
var _33=(_24.indexOf("#")>=0&&num!=0)?"0b":"";
_2e=_31(_2f,_33,_30,"",_2a,_2c,_2d);
}
if(_28=="o"){
var _30=String(Math.abs(num).toString(8));
var _33=(_24.indexOf("#")>=0&&num!=0)?"0":"";
_2e=_31(_2f,_33,_30,"",_2a,_2c,_2d);
}
if(RegExp("[A-Z]").test(_28)){
_2e=_2e.toUpperCase();
}else{
_2e=_2e.toLowerCase();
}
}else{
var _2e="";
if(_28=="%"){
_2e="%";
}else{
if(_28=="c"){
_2e=String(arguments[_23]).charAt(0);
}else{
if(_28=="s"||_28=="@"){
_2e=String(arguments[_23]);
}else{
if(_28=="p"||_28=="n"){
_2e="";
}
}
}
}
_2e=_31("","",_2e,"",_2a,_2c,false);
}
_20+=_2e;
}
}
}
return _20;
};
function _31(_34,_35,_36,_37,_38,_39,_3a){
var _3b=(_34.length+_35.length+_36.length+_37.length);
if(_39){
return _34+_35+_36+_37+pad(_38-_3b," ");
}else{
if(_3a){
return _34+_35+pad(_38-_3b,"0")+_36+_37;
}else{
return pad(_38-_3b," ")+_34+_35+_36+_37;
}
}
};
function pad(n,ch){
return Array(MAX(0,n)+1).join(ch);
};
CPLogDisable=false;
var _3c="Cappuccino";
var _3d=["fatal","error","warn","info","debug","trace"];
var _3e=_3d[3];
var _3f={};
for(var i=0;i<_3d.length;i++){
_3f[_3d[i]]=i;
}
var _40={};
CPLogRegister=function(_41,_42,_43){
CPLogRegisterRange(_41,_3d[0],_42||_3d[_3d.length-1],_43);
};
CPLogRegisterRange=function(_44,_45,_46,_47){
var min=_3f[_45];
var max=_3f[_46];
if(min!==_29&&max!==_29&&min<=max){
for(var i=min;i<=max;i++){
CPLogRegisterSingle(_44,_3d[i],_47);
}
}
};
CPLogRegisterSingle=function(_48,_49,_4a){
if(!_40[_49]){
_40[_49]=[];
}
for(var i=0;i<_40[_49].length;i++){
if(_40[_49][i][0]===_48){
_40[_49][i][1]=_4a;
return;
}
}
_40[_49].push([_48,_4a]);
};
CPLogUnregister=function(_4b){
for(var _4c in _40){
for(var i=0;i<_40[_4c].length;i++){
if(_40[_4c][i][0]===_4b){
_40[_4c].splice(i--,1);
}
}
}
};
function _4d(_4e,_4f,_50){
if(_50==_29){
_50=_3c;
}
if(_4f==_29){
_4f=_3e;
}
var _51=(typeof _4e[0]=="string"&&_4e.length>1)?_2.sprintf.apply(null,_4e):String(_4e[0]);
if(_40[_4f]){
for(var i=0;i<_40[_4f].length;i++){
var _52=_40[_4f][i];
_52[0](_51,_4f,_50,_52[1]);
}
}
};
CPLog=function(){
_4d(arguments);
};
for(var i=0;i<_3d.length;i++){
CPLog[_3d[i]]=(function(_53){
return function(){
_4d(arguments,_53);
};
})(_3d[i]);
}
var _54=function(_55,_56,_57){
var now=new Date();
_56=(_56==null?"":" ["+CPLogColorize(_56,_56)+"]");
if(typeof _2.sprintf=="function"){
return _2.sprintf("%4d-%02d-%02d %02d:%02d:%02d.%03d %s%s: %s",now.getFullYear(),now.getMonth()+1,now.getDate(),now.getHours(),now.getMinutes(),now.getSeconds(),now.getMilliseconds(),_57,_56,_55);
}else{
return now+" "+_57+_56+": "+_55;
}
};
CPLogConsole=function(_58,_59,_5a,_5b){
if(typeof console!="undefined"){
var _5c=(_5b||_54)(_58,_59,_5a);
var _5d={"fatal":"error","error":"error","warn":"warn","info":"info","debug":"debug","trace":"debug"}[_59];
if(_5d&&console[_5d]){
console[_5d](_5c);
}else{
if(console.log){
console.log(_5c);
}
}
}
};
CPLogColorize=function(_5e,_5f){
return _5e;
};
CPLogAlert=function(_60,_61,_62,_63){
if(typeof alert!="undefined"&&!CPLogDisable){
var _64=(_63||_54)(_60,_61,_62);
CPLogDisable=!confirm(_64+"\n\n(Click cancel to stop log alerts)");
}
};
var _65=null;
CPLogPopup=function(_66,_67,_68,_69){
try{
if(CPLogDisable||window.open==_29){
return;
}
if(!_65||!_65.document){
_65=window.open("","_blank","width=600,height=400,status=no,resizable=yes,scrollbars=yes");
if(!_65){
CPLogDisable=!confirm(_66+"\n\n(Disable pop-up blocking for CPLog window; Click cancel to stop log alerts)");
return;
}
_6a(_65);
}
var _6b=_65.document.createElement("div");
_6b.setAttribute("class",_67||"fatal");
var _6c=(_69||_54)(_66,_69?_67:null,_68);
_6b.appendChild(_65.document.createTextNode(_6c));
_65.log.appendChild(_6b);
if(_65.focusEnabled.checked){
_65.focus();
}
if(_65.blockEnabled.checked){
_65.blockEnabled.checked=_65.confirm(_6c+"\nContinue blocking?");
}
if(_65.scrollEnabled.checked){
_65.scrollToBottom();
}
}
catch(e){
}
};
var _6d="<style type=\"text/css\" media=\"screen\"> body{font:10px Monaco,Courier,\"Courier New\",monospace,mono;padding-top:15px;} div > .fatal,div > .error,div > .warn,div > .info,div > .debug,div > .trace{display:none;overflow:hidden;white-space:pre;padding:0px 5px 0px 5px;margin-top:2px;-moz-border-radius:5px;-webkit-border-radius:5px;} div[wrap=\"yes\"] > div{white-space:normal;} .fatal{background-color:#ffb2b3;} .error{background-color:#ffe2b2;} .warn{background-color:#fdffb2;} .info{background-color:#e4ffb2;} .debug{background-color:#a0e5a0;} .trace{background-color:#99b9ff;} .enfatal .fatal,.enerror .error,.enwarn .warn,.eninfo .info,.endebug .debug,.entrace .trace{display:block;} div#header{background-color:rgba(240,240,240,0.82);position:fixed;top:0px;left:0px;width:100%;border-bottom:1px solid rgba(0,0,0,0.33);text-align:center;} ul#enablers{display:inline-block;margin:1px 15px 0 15px;padding:2px 0 2px 0;} ul#enablers li{display:inline;padding:0px 5px 0px 5px;margin-left:4px;-moz-border-radius:5px;-webkit-border-radius:5px;} [enabled=\"no\"]{opacity:0.25;} ul#options{display:inline-block;margin:0 15px 0px 15px;padding:0 0px;} ul#options li{margin:0 0 0 0;padding:0 0 0 0;display:inline;} </style>";
function _6a(_6e){
var doc=_6e.document;
doc.writeln("<html><head><title></title>"+_6d+"</head><body></body></html>");
doc.title=_3c+" Run Log";
var _6f=doc.getElementsByTagName("head")[0];
var _70=doc.getElementsByTagName("body")[0];
var _71=window.location.protocol+"//"+window.location.host+window.location.pathname;
_71=_71.substring(0,_71.lastIndexOf("/")+1);
var div=doc.createElement("div");
div.setAttribute("id","header");
_70.appendChild(div);
var ul=doc.createElement("ul");
ul.setAttribute("id","enablers");
div.appendChild(ul);
for(var i=0;i<_3d.length;i++){
var li=doc.createElement("li");
li.setAttribute("id","en"+_3d[i]);
li.setAttribute("class",_3d[i]);
li.setAttribute("onclick","toggle(this);");
li.setAttribute("enabled","yes");
li.appendChild(doc.createTextNode(_3d[i]));
ul.appendChild(li);
}
var ul=doc.createElement("ul");
ul.setAttribute("id","options");
div.appendChild(ul);
var _72={"focus":["Focus",false],"block":["Block",false],"wrap":["Wrap",false],"scroll":["Scroll",true],"close":["Close",true]};
for(o in _72){
var li=doc.createElement("li");
ul.appendChild(li);
_6e[o+"Enabled"]=doc.createElement("input");
_6e[o+"Enabled"].setAttribute("id",o);
_6e[o+"Enabled"].setAttribute("type","checkbox");
if(_72[o][1]){
_6e[o+"Enabled"].setAttribute("checked","checked");
}
li.appendChild(_6e[o+"Enabled"]);
var _73=doc.createElement("label");
_73.setAttribute("for",o);
_73.appendChild(doc.createTextNode(_72[o][0]));
li.appendChild(_73);
}
_6e.log=doc.createElement("div");
_6e.log.setAttribute("class","enerror endebug enwarn eninfo enfatal entrace");
_70.appendChild(_6e.log);
_6e.toggle=function(_74){
var _75=(_74.getAttribute("enabled")=="yes")?"no":"yes";
_74.setAttribute("enabled",_75);
if(_75=="yes"){
_6e.log.className+=" "+_74.id;
}else{
_6e.log.className=_6e.log.className.replace(new RegExp("[\\s]*"+_74.id,"g"),"");
}
};
_6e.scrollToBottom=function(){
_6e.scrollTo(0,_70.offsetHeight);
};
_6e.wrapEnabled.addEventListener("click",function(){
_6e.log.setAttribute("wrap",_6e.wrapEnabled.checked?"yes":"no");
},false);
_6e.addEventListener("keydown",function(e){
var e=e||_6e.event;
if(e.keyCode==75&&(e.ctrlKey||e.metaKey)){
while(_6e.log.firstChild){
_6e.log.removeChild(_6e.log.firstChild);
}
e.preventDefault();
}
},"false");
window.addEventListener("unload",function(){
if(_6e&&_6e.closeEnabled&&_6e.closeEnabled.checked){
CPLogDisable=true;
_6e.close();
}
},false);
_6e.addEventListener("unload",function(){
if(!CPLogDisable){
CPLogDisable=!confirm("Click cancel to stop logging");
}
},false);
};
CPLogDefault=(typeof window==="object"&&window.console)?CPLogConsole:CPLogPopup;
var _29;
if(typeof window!=="undefined"){
window.setNativeTimeout=window.setTimeout;
window.clearNativeTimeout=window.clearTimeout;
window.setNativeInterval=window.setInterval;
window.clearNativeInterval=window.clearInterval;
}
NO=false;
YES=true;
nil=null;
Nil=null;
NULL=null;
ABS=Math.abs;
ASIN=Math.asin;
ACOS=Math.acos;
ATAN=Math.atan;
ATAN2=Math.atan2;
SIN=Math.sin;
COS=Math.cos;
TAN=Math.tan;
EXP=Math.exp;
POW=Math.pow;
CEIL=Math.ceil;
FLOOR=Math.floor;
ROUND=Math.round;
MIN=Math.min;
MAX=Math.max;
RAND=Math.random;
SQRT=Math.sqrt;
E=Math.E;
LN2=Math.LN2;
LN10=Math.LN10;
LOG2E=Math.LOG2E;
LOG10E=Math.LOG10E;
PI=Math.PI;
PI2=Math.PI*2;
PI_2=Math.PI/2;
SQRT1_2=Math.SQRT1_2;
SQRT2=Math.SQRT2;
function _76(_77){
this._eventListenersForEventNames={};
this._owner=_77;
};
_76.prototype.addEventListener=function(_78,_79){
var _7a=this._eventListenersForEventNames;
if(!_7b.call(_7a,_78)){
var _7c=[];
_7a[_78]=_7c;
}else{
var _7c=_7a[_78];
}
var _7d=_7c.length;
while(_7d--){
if(_7c[_7d]===_79){
return;
}
}
_7c.push(_79);
};
_76.prototype.removeEventListener=function(_7e,_7f){
var _80=this._eventListenersForEventNames;
if(!_7b.call(_80,_7e)){
return;
}
var _81=_80[_7e],_82=_81.length;
while(_82--){
if(_81[_82]===_7f){
return _81.splice(_82,1);
}
}
};
_76.prototype.dispatchEvent=function(_83){
var _84=_83.type,_85=this._eventListenersForEventNames;
if(_7b.call(_85,_84)){
var _86=this._eventListenersForEventNames[_84],_87=0,_88=_86.length;
for(;_87<_88;++_87){
_86[_87](_83);
}
}
var _89=(this._owner||this)["on"+_84];
if(_89){
_89(_83);
}
};
var _8a=0,_8b=null,_8c=[];
function _8d(_8e){
var _8f=_8a;
if(_8b===null){
window.setNativeTimeout(function(){
var _90=_8c,_91=0,_92=_8c.length;
++_8a;
_8b=null;
_8c=[];
for(;_91<_92;++_91){
_90[_91]();
}
},0);
}
return function(){
var _93=arguments;
if(_8a>_8f){
_8e.apply(this,_93);
}else{
_8c.push(function(){
_8e.apply(this,_93);
});
}
};
};
var _94=null;
if(window.ActiveXObject!==_29){
var _95=["Msxml2.XMLHTTP.3.0","Msxml2.XMLHTTP.6.0"],_96=_95.length;
while(_96--){
try{
var _97=_95[_96];
new ActiveXObject(_97);
_94=function(){
return new ActiveXObject(_97);
};
break;
}
catch(anException){
}
}
}
if(!_94){
_94=window.XMLHttpRequest;
}
CFHTTPRequest=function(){
this._isOpen=false;
this._requestHeaders={};
this._mimeType=null;
this._eventDispatcher=new _76(this);
this._nativeRequest=new _94();
var _98=this;
this._stateChangeHandler=function(){
_ab(_98);
};
this._nativeRequest.onreadystatechange=this._stateChangeHandler;
if(CFHTTPRequest.AuthenticationDelegate!==nil){
this._eventDispatcher.addEventListener("HTTP403",function(){
CFHTTPRequest.AuthenticationDelegate(_98);
});
}
};
CFHTTPRequest.UninitializedState=0;
CFHTTPRequest.LoadingState=1;
CFHTTPRequest.LoadedState=2;
CFHTTPRequest.InteractiveState=3;
CFHTTPRequest.CompleteState=4;
CFHTTPRequest.AuthenticationDelegate=nil;
CFHTTPRequest.prototype.status=function(){
try{
return this._nativeRequest.status||0;
}
catch(anException){
return 0;
}
};
CFHTTPRequest.prototype.statusText=function(){
try{
return this._nativeRequest.statusText||"";
}
catch(anException){
return "";
}
};
CFHTTPRequest.prototype.readyState=function(){
return this._nativeRequest.readyState;
};
CFHTTPRequest.prototype.success=function(){
var _99=this.status();
if(_99>=200&&_99<300){
return YES;
}
return _99===0&&this.responseText()&&this.responseText().length;
};
CFHTTPRequest.prototype.responseXML=function(){
var _9a=this._nativeRequest.responseXML;
if(_9a&&(_94===window.XMLHttpRequest)){
return _9a;
}
return _9b(this.responseText());
};
CFHTTPRequest.prototype.responsePropertyList=function(){
var _9c=this.responseText();
if(CFPropertyList.sniffedFormatOfString(_9c)===CFPropertyList.FormatXML_v1_0){
return CFPropertyList.propertyListFromXML(this.responseXML());
}
return CFPropertyList.propertyListFromString(_9c);
};
CFHTTPRequest.prototype.responseText=function(){
return this._nativeRequest.responseText;
};
CFHTTPRequest.prototype.setRequestHeader=function(_9d,_9e){
this._requestHeaders[_9d]=_9e;
};
CFHTTPRequest.prototype.getResponseHeader=function(_9f){
return this._nativeRequest.getResponseHeader(_9f);
};
CFHTTPRequest.prototype.getAllResponseHeaders=function(){
return this._nativeRequest.getAllResponseHeaders();
};
CFHTTPRequest.prototype.overrideMimeType=function(_a0){
this._mimeType=_a0;
};
CFHTTPRequest.prototype.open=function(_a1,_a2,_a3,_a4,_a5){
this._isOpen=true;
this._URL=_a2;
this._async=_a3;
this._method=_a1;
this._user=_a4;
this._password=_a5;
return this._nativeRequest.open(_a1,_a2,_a3,_a4,_a5);
};
CFHTTPRequest.prototype.send=function(_a6){
if(!this._isOpen){
delete this._nativeRequest.onreadystatechange;
this._nativeRequest.open(this._method,this._URL,this._async,this._user,this._password);
this._nativeRequest.onreadystatechange=this._stateChangeHandler;
}
for(var i in this._requestHeaders){
if(this._requestHeaders.hasOwnProperty(i)){
this._nativeRequest.setRequestHeader(i,this._requestHeaders[i]);
}
}
if(this._mimeType&&"overrideMimeType" in this._nativeRequest){
this._nativeRequest.overrideMimeType(this._mimeType);
}
this._isOpen=false;
try{
return this._nativeRequest.send(_a6);
}
catch(anException){
this._eventDispatcher.dispatchEvent({type:"failure",request:this});
}
};
CFHTTPRequest.prototype.abort=function(){
this._isOpen=false;
return this._nativeRequest.abort();
};
CFHTTPRequest.prototype.addEventListener=function(_a7,_a8){
this._eventDispatcher.addEventListener(_a7,_a8);
};
CFHTTPRequest.prototype.removeEventListener=function(_a9,_aa){
this._eventDispatcher.removeEventListener(_a9,_aa);
};
function _ab(_ac){
var _ad=_ac._eventDispatcher;
_ad.dispatchEvent({type:"readystatechange",request:_ac});
var _ae=_ac._nativeRequest,_af=["uninitialized","loading","loaded","interactive","complete"];
if(_af[_ac.readyState()]==="complete"){
var _b0="HTTP"+_ac.status();
_ad.dispatchEvent({type:_b0,request:_ac});
var _b1=_ac.success()?"success":"failure";
_ad.dispatchEvent({type:_b1,request:_ac});
_ad.dispatchEvent({type:_af[_ac.readyState()],request:_ac});
}else{
_ad.dispatchEvent({type:_af[_ac.readyState()],request:_ac});
}
};
function _b2(_b3,_b4,_b5){
var _b6=new CFHTTPRequest();
if(_b3.pathExtension()==="plist"){
_b6.overrideMimeType("text/xml");
}
if(_2.asyncLoader){
_b6.onsuccess=_8d(_b4);
_b6.onfailure=_8d(_b5);
}else{
_b6.onsuccess=_b4;
_b6.onfailure=_b5;
}
_b6.open("GET",_b3.absoluteString(),_2.asyncLoader);
_b6.send("");
};
_2.asyncLoader=YES;
_2.Asynchronous=_8d;
_2.determineAndDispatchHTTPRequestEvents=_ab;
var _b7=0;
objj_generateObjectUID=function(){
return _b7++;
};
CFPropertyList=function(){
this._UID=objj_generateObjectUID();
};
CFPropertyList.DTDRE=/^\s*(?:<\?\s*xml\s+version\s*=\s*\"1.0\"[^>]*\?>\s*)?(?:<\!DOCTYPE[^>]*>\s*)?/i;
CFPropertyList.XMLRE=/^\s*(?:<\?\s*xml\s+version\s*=\s*\"1.0\"[^>]*\?>\s*)?(?:<\!DOCTYPE[^>]*>\s*)?<\s*plist[^>]*\>/i;
CFPropertyList.FormatXMLDTD="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">";
CFPropertyList.Format280NorthMagicNumber="280NPLIST";
CFPropertyList.FormatOpenStep=1,CFPropertyList.FormatXML_v1_0=100,CFPropertyList.FormatBinary_v1_0=200,CFPropertyList.Format280North_v1_0=-1000;
CFPropertyList.sniffedFormatOfString=function(_b8){
if(_b8.match(CFPropertyList.XMLRE)){
return CFPropertyList.FormatXML_v1_0;
}
if(_b8.substr(0,CFPropertyList.Format280NorthMagicNumber.length)===CFPropertyList.Format280NorthMagicNumber){
return CFPropertyList.Format280North_v1_0;
}
return NULL;
};
CFPropertyList.dataFromPropertyList=function(_b9,_ba){
var _bb=new CFMutableData();
_bb.setRawString(CFPropertyList.stringFromPropertyList(_b9,_ba));
return _bb;
};
CFPropertyList.stringFromPropertyList=function(_bc,_bd){
if(!_bd){
_bd=CFPropertyList.Format280North_v1_0;
}
var _be=_bf[_bd];
return _be["start"]()+_c0(_bc,_be)+_be["finish"]();
};
function _c0(_c1,_c2){
var _c3=typeof _c1,_c4=_c1.valueOf(),_c5=typeof _c4;
if(_c3!==_c5){
_c3=_c5;
_c1=_c4;
}
if(_c1===YES||_c1===NO){
_c3="boolean";
}else{
if(_c3==="number"){
if(FLOOR(_c1)===_c1&&(""+_c1).indexOf("e")==-1){
_c3="integer";
}else{
_c3="real";
}
}else{
if(_c3!=="string"){
if(_c1.slice){
_c3="array";
}else{
_c3="dictionary";
}
}
}
}
return _c2[_c3](_c1,_c2);
};
var _bf={};
_bf[CFPropertyList.FormatXML_v1_0]={"start":function(){
return CFPropertyList.FormatXMLDTD+"<plist version = \"1.0\">";
},"finish":function(){
return "</plist>";
},"string":function(_c6){
return "<string>"+_c7(_c6)+"</string>";
},"boolean":function(_c8){
return _c8?"<true/>":"<false/>";
},"integer":function(_c9){
return "<integer>"+_c9+"</integer>";
},"real":function(_ca){
return "<real>"+_ca+"</real>";
},"array":function(_cb,_cc){
var _cd=0,_ce=_cb.length,_cf="<array>";
for(;_cd<_ce;++_cd){
_cf+=_c0(_cb[_cd],_cc);
}
return _cf+"</array>";
},"dictionary":function(_d0,_d1){
var _d2=_d0._keys,_96=0,_d3=_d2.length,_d4="<dict>";
for(;_96<_d3;++_96){
var key=_d2[_96];
_d4+="<key>"+key+"</key>";
_d4+=_c0(_d0.valueForKey(key),_d1);
}
return _d4+"</dict>";
}};
var _d5="A",_d6="D",_d7="f",_d8="d",_d9="S",_da="T",_db="F",_dc="K",_dd="E";
_bf[CFPropertyList.Format280North_v1_0]={"start":function(){
return CFPropertyList.Format280NorthMagicNumber+";1.0;";
},"finish":function(){
return "";
},"string":function(_de){
return _d9+";"+_de.length+";"+_de;
},"boolean":function(_df){
return (_df?_da:_db)+";";
},"integer":function(_e0){
var _e1=""+_e0;
return _d8+";"+_e1.length+";"+_e1;
},"real":function(_e2){
var _e3=""+_e2;
return _d7+";"+_e3.length+";"+_e3;
},"array":function(_e4,_e5){
var _e6=0,_e7=_e4.length,_e8=_d5+";";
for(;_e6<_e7;++_e6){
_e8+=_c0(_e4[_e6],_e5);
}
return _e8+_dd+";";
},"dictionary":function(_e9,_ea){
var _eb=_e9._keys,_96=0,_ec=_eb.length,_ed=_d6+";";
for(;_96<_ec;++_96){
var key=_eb[_96];
_ed+=_dc+";"+key.length+";"+key;
_ed+=_c0(_e9.valueForKey(key),_ea);
}
return _ed+_dd+";";
}};
var _ee="xml",_ef="#document",_f0="plist",_f1="key",_f2="dict",_f3="array",_f4="string",_f5="true",_f6="false",_f7="real",_f8="integer",_f9="data";
var _fa=function(_fb){
var _fc="",_96=0,_fd=_fb.length;
for(;_96<_fd;++_96){
var _fe=_fb[_96];
if(_fe.nodeType===3||_fe.nodeType===4){
_fc+=_fe.nodeValue;
}else{
if(_fe.nodeType!==8){
_fc+=_fa(_fe.childNodes);
}
}
}
return _fc;
};
var _ff=function(_100,_101,_102){
var node=_100;
node=(node.firstChild);
if(node!==NULL&&((node.nodeType)===8||(node.nodeType)===3)){
while((node=(node.nextSibling))&&((node.nodeType)===8||(node.nodeType)===3)){
}
}
if(node){
return node;
}
if((String(_100.nodeName))===_f3||(String(_100.nodeName))===_f2){
_102.pop();
}else{
if(node===_101){
return NULL;
}
node=_100;
while((node=(node.nextSibling))&&((node.nodeType)===8||(node.nodeType)===3)){
}
if(node){
return node;
}
}
node=_100;
while(node){
var next=node;
while((next=(next.nextSibling))&&((next.nodeType)===8||(next.nodeType)===3)){
}
if(next){
return next;
}
var node=(node.parentNode);
if(_101&&node===_101){
return NULL;
}
_102.pop();
}
return NULL;
};
CFPropertyList.propertyListFromData=function(_103,_104){
return CFPropertyList.propertyListFromString(_103.rawString(),_104);
};
CFPropertyList.propertyListFromString=function(_105,_106){
if(!_106){
_106=CFPropertyList.sniffedFormatOfString(_105);
}
if(_106===CFPropertyList.FormatXML_v1_0){
return CFPropertyList.propertyListFromXML(_105);
}
if(_106===CFPropertyList.Format280North_v1_0){
return _107(_105);
}
return NULL;
};
var _d5="A",_d6="D",_d7="f",_d8="d",_d9="S",_da="T",_db="F",_dc="K",_dd="E";
function _107(_108){
var _109=new _10a(_108),_10b=NULL,key="",_10c=NULL,_10d=NULL,_10e=[],_10f=NULL;
while(_10b=_109.getMarker()){
if(_10b===_dd){
_10e.pop();
continue;
}
var _110=_10e.length;
if(_110){
_10f=_10e[_110-1];
}
if(_10b===_dc){
key=_109.getString();
_10b=_109.getMarker();
}
switch(_10b){
case _d5:
_10c=[];
_10e.push(_10c);
break;
case _d6:
_10c=new CFMutableDictionary();
_10e.push(_10c);
break;
case _d7:
_10c=parseFloat(_109.getString());
break;
case _d8:
_10c=parseInt(_109.getString(),10);
break;
case _d9:
_10c=_109.getString();
break;
case _da:
_10c=YES;
break;
case _db:
_10c=NO;
break;
default:
throw new Error("*** "+_10b+" marker not recognized in Plist.");
}
if(!_10d){
_10d=_10c;
}else{
if(_10f){
if(_10f.slice){
_10f.push(_10c);
}else{
_10f.setValueForKey(key,_10c);
}
}
}
}
return _10d;
};
function _c7(_111){
return _111.replace(/&/g,"&amp;").replace(/"/g,"&quot;").replace(/'/g,"&apos;").replace(/</g,"&lt;").replace(/>/g,"&gt;");
};
function _112(_113){
return _113.replace(/&quot;/g,"\"").replace(/&apos;/g,"'").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&amp;/g,"&");
};
function _9b(_114){
if(window.DOMParser){
return (new window.DOMParser().parseFromString(_114,"text/xml").documentElement);
}else{
if(window.ActiveXObject){
XMLNode=new ActiveXObject("Microsoft.XMLDOM");
var _115=_114.match(CFPropertyList.DTDRE);
if(_115){
_114=_114.substr(_115[0].length);
}
XMLNode.loadXML(_114);
return XMLNode;
}
}
return NULL;
};
CFPropertyList.propertyListFromXML=function(_116){
var _117=_116;
if(_116.valueOf&&typeof _116.valueOf()==="string"){
_117=_9b(_116);
}
while(((String(_117.nodeName))===_ef)||((String(_117.nodeName))===_ee)){
_117=(_117.firstChild);
}
if(_117!==NULL&&((_117.nodeType)===8||(_117.nodeType)===3)){
while((_117=(_117.nextSibling))&&((_117.nodeType)===8||(_117.nodeType)===3)){
}
}
if(((_117.nodeType)===10)){
while((_117=(_117.nextSibling))&&((_117.nodeType)===8||(_117.nodeType)===3)){
}
}
if(!((String(_117.nodeName))===_f0)){
return NULL;
}
var key="",_118=NULL,_119=NULL,_11a=_117,_11b=[],_11c=NULL;
while(_117=_ff(_117,_11a,_11b)){
var _11d=_11b.length;
if(_11d){
_11c=_11b[_11d-1];
}
if((String(_117.nodeName))===_f1){
key=(_117.textContent||(_117.textContent!==""&&_fa([_117])));
while((_117=(_117.nextSibling))&&((_117.nodeType)===8||(_117.nodeType)===3)){
}
}
switch(String((String(_117.nodeName)))){
case _f3:
_118=[];
_11b.push(_118);
break;
case _f2:
_118=new CFMutableDictionary();
_11b.push(_118);
break;
case _f7:
_118=parseFloat((_117.textContent||(_117.textContent!==""&&_fa([_117]))));
break;
case _f8:
_118=parseInt((_117.textContent||(_117.textContent!==""&&_fa([_117]))),10);
break;
case _f4:
if((_117.getAttribute("type")==="base64")){
_118=(_117.firstChild)?CFData.decodeBase64ToString((_117.textContent||(_117.textContent!==""&&_fa([_117])))):"";
}else{
_118=_112((_117.firstChild)?(_117.textContent||(_117.textContent!==""&&_fa([_117]))):"");
}
break;
case _f5:
_118=YES;
break;
case _f6:
_118=NO;
break;
case _f9:
_118=new CFMutableData();
var _11e=(_117.firstChild)?CFData.decodeBase64ToArray((_117.textContent||(_117.textContent!==""&&_fa([_117]))),YES):[];
_118.setBytes(_11e);
break;
default:
throw new Error("*** "+(String(_117.nodeName))+" tag not recognized in Plist.");
}
if(!_119){
_119=_118;
}else{
if(_11c){
if(_11c.slice){
_11c.push(_118);
}else{
_11c.setValueForKey(key,_118);
}
}
}
}
return _119;
};
kCFPropertyListOpenStepFormat=CFPropertyList.FormatOpenStep;
kCFPropertyListXMLFormat_v1_0=CFPropertyList.FormatXML_v1_0;
kCFPropertyListBinaryFormat_v1_0=CFPropertyList.FormatBinary_v1_0;
kCFPropertyList280NorthFormat_v1_0=CFPropertyList.Format280North_v1_0;
CFPropertyListCreate=function(){
return new CFPropertyList();
};
CFPropertyListCreateFromXMLData=function(data){
return CFPropertyList.propertyListFromData(data,CFPropertyList.FormatXML_v1_0);
};
CFPropertyListCreateXMLData=function(_11f){
return CFPropertyList.dataFromPropertyList(_11f,CFPropertyList.FormatXML_v1_0);
};
CFPropertyListCreateFrom280NorthData=function(data){
return CFPropertyList.propertyListFromData(data,CFPropertyList.Format280North_v1_0);
};
CFPropertyListCreate280NorthData=function(_120){
return CFPropertyList.dataFromPropertyList(_120,CFPropertyList.Format280North_v1_0);
};
CPPropertyListCreateFromData=function(data,_121){
return CFPropertyList.propertyListFromData(data,_121);
};
CPPropertyListCreateData=function(_122,_123){
return CFPropertyList.dataFromPropertyList(_122,_123);
};
CFDictionary=function(_124){
this._keys=[];
this._count=0;
this._buckets={};
this._UID=objj_generateObjectUID();
};
var _125=Array.prototype.indexOf,_7b=Object.prototype.hasOwnProperty;
CFDictionary.prototype.copy=function(){
return this;
};
CFDictionary.prototype.mutableCopy=function(){
var _126=new CFMutableDictionary(),keys=this._keys,_127=this._count;
_126._keys=keys.slice();
_126._count=_127;
var _128=0,_129=this._buckets,_12a=_126._buckets;
for(;_128<_127;++_128){
var key=keys[_128];
_12a[key]=_129[key];
}
return _126;
};
CFDictionary.prototype.containsKey=function(aKey){
return _7b.apply(this._buckets,[aKey]);
};
CFDictionary.prototype.containsValue=function(_12b){
var keys=this._keys,_12c=this._buckets,_96=0,_12d=keys.length;
for(;_96<_12d;++_96){
if(_12c[keys[_96]]===_12b){
return YES;
}
}
return NO;
};
CFDictionary.prototype.count=function(){
return this._count;
};
CFDictionary.prototype.countOfKey=function(aKey){
return this.containsKey(aKey)?1:0;
};
CFDictionary.prototype.countOfValue=function(_12e){
var keys=this._keys,_12f=this._buckets,_96=0,_130=keys.length,_131=0;
for(;_96<_130;++_96){
if(_12f[keys[_96]]===_12e){
++_131;
}
}
return _131;
};
CFDictionary.prototype.keys=function(){
return this._keys.slice();
};
CFDictionary.prototype.valueForKey=function(aKey){
var _132=this._buckets;
if(!_7b.apply(_132,[aKey])){
return nil;
}
return _132[aKey];
};
CFDictionary.prototype.toString=function(){
var _133="{\n",keys=this._keys,_96=0,_134=this._count;
for(;_96<_134;++_96){
var key=keys[_96];
_133+="\t"+key+" = \""+String(this.valueForKey(key)).split("\n").join("\n\t")+"\"\n";
}
return _133+"}";
};
CFMutableDictionary=function(_135){
CFDictionary.apply(this,[]);
};
CFMutableDictionary.prototype=new CFDictionary();
CFMutableDictionary.prototype.copy=function(){
return this.mutableCopy();
};
CFMutableDictionary.prototype.addValueForKey=function(aKey,_136){
if(this.containsKey(aKey)){
return;
}
++this._count;
this._keys.push(aKey);
this._buckets[aKey]=_136;
};
CFMutableDictionary.prototype.removeValueForKey=function(aKey){
var _137=-1;
if(_125){
_137=_125.call(this._keys,aKey);
}else{
var keys=this._keys,_96=0,_138=keys.length;
for(;_96<_138;++_96){
if(keys[_96]===aKey){
_137=_96;
break;
}
}
}
if(_137===-1){
return;
}
--this._count;
this._keys.splice(_137,1);
delete this._buckets[aKey];
};
CFMutableDictionary.prototype.removeAllValues=function(){
this._count=0;
this._keys=[];
this._buckets={};
};
CFMutableDictionary.prototype.replaceValueForKey=function(aKey,_139){
if(!this.containsKey(aKey)){
return;
}
this._buckets[aKey]=_139;
};
CFMutableDictionary.prototype.setValueForKey=function(aKey,_13a){
if(_13a===nil||_13a===_29){
this.removeValueForKey(aKey);
}else{
if(this.containsKey(aKey)){
this.replaceValueForKey(aKey,_13a);
}else{
this.addValueForKey(aKey,_13a);
}
}
};
CFData=function(){
this._rawString=NULL;
this._propertyList=NULL;
this._propertyListFormat=NULL;
this._JSONObject=NULL;
this._bytes=NULL;
this._base64=NULL;
};
CFData.prototype.propertyList=function(){
if(!this._propertyList){
this._propertyList=CFPropertyList.propertyListFromString(this.rawString());
}
return this._propertyList;
};
CFData.prototype.JSONObject=function(){
if(!this._JSONObject){
try{
this._JSONObject=JSON.parse(this.rawString());
}
catch(anException){
}
}
return this._JSONObject;
};
CFData.prototype.rawString=function(){
if(this._rawString===NULL){
if(this._propertyList){
this._rawString=CFPropertyList.stringFromPropertyList(this._propertyList,this._propertyListFormat);
}else{
if(this._JSONObject){
this._rawString=JSON.stringify(this._JSONObject);
}else{
throw new Error("Can't convert data to string.");
}
}
}
return this._rawString;
};
CFData.prototype.bytes=function(){
return this._bytes;
};
CFData.prototype.base64=function(){
return this._base64;
};
CFMutableData=function(){
CFData.call(this);
};
CFMutableData.prototype=new CFData();
function _13b(_13c){
this._rawString=NULL;
this._propertyList=NULL;
this._propertyListFormat=NULL;
this._JSONObject=NULL;
this._bytes=NULL;
this._base64=NULL;
};
CFMutableData.prototype.setPropertyList=function(_13d,_13e){
_13b(this);
this._propertyList=_13d;
this._propertyListFormat=_13e;
};
CFMutableData.prototype.setJSONObject=function(_13f){
_13b(this);
this._JSONObject=_13f;
};
CFMutableData.prototype.setRawString=function(_140){
_13b(this);
this._rawString=_140;
};
CFMutableData.prototype.setBytes=function(_141){
_13b(this);
this._bytes=_141;
};
CFMutableData.prototype.setBase64String=function(_142){
_13b(this);
this._base64=_142;
};
var _143=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","/","="],_144=[];
for(var i=0;i<_143.length;i++){
_144[_143[i].charCodeAt(0)]=i;
}
CFData.decodeBase64ToArray=function(_145,_146){
if(_146){
_145=_145.replace(/[^A-Za-z0-9\+\/\=]/g,"");
}
var pad=(_145[_145.length-1]=="="?1:0)+(_145[_145.length-2]=="="?1:0),_147=_145.length,_148=[];
var i=0;
while(i<_147){
var bits=(_144[_145.charCodeAt(i++)]<<18)|(_144[_145.charCodeAt(i++)]<<12)|(_144[_145.charCodeAt(i++)]<<6)|(_144[_145.charCodeAt(i++)]);
_148.push((bits&16711680)>>16);
_148.push((bits&65280)>>8);
_148.push(bits&255);
}
if(pad>0){
return _148.slice(0,-1*pad);
}
return _148;
};
CFData.encodeBase64Array=function(_149){
var pad=(3-(_149.length%3))%3,_14a=_149.length+pad,_14b=[];
if(pad>0){
_149.push(0);
}
if(pad>1){
_149.push(0);
}
var i=0;
while(i<_14a){
var bits=(_149[i++]<<16)|(_149[i++]<<8)|(_149[i++]);
_14b.push(_143[(bits&16515072)>>18]);
_14b.push(_143[(bits&258048)>>12]);
_14b.push(_143[(bits&4032)>>6]);
_14b.push(_143[bits&63]);
}
if(pad>0){
_14b[_14b.length-1]="=";
_149.pop();
}
if(pad>1){
_14b[_14b.length-2]="=";
_149.pop();
}
return _14b.join("");
};
CFData.decodeBase64ToString=function(_14c,_14d){
return CFData.bytesToString(CFData.decodeBase64ToArray(_14c,_14d));
};
CFData.decodeBase64ToUtf16String=function(_14e,_14f){
return CFData.bytesToUtf16String(CFData.decodeBase64ToArray(_14e,_14f));
};
CFData.bytesToString=function(_150){
return String.fromCharCode.apply(NULL,_150);
};
CFData.encodeBase64String=function(_151){
var temp=[];
for(var i=0;i<_151.length;i++){
temp.push(_151.charCodeAt(i));
}
return CFData.encodeBase64Array(temp);
};
CFData.bytesToUtf16String=function(_152){
var temp=[];
for(var i=0;i<_152.length;i+=2){
temp.push(_152[i+1]<<8|_152[i]);
}
return String.fromCharCode.apply(NULL,temp);
};
CFData.encodeBase64Utf16String=function(_153){
var temp=[];
for(var i=0;i<_153.length;i++){
var c=_153.charCodeAt(i);
temp.push(_153.charCodeAt(i)&255);
temp.push((_153.charCodeAt(i)&65280)>>8);
}
return CFData.encodeBase64Array(temp);
};
var _154,_155,_156=0;
function _157(){
if(++_156!==1){
return;
}
_154={};
_155={};
};
function _158(){
_156=MAX(_156-1,0);
if(_156!==0){
return;
}
delete _154;
delete _155;
};
var _159=new RegExp("^"+"(?:"+"([^:/?#]+):"+")?"+"(?:"+"(//)"+"("+"(?:"+"("+"([^:@]*)"+":?"+"([^:@]*)"+")?"+"@"+")?"+"([^:/?#]*)"+"(?::(\\d*))?"+")"+")?"+"([^?#]*)"+"(?:\\?([^#]*))?"+"(?:#(.*))?");
var _15a=["url","scheme","authorityRoot","authority","userInfo","user","password","domain","portNumber","path","queryString","fragment"];
function _15b(aURL){
if(aURL._parts){
return aURL._parts;
}
var _15c=aURL.string(),_15d=_15c.match(/^mhtml:/);
if(_15d){
_15c=_15c.substr("mhtml:".length);
}
if(_156>0&&_7b.call(_155,_15c)){
aURL._parts=_155[_15c];
return aURL._parts;
}
aURL._parts={};
var _15e=aURL._parts,_15f=_159.exec(_15c),_96=_15f.length;
while(_96--){
_15e[_15a[_96]]=_15f[_96]||NULL;
}
_15e.portNumber=parseInt(_15e.portNumber,10);
if(isNaN(_15e.portNumber)){
_15e.portNumber=-1;
}
_15e.pathComponents=[];
if(_15e.path){
var _160=_15e.path.split("/"),_161=_15e.pathComponents,_96=0,_162=_160.length;
for(;_96<_162;++_96){
var _163=_160[_96];
if(_163){
_161.push(_163);
}else{
if(_96===0){
_161.push("/");
}
}
}
_15e.pathComponents=_161;
}
if(_15d){
_15e.url="mhtml:"+_15e.url;
_15e.scheme="mhtml:"+_15e.scheme;
}
if(_156>0){
_155[_15c]=_15e;
}
return _15e;
};
CFURL=function(aURL,_164){
aURL=aURL||"";
if(aURL instanceof CFURL){
if(!_164){
return aURL;
}
var _165=aURL.baseURL();
if(_165){
_164=new CFURL(_165.absoluteURL(),_164);
}
aURL=aURL.string();
}
if(_156>0){
var _166=aURL+" "+(_164&&_164.UID()||"");
if(_7b.call(_154,_166)){
return _154[_166];
}
_154[_166]=this;
}
if(aURL.match(/^data:/)){
var _167={},_96=_15a.length;
while(_96--){
_167[_15a[_96]]="";
}
_167.url=aURL;
_167.scheme="data";
_167.pathComponents=[];
this._parts=_167;
this._standardizedURL=this;
this._absoluteURL=this;
}
this._UID=objj_generateObjectUID();
this._string=aURL;
this._baseURL=_164;
};
CFURL.prototype.UID=function(){
return this._UID;
};
var _168={};
CFURL.prototype.mappedURL=function(){
return _168[this.absoluteString()]||this;
};
CFURL.setMappedURLForURL=function(_169,_16a){
_168[_169.absoluteString()]=_16a;
};
CFURL.prototype.schemeAndAuthority=function(){
var _16b="",_16c=this.scheme();
if(_16c){
_16b+=_16c+":";
}
var _16d=this.authority();
if(_16d){
_16b+="//"+_16d;
}
return _16b;
};
CFURL.prototype.absoluteString=function(){
if(this._absoluteString===_29){
this._absoluteString=this.absoluteURL().string();
}
return this._absoluteString;
};
CFURL.prototype.toString=function(){
return this.absoluteString();
};
function _16e(aURL){
aURL=aURL.standardizedURL();
var _16f=aURL.baseURL();
if(!_16f){
return aURL;
}
var _170=((aURL)._parts||_15b(aURL)),_171,_172=_16f.absoluteURL(),_173=((_172)._parts||_15b(_172));
if(_170.scheme||_170.authority){
_171=_170;
}else{
_171={};
_171.scheme=_173.scheme;
_171.authority=_173.authority;
_171.userInfo=_173.userInfo;
_171.user=_173.user;
_171.password=_173.password;
_171.domain=_173.domain;
_171.portNumber=_173.portNumber;
_171.queryString=_170.queryString;
_171.fragment=_170.fragment;
var _174=_170.pathComponents;
if(_174.length&&_174[0]==="/"){
_171.path=_170.path;
_171.pathComponents=_174;
}else{
var _175=_173.pathComponents,_176=_175.concat(_174);
if(!_16f.hasDirectoryPath()&&_175.length){
_176.splice(_175.length-1,1);
}
if(_174.length&&(_174[0]===".."||_174[0]===".")){
_177(_176,YES);
}
_171.pathComponents=_176;
_171.path=_178(_176,_174.length<=0||aURL.hasDirectoryPath());
}
}
var _179=_17a(_171),_17b=new CFURL(_179);
_17b._parts=_171;
_17b._standardizedURL=_17b;
_17b._standardizedString=_179;
_17b._absoluteURL=_17b;
_17b._absoluteString=_179;
return _17b;
};
function _178(_17c,_17d){
var path=_17c.join("/");
if(path.length&&path.charAt(0)==="/"){
path=path.substr(1);
}
if(_17d){
path+="/";
}
return path;
};
function _177(_17e,_17f){
var _180=0,_181=0,_182=_17e.length,_183=_17f?_17e:[],_184=NO;
for(;_180<_182;++_180){
var _185=_17e[_180];
if(_185===""){
continue;
}
if(_185==="."){
_184=_181===0;
continue;
}
if(_185!==".."||_181===0||_183[_181-1]===".."){
_183[_181]=_185;
_181++;
continue;
}
if(_181>0&&_183[_181-1]!=="/"){
--_181;
}
}
if(_184&&_181===0){
_183[_181++]=".";
}
_183.length=_181;
return _183;
};
function _17a(_186){
var _187="",_188=_186.scheme;
if(_188){
_187+=_188+":";
}
var _189=_186.authority;
if(_189){
_187+="//"+_189;
}
_187+=_186.path;
var _18a=_186.queryString;
if(_18a){
_187+="?"+_18a;
}
var _18b=_186.fragment;
if(_18b){
_187+="#"+_18b;
}
return _187;
};
CFURL.prototype.absoluteURL=function(){
if(this._absoluteURL===_29){
this._absoluteURL=_16e(this);
}
return this._absoluteURL;
};
CFURL.prototype.standardizedURL=function(){
if(this._standardizedURL===_29){
var _18c=((this)._parts||_15b(this)),_18d=_18c.pathComponents,_18e=_177(_18d,NO);
var _18f=_178(_18e,this.hasDirectoryPath());
if(_18c.path===_18f){
this._standardizedURL=this;
}else{
var _190=_191(_18c);
_190.pathComponents=_18e;
_190.path=_18f;
var _192=new CFURL(_17a(_190),this.baseURL());
_192._parts=_190;
_192._standardizedURL=_192;
this._standardizedURL=_192;
}
}
return this._standardizedURL;
};
function _191(_193){
var _194={},_195=_15a.length;
while(_195--){
var _196=_15a[_195];
_194[_196]=_193[_196];
}
return _194;
};
CFURL.prototype.string=function(){
return this._string;
};
CFURL.prototype.authority=function(){
var _197=((this)._parts||_15b(this)).authority;
if(_197){
return _197;
}
var _198=this.baseURL();
return _198&&_198.authority()||"";
};
CFURL.prototype.hasDirectoryPath=function(){
var _199=this._hasDirectoryPath;
if(_199===_29){
var path=this.path();
if(!path){
return NO;
}
if(path.charAt(path.length-1)==="/"){
return YES;
}
var _19a=this.lastPathComponent();
_199=_19a==="."||_19a==="..";
this._hasDirectoryPath=_199;
}
return _199;
};
CFURL.prototype.hostName=function(){
return this.authority();
};
CFURL.prototype.fragment=function(){
return ((this)._parts||_15b(this)).fragment;
};
CFURL.prototype.lastPathComponent=function(){
if(this._lastPathComponent===_29){
var _19b=this.pathComponents(),_19c=_19b.length;
if(!_19c){
this._lastPathComponent="";
}else{
this._lastPathComponent=_19b[_19c-1];
}
}
return this._lastPathComponent;
};
CFURL.prototype.path=function(){
return ((this)._parts||_15b(this)).path;
};
CFURL.prototype.pathComponents=function(){
return ((this)._parts||_15b(this)).pathComponents;
};
CFURL.prototype.pathExtension=function(){
var _19d=this.lastPathComponent();
if(!_19d){
return NULL;
}
_19d=_19d.replace(/^\.*/,"");
var _19e=_19d.lastIndexOf(".");
return _19e<=0?"":_19d.substring(_19e+1);
};
CFURL.prototype.queryString=function(){
return ((this)._parts||_15b(this)).queryString;
};
CFURL.prototype.scheme=function(){
var _19f=this._scheme;
if(_19f===_29){
_19f=((this)._parts||_15b(this)).scheme;
if(!_19f){
var _1a0=this.baseURL();
_19f=_1a0&&_1a0.scheme();
}
this._scheme=_19f;
}
return _19f;
};
CFURL.prototype.user=function(){
return ((this)._parts||_15b(this)).user;
};
CFURL.prototype.password=function(){
return ((this)._parts||_15b(this)).password;
};
CFURL.prototype.portNumber=function(){
return ((this)._parts||_15b(this)).portNumber;
};
CFURL.prototype.domain=function(){
return ((this)._parts||_15b(this)).domain;
};
CFURL.prototype.baseURL=function(){
return this._baseURL;
};
CFURL.prototype.asDirectoryPathURL=function(){
if(this.hasDirectoryPath()){
return this;
}
var _1a1=this.lastPathComponent();
if(_1a1!=="/"){
_1a1="./"+_1a1;
}
return new CFURL(_1a1+"/",this);
};
function _1a2(aURL){
if(!aURL._resourcePropertiesForKeys){
aURL._resourcePropertiesForKeys=new CFMutableDictionary();
}
return aURL._resourcePropertiesForKeys;
};
CFURL.prototype.resourcePropertyForKey=function(aKey){
return _1a2(this).valueForKey(aKey);
};
CFURL.prototype.setResourcePropertyForKey=function(aKey,_1a3){
_1a2(this).setValueForKey(aKey,_1a3);
};
CFURL.prototype.staticResourceData=function(){
var data=new CFMutableData();
data.setRawString(_1a4.resourceAtURL(this).contents());
return data;
};
function _10a(_1a5){
this._string=_1a5;
var _1a6=_1a5.indexOf(";");
this._magicNumber=_1a5.substr(0,_1a6);
this._location=_1a5.indexOf(";",++_1a6);
this._version=_1a5.substring(_1a6,this._location++);
};
_10a.prototype.magicNumber=function(){
return this._magicNumber;
};
_10a.prototype.version=function(){
return this._version;
};
_10a.prototype.getMarker=function(){
var _1a7=this._string,_1a8=this._location;
if(_1a8>=_1a7.length){
return null;
}
var next=_1a7.indexOf(";",_1a8);
if(next<0){
return null;
}
var _1a9=_1a7.substring(_1a8,next);
if(_1a9==="e"){
return null;
}
this._location=next+1;
return _1a9;
};
_10a.prototype.getString=function(){
var _1aa=this._string,_1ab=this._location;
if(_1ab>=_1aa.length){
return null;
}
var next=_1aa.indexOf(";",_1ab);
if(next<0){
return null;
}
var size=parseInt(_1aa.substring(_1ab,next),10),text=_1aa.substr(next+1,size);
this._location=next+1+size;
return text;
};
var _1ac=0,_1ad=1<<0,_1ae=1<<1,_1af=1<<2,_1b0=1<<3,_1b1=1<<4;
var _1b2={},_1b3={},_1b4=new Date().getTime(),_1b5=0,_1b6=0;
CFBundle=function(aURL){
aURL=_1b7(aURL).asDirectoryPathURL();
var _1b8=aURL.absoluteString(),_1b9=_1b2[_1b8];
if(_1b9){
return _1b9;
}
_1b2[_1b8]=this;
this._bundleURL=aURL;
this._resourcesDirectoryURL=new CFURL("Resources/",aURL);
this._staticResource=NULL;
this._isValid=NO;
this._loadStatus=_1ac;
this._loadRequests=[];
this._infoDictionary=new CFDictionary();
this._eventDispatcher=new _76(this);
};
CFBundle.environments=function(){
return ["Browser","ObjJ"];
};
CFBundle.bundleContainingURL=function(aURL){
aURL=new CFURL(".",_1b7(aURL));
var _1ba,_1bb=aURL.absoluteString();
while(!_1ba||_1ba!==_1bb){
var _1bc=_1b2[_1bb];
if(_1bc&&_1bc._isValid){
return _1bc;
}
aURL=new CFURL("..",aURL);
_1ba=_1bb;
_1bb=aURL.absoluteString();
}
return NULL;
};
CFBundle.mainBundle=function(){
return new CFBundle(_1bd);
};
function _1be(_1bf,_1c0){
if(_1c0){
_1b3[_1bf.name]=_1c0;
}
};
CFBundle.bundleForClass=function(_1c1){
return _1b3[_1c1.name]||CFBundle.mainBundle();
};
CFBundle.prototype.bundleURL=function(){
return this._bundleURL;
};
CFBundle.prototype.resourcesDirectoryURL=function(){
return this._resourcesDirectoryURL;
};
CFBundle.prototype.resourceURL=function(_1c2,_1c3,_1c4){
if(_1c3){
_1c2=_1c2+"."+_1c3;
}
if(_1c4){
_1c2=_1c4+"/"+_1c2;
}
var _1c5=(new CFURL(_1c2,this.resourcesDirectoryURL())).mappedURL();
return _1c5.absoluteURL();
};
CFBundle.prototype.mostEligibleEnvironmentURL=function(){
if(this._mostEligibleEnvironmentURL===_29){
this._mostEligibleEnvironmentURL=new CFURL(this.mostEligibleEnvironment()+".environment/",this.bundleURL());
}
return this._mostEligibleEnvironmentURL;
};
CFBundle.prototype.executableURL=function(){
if(this._executableURL===_29){
var _1c6=this.valueForInfoDictionaryKey("CPBundleExecutable");
if(!_1c6){
this._executableURL=NULL;
}else{
this._executableURL=new CFURL(_1c6,this.mostEligibleEnvironmentURL());
}
}
return this._executableURL;
};
CFBundle.prototype.infoDictionary=function(){
return this._infoDictionary;
};
CFBundle.prototype.valueForInfoDictionaryKey=function(aKey){
return this._infoDictionary.valueForKey(aKey);
};
CFBundle.prototype.hasSpritedImages=function(){
var _1c7=this._infoDictionary.valueForKey("CPBundleEnvironmentsWithImageSprites")||[],_96=_1c7.length,_1c8=this.mostEligibleEnvironment();
while(_96--){
if(_1c7[_96]===_1c8){
return YES;
}
}
return NO;
};
CFBundle.prototype.environments=function(){
return this._infoDictionary.valueForKey("CPBundleEnvironments")||["ObjJ"];
};
CFBundle.prototype.mostEligibleEnvironment=function(_1c9){
_1c9=_1c9||this.environments();
var _1ca=CFBundle.environments(),_96=0,_1cb=_1ca.length,_1cc=_1c9.length;
for(;_96<_1cb;++_96){
var _1cd=0,_1ce=_1ca[_96];
for(;_1cd<_1cc;++_1cd){
if(_1ce===_1c9[_1cd]){
return _1ce;
}
}
}
return NULL;
};
CFBundle.prototype.isLoading=function(){
return this._loadStatus&_1ad;
};
CFBundle.prototype.isLoaded=function(){
return !!(this._loadStatus&_1b1);
};
CFBundle.prototype.load=function(_1cf){
if(this._loadStatus!==_1ac){
return;
}
this._loadStatus=_1ad|_1ae;
var self=this,_1d0=this.bundleURL(),_1d1=new CFURL("..",_1d0);
if(_1d1.absoluteString()===_1d0.absoluteString()){
_1d1=_1d1.schemeAndAuthority();
}
_1a4.resolveResourceAtURL(_1d1,YES,function(_1d2){
var _1d3=_1d0.absoluteURL().lastPathComponent();
self._staticResource=_1d2._children[_1d3]||new _1a4(_1d0,_1d2,YES,NO);
function _1d4(_1d5){
self._loadStatus&=~_1ae;
var _1d6=_1d5.request.responsePropertyList();
self._isValid=!!_1d6||CFBundle.mainBundle()===self;
if(_1d6){
self._infoDictionary=_1d6;
}
if(!self._infoDictionary){
_1d8(self,new Error("Could not load bundle at \""+path+"\""));
return;
}
if(self===CFBundle.mainBundle()&&self.valueForInfoDictionaryKey("CPApplicationSize")){
_1b6=self.valueForInfoDictionaryKey("CPApplicationSize").valueForKey("executable")||0;
}
_1dc(self,_1cf);
};
function _1d7(){
self._isValid=CFBundle.mainBundle()===self;
self._loadStatus=_1ac;
_1d8(self,new Error("Could not load bundle at \""+self.bundleURL()+"\""));
};
new _b2(new CFURL("Info.plist",self.bundleURL()),_1d4,_1d7);
});
};
function _1d8(_1d9,_1da){
_1db(_1d9._staticResource);
_1d9._eventDispatcher.dispatchEvent({type:"error",error:_1da,bundle:_1d9});
};
function _1dc(_1dd,_1de){
if(!_1dd.mostEligibleEnvironment()){
return _1df();
}
_1e0(_1dd,_1e1,_1df);
_1e2(_1dd,_1e1,_1df);
if(_1dd._loadStatus===_1ad){
return _1e1();
}
function _1df(_1e3){
var _1e4=_1dd._loadRequests,_1e5=_1e4.length;
while(_1e5--){
_1e4[_1e5].abort();
}
this._loadRequests=[];
_1dd._loadStatus=_1ac;
_1d8(_1dd,_1e3||new Error("Could not recognize executable code format in Bundle "+_1dd));
};
function _1e1(){
if((typeof CPApp==="undefined"||!CPApp||!CPApp._finishedLaunching)&&typeof OBJJ_PROGRESS_CALLBACK==="function"&&_1b6){
OBJJ_PROGRESS_CALLBACK(MAX(MIN(1,_1b5/_1b6),0),_1b6,_1dd.bundlePath());
}
if(_1dd._loadStatus===_1ad){
_1dd._loadStatus=_1b1;
}else{
return;
}
_1db(_1dd._staticResource);
function _1e6(){
_1dd._eventDispatcher.dispatchEvent({type:"load",bundle:_1dd});
};
if(_1de){
_1e7(_1dd,_1e6);
}else{
_1e6();
}
};
};
function _1e0(_1e8,_1e9,_1ea){
var _1eb=_1e8.executableURL();
if(!_1eb){
return;
}
_1e8._loadStatus|=_1af;
new _b2(_1eb,function(_1ec){
try{
_1b5+=_1ec.request.responseText().length;
_1ed(_1e8,_1ec.request.responseText(),_1eb);
_1e8._loadStatus&=~_1af;
_1e9();
}
catch(anException){
_1ea(anException);
}
},_1ea);
};
function _1ee(_1ef){
return "mhtml:"+new CFURL("MHTMLTest.txt",_1ef.mostEligibleEnvironmentURL());
};
function _1f0(_1f1){
if(_1f2===_1f3){
return new CFURL("dataURLs.txt",_1f1.mostEligibleEnvironmentURL());
}
if(_1f2===_1f4||_1f2===_1f5){
return new CFURL("MHTMLPaths.txt",_1f1.mostEligibleEnvironmentURL());
}
return NULL;
};
function _1e2(_1f6,_1f7,_1f8){
if(!_1f6.hasSpritedImages()){
return;
}
_1f6._loadStatus|=_1b0;
if(!_1f9()){
return _1fa(_1ee(_1f6),function(){
_1e2(_1f6,_1f7,_1f8);
});
}
var _1fb=_1f0(_1f6);
if(!_1fb){
_1f6._loadStatus&=~_1b0;
return _1f7();
}
new _b2(_1fb,function(_1fc){
try{
_1b5+=_1fc.request.responseText().length;
_1ed(_1f6,_1fc.request.responseText(),_1fb);
_1f6._loadStatus&=~_1b0;
}
catch(anException){
_1f8(anException);
}
_1f7();
},_1f8);
};
var _1fd=[],_1f2=-1,_1fe=0,_1f3=1,_1f4=2,_1f5=3;
function _1f9(){
return _1f2!==-1;
};
function _1fa(_1ff,_200){
if(_1f9()){
return;
}
_1fd.push(_200);
if(_1fd.length>1){
return;
}
_1fd.push(function(){
var size=0,_201=CFBundle.mainBundle().valueForInfoDictionaryKey("CPApplicationSize");
if(!_201){
return;
}
switch(_1f2){
case _1f3:
size=_201.valueForKey("data");
break;
case _1f4:
case _1f5:
size=_201.valueForKey("mhtml");
break;
}
_1b6+=size;
});
_202([_1f3,"data:image/gif;base64,R0lGODlhAQABAIAAAMc9BQAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==",_1f4,_1ff+"!test",_1f5,_1ff+"?"+_1b4+"!test"]);
};
function _203(){
var _204=_1fd.length;
while(_204--){
_1fd[_204]();
}
};
function _202(_205){
if(!("Image" in _1)||_205.length<2){
_1f2=_1fe;
_203();
return;
}
var _206=new Image();
_206.onload=function(){
if(_206.width===1&&_206.height===1){
_1f2=_205[0];
_203();
}else{
_206.onerror();
}
};
_206.onerror=function(){
_202(_205.slice(2));
};
_206.src=_205[1];
};
function _1e7(_207,_208){
var _209=[_207._staticResource];
function _20a(_20b){
for(;_20b<_209.length;++_20b){
var _20c=_209[_20b];
if(_20c.isNotFound()){
continue;
}
if(_20c.isFile()){
var _20d=new _325(_20c.URL());
if(_20d.hasLoadedFileDependencies()){
_20d.execute();
}else{
_20d.loadFileDependencies(function(){
_20a(_20b);
});
return;
}
}else{
if(_20c.URL().absoluteString()===_207.resourcesDirectoryURL().absoluteString()){
continue;
}
var _20e=_20c.children();
for(var name in _20e){
if(_7b.call(_20e,name)){
_209.push(_20e[name]);
}
}
}
}
_208();
};
_20a(0);
};
var _20f="@STATIC",_210="p",_211="u",_212="c",_213="t",_214="I",_215="i";
function _1ed(_216,_217,_218){
var _219=new _10a(_217);
if(_219.magicNumber()!==_20f){
throw new Error("Could not read static file: "+_218);
}
if(_219.version()!=="1.0"){
throw new Error("Could not read static file: "+_218);
}
var _21a,_21b=_216.bundleURL(),file=NULL;
while(_21a=_219.getMarker()){
var text=_219.getString();
if(_21a===_210){
var _21c=new CFURL(text,_21b),_21d=_1a4.resourceAtURL(new CFURL(".",_21c),YES);
file=new _1a4(_21c,_21d,NO,YES);
}else{
if(_21a===_211){
var URL=new CFURL(text,_21b),_21e=_219.getString();
if(_21e.indexOf("mhtml:")===0){
_21e="mhtml:"+new CFURL(_21e.substr("mhtml:".length),_21b);
if(_1f2===_1f5){
var _21f=_21e.indexOf("!"),_220=_21e.substring(0,_21f),_221=_21e.substring(_21f);
_21e=_220+"?"+_1b4+_221;
}
}
CFURL.setMappedURLForURL(URL,new CFURL(_21e));
var _21d=_1a4.resourceAtURL(new CFURL(".",URL),YES);
new _1a4(URL,_21d,NO,YES);
}else{
if(_21a===_213){
file.write(text);
}
}
}
}
};
CFBundle.prototype.addEventListener=function(_222,_223){
this._eventDispatcher.addEventListener(_222,_223);
};
CFBundle.prototype.removeEventListener=function(_224,_225){
this._eventDispatcher.removeEventListener(_224,_225);
};
CFBundle.prototype.onerror=function(_226){
throw _226.error;
};
CFBundle.prototype.bundlePath=function(){
return this._bundleURL.absoluteURL().path();
};
CFBundle.prototype.path=function(){
CPLog.warn("CFBundle.prototype.path is deprecated, use CFBundle.prototype.bundlePath instead.");
return this.bundlePath.apply(this,arguments);
};
CFBundle.prototype.pathForResource=function(_227){
return this.resourceURL(_227).absoluteString();
};
var _228={};
function _1a4(aURL,_229,_22a,_22b){
this._parent=_229;
this._eventDispatcher=new _76(this);
var name=aURL.absoluteURL().lastPathComponent()||aURL.schemeAndAuthority();
this._name=name;
this._URL=aURL;
this._isResolved=!!_22b;
if(_22a){
this._URL=this._URL.asDirectoryPathURL();
}
if(!_229){
_228[name]=this;
}
this._isDirectory=!!_22a;
this._isNotFound=NO;
if(_229){
_229._children[name]=this;
}
if(_22a){
this._children={};
}else{
this._contents="";
}
};
_1a4.rootResources=function(){
return _228;
};
_2.StaticResource=_1a4;
function _1db(_22c){
_22c._isResolved=YES;
_22c._eventDispatcher.dispatchEvent({type:"resolve",staticResource:_22c});
};
_1a4.prototype.resolve=function(){
if(this.isDirectory()){
var _22d=new CFBundle(this.URL());
_22d.onerror=function(){
};
_22d.load(NO);
}else{
var self=this;
function _22e(_22f){
self._contents=_22f.request.responseText();
_1db(self);
};
function _230(){
self._isNotFound=YES;
_1db(self);
};
new _b2(this.URL(),_22e,_230);
}
};
_1a4.prototype.name=function(){
return this._name;
};
_1a4.prototype.URL=function(){
return this._URL;
};
_1a4.prototype.contents=function(){
return this._contents;
};
_1a4.prototype.children=function(){
return this._children;
};
_1a4.prototype.parent=function(){
return this._parent;
};
_1a4.prototype.isResolved=function(){
return this._isResolved;
};
_1a4.prototype.write=function(_231){
this._contents+=_231;
};
function _232(_233){
var _234=_233.schemeAndAuthority(),_235=_228[_234];
if(!_235){
_235=new _1a4(new CFURL(_234),NULL,YES,YES);
}
return _235;
};
_1a4.resourceAtURL=function(aURL,_236){
aURL=_1b7(aURL).absoluteURL();
var _237=_232(aURL),_238=aURL.pathComponents(),_96=0,_239=_238.length;
for(;_96<_239;++_96){
var name=_238[_96];
if(_7b.call(_237._children,name)){
_237=_237._children[name];
}else{
if(_236){
if(name!=="/"){
name="./"+name;
}
_237=new _1a4(new CFURL(name,_237.URL()),_237,YES,YES);
}else{
throw new Error("Static Resource at "+aURL+" is not resolved (\""+name+"\")");
}
}
}
return _237;
};
_1a4.prototype.resourceAtURL=function(aURL,_23a){
return _1a4.resourceAtURL(new CFURL(aURL,this.URL()),_23a);
};
_1a4.resolveResourceAtURL=function(aURL,_23b,_23c){
aURL=_1b7(aURL).absoluteURL();
_23d(_232(aURL),_23b,aURL.pathComponents(),0,_23c);
};
_1a4.prototype.resolveResourceAtURL=function(aURL,_23e,_23f){
_1a4.resolveResourceAtURL(new CFURL(aURL,this.URL()).absoluteURL(),_23e,_23f);
};
function _23d(_240,_241,_242,_243,_244){
var _245=_242.length;
for(;_243<_245;++_243){
var name=_242[_243],_246=_7b.call(_240._children,name)&&_240._children[name];
if(!_246){
_246=new _1a4(new CFURL(name,_240.URL()),_240,_243+1<_245||_241,NO);
_246.resolve();
}
if(!_246.isResolved()){
return _246.addEventListener("resolve",function(){
_23d(_240,_241,_242,_243,_244);
});
}
if(_246.isNotFound()){
return _244(null,new Error("File not found: "+_242.join("/")));
}
if((_243+1<_245)&&_246.isFile()){
return _244(null,new Error("File is not a directory: "+_242.join("/")));
}
_240=_246;
}
_244(_240);
};
function _247(aURL,_248,_249){
var _24a=_1a4.includeURLs(),_24b=new CFURL(aURL,_24a[_248]).absoluteURL();
_1a4.resolveResourceAtURL(_24b,NO,function(_24c){
if(!_24c){
if(_248+1<_24a.length){
_247(aURL,_248+1,_249);
}else{
_249(NULL);
}
return;
}
_249(_24c);
});
};
_1a4.resolveResourceAtURLSearchingIncludeURLs=function(aURL,_24d){
_247(aURL,0,_24d);
};
_1a4.prototype.addEventListener=function(_24e,_24f){
this._eventDispatcher.addEventListener(_24e,_24f);
};
_1a4.prototype.removeEventListener=function(_250,_251){
this._eventDispatcher.removeEventListener(_250,_251);
};
_1a4.prototype.isNotFound=function(){
return this._isNotFound;
};
_1a4.prototype.isFile=function(){
return !this._isDirectory;
};
_1a4.prototype.isDirectory=function(){
return this._isDirectory;
};
_1a4.prototype.toString=function(_252){
if(this.isNotFound()){
return "<file not found: "+this.name()+">";
}
var _253=this.name();
if(this.isDirectory()){
var _254=this._children;
for(var name in _254){
if(_254.hasOwnProperty(name)){
var _255=_254[name];
if(_252||!_255.isNotFound()){
_253+="\n\t"+_254[name].toString(_252).split("\n").join("\n\t");
}
}
}
}
return _253;
};
var _256=NULL;
_1a4.includeURLs=function(){
if(_256!==NULL){
return _256;
}
_256=[];
if(!_1.OBJJ_INCLUDE_PATHS&&!_1.OBJJ_INCLUDE_URLS){
_256=["Frameworks","Frameworks/Debug"];
}else{
_256=(_1.OBJJ_INCLUDE_PATHS||[]).concat(_1.OBJJ_INCLUDE_URLS||[]);
}
var _257=_256.length;
while(_257--){
_256[_257]=new CFURL(_256[_257]).asDirectoryPathURL();
}
return _256;
};
var _258="accessors",_259="class",_25a="end",_25b="function",_25c="implementation",_25d="import",_25e="each",_25f="outlet",_260="action",_261="new",_262="selector",_263="super",_264="var",_265="in",_266="pragma",_267="mark",_268="=",_269="+",_26a="-",_26b=":",_26c=",",_26d=".",_26e="*",_26f=";",_270="<",_271="{",_272="}",_273=">",_274="[",_275="\"",_276="@",_277="#",_278="]",_279="?",_27a="(",_27b=")",_27c=/^(?:(?:\s+$)|(?:\/(?:\/|\*)))/,_27d=/^[+-]?\d+(([.]\d+)*([eE][+-]?\d+))?$/,_27e=/^[a-zA-Z_$](\w|$)*$/;
function _27f(_280){
this._index=-1;
this._tokens=(_280+"\n").match(/\/\/.*(\r|\n)?|\/\*(?:.|\n|\r)*?\*\/|\w+\b|[+-]?\d+(([.]\d+)*([eE][+-]?\d+))?|"[^"\\]*(\\[\s\S][^"\\]*)*"|'[^'\\]*(\\[\s\S][^'\\]*)*'|\s+|./g);
this._context=[];
return this;
};
_27f.prototype.push=function(){
this._context.push(this._index);
};
_27f.prototype.pop=function(){
this._index=this._context.pop();
};
_27f.prototype.peek=function(_281){
if(_281){
this.push();
var _282=this.skip_whitespace();
this.pop();
return _282;
}
return this._tokens[this._index+1];
};
_27f.prototype.next=function(){
return this._tokens[++this._index];
};
_27f.prototype.previous=function(){
return this._tokens[--this._index];
};
_27f.prototype.last=function(){
if(this._index<0){
return NULL;
}
return this._tokens[this._index-1];
};
_27f.prototype.skip_whitespace=function(_283){
var _284;
if(_283){
while((_284=this.previous())&&_27c.test(_284)){
}
}else{
while((_284=this.next())&&_27c.test(_284)){
}
}
return _284;
};
_2.Lexer=_27f;
function _285(){
this.atoms=[];
};
_285.prototype.toString=function(){
return this.atoms.join("");
};
_2.preprocess=function(_286,aURL,_287){
return new _288(_286,aURL,_287).executable();
};
_2.eval=function(_289){
return eval(_2.preprocess(_289).code());
};
var _288=function(_28a,aURL,_28b){
this._URL=new CFURL(aURL);
_28a=_28a.replace(/^#[^\n]+\n/,"\n");
this._currentSelector="";
this._currentClass="";
this._currentSuperClass="";
this._currentSuperMetaClass="";
this._buffer=new _285();
this._preprocessed=NULL;
this._dependencies=[];
this._tokens=new _27f(_28a);
this._flags=_28b;
this._classMethod=false;
this._executable=NULL;
this._classLookupTable={};
this._classVars={};
var _28c=new objj_class();
for(var i in _28c){
this._classVars[i]=1;
}
this.preprocess(this._tokens,this._buffer);
};
_288.prototype.setClassInfo=function(_28d,_28e,_28f){
this._classLookupTable[_28d]={superClassName:_28e,ivars:_28f};
};
_288.prototype.getClassInfo=function(_290){
return this._classLookupTable[_290];
};
_288.prototype.allIvarNamesForClassName=function(_291){
var _292={},_293=this.getClassInfo(_291);
while(_293){
for(var i in _293.ivars){
_292[i]=1;
}
_293=this.getClassInfo(_293.superClassName);
}
return _292;
};
_2.Preprocessor=_288;
_288.Flags={};
_288.Flags.IncludeDebugSymbols=1<<0;
_288.Flags.IncludeTypeSignatures=1<<1;
_288.prototype.executable=function(){
if(!this._executable){
this._executable=new _294(this._buffer.toString(),this._dependencies,this._URL);
}
return this._executable;
};
_288.prototype.accessors=function(_295){
var _296=_295.skip_whitespace(),_297={};
if(_296!=_27a){
_295.previous();
return _297;
}
while((_296=_295.skip_whitespace())!=_27b){
var name=_296,_298=true;
if(!/^\w+$/.test(name)){
throw new SyntaxError(this.error_message("*** @accessors attribute name not valid."));
}
if((_296=_295.skip_whitespace())==_268){
_298=_295.skip_whitespace();
if(!/^\w+$/.test(_298)){
throw new SyntaxError(this.error_message("*** @accessors attribute value not valid."));
}
if(name=="setter"){
if((_296=_295.next())!=_26b){
throw new SyntaxError(this.error_message("*** @accessors setter attribute requires argument with \":\" at end of selector name."));
}
_298+=":";
}
_296=_295.skip_whitespace();
}
_297[name]=_298;
if(_296==_27b){
break;
}
if(_296!=_26c){
throw new SyntaxError(this.error_message("*** Expected ',' or ')' in @accessors attribute list."));
}
}
return _297;
};
_288.prototype.brackets=function(_299,_29a){
var _29b=[];
while(this.preprocess(_299,NULL,NULL,NULL,_29b[_29b.length]=[])){
}
if(_29b[0].length===1){
_29a.atoms[_29a.atoms.length]="[";
_29a.atoms[_29a.atoms.length]=_29b[0][0];
_29a.atoms[_29a.atoms.length]="]";
}else{
var _29c=new _285();
if(_29b[0][0].atoms[0]==_263){
_29a.atoms[_29a.atoms.length]="objj_msgSendSuper(";
_29a.atoms[_29a.atoms.length]="{ receiver:self, super_class:"+(this._classMethod?this._currentSuperMetaClass:this._currentSuperClass)+" }";
}else{
_29a.atoms[_29a.atoms.length]="objj_msgSend(";
_29a.atoms[_29a.atoms.length]=_29b[0][0];
}
_29c.atoms[_29c.atoms.length]=_29b[0][1];
var _29d=1,_29e=_29b.length,_29f=new _285();
for(;_29d<_29e;++_29d){
var pair=_29b[_29d];
_29c.atoms[_29c.atoms.length]=pair[1];
_29f.atoms[_29f.atoms.length]=", "+pair[0];
}
_29a.atoms[_29a.atoms.length]=", \"";
_29a.atoms[_29a.atoms.length]=_29c;
_29a.atoms[_29a.atoms.length]="\"";
_29a.atoms[_29a.atoms.length]=_29f;
_29a.atoms[_29a.atoms.length]=")";
}
};
_288.prototype.directive=function(_2a0,_2a1,_2a2){
var _2a3=_2a1?_2a1:new _285(),_2a4=_2a0.next();
if(_2a4.charAt(0)==_275){
_2a3.atoms[_2a3.atoms.length]=_2a4;
}else{
if(_2a4===_259){
_2a0.skip_whitespace();
return;
}else{
if(_2a4===_25c){
this.implementation(_2a0,_2a3);
}else{
if(_2a4===_25d){
this._import(_2a0);
}else{
if(_2a4===_262){
this.selector(_2a0,_2a3);
}
}
}
}
}
if(!_2a1){
return _2a3;
}
};
_288.prototype.hash=function(_2a5,_2a6){
var _2a7=_2a6?_2a6:new _285(),_2a8=_2a5.next();
if(_2a8===_266){
_2a8=_2a5.skip_whitespace();
if(_2a8===_267){
while((_2a8=_2a5.next()).indexOf("\n")<0){
}
}
}else{
throw new SyntaxError(this.error_message("*** Expected \"pragma\" to follow # but instead saw \""+_2a8+"\"."));
}
};
_288.prototype.implementation=function(_2a9,_2aa){
var _2ab=_2aa,_2ac="",_2ad=NO,_2ae=_2a9.skip_whitespace(),_2af="Nil",_2b0=new _285(),_2b1=new _285();
if(!(/^\w/).test(_2ae)){
throw new Error(this.error_message("*** Expected class name, found \""+_2ae+"\"."));
}
this._currentSuperClass="objj_getClass(\""+_2ae+"\").super_class";
this._currentSuperMetaClass="objj_getMetaClass(\""+_2ae+"\").super_class";
this._currentClass=_2ae;
this._currentSelector="";
if((_2ac=_2a9.skip_whitespace())==_27a){
_2ac=_2a9.skip_whitespace();
if(_2ac==_27b){
throw new SyntaxError(this.error_message("*** Can't Have Empty Category Name for class \""+_2ae+"\"."));
}
if(_2a9.skip_whitespace()!=_27b){
throw new SyntaxError(this.error_message("*** Improper Category Definition for class \""+_2ae+"\"."));
}
_2ab.atoms[_2ab.atoms.length]="{\nvar the_class = objj_getClass(\""+_2ae+"\")\n";
_2ab.atoms[_2ab.atoms.length]="if(!the_class) throw new SyntaxError(\"*** Could not find definition for class \\\""+_2ae+"\\\"\");\n";
_2ab.atoms[_2ab.atoms.length]="var meta_class = the_class.isa;";
}else{
if(_2ac==_26b){
_2ac=_2a9.skip_whitespace();
if(!_27e.test(_2ac)){
throw new SyntaxError(this.error_message("*** Expected class name, found \""+_2ac+"\"."));
}
_2af=_2ac;
_2ac=_2a9.skip_whitespace();
}
_2ab.atoms[_2ab.atoms.length]="{var the_class = objj_allocateClassPair("+_2af+", \""+_2ae+"\"),\nmeta_class = the_class.isa;";
if(_2ac==_271){
var _2b2={},_2b3=0,_2b4=[],_2b5,_2b6={},_2b7=[];
while((_2ac=_2a9.skip_whitespace())&&_2ac!=_272){
if(_2ac===_276){
_2ac=_2a9.next();
if(_2ac===_258){
_2b5=this.accessors(_2a9);
}else{
if(_2ac!==_25f){
throw new SyntaxError(this.error_message("*** Unexpected '@' token in ivar declaration ('@"+_2ac+"')."));
}else{
_2b7.push("@"+_2ac);
}
}
}else{
if(_2ac==_26f){
if(_2b3++===0){
_2ab.atoms[_2ab.atoms.length]="class_addIvars(the_class, [";
}else{
_2ab.atoms[_2ab.atoms.length]=", ";
}
var name=_2b4[_2b4.length-1];
if(this._flags&_288.Flags.IncludeTypeSignatures){
_2ab.atoms[_2ab.atoms.length]="new objj_ivar(\""+name+"\", \""+_2b7.slice(0,_2b7.length-1).join(" ")+"\")";
}else{
_2ab.atoms[_2ab.atoms.length]="new objj_ivar(\""+name+"\")";
}
_2b2[name]=1;
_2b4=[];
_2b7=[];
if(_2b5){
_2b6[name]=_2b5;
_2b5=NULL;
}
}else{
_2b4.push(_2ac);
_2b7.push(_2ac);
}
}
}
if(_2b4.length){
throw new SyntaxError(this.error_message("*** Expected ';' in ivar declaration, found '}'."));
}
if(_2b3){
_2ab.atoms[_2ab.atoms.length]="]);\n";
}
if(!_2ac){
throw new SyntaxError(this.error_message("*** Expected '}'"));
}
this.setClassInfo(_2ae,_2af==="Nil"?null:_2af,_2b2);
var _2b2=this.allIvarNamesForClassName(_2ae);
for(ivar_name in _2b6){
var _2b8=_2b6[ivar_name],_2b9=_2b8["property"]||ivar_name;
var _2ba=_2b8["getter"]||_2b9,_2bb="(id)"+_2ba+"\n{\nreturn "+ivar_name+";\n}";
if(_2b0.atoms.length!==0){
_2b0.atoms[_2b0.atoms.length]=",\n";
}
_2b0.atoms[_2b0.atoms.length]=this.method(new _27f(_2bb),_2b2);
if(_2b8["readonly"]){
continue;
}
var _2bc=_2b8["setter"];
if(!_2bc){
var _2bd=_2b9.charAt(0)=="_"?1:0;
_2bc=(_2bd?"_":"")+"set"+_2b9.substr(_2bd,1).toUpperCase()+_2b9.substring(_2bd+1)+":";
}
var _2be="(void)"+_2bc+"(id)newValue\n{\n";
if(_2b8["copy"]){
_2be+="if ("+ivar_name+" !== newValue)\n"+ivar_name+" = [newValue copy];\n}";
}else{
_2be+=ivar_name+" = newValue;\n}";
}
if(_2b0.atoms.length!==0){
_2b0.atoms[_2b0.atoms.length]=",\n";
}
_2b0.atoms[_2b0.atoms.length]=this.method(new _27f(_2be),_2b2);
}
}else{
_2a9.previous();
}
_2ab.atoms[_2ab.atoms.length]="objj_registerClassPair(the_class);\n";
}
if(!_2b2){
var _2b2=this.allIvarNamesForClassName(_2ae);
}
while((_2ac=_2a9.skip_whitespace())){
if(_2ac==_269){
this._classMethod=true;
if(_2b1.atoms.length!==0){
_2b1.atoms[_2b1.atoms.length]=", ";
}
_2b1.atoms[_2b1.atoms.length]=this.method(_2a9,this._classVars);
}else{
if(_2ac==_26a){
this._classMethod=false;
if(_2b0.atoms.length!==0){
_2b0.atoms[_2b0.atoms.length]=", ";
}
_2b0.atoms[_2b0.atoms.length]=this.method(_2a9,_2b2);
}else{
if(_2ac==_277){
this.hash(_2a9,_2ab);
}else{
if(_2ac==_276){
if((_2ac=_2a9.next())==_25a){
break;
}else{
throw new SyntaxError(this.error_message("*** Expected \"@end\", found \"@"+_2ac+"\"."));
}
}
}
}
}
}
if(_2b0.atoms.length!==0){
_2ab.atoms[_2ab.atoms.length]="class_addMethods(the_class, [";
_2ab.atoms[_2ab.atoms.length]=_2b0;
_2ab.atoms[_2ab.atoms.length]="]);\n";
}
if(_2b1.atoms.length!==0){
_2ab.atoms[_2ab.atoms.length]="class_addMethods(meta_class, [";
_2ab.atoms[_2ab.atoms.length]=_2b1;
_2ab.atoms[_2ab.atoms.length]="]);\n";
}
_2ab.atoms[_2ab.atoms.length]="}";
this._currentClass="";
};
_288.prototype._import=function(_2bf){
var _2c0="",_2c1=_2bf.skip_whitespace(),_2c2=(_2c1!==_270);
if(_2c1===_270){
while((_2c1=_2bf.next())&&_2c1!==_273){
_2c0+=_2c1;
}
if(!_2c1){
throw new SyntaxError(this.error_message("*** Unterminated import statement."));
}
}else{
if(_2c1.charAt(0)===_275){
_2c0=_2c1.substr(1,_2c1.length-2);
}else{
throw new SyntaxError(this.error_message("*** Expecting '<' or '\"', found \""+_2c1+"\"."));
}
}
this._buffer.atoms[this._buffer.atoms.length]="objj_executeFile(\"";
this._buffer.atoms[this._buffer.atoms.length]=_2c0;
this._buffer.atoms[this._buffer.atoms.length]=_2c2?"\", YES);":"\", NO);";
this._dependencies.push(new _2c3(new CFURL(_2c0),_2c2));
};
_288.prototype.method=function(_2c4,_2c5){
var _2c6=new _285(),_2c7,_2c8="",_2c9=[],_2ca=[null];
_2c5=_2c5||{};
while((_2c7=_2c4.skip_whitespace())&&_2c7!==_271&&_2c7!==_26f){
if(_2c7==_26b){
var type="";
_2c8+=_2c7;
_2c7=_2c4.skip_whitespace();
if(_2c7==_27a){
while((_2c7=_2c4.skip_whitespace())&&_2c7!=_27b){
type+=_2c7;
}
_2c7=_2c4.skip_whitespace();
}
_2ca[_2c9.length+1]=type||null;
_2c9[_2c9.length]=_2c7;
if(_2c7 in _2c5){
CPLog.warn(this.error_message("*** Warning: Method ( "+_2c8+" ) uses a parameter name that is already in use ( "+_2c7+" )"));
}
}else{
if(_2c7==_27a){
var type="";
while((_2c7=_2c4.skip_whitespace())&&_2c7!=_27b){
type+=_2c7;
}
_2ca[0]=type||null;
}else{
if(_2c7==_26c){
if((_2c7=_2c4.skip_whitespace())!=_26d||_2c4.next()!=_26d||_2c4.next()!=_26d){
throw new SyntaxError(this.error_message("*** Argument list expected after ','."));
}
}else{
_2c8+=_2c7;
}
}
}
}
if(_2c7===_26f){
_2c7=_2c4.skip_whitespace();
if(_2c7!==_271){
throw new SyntaxError(this.error_message("Invalid semi-colon in method declaration. "+"Semi-colons are allowed only to terminate the method signature, before the open brace."));
}
}
var _2cb=0,_2cc=_2c9.length;
_2c6.atoms[_2c6.atoms.length]="new objj_method(sel_getUid(\"";
_2c6.atoms[_2c6.atoms.length]=_2c8;
_2c6.atoms[_2c6.atoms.length]="\"), function";
this._currentSelector=_2c8;
if(this._flags&_288.Flags.IncludeDebugSymbols){
_2c6.atoms[_2c6.atoms.length]=" $"+this._currentClass+"__"+_2c8.replace(/:/g,"_");
}
_2c6.atoms[_2c6.atoms.length]="(self, _cmd";
for(;_2cb<_2cc;++_2cb){
_2c6.atoms[_2c6.atoms.length]=", ";
_2c6.atoms[_2c6.atoms.length]=_2c9[_2cb];
}
_2c6.atoms[_2c6.atoms.length]=")\n{ with(self)\n{";
_2c6.atoms[_2c6.atoms.length]=this.preprocess(_2c4,NULL,_272,_271);
_2c6.atoms[_2c6.atoms.length]="}\n}";
if(this._flags&_288.Flags.IncludeDebugSymbols){
_2c6.atoms[_2c6.atoms.length]=","+JSON.stringify(_2ca);
}
_2c6.atoms[_2c6.atoms.length]=")";
this._currentSelector="";
return _2c6;
};
_288.prototype.preprocess=function(_2cd,_2ce,_2cf,_2d0,_2d1){
var _2d2=_2ce?_2ce:new _285(),_2d3=0,_2d4="";
if(_2d1){
_2d1[0]=_2d2;
var _2d5=false,_2d6=[0,0,0];
}
while((_2d4=_2cd.next())&&((_2d4!==_2cf)||_2d3)){
if(_2d1){
if(_2d4===_279){
++_2d6[2];
}else{
if(_2d4===_271){
++_2d6[0];
}else{
if(_2d4===_272){
--_2d6[0];
}else{
if(_2d4===_27a){
++_2d6[1];
}else{
if(_2d4===_27b){
--_2d6[1];
}else{
if((_2d4===_26b&&_2d6[2]--===0||(_2d5=(_2d4===_278)))&&_2d6[0]===0&&_2d6[1]===0){
_2cd.push();
var _2d7=_2d5?_2cd.skip_whitespace(true):_2cd.previous(),_2d8=_27c.test(_2d7);
if(_2d8||_27e.test(_2d7)&&_27c.test(_2cd.previous())){
_2cd.push();
var last=_2cd.skip_whitespace(true),_2d9=true,_2da=false;
if(last==="+"||last==="-"){
if(_2cd.previous()!==last){
_2d9=false;
}else{
last=_2cd.skip_whitespace(true);
_2da=true;
}
}
_2cd.pop();
_2cd.pop();
if(_2d9&&((!_2da&&(last===_272))||last===_27b||last===_278||last===_26d||_27d.test(last)||last.charAt(last.length-1)==="\""||last.charAt(last.length-1)==="'"||_27e.test(last)&&!/^(new|return|case|var)$/.test(last))){
if(_2d8){
_2d1[1]=":";
}else{
_2d1[1]=_2d7;
if(!_2d5){
_2d1[1]+=":";
}
var _2d3=_2d2.atoms.length;
while(_2d2.atoms[_2d3--]!==_2d7){
}
_2d2.atoms.length=_2d3;
}
return !_2d5;
}
if(_2d5){
return NO;
}
}
_2cd.pop();
if(_2d5){
return NO;
}
}
}
}
}
}
}
_2d6[2]=MAX(_2d6[2],0);
}
if(_2d0){
if(_2d4===_2d0){
++_2d3;
}else{
if(_2d4===_2cf){
--_2d3;
}
}
}
if(_2d4===_25b){
var _2db="";
while((_2d4=_2cd.next())&&_2d4!==_27a&&!(/^\w/).test(_2d4)){
_2db+=_2d4;
}
if(_2d4===_27a){
if(_2d0===_27a){
++_2d3;
}
_2d2.atoms[_2d2.atoms.length]="function"+_2db+"(";
if(_2d1){
++_2d6[1];
}
}else{
_2d2.atoms[_2d2.atoms.length]=_2d4+" = function";
}
}else{
if(_2d4==_276){
this.directive(_2cd,_2d2);
}else{
if(_2d4==_277){
this.hash(_2cd,_2d2);
}else{
if(_2d4==_274){
this.brackets(_2cd,_2d2);
}else{
_2d2.atoms[_2d2.atoms.length]=_2d4;
}
}
}
}
}
if(_2d1){
throw new SyntaxError(this.error_message("*** Expected ']' - Unterminated message send or array."));
}
if(!_2ce){
return _2d2;
}
};
_288.prototype.selector=function(_2dc,_2dd){
var _2de=_2dd?_2dd:new _285();
_2de.atoms[_2de.atoms.length]="sel_getUid(\"";
if(_2dc.skip_whitespace()!=_27a){
throw new SyntaxError(this.error_message("*** Expected '('"));
}
var _2df=_2dc.skip_whitespace();
if(_2df==_27b){
throw new SyntaxError(this.error_message("*** Unexpected ')', can't have empty @selector()"));
}
_2dd.atoms[_2dd.atoms.length]=_2df;
var _2e0,_2e1=true;
while((_2e0=_2dc.next())&&_2e0!=_27b){
if(_2e1&&/^\d+$/.test(_2e0)||!(/^(\w|$|\:)/.test(_2e0))){
if(!(/\S/).test(_2e0)){
if(_2dc.skip_whitespace()==_27b){
break;
}else{
throw new SyntaxError(this.error_message("*** Unexpected whitespace in @selector()."));
}
}else{
throw new SyntaxError(this.error_message("*** Illegal character '"+_2e0+"' in @selector()."));
}
}
_2de.atoms[_2de.atoms.length]=_2e0;
_2e1=(_2e0==_26b);
}
_2de.atoms[_2de.atoms.length]="\")";
if(!_2dd){
return _2de;
}
};
_288.prototype.error_message=function(_2e2){
return _2e2+" <Context File: "+this._URL+(this._currentClass?" Class: "+this._currentClass:"")+(this._currentSelector?" Method: "+this._currentSelector:"")+">";
};
function _2c3(aURL,_2e3){
this._URL=aURL;
this._isLocal=_2e3;
};
_2.FileDependency=_2c3;
_2c3.prototype.URL=function(){
return this._URL;
};
_2c3.prototype.isLocal=function(){
return this._isLocal;
};
_2c3.prototype.toMarkedString=function(){
var _2e4=this.URL().absoluteString();
return (this.isLocal()?_215:_214)+";"+_2e4.length+";"+_2e4;
};
_2c3.prototype.toString=function(){
return (this.isLocal()?"LOCAL: ":"STD: ")+this.URL();
};
var _2e5=0,_2e6=1,_2e7=2,_2e8=0;
function _294(_2e9,_2ea,aURL,_2eb){
if(arguments.length===0){
return this;
}
this._code=_2e9;
this._function=_2eb||NULL;
this._URL=_1b7(aURL||new CFURL("(Anonymous"+(_2e8++)+")"));
this._fileDependencies=_2ea;
if(_2ea.length){
this._fileDependencyStatus=_2e5;
this._fileDependencyCallbacks=[];
}else{
this._fileDependencyStatus=_2e7;
}
if(this._function){
return;
}
this.setCode(_2e9);
};
_2.Executable=_294;
_294.prototype.path=function(){
return this.URL().path();
};
_294.prototype.URL=function(){
return this._URL;
};
_294.prototype.functionParameters=function(){
var _2ec=["global","objj_executeFile","objj_importFile"];
return _2ec;
};
_294.prototype.functionArguments=function(){
var _2ed=[_1,this.fileExecuter(),this.fileImporter()];
return _2ed;
};
_294.prototype.execute=function(){
var _2ee=_2ef;
_2ef=CFBundle.bundleContainingURL(this.URL());
var _2f0=this._function.apply(_1,this.functionArguments());
_2ef=_2ee;
return _2f0;
};
_294.prototype.code=function(){
return this._code;
};
_294.prototype.setCode=function(code){
this._code=code;
var _2f1=this.functionParameters().join(",");
this._function=new Function(_2f1,code);
};
_294.prototype.fileDependencies=function(){
return this._fileDependencies;
};
_294.prototype.hasLoadedFileDependencies=function(){
return this._fileDependencyStatus===_2e7;
};
var _2f2=0,_2f3=[],_2f4={};
_294.prototype.loadFileDependencies=function(_2f5){
var _2f6=this._fileDependencyStatus;
if(_2f5){
if(_2f6===_2e7){
return _2f5();
}
this._fileDependencyCallbacks.push(_2f5);
}
if(_2f6===_2e5){
if(_2f2){
throw "Can't load";
}
_2f7(this);
}
};
function _2f7(_2f8){
_2f3.push(_2f8);
_2f8._fileDependencyStatus=_2e6;
var _2f9=_2f8.fileDependencies(),_96=0,_2fa=_2f9.length,_2fb=_2f8.referenceURL(),_2fc=_2fb.absoluteString(),_2fd=_2f8.fileExecutableSearcher();
_2f2+=_2fa;
for(;_96<_2fa;++_96){
var _2fe=_2f9[_96],_2ff=_2fe.isLocal(),URL=_2fe.URL(),_300=(_2ff&&(_2fc+" ")||"")+URL;
if(_2f4[_300]){
if(--_2f2===0){
_301();
}
continue;
}
_2f4[_300]=YES;
_2fd(URL,_2ff,_302);
}
};
function _302(_303){
--_2f2;
if(_303._fileDependencyStatus===_2e5){
_2f7(_303);
}else{
if(_2f2===0){
_301();
}
}
};
function _301(){
var _304=_2f3,_96=0,_305=_304.length;
_2f3=[];
for(;_96<_305;++_96){
_304[_96]._fileDependencyStatus=_2e7;
}
for(_96=0;_96<_305;++_96){
var _306=_304[_96],_307=_306._fileDependencyCallbacks,_308=0,_309=_307.length;
for(;_308<_309;++_308){
_307[_308]();
}
_306._fileDependencyCallbacks=[];
}
};
_294.prototype.referenceURL=function(){
if(this._referenceURL===_29){
this._referenceURL=new CFURL(".",this.URL());
}
return this._referenceURL;
};
_294.prototype.fileImporter=function(){
return _294.fileImporterForURL(this.referenceURL());
};
_294.prototype.fileExecuter=function(){
return _294.fileExecuterForURL(this.referenceURL());
};
_294.prototype.fileExecutableSearcher=function(){
return _294.fileExecutableSearcherForURL(this.referenceURL());
};
var _30a={};
_294.fileExecuterForURL=function(aURL){
var _30b=_1b7(aURL),_30c=_30b.absoluteString(),_30d=_30a[_30c];
if(!_30d){
_30d=function(aURL,_30e,_30f){
_294.fileExecutableSearcherForURL(_30b)(aURL,_30e,function(_310){
if(!_310.hasLoadedFileDependencies()){
throw "No executable loaded for file at URL "+aURL;
}
_310.execute(_30f);
});
};
_30a[_30c]=_30d;
}
return _30d;
};
var _311={};
_294.fileImporterForURL=function(aURL){
var _312=_1b7(aURL),_313=_312.absoluteString(),_314=_311[_313];
if(!_314){
_314=function(aURL,_315,_316){
_157();
_294.fileExecutableSearcherForURL(_312)(aURL,_315,function(_317){
_317.loadFileDependencies(function(){
_317.execute();
_158();
if(_316){
_316();
}
});
});
};
_311[_313]=_314;
}
return _314;
};
var _318={},_319={};
_294.fileExecutableSearcherForURL=function(_31a){
var _31b=_31a.absoluteString(),_31c=_318[_31b],_31d={};
if(!_31c){
_31c=function(aURL,_31e,_31f){
var _320=(_31e&&_31a||"")+aURL,_321=_319[_320];
if(_321){
return _322(_321);
}
var _323=(aURL instanceof CFURL)&&aURL.scheme();
if(_31e||_323){
if(!_323){
aURL=new CFURL(aURL,_31a);
}
_1a4.resolveResourceAtURL(aURL,NO,_322);
}else{
_1a4.resolveResourceAtURLSearchingIncludeURLs(aURL,_322);
}
function _322(_324){
if(!_324){
throw new Error("Could not load file at "+aURL);
}
_319[_320]=_324;
_31f(new _325(_324.URL()));
};
};
_318[_31b]=_31c;
}
return _31c;
};
var _326={};
function _325(aURL){
aURL=_1b7(aURL);
var _327=aURL.absoluteString(),_328=_326[_327];
if(_328){
return _328;
}
_326[_327]=this;
var _329=_1a4.resourceAtURL(aURL).contents(),_32a=NULL,_32b=aURL.pathExtension();
if(_329.match(/^@STATIC;/)){
_32a=_32c(_329,aURL);
}else{
if(_32b==="j"||!_32b){
_32a=_2.preprocess(_329,aURL,_288.Flags.IncludeDebugSymbols);
}else{
_32a=new _294(_329,[],aURL);
}
}
_294.apply(this,[_32a.code(),_32a.fileDependencies(),aURL,_32a._function]);
this._hasExecuted=NO;
};
_2.FileExecutable=_325;
_325.prototype=new _294();
_325.prototype.execute=function(_32d){
if(this._hasExecuted&&!_32d){
return;
}
this._hasExecuted=YES;
_294.prototype.execute.call(this);
};
_325.prototype.hasExecuted=function(){
return this._hasExecuted;
};
function _32c(_32e,aURL){
var _32f=new _10a(_32e);
var _330=NULL,code="",_331=[];
while(_330=_32f.getMarker()){
var text=_32f.getString();
if(_330===_213){
code+=text;
}else{
if(_330===_214){
_331.push(new _2c3(new CFURL(text),NO));
}else{
if(_330===_215){
_331.push(new _2c3(new CFURL(text),YES));
}
}
}
}
var fn=_325._lookupCachedFunction(aURL);
if(fn){
return new _294(code,_331,aURL,fn);
}
return new _294(code,_331,aURL);
};
var _332={};
_325._cacheFunction=function(aURL,fn){
aURL=typeof aURL==="string"?aURL:aURL.absoluteString();
_332[aURL]=fn;
};
_325._lookupCachedFunction=function(aURL){
aURL=typeof aURL==="string"?aURL:aURL.absoluteString();
return _332[aURL];
};
var _333=1,_334=2,_335=4,_336=8;
objj_ivar=function(_337,_338){
this.name=_337;
this.type=_338;
};
objj_method=function(_339,_33a,_33b){
this.name=_339;
this.method_imp=_33a;
this.types=_33b;
};
objj_class=function(_33c){
this.isa=NULL;
this.version=0;
this.super_class=NULL;
this.sub_classes=[];
this.name=NULL;
this.info=0;
this.ivar_list=[];
this.ivar_store=function(){
};
this.ivar_dtable=this.ivar_store.prototype;
this.method_list=[];
this.method_store=function(){
};
this.method_dtable=this.method_store.prototype;
this.allocator=function(){
};
this._UID=-1;
};
objj_object=function(){
this.isa=NULL;
this._UID=-1;
};
class_getName=function(_33d){
if(_33d==Nil){
return "";
}
return _33d.name;
};
class_isMetaClass=function(_33e){
if(!_33e){
return NO;
}
return ((_33e.info&(_334)));
};
class_getSuperclass=function(_33f){
if(_33f==Nil){
return Nil;
}
return _33f.super_class;
};
class_setSuperclass=function(_340,_341){
_340.super_class=_341;
_340.isa.super_class=_341.isa;
};
class_addIvar=function(_342,_343,_344){
var _345=_342.allocator.prototype;
if(typeof _345[_343]!="undefined"){
return NO;
}
var ivar=new objj_ivar(_343,_344);
_342.ivar_list.push(ivar);
_342.ivar_dtable[_343]=ivar;
_345[_343]=NULL;
return YES;
};
class_addIvars=function(_346,_347){
var _348=0,_349=_347.length,_34a=_346.allocator.prototype;
for(;_348<_349;++_348){
var ivar=_347[_348],name=ivar.name;
if(typeof _34a[name]==="undefined"){
_346.ivar_list.push(ivar);
_346.ivar_dtable[name]=ivar;
_34a[name]=NULL;
}
}
};
class_copyIvarList=function(_34b){
return _34b.ivar_list.slice(0);
};
class_addMethod=function(_34c,_34d,_34e,_34f){
var _350=new objj_method(_34d,_34e,_34f);
_34c.method_list.push(_350);
_34c.method_dtable[_34d]=_350;
if(!((_34c.info&(_334)))&&(((_34c.info&(_334)))?_34c:_34c.isa).isa===(((_34c.info&(_334)))?_34c:_34c.isa)){
class_addMethod((((_34c.info&(_334)))?_34c:_34c.isa),_34d,_34e,_34f);
}
return YES;
};
class_addMethods=function(_351,_352){
var _353=0,_354=_352.length,_355=_351.method_list,_356=_351.method_dtable;
for(;_353<_354;++_353){
var _357=_352[_353];
_355.push(_357);
_356[_357.name]=_357;
}
if(!((_351.info&(_334)))&&(((_351.info&(_334)))?_351:_351.isa).isa===(((_351.info&(_334)))?_351:_351.isa)){
class_addMethods((((_351.info&(_334)))?_351:_351.isa),_352);
}
};
class_getInstanceMethod=function(_358,_359){
if(!_358||!_359){
return NULL;
}
var _35a=_358.method_dtable[_359];
return _35a?_35a:NULL;
};
class_getInstanceVariable=function(_35b,_35c){
if(!_35b||!_35c){
return NULL;
}
var _35d=_35b.ivar_dtable[_35c];
return _35d;
};
class_getClassMethod=function(_35e,_35f){
if(!_35e||!_35f){
return NULL;
}
var _360=(((_35e.info&(_334)))?_35e:_35e.isa).method_dtable[_35f];
return _360?_360:NULL;
};
class_respondsToSelector=function(_361,_362){
return class_getClassMethod(_361,_362)!=NULL;
};
class_copyMethodList=function(_363){
return _363.method_list.slice(0);
};
class_getVersion=function(_364){
return _364.version;
};
class_setVersion=function(_365,_366){
_365.version=parseInt(_366,10);
};
class_replaceMethod=function(_367,_368,_369){
if(!_367||!_368){
return NULL;
}
var _36a=_367.method_dtable[_368],_36b=NULL;
if(_36a){
_36b=_36a.method_imp;
}
_36a.method_imp=_369;
return _36b;
};
var _36c=function(_36d){
var meta=(((_36d.info&(_334)))?_36d:_36d.isa);
if((_36d.info&(_334))){
_36d=objj_getClass(_36d.name);
}
if(_36d.super_class&&!((((_36d.super_class.info&(_334)))?_36d.super_class:_36d.super_class.isa).info&(_335))){
_36c(_36d.super_class);
}
if(!(meta.info&(_335))&&!(meta.info&(_336))){
meta.info=(meta.info|(_336))&~(0);
objj_msgSend(_36d,"initialize");
meta.info=(meta.info|(_335))&~(_336);
}
};
var _36e=function(self,_36f){
var isa=self.isa,_370=isa.method_dtable[_371];
if(_370){
var _372=_370.method_imp.call(this,self,_371,_36f);
if(_372&&_372!==self){
arguments[0]=_372;
return objj_msgSend.apply(this,arguments);
}
}
_370=isa.method_dtable[_373];
if(_370){
var _374=isa.method_dtable[_375];
if(_374){
var _376=_370.method_imp.call(this,self,_373,_36f);
if(_376){
var _377=objj_lookUpClass("CPInvocation");
if(_377){
var _378=objj_msgSend(_377,_379,_376),_96=0,_37a=arguments.length;
for(;_96<_37a;++_96){
objj_msgSend(_378,_37b,arguments[_96],_96);
}
_374.method_imp.call(this,self,_375,_378);
return objj_msgSend(_378,_37c);
}
}
}
}
_370=isa.method_dtable[_37d];
if(_370){
return _370.method_imp.call(this,self,_37d,_36f);
}
throw class_getName(isa)+" does not implement doesNotRecognizeSelector:. Did you forget a superclass for "+class_getName(isa)+"?";
};
class_getMethodImplementation=function(_37e,_37f){
if(!((((_37e.info&(_334)))?_37e:_37e.isa).info&(_335))){
_36c(_37e);
}
var _380=_37e.method_dtable[_37f];
var _381=_380?_380.method_imp:_36e;
return _381;
};
var _382={};
objj_allocateClassPair=function(_383,_384){
var _385=new objj_class(_384),_386=new objj_class(_384),_387=_385;
if(_383){
_387=_383;
while(_387.superclass){
_387=_387.superclass;
}
_385.allocator.prototype=new _383.allocator;
_385.ivar_dtable=_385.ivar_store.prototype=new _383.ivar_store;
_385.method_dtable=_385.method_store.prototype=new _383.method_store;
_386.method_dtable=_386.method_store.prototype=new _383.isa.method_store;
_385.super_class=_383;
_386.super_class=_383.isa;
}else{
_385.allocator.prototype=new objj_object();
}
_385.isa=_386;
_385.name=_384;
_385.info=_333;
_385._UID=objj_generateObjectUID();
_386.isa=_387.isa;
_386.name=_384;
_386.info=_334;
_386._UID=objj_generateObjectUID();
return _385;
};
var _2ef=nil;
objj_registerClassPair=function(_388){
_1[_388.name]=_388;
_382[_388.name]=_388;
_1be(_388,_2ef);
};
class_createInstance=function(_389){
if(!_389){
throw new Error("*** Attempting to create object with Nil class.");
}
var _38a=new _389.allocator();
_38a.isa=_389;
_38a._UID=objj_generateObjectUID();
return _38a;
};
var _38b=function(){
};
_38b.prototype.member=false;
with(new _38b()){
member=true;
}
if(new _38b().member){
var _38c=class_createInstance;
class_createInstance=function(_38d){
var _38e=_38c(_38d);
if(_38e){
var _38f=_38e.isa,_390=_38f;
while(_38f){
var _391=_38f.ivar_list,_392=_391.length;
while(_392--){
_38e[_391[_392].name]=NULL;
}
_38f=_38f.super_class;
}
_38e.isa=_390;
}
return _38e;
};
}
object_getClassName=function(_393){
if(!_393){
return "";
}
var _394=_393.isa;
return _394?class_getName(_394):"";
};
objj_lookUpClass=function(_395){
var _396=_382[_395];
return _396?_396:Nil;
};
objj_getClass=function(_397){
var _398=_382[_397];
if(!_398){
}
return _398?_398:Nil;
};
objj_getMetaClass=function(_399){
var _39a=objj_getClass(_399);
return (((_39a.info&(_334)))?_39a:_39a.isa);
};
ivar_getName=function(_39b){
return _39b.name;
};
ivar_getTypeEncoding=function(_39c){
return _39c.type;
};
objj_msgSend=function(_39d,_39e){
if(_39d==nil){
return nil;
}
var isa=_39d.isa;
if(!((((isa.info&(_334)))?isa:isa.isa).info&(_335))){
_36c(isa);
}
var _39f=isa.method_dtable[_39e];
var _3a0=_39f?_39f.method_imp:_36e;
switch(arguments.length){
case 2:
return _3a0(_39d,_39e);
case 3:
return _3a0(_39d,_39e,arguments[2]);
case 4:
return _3a0(_39d,_39e,arguments[2],arguments[3]);
}
return _3a0.apply(_39d,arguments);
};
objj_msgSendSuper=function(_3a1,_3a2){
var _3a3=_3a1.super_class;
arguments[0]=_3a1.receiver;
if(!((((_3a3.info&(_334)))?_3a3:_3a3.isa).info&(_335))){
_36c(_3a3);
}
var _3a4=_3a3.method_dtable[_3a2];
var _3a5=_3a4?_3a4.method_imp:_36e;
return _3a5.apply(_3a1.receiver,arguments);
};
method_getName=function(_3a6){
return _3a6.name;
};
method_getImplementation=function(_3a7){
return _3a7.method_imp;
};
method_setImplementation=function(_3a8,_3a9){
var _3aa=_3a8.method_imp;
_3a8.method_imp=_3a9;
return _3aa;
};
method_exchangeImplementations=function(lhs,rhs){
var _3ab=method_getImplementation(lhs),_3ac=method_getImplementation(rhs);
method_setImplementation(lhs,_3ac);
method_setImplementation(rhs,_3ab);
};
sel_getName=function(_3ad){
return _3ad?_3ad:"<null selector>";
};
sel_getUid=function(_3ae){
return _3ae;
};
sel_isEqual=function(lhs,rhs){
return lhs===rhs;
};
sel_registerName=function(_3af){
return _3af;
};
objj_class.prototype.toString=objj_object.prototype.toString=function(){
var isa=this.isa;
if(class_getInstanceMethod(isa,_3b0)){
return objj_msgSend(this,_3b0);
}
if(class_isMetaClass(isa)){
return this.name;
}
return "["+isa.name+" Object](-description not implemented)";
};
var _3b0=sel_getUid("description"),_371=sel_getUid("forwardingTargetForSelector:"),_373=sel_getUid("methodSignatureForSelector:"),_375=sel_getUid("forwardInvocation:"),_37d=sel_getUid("doesNotRecognizeSelector:"),_379=sel_getUid("invocationWithMethodSignature:"),_3b1=sel_getUid("setTarget:"),_3b2=sel_getUid("setSelector:"),_37b=sel_getUid("setArgument:atIndex:"),_37c=sel_getUid("returnValue");
objj_eval=function(_3b3){
var url=_2.pageURL;
var _3b4=_2.asyncLoader;
_2.asyncLoader=NO;
var _3b5=_2.preprocess(_3b3,url,0);
if(!_3b5.hasLoadedFileDependencies()){
_3b5.loadFileDependencies();
}
_1._objj_eval_scope={};
_1._objj_eval_scope.objj_executeFile=_294.fileExecuterForURL(url);
_1._objj_eval_scope.objj_importFile=_294.fileImporterForURL(url);
var code="with(_objj_eval_scope){"+_3b5._code+"\n//*/\n}";
var _3b6;
_3b6=eval(code);
_2.asyncLoader=_3b4;
return _3b6;
};
_2.objj_eval=objj_eval;
_157();
var _3b7=new CFURL(window.location.href),_3b8=document.getElementsByTagName("base"),_3b9=_3b8.length;
if(_3b9>0){
var _3ba=_3b8[_3b9-1],_3bb=_3ba&&_3ba.getAttribute("href");
if(_3bb){
_3b7=new CFURL(_3bb,_3b7);
}
}
var _3bc=new CFURL(window.OBJJ_MAIN_FILE||"main.j"),_1bd=new CFURL(".",new CFURL(_3bc,_3b7)).absoluteURL(),_3bd=new CFURL("..",_1bd).absoluteURL();
if(_1bd===_3bd){
_3bd=new CFURL(_3bd.schemeAndAuthority());
}
_1a4.resourceAtURL(_3bd,YES);
_2.pageURL=_3b7;
_2.bootstrap=function(){
_3be();
};
function _3be(){
_1a4.resolveResourceAtURL(_1bd,YES,function(_3bf){
var _3c0=_1a4.includeURLs(),_96=0,_3c1=_3c0.length;
for(;_96<_3c1;++_96){
_3bf.resourceAtURL(_3c0[_96],YES);
}
_294.fileImporterForURL(_1bd)(_3bc.lastPathComponent(),YES,function(){
_158();
_3c7(function(){
var _3c2=window.location.hash.substring(1),args=[];
if(_3c2.length){
args=_3c2.split("/");
for(var i=0,_3c1=args.length;i<_3c1;i++){
args[i]=decodeURIComponent(args[i]);
}
}
var _3c3=window.location.search.substring(1).split("&"),_3c4=new CFMutableDictionary();
for(var i=0,_3c1=_3c3.length;i<_3c1;i++){
var _3c5=_3c3[i].split("=");
if(!_3c5[0]){
continue;
}
if(_3c5[1]==null){
_3c5[1]=true;
}
_3c4.setValueForKey(decodeURIComponent(_3c5[0]),decodeURIComponent(_3c5[1]));
}
main(args,_3c4);
});
});
});
};
var _3c6=NO;
function _3c7(_3c8){
if(_3c6){
return _3c8();
}
if(window.addEventListener){
window.addEventListener("load",_3c8,NO);
}else{
if(window.attachEvent){
window.attachEvent("onload",_3c8);
}
}
};
_3c7(function(){
_3c6=YES;
});
if(typeof OBJJ_AUTO_BOOTSTRAP==="undefined"||OBJJ_AUTO_BOOTSTRAP){
_2.bootstrap();
}
function _1b7(aURL){
if(aURL instanceof CFURL&&aURL.scheme()){
return aURL;
}
return new CFURL(aURL,_1bd);
};
objj_importFile=_294.fileImporterForURL(_1bd);
objj_executeFile=_294.fileExecuterForURL(_1bd);
objj_import=function(){
CPLog.warn("objj_import is deprecated, use objj_importFile instead");
objj_importFile.apply(this,arguments);
};
})(window,ObjectiveJ);
