﻿Type.registerNamespace('AjaxControlToolkit');AjaxControlToolkit.ValidatorCalloutBehavior = function AjaxControlToolkit$ValidatorCalloutBehavior(element) {
AjaxControlToolkit.ValidatorCalloutBehavior.initializeBase(this, [element]);this._warningIconImageUrl = null;this._closeImageUrl = null;this._cssClass = "ajax__validatorcallout";this._highlightCssClass = null;this._width = "200px";this._invalid = false;this._originalValidationMethod = null;this._validationMethodOverride = null;this._elementToValidate = null;this._popupTable = null;this._errorMessageCell = null;this._calloutArrowCell = null;this._warningIconImage = null;this._closeImage = null;this._closeCellInnerDiv = null;this._popupBehavior = null;this._onShowJson = null;this._onHideJson = null;this._focusAttached = false;this._isBuilt = false;this._focusHandler = Function.createDelegate(this, this._onfocus);this._closeClickHandler = Function.createDelegate(this, this._oncloseClick);}
AjaxControlToolkit.ValidatorCalloutBehavior.prototype = {
initialize : function() {
AjaxControlToolkit.ValidatorCalloutBehavior.callBaseMethod(this, 'initialize');var elt = this.get_element();if(elt.evaluationfunction) {
this._originalValidationMethod = Function.createDelegate(elt, elt.evaluationfunction);this._validationMethodOverride = Function.createDelegate(this, this._onvalidate);elt.evaluationfunction = this._validationMethodOverride;}
var clientState = this.get_ClientState();if ((null != clientState) && ("" !== clientState)) {
this._ensureCallout();if(this._highlightCssClass) {
Sys.UI.DomElement.addCssClass(this._elementToValidate, this._highlightCssClass);}
this.show();}
},
_ensureCallout : function() {
if (!this._isBuilt) {
var elt = this.get_element();var elementToValidate = this._elementToValidate = $get(elt.controltovalidate);var popupTableBody = document.createElement("tbody");var popupTableRow = document.createElement("tr");var calloutCell = document.createElement("td");var calloutTable = document.createElement("table");var calloutTableBody = document.createElement("tbody");var calloutTableRow = document.createElement("tr");var iconCell = document.createElement("td");var closeCell = document.createElement("td");var closeCellInnerDiv = this._closeCellInnerDiv = document.createElement("div");var popupTable = this._popupTable = document.createElement("table");var calloutArrowCell = this._calloutArrowCell = document.createElement("td");var warningIconImage = this._warningIconImage = document.createElement("img");var closeImage = this._closeImage = document.createElement("img");var errorMessageCell = this._errorMessageCell = document.createElement("td");popupTable.id = this.get_id() + "_popupTable";popupTable.cellPadding = 0;popupTable.cellSpacing = 0;popupTable.border = 0;popupTable.width = this.get_width();popupTable.className = this._cssClass + " ajax__validatorcallout_popup_table";popupTableRow.className = "ajax__validatorcallout_popup_table_row";calloutCell.className = "ajax__validatorcallout_callout_cell";calloutTable.cellPadding = 0;calloutTable.cellSpacing = 0;calloutTable.border = 0;calloutTable.className = "ajax__validatorcallout_callout_table";calloutTableRow.className = "ajax__validatorcallout_callout_table_row";calloutArrowCell.className = "ajax__validatorcallout_callout_arrow_cell";iconCell.className = "ajax__validatorcallout_icon_cell";warningIconImage.border = 0;warningIconImage.src = this.get_warningIconImageUrl();errorMessageCell.className = "ajax__validatorcallout_error_message_cell";errorMessageCell.innerHTML = this._getErrorMessage();closeCell.className = "ajax__validatorcallout_close_button_cell";closeCellInnerDiv.className = "ajax__validatorcallout_innerdiv";closeImage.src = this.get_closeImageUrl();elt.parentNode.appendChild(popupTable)
popupTable.appendChild(popupTableBody);popupTableBody.appendChild(popupTableRow);popupTableRow.appendChild(calloutCell);calloutCell.appendChild(calloutTable);calloutTable.appendChild(calloutTableBody);calloutTableBody.appendChild(calloutTableRow);calloutTableRow.appendChild(calloutArrowCell);popupTableRow.appendChild(iconCell);iconCell.appendChild(warningIconImage);popupTableRow.appendChild(errorMessageCell);popupTableRow.appendChild(closeCell);closeCellInnerDiv.appendChild(closeImage);closeCell.appendChild(closeCellInnerDiv);var div = document.createElement("div");div.className = "ajax__validatorcallout_innerdiv";calloutArrowCell.appendChild(div);for(var i = 14;i > 0;i--)
{
var line = document.createElement("div");line.style.width = i.toString() + "px";div.appendChild(line);}
this._popupBehavior = $create(
AjaxControlToolkit.PopupBehavior, 
{ 
positioningMode : AjaxControlToolkit.PositioningMode.Absolute,
parentElement : elementToValidate
}, 
{ }, 
null,
this._popupTable);if (this._onShowJson) {
this._popupBehavior.set_onShow(this._onShowJson);}
if (this._onHideJson) {
this._popupBehavior.set_onHide(this._onHideJson);}
$addHandler(this._closeCellInnerDiv, "click", this._closeClickHandler);this._isBuilt = true;}
},
dispose : function() {
if (this._isBuilt) {
this.hide();if (this._focusAttached) {
$removeHandler(this._elementToValidate, "focus", this._focusHandler);this._focusAttached = false;}
$removeHandler(this._closeCellInnerDiv, "click", this._closeClickHandler);this._onShowJson = null;this._onHideJson = null;if (this._popupBehavior) {
this._popupBehavior.dispose();this._popupBehavior = null;}
if (this._closeBehavior) {
this._closeBehavior.dispose();this._closeBehavior = null;}
if (this._popupTable) {
this._popupTable.parentNode.removeChild(this._popupTable);this._popupTable = null;this._errorMessageCell = null;this._elementToValidate = null;this._calloutArrowCell = null;this._warningIconImage = null;this._closeImage = null;this._closeCellInnerDiv = null;}
this._isBuilt = false;}
AjaxControlToolkit.ValidatorCalloutBehavior.callBaseMethod(this, 'dispose');}, 
_getErrorMessage : function() {
return this.get_element().errormessage || AjaxControlToolkit.Resources.ValidatorCallout_DefaultErrorMessage;},
show : function(force) { 
if (force || !this.get_isOpen()) {
if(force && AjaxControlToolkit.ValidatorCalloutBehavior._currentCallout) {
AjaxControlToolkit.ValidatorCalloutBehavior._currentCallout.hide();}
if(AjaxControlToolkit.ValidatorCalloutBehavior._currentCallout != null) {
return;}
AjaxControlToolkit.ValidatorCalloutBehavior._currentCallout = this;this._popupBehavior.set_x($common.getSize(this._elementToValidate).width);this._popupBehavior.show();}
},
hide : function() {
if(AjaxControlToolkit.ValidatorCalloutBehavior._currentCallout == this) {
AjaxControlToolkit.ValidatorCalloutBehavior._currentCallout = null;}
if (this.get_isOpen()) {
this._popupBehavior.hide();}
},
_onfocus : function(e) {
if(!this._originalValidationMethod(this.get_element())) {
this._ensureCallout();if(this._highlightCssClass) {
Sys.UI.DomElement.addCssClass(this._elementToValidate, this._highlightCssClass);}
this.show(true);return false;} else {
this.hide();return true;}
},
_oncloseClick : function(e) {
this.hide();},
_onvalidate : function(val) {
if(!this._originalValidationMethod(val)) {
this._ensureCallout();if(this._highlightCssClass) {
Sys.UI.DomElement.addCssClass(this._elementToValidate, this._highlightCssClass);}
if (!this._focusAttached) {
$addHandler(this._elementToValidate, "focus", this._focusHandler);this._focusAttached = true;}
this.show(false);this._invalid = true;return false;} else {
if(this._highlightCssClass && this._invalid) {
Sys.UI.DomElement.removeCssClass(this._elementToValidate, this._highlightCssClass)
}
this._invalid = false;this.hide();return true;}
},
get_onShow : function() {
return this._popupBehavior ? this._popupBehavior.get_onShow() : this._onShowJson;},
set_onShow : function(value) {
if (this._popupBehavior) {
this._popupBehavior.set_onShow(value)
} else {
this._onShowJson = value;}
this.raisePropertyChanged('onShow');},
get_onShowBehavior : function() {
return this._popupBehavior ? this._popupBehavior.get_onShowBehavior() : null;},
onShow : function() {
if (this._popupBehavior) {
this._popupBehavior.onShow();}
},
get_onHide : function() {
return this._popupBehavior ? this._popupBehavior.get_onHide() : this._onHideJson;},
set_onHide : function(value) {
if (this._popupBehavior) {
this._popupBehavior.set_onHide(value)
} else {
this._onHideJson = value;}
this.raisePropertyChanged('onHide');},
get_onHideBehavior : function() {
return this._popupBehavior ? this._popupBehavior.get_onHideBehavior() : null;},
onHide : function() {
if (this._popupBehavior) {
this._popupBehavior.onHide();}
},
get_warningIconImageUrl : function() {
return this._warningIconImageUrl;},
set_warningIconImageUrl : function(value) {
if (this._warningIconImageUrl != value) {
this._warningIconImageUrl = value;if (this.get_isInitialized()) {
this._warningIconImage.src = value;}
this.raisePropertyChanged("warningIconImageUrl");}
},
get_closeImageUrl : function() {
return this._closeImageUrl;},
set_closeImageUrl : function(value) {
if (this._closeImageUrl != value) {
this._closeImageUrl = value;if (this.get_isInitialized()) {
this._closeImage.src = value;}
this.raisePropertyChanged("closeImageUrl");}
},
get_width : function() {
return this._width;},
set_width : function(value) {
if (this._width != value) { 
this._width = value;if (this.get_isInitialized()) {
this._popupTable.style.width = _width;}
this.raisePropertyChanged("width");}
},
get_cssClass : function() {
return this._cssClass;},
set_cssClass : function(value) {
if (this._cssClass != value) {
this._cssClass = value;this.raisePropertyChanged("cssClass");}
},
get_highlightCssClass : function() {
return this._highlightCssClass;},
set_highlightCssClass : function(value) {
if (this._highlightCssClass != value) {
this._highlightCssClass = value;this.raisePropertyChanged("highlightCssClass");}
},
get_isOpen : function() {
return $common.getVisible(this._popupTable);}
}
AjaxControlToolkit.ValidatorCalloutBehavior.registerClass('AjaxControlToolkit.ValidatorCalloutBehavior', AjaxControlToolkit.BehaviorBase);