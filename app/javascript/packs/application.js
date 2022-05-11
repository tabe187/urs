// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

// import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";
import '@fortawesome/fontawesome-free/js/all';
window.$ = window.jQuery = require('jquery');
require("jquery.raty")

Rails.start();
ActiveStorage.start();

/*global google*/
/*global gon*/
/*global navigator*/
/*global $*/
/*global initMap*/


let map;
let geocoder;
let placesList;
let place;

$(document).on('turbolinks:load', function() {
initMap();
});

window.initMap = function(){
  let marker = [];
  let infoWindow = [];
  let latlng;
  const maps = gon.maps;
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 35.599, lng: 139.610},
    zoom: 15
  });

  for (let i = 0; i < maps.length; i++) {
    latlng = new google.maps.LatLng(maps[i].latitude, maps[i].longitude);
    marker[i] = new google.maps.Marker({
            map: map,
            position: latlng,
      });

      infoWindow[i] = new google.maps.InfoWindow({
                // contentで中身を指定
                // 今回は文字にリンクを貼り付けた形で表示
                content: `<a href='/maps/${maps[i].id}'>${maps[i].place_name}</a>`
                });
                // markerがクリックされた時、
                marker[i].addListener("click", function(){
                    // infoWindowを表示
                    infoWindow[i].open(map, marker[i]);
                });
    }
};

