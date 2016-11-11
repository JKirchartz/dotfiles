#!/usr/bin/env php
<?php
/**
 * De-serialize PHP data
 */

$stdin = file_get_contents('php://stdin');
var_export(unserialize($stdin));

?>
