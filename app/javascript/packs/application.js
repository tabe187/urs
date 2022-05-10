// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";
import '@fortawesome/fontawesome-free/js/all';

Rails.start();
ActiveStorage.start();


// /*global google*/
// /*global gon*/
// /*global navigator*/
// /*global $*/
// /*global initMap*/

// let map;
// let geocoder;

// $(document).on('turbolinks:load', function() {
// initMap();
// // codeAddress();
// // getFavoriteAddresss();
// // getCurrentAddress();
// });

// window.initMap = function(){
//   let marker = [];
//   let infoWindow = [];
//   let latlng;
//   const maps = gon.maps;
//   map = new google.maps.Map(document.getElementById('map'), {
//     center: {lat: 35.599, lng: 139.610},
//     zoom: 15
//   });

//   for (let i = 0; i < maps.length; i++) {
//     latlng = new google.maps.LatLng(maps[i].latitude, maps[i].longitude);
//     marker[i] = new google.maps.Marker({
//             map: map,
//             position: latlng,
//       });

//       infoWindow[i] = new google.maps.InfoWindow({
//                 // contentで中身を指定
//                 // 今回は文字にリンクを貼り付けた形で表示
//                 content: `<a href='/maps/${maps[i].id}'>${maps[i].place_name}</a>`
//                 });
//                 // markerがクリックされた時、
//                 marker[i].addListener("click", function(){
//                     // infoWindowを表示
//                     infoWindow[i].open(map, marker[i]);
//                 });
//     }
// };


// function codeAddress(){
//   let inputAddress = document.getElementById('address').value;
//   geocoder = new google.maps.Geocoder();
//   geocoder.geocode( { 'address': inputAddress},

//   function(results, status) {
//     if (status == 'OK') {
//       map.setCenter(results[0].geometry.location);

//     } else {
//       alert('Geocode was not successful for the following reason: ' + status);
//     }
//   });
// }




// function getFavoriteAddresss(latitude, longitude, id, place_name) {
//   function successCallback(position) {
//       let marker = [];
//       let infoWindow = [];
//       const latlng = new google.maps.LatLng(latitude, longitude);
//           map = new google.maps.Map(document.getElementById('map'), {
//           center: latlng,
//           zoom: 15,
//       });

//       marker[0] = new google.maps.Marker({
//         map: map,
//         position: latlng,
//       });

//       infoWindow[0] = new google.maps.InfoWindow({
//         content: `<a href='/maps/${id}'>${place_name}</a>`
//       });

//       marker[0].addListener("click", function(){
//         infoWindow[0].open(map, marker[0]);
//       });
//   }

//   function errorCallback() {
//       const result = document.getElementById('result');
//       result.innerHTML = '座標取得できませんでした';
//   }
//   navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
// }

// function getCurrentAddress() {
//   function successCallback(position) {
//       let marker = [];
//       let infoWindow = [];
//       let latlngFav;
//       const maps = gon.maps;
//       const latitude = position.coords.latitude;
//       const longitude = position.coords.longitude;

//       let latlng = new google.maps.LatLng(latitude, longitude);
//           map = new google.maps.Map(document.getElementById('map'), {
//           center: latlng,
//           zoom: 15,
//       });

//       for (let i = 0; i < maps.length; i++) {
//         latlngFav = new google.maps.LatLng(maps[i].latitude, maps[i].longitude);
//         marker[i] = new google.maps.Marker({
//                 map: map,
//                 position: latlngFav,
//           });

//           infoWindow[i] = new google.maps.InfoWindow({
//                     // contentで中身を指定
//                     // 今回は文字にリンクを貼り付けた形で表示
//                     content: `<a href='/maps/${maps[i].id}'>${maps[i].place_name}</a>`
//                     });
//                     // markerがクリックされた時、
//                     marker[i].addListener("click", function(){
//                         // infoWindowを表示
//                         infoWindow[i].open(map, marker[i]);
//                     });
//       }
//   }

//   function errorCallback() {
//       const result = document.getElementById('result');
//       result.innerHTML = '座標取得できませんでした';
//   }
//   navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
// }

// // window.addEventListener('DOMContentLoaded', ()=>{
// //   getCurrentAddress();
// // });
