<?php
// config/generate.config.ini.php

$content = file_get_contents(__DIR__.'/config.ini.php.tmpl');
ob_start();
eval($content);
$content = ob_get_clean();
file_put_contents(__DIR__.'/config.ini.php', $content);

if (getenv('MAIL_URL') !== False) {
  $content = file_get_contents(__DIR__.'/config-email.ini.php.tmpl');
  ob_start();
  eval($content);
  $content = ob_get_contents();
  file_put_contents(__DIR__.'/config.ini.php', $content, FILE_APPEND);
}