window.codeAddress = function (){
  let inputAddress = document.getElementById('address').value;
  geocoder = new google.maps.Geocoder();
  geocoder.geocode( { 'address': inputAddress},

  function(results, status) {
    if (status == 'OK') {
      map.setCenter(results[0].geometry.location);

    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
};


window.getFavoriteAddresss = function (latitude, longitude, id, place_name) {
  function successCallback(position) {
      let marker = [];
      let infoWindow = [];
      const latlng = new google.maps.LatLng(latitude, longitude);
          map = new google.maps.Map(document.getElementById('map'), {
          center: latlng,
          zoom: 15,
      });

      marker[0] = new google.maps.Marker({
        map: map,
        position: latlng,
      });

      infoWindow[0] = new google.maps.InfoWindow({
        content: `<a href='/maps/${id}'>${place_name}</a>`
      });

      marker[0].addListener("click", function(){
        infoWindow[0].open(map, marker[0]);
      });
  }

  function errorCallback() {
      const result = document.getElementById('result');
      result.innerHTML = '座標取得できませんでした';
  }
  navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
};

window.getCurrentAddress = function () {
  function successCallback(position) {
      let marker = [];
      let infoWindow = [];
      let latlngFav;
      const maps = gon.maps;
      const latitude = position.coords.latitude;
      const longitude = position.coords.longitude;

      let latlng = new google.maps.LatLng(latitude, longitude);
          map = new google.maps.Map(document.getElementById('map'), {
          center: latlng,
          zoom: 15,
      });

      for (let i = 0; i < maps.length; i++) {
        latlngFav = new google.maps.LatLng(maps[i].latitude, maps[i].longitude);
        marker[i] = new google.maps.Marker({
                map: map,
                position: latlngFav,
          });

          infoWindow[i] = new google.maps.InfoWindow({
                    // contentで中身を指定
                    // 今回は文字にリンクを貼り付けた形で表示
                    content: `<a href='/maps/${maps[i].id}'>${maps[i].place_name}</a>`
                    });
                    // markerがクリックされた時、
                    marker[i].addListener("click", function(){
                        // infoWindowを表示
                        infoWindow[i].open(map, marker[i]);
                    });
      }
  }

  function errorCallback() {
      const result = document.getElementById('result');
      result.innerHTML = '座標取得できませんでした';
  }
  navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
};



window.getPlaces = function(){

  //結果表示クリア
  document.getElementById("results").innerHTML = "";
  //placesList配列を初期化
  placesList = new Array();

  //入力した検索場所を取得
  var addressInput = document.getElementById("addressInput").value;
  if (addressInput == "") {
    return;
  }

  //検索場所の位置情報を取得
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode(
    {
      address: addressInput
    },
    function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        //取得した緯度・経度を使って周辺検索
        startNearbySearch(results[0].geometry.location);
      }
      else {
        alert(addressInput + "：位置情報が取得できませんでした。");
      }
    });
};

/*
 位置情報を使って周辺検索
  latLng : 位置座標インスタンス（google.maps.LatLng）
*/
function startNearbySearch(latLng){

  //読み込み中表示
  document.getElementById("results").innerHTML = "Now Loading...";

  //Mapインスタンス生成
  var map = new google.maps.Map(
    document.getElementById("map"),
    {
      zoom: 15,
      center: latLng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
  );

  //PlacesServiceインスタンス生成
  var service = new google.maps.places.PlacesService(map);

  //入力したKeywordを取得
  var keywordInput = document.getElementById("keywordInput").value;
  //入力した検索範囲を取得
  // var obj = document.getElementById("radiusInput");
  // var radiusInput = Number(obj.options[obj.selectedIndex].value);

  //周辺検索
  service.nearbySearch(
    {
      location: latLng,
      radius: '2000',
      type: ['restaurant, park, bar, night_club, clothing_store, cafe, hotel, hot_spring'],
      keyword: keywordInput,
      language: 'ja'
    },
    displayResults
  );

}

function displayResults(results, status, pagination) {

  if(status == google.maps.places.PlacesServiceStatus.OK) {

    placesList = placesList.concat(results);

    if (pagination.hasNextPage) {

      setTimeout(pagination.nextPage(), 1000);

    } else {

      var resultHTML = "<ol>";

      for (var i = 0; i < placesList.length; i++) {
        place = placesList[i];

        //ratingが-1のものは「---」に表示変更
        var rating = place.rating;
        if(rating == -1) rating = "---";

        //表示内容（評価＋名称）
        var content = "【" + rating + "】 " + place.name;

        //クリック時にMapにマーカー表示するようにAタグを作成
        resultHTML += "<li>";
        resultHTML += "<a href=\"javascript: void(0);\"";
        resultHTML += " onclick=\"createMarker(";
        resultHTML += "'" + place.name + "',";
        resultHTML += "'" + place.vicinity + "',";
        resultHTML += "'" + place.rating + "',";
        resultHTML += "'" + place.place_id + "',";
        resultHTML += place.geometry.location.lat() + ",";
        resultHTML += place.geometry.location.lng() + ")\">";
        resultHTML += content;
        resultHTML += "</a>";
        resultHTML += "</li>";
      }

      resultHTML += "</ol>";

      //結果表示
      document.getElementById("results").innerHTML = resultHTML;
    }

  } else {
    //エラー表示
    var results = document.getElementById("results");
    if(status == google.maps.places.PlacesServiceStatus.ZERO_RESULTS) {
      results.innerHTML = "検索結果が0件です。";
    } else if(status == google.maps.places.PlacesServiceStatus.ERROR) {
      results.innerHTML = "サーバ接続に失敗しました。";
    } else if(status == google.maps.places.PlacesServiceStatus.INVALID_REQUEST) {
      results.innerHTML = "リクエストが無効でした。";
    } else if(status == google.maps.places.PlacesServiceStatus.OVER_QUERY_LIMIT) {
      results.innerHTML = "リクエストの利用制限回数を超えました。";
    } else if(status == google.maps.places.PlacesServiceStatus.REQUEST_DENIED) {
      results.innerHTML = "サービスが使えない状態でした。";
    } else if(status == google.maps.places.PlacesServiceStatus.UNKNOWN_ERROR) {
      results.innerHTML = "原因不明のエラーが発生しました。";
    }

  }
}

window.createMarker = function (name, vicinity, rating, place_id, lat, lng){

  //マーカー表示する位置のMap表示
  var map = new google.maps.Map(document.getElementById("map"), {
    zoom: 15,
    center: new google.maps.LatLng(lat, lng),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  //マーカー表示
  var marker = new google.maps.Marker({
    map: map,
    position: new google.maps.LatLng(lat, lng)
  });


  //情報窓の設定
  var info = "<div style=\"min-width: 100px\">";
  info += name + "<br />";
  info += vicinity + "<br />";
  info += "<a href=\"https://3edd046ab89d44ffb9e428bc8ae6ae42.vfs.cloud9.us-east-1.amazonaws.com/maps/new/?place_name=" + name + "&address=" + vicinity + "&rating=" + rating + "&place_id=" + place_id + "&latitude="  + lat + "&longitude=" + lng + "\"";
  info += " target=\"_self\">⇒お気に入りに登録する</a>";
  info += "</div>";

  //情報窓の表示
  var infoWindow = new google.maps.InfoWindow({
    content: info
  });
  infoWindow.open(map, marker);

  //マーカーのクリック時にも情報窓を表示する
  marker.addListener("click", function(){
    infoWindow.open(map, marker);
  });
};

