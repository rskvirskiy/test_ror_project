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
var startZoom = 13;
var map;

function addMarker(latitude, longitude, description) {
	var marker = new GMarker(new GLatLng(latitude, longitude));
	GEvent.addListener(marker, 'click',function() {
		marker.openInfoWindowHtml(description);});
	map.addOverlay(marker);
}

function init() {
	if (GBrowserIsCompatible()) {
	map = new GMap2(document.getElementById("map"));
	map.addControl(new GSmallMapControl());
	map.setCenter(new GLatLng(centerLatitude, centerLongitude), startZoom);
	addMarker(centerLatitude, centerLongitude, description);
	}
}

window.onload = init;
window.onunload = GUnload;

