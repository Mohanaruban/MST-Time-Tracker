<?php

require_once('initialize.php');
import('ttImportHelper');
import('form.Form');

// Access check.
if (!ttAccessCheck(right_administer_site)) {
  header('Location: access_denied.php');
  exit();
}

$form = new Form('importForm');
$form->addFormStyle(array('class'=>'form-horizontal'));
$form->addInput(array('type'=>'upload','name'=>'xmlfile','class'=>'btn btn-primary','value'=>'browse','maxsize'=>67108864)); // 64 MB file upload limit.
// Note: for the above limit to work make sure to set upload_max_filesize and post_max_size in php.ini to at least 64M.
$form->addInput(array('type'=>'submit','name'=>'btn_submit','class'=>'btn btn-success','value'=>$i18n->getKey('button.import')));

if ($request->isPost()) {

  $import = new ttImportHelper($err);
  $import->importXml();
  if ($err->no()) $msg->add($i18n->getKey('form.import.success'));
} // isPost

$smarty->assign('forms', array($form->getName()=>$form->toArray()) );
$smarty->assign('title', $i18n->getKey('title.import'));
$smarty->assign('content_page_name', 'import.tpl');
$smarty->display('index.tpl');
