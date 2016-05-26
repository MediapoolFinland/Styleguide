$(document).foundation();

$(".show-code").on("click", function(){
	$(this).next("pre").toggle();
});
