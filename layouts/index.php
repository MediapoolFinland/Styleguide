<?php

ini_set("display_errors", "1");

include "../vendor/autoload.php";

$loader = new Twig_Loader_Filesystem('../twig');
$twig = new Twig_Environment($loader, array("autoescape" => false));

// echo $twig->render('index', array('name' => 'Fabien'));

$templatePath = "../twig/";

function render($file, $dataArr = array()) {
	global $templatePath, $twig;

	echo $twig->render($file, $dataArr);
	echo "<button type='button' class='button tiny show-code'>Show code</button>";
	echo "<pre class='main-code-block' style='display:none'>" . htmlspecialchars(file_get_contents("../twig/" . $file)) . PHP_EOL . PHP_EOL . "/*** SCSS ***/" . PHP_EOL . file_get_contents("../assets/scss/layouts/_" . str_replace(".twig", ".scss", $file)) . "</pre>";
	echo "</div>";
	echo "<hr>";
	echo "<div class='row'>";
}

?><!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>List of elements</title>
	<link rel="stylesheet" href="../assets/foundation/css/foundation.min.css">
	<link rel="stylesheet" href="../assets/css/app.css">
	<script type="text/javascript" src="../assets/js/vendor/jquery.js"></script>
	<script type="text/javascript" src="../assets/js/vendor/foundation.min.js"></script>
</head>
<body>
<div class="row">
	<h1>List of elements.</h1>
	<blockquote>Work in progress.</blockquote>
</div>
<hr>
<div class="row">
	<h2>Navigation - two rows</h2>
	<p>Vertical nav with support to 5 nav elements, language list and submenus. Submenus open as second row below the main row.<br>This nav is not responsive.</p>
		<?php
render("nav--tworows.twig", array());
?>
	<h2>Row with five columns</h2>
		<p>Row where the number of columns is <b>15</b> <i>(default 12)</i>. For mobile, only 3 columns are shown.</p>
		<?php
render("row--five-columns.twig", array("image" => "https://placehold.it/350x350", "body" => "<strong>Lorem ipsum doret</strong><br> ipsum hipsum hipsuli pipsuli"));
?>

	<h2>Row with four images as columns</h2>
		<p>Simple 4 column block with images that have a hover active vertically aligned body content.</p>
		<p><i>Note: the vertical align css classes are in the <b>_library.scss</b> -file.</i></p>
		<?php
render("row--four-columns-with-imgs.twig", array("image" => "https://placehold.it/227x339", "body" => "<strong>Lorem ipsum doret</strong><br> ipsum hipsum hipsuli pipsuli"));
?>

	<h2>Row with three columns</h2>
		<p>Simple 3 column block with a header image and body content. Columns switch to 100% width on mobile. 2 variations for different image aspect ratios.</p>
		<?php
render("row--three-columns.twig", array("image" => "https://placehold.it/350x350", "body" => "<strong>Lorem ipsum doret</strong><br> ipsum hipsum hipsuli pipsuli"));
?>

	<h2>Row with two columns</h2>
		<p>Simple 2 column block with a header image and body content. 2 variations for different image aspect ratios.</p>
		<?php
render("row--two-columns.twig", array("image" => "https://placehold.it/350x350", "body" => "<strong>Lorem ipsum doret</strong><br> ipsum hipsum hipsuli pipsuli"));
?>

	<h2>Styled title</h2>
	<p>Horizontal element with blocks on top of it. Vertical alignment for titles supports only a single line of text.</p>
		<?php
render("element--styled-title.twig", array(
	"image_basic" => "../assets/img/slashed-line-withmargins.png",
	"image_sides" => "../assets/img/dotted-line.png",
	"title" => "This is a title", "leftblock" => "Read more", "rightblock" => "Some icons"));
?>

	<h2>Hilighted articles</h2>
	<p>Two articles side by side.</p>
		<?php
render("element--hilighted-articles.twig", array("articles" => array(
	array("image" => "https://placehold.it/90x90", "date" => "April 13 2013 - in Personal", "title" => "March looks"),
	array("image" => "https://placehold.it/90x90", "date" => "April 13 2014 - in Personal", "title" => "Stripes for spring &amp; more beauty picks"),
	array("image" => "https://placehold.it/90x90", "date" => "April 14 2015 - in Personal", "title" => "Stripes for summer"),
	array("image" => "https://placehold.it/90x90", "date" => "April 13 2016 - in Personal", "title" => "April looks"),
), "next" => "Next", "previous" => "Previous"));
?>
</div>
<script type="text/javascript" src="../assets/js/app.js"></script>
</body>
</html>