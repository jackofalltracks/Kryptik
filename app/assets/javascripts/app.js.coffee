$ ->

  $("a[data-toggle=modal]").click ->
    $("#plan-options").modal "show"

  $("a[data-toggle=modal]").click ->
    $("#card-data").modal "show"  

	setTimeout () -> 
    	$(".alert").fadeOut("slow"); 
  		, 10000  

  setTimeout () -> 
    	$(".alert-quick").fadeOut("slow"); 
  		, 3000 	

 