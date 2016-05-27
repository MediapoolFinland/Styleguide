$(document).foundation();

$(".show-code").on("click", function() {
	var $pre = $(this).next("pre");
	var $element = $(this).prevAll("h2");
	
	$pre.toggle();
	
	var visible = $pre.css("display") === "block";
	
	if (visible)
		scrollWindowTo($pre);
	else
		scrollWindowTo($element);
});

function scrollWindowTo(element) {
	$('html, body').animate({
		scrollTop: element.offset().top
	}, 200);
}