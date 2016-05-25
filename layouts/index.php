<?php

ini_set("display_errors", "1");

include "../vendor/autoload.php";

$loader = new Twig_Loader_Filesystem('../twig');
$twig = new Twig_Environment($loader);

// echo $twig->render('index', array('name' => 'Fabien'));

$templatePath = "../twig/";

function render($file, $dataArr = array()) {
	global $templatePath, $twig;
	echo $twig->render($file, $dataArr);
}

render("three-columns-with-images.twig", array("columnTitle1" => "Title 1", "columnTitle2" => "Title 2", "columnTitle3" => "Title 3"));