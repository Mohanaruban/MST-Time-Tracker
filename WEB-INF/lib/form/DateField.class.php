<?php
// +----------------------------------------------------------------------+
// | Anuko Time Tracker
// +----------------------------------------------------------------------+
// | Copyright (c) Anuko International Ltd. (https://www.anuko.com)
// +----------------------------------------------------------------------+
// | LIBERAL FREEWARE LICENSE: This source code document may be used
// | by anyone for any purpose, and freely redistributed alone or in
// | combination with other software, provided that the license is obeyed.
// |
// | There are only two ways to violate the license:
// |
// | 1. To redistribute this code in source form, with the copyright
// |    notice or license removed or altered. (Distributing in compiled
// |    forms without embedded copyright notices is permitted).
// |
// | 2. To redistribute modified versions of this code in *any* form
// |    that bears insufficient indications that the modifications are
// |    not the work of the original author(s).
// |
// | This license applies to this document only, not any other software
// | that it may be combined with.
// |
// +----------------------------------------------------------------------+
// | Contributors:
// | https://www.anuko.com/time_tracker/credits.htm
// +----------------------------------------------------------------------+

import('form.TextField');
import('DateAndTime');

class DateField extends TextField {
  var $mWeekStartDay = 0;
  var $mDateFormat  = "d/m/Y";
  var $lToday      = "Today";

  var $mDateObj;
  var $cClassName  = "DateField";

  var $lCalendarButtons = array('today'=>'Today', 'close'=>'Close');

  function __construct($name) {
    $this->mName  = $name;
    $this->mDateObj  = new DateAndTime();

    if (isset($GLOBALS["I18N"])) {
      $this->setLocalization($GLOBALS["I18N"]);
    }
  }

  function setLocalization($i18n)  {
  	global $user;
  	
    FormElement::setLocalization($i18n);
    $this->mDateObj->setFormat($user->date_format);

    $this->mMonthNames = $i18n->monthNames;
    $this->mWeekDayShortNames = $i18n->weekdayShortNames;
    $this->lToday = $i18n->getKey('label.today');
    $this->lCalendarButtons['today'] = $i18n->getKey('label.today');
    $this->lCalendarButtons['close'] = $i18n->getKey('button.close');

    $this->mDateFormat = $user->date_format;
    $this->mWeekStartDay = $user->week_start;
  }

  // set current value taken from session or database
  function setValueSafe($value)  {
    if (isset($value) && (strlen($value) > 0)) {
      $this->mDateObj->parseVal($value, DB_DATEFORMAT);
      $this->mValue = $this->mDateObj->toString($this->mDateFormat); //?
    }
  }
  // get value for storing in session or database
  function getValueSafe() {
    if (strlen($this->mValue)>0) {
      $this->mDateObj->parseVal($this->mValue, $this->mDateFormat);  //?
      return $this->mDateObj->toString(DB_DATEFORMAT);
    } else {
      return null;
    }
  }

  function toStringControl()  {
    if (!$this->isRenderable()) return "";

    if (!$this->isEnable()) {
      $html = htmlspecialchars($this->getValue()).
        "<input type=\"hidden\" name=\"$this->mName\" value=\"".htmlspecialchars($this->getValue())."\">\n";
    } else {

        if ($this->mId=="") $this->mId = $this->mName;

      $html = "";

      $html .= "\n\t<input type=\"date\"";
      $html .= " name=\"$this->mName\" id=\"$this->mId\"";

      if ($this->mSize!="")
        $html .= " size=\"$this->mSize\"";

      if ($this->mStyle!="")
         $html .= " style=\"$this->mStyle\"";

      if ($this->mClassStyle!="")
         $html .= " class=\"$this->mClassStyle\"";
       
      if ($this->mPlaceholder!="")
         $html .= " placeholder=\"$this->mPlaceholder\"";

        $html .= " maxlength=\"50\"";

      if ($this->mOnChange!="")
         $html .= " onchange=\"$this->mOnChange\"";

      if ($this->mOnBlur!="")
         $html .= " onblur=\"$this->mOnBlur\"";

      if ($this->mOnClick!="")
         $html .= " onclick=\"$this->mOnClick\"";

      if ($this->mOnFocus!="")
         $html .= " onfocus=\"$this->mOnFocus\"";

      $html .= " value=\"".htmlspecialchars($this->getValue())."\"";
      $html .= ">";
      
      if (APP_NAME)
      	$app_root = '/'.APP_NAME;
    }

    return $html;
  }
}
