#!/usr/bin/env php
<?php
/**
 * De-serialize & de-base64 endcode PHP data
 */

$stdin = file_get_contents('php://stdin');
var_export(unserialize(base64_decode($stdin)));

?>
