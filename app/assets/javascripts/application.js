// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require nicEdit-latest
//= require message
//= require_tree .


$(function (){		
		

		$("#accordion").accordion();
	
		$("#accordion").accordion("activate", 2);

        $('#calendario').datepicker({
			nextText: "Sig.",
			prevText: "Ant.",
			monthNames: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Deciembre"],
			dayNamesMin: ["Di", "Lu", "Ma", "Me", "Je", "Ve", "Sa"]
			
		});

		$('#calendario2').datepicker({
			nextText: "Sig.",
			prevText: "Ant.",
			monthNames: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Deciembre"],
			dayNamesMin: ["Di", "Lu", "Ma", "Me", "Je", "Ve", "Sa"]
			
		});


		$( "#dialog:ui-dialog" ).dialog( "destroy" );		
	
		$( "#dialog-form" ).dialog({
			   autoOpen: false,
			   modal: true,
			   title: "INICIO DE SESION",
			   width: 550,
			   minWidth: 400,
			   maxWidth: 650,
			   closeText: "cerrar",
			   show: "fade"
		});
		$( "#dialog-form2" ).dialog({
			   autoOpen: false,
			   modal: true,
			   title: "RECUPERAR CLAVE",
			   width: 550,
			   minWidth: 400,
			   maxWidth: 650,
			   closeText: "cerrar",
			   show: "fade"
		});

		$( "#acceder" )
			.button()
			.click(function() {
				$( "#dialog-form" ).dialog( "open" );
			});

		$( "#olvido" )
			.button()
			.click(function() {
				$( "#dialog-form2" ).dialog( "open" );
				$( "#dialog-form" ).dialog( "close" );
			});


});
