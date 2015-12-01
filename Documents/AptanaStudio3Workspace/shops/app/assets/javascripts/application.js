// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-2.1.4.min
//= require jquery_ujs
//= require jquery.remotipart
//= require underscore
//= require gmaps/google
//= require turbolinks
//= require_tree .

/* REGION : Error/Msg Show and Hide*/

function MsgShow(type, msg) {
	
	var icon, mtype, mtitle = "";
	var mdelay = 0;
	
	$(".msg-growl").remove();
	
	if (type == "success") {
		mtitle = "Success !!";
		icon = "fa fa-check";
		mtype = "success msg-growl";
		mdelay = 4000;
	}
	else {
		mtitle = "Oops !!";
		icon = "fa fa-warning";
		mtype = "danger msg-growl";
		mdelay = 6000;
	}
	
	$.growl({
		icon: icon,
		title: "<strong>" + mtitle + "</strong>",
		message: msg
	},{
		type: mtype,
		allow_dismiss: true,
		placement: {
			from: "top",
			align: "center"
		},
		offset: { x: 20, y: 0},
		spacing: 1,
		z_index: 1075,
		delay: mdelay,
		timer: 1000,
		mouse_over: "pause",
		animate: {
			enter: 'animated fadeInDown',
			exit: 'animated fadeOutUp'
		},
		icon_type: 'class'
	});
}

function MsgHide(MilliSecond) {
    window.setTimeout(function () {
        $(".alert").fadeOut("slow");
        $(".msg-growl").fadeOut("slow").remove();
    }, MilliSecond);
}

/* END REGION : Error/Msg Show and Hide*/

/* REGION : Loading Helper */

 function LoadingHelper(Action,message) {
     var OverLay = $(".Overlay");
     var loading = $(".Loading");
     $("p",loading).html(message);
     var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2 - 50, 0);
     var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2 - 75, 0);
     if (Action == 1) {
         OverLay.fadeIn();
         loading.fadeIn();
         loading.css({ top: top, left: left });
     }
     else if (Action == 0) {
         OverLay.fadeOut();
         loading.fadeOut();
     }
 }

 /* END REGION : Loading Helper */