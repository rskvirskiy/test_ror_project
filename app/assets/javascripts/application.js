// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
var centerLatitude = gon.latitude;
var centerLongitude = gon.longitude;
var description = gon.fullname;

function initialize() {
	  var myLatlng = new google.maps.LatLng(centerLatitude,centerLongitude);
	  var mapOptions = {
	    zoom: 13,
	    center: myLatlng,
	    mapTypeId: google.maps.MapTypeId.ROADMAP
	  }
	  var map = new google.maps.Map(document.getElementById("map"), mapOptions);
	  var marker = new google.maps.Marker({
	      position: myLatlng,
	      map: map,
	      title: description
	  });
}

window.onload = initialize;

