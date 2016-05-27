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
</head>
<body>
<div class="row">
	<h1>List of elements.</h1>
	<blockquote>Work in progress.</blockquote>
</div>
<hr>
<div class="row">
	<h2>Row with three columns</h2>
		<p>Simple 3 column block with a header image and body content. Columns switch to 100% width on mobile. 2 variations for different image aspect ratios.</p>
		<?php
		render("row--three-columns.twig", array("image" => "https://placehold.it/350x350", "body" => "<strong>Lorem ipsum doret</strong><br> ipsum hipsum hipsuli pipsuli"));
		?>
		
	<h2>Styled title</h2>
	<p>Horizontal element with blocks on top of it. Vertical alignment for titles supports only a single line of text.</p>
		<?php
		render("element--styled-title.twig", array("image_basic" => "../assets/img/slashed-line-withmargins.png", "image_sides" => "../assets/img/dotted-line.png"));
		?>
</div>
<!-- render("three-columns-with-images.twig", array("columnTitle1" => "Title 1", "columnTitle2" => "Title 2", "columnTitle3" => "Title 3")); -->
<script type="text/javascript" src="../assets/js/vendor/jquery.js"></script>
<script type="text/javascript" src="../assets/js/vendor/foundation.min.js"></script>
<script type="text/javascript" src="../assets/js/app.js"></script>
</body>
</html>