<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
    String ctx = request.getContextPath();
    pageContext.setAttribute("ctx", ctx);
%>
<html>
<head>
    <meta charset="utf-8">
    <title>헬스장 검색</title>
    <!--common stylesheet-->
	<link rel="stylesheet" href="${ctx}/include/main/css/style.css">
	<!--style-->
	<link rel="stylesheet" href="${ctx}/css/kakaomap.css">	
	<!--font-->
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
	<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
	<!--common script-->
	<script src="${ctx}/include/main/js/menu.js" defer></script>    
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <!-- javascript -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2c2bc208d89c3b89832ac410d98c7a02&libraries=services"></script>
    <script type="text/javascript">
    	$(document).ready(function(){
    		$("#arroundbtn").on("click", function(){
        		//alert("주변버튼 누름");
        		myLocation();
        	});
    	});
    </script>
</head>
<body>

<!-- head menu -->
<jsp:include page="../common/mainnav.jsp"></jsp:include>

<!--content-->
<div class="fithe_wrap">
	<div class="content_wrap">
		
		<div class="map_wrap">		
			<!--  맵 크기 조정 -->
		    <div id="map" style="width:100%; height:600px; overflow:hidden;"></div> 
		
		    <div id="menu_wrap" class="bg_white">
		        <div class="option">
		            <div>
		                <form onsubmit="searchPlaces(); return false;">
		                <div class="keyword_serach">
		                    <div>
		                    	<span>검색어</span>
		                    	<input type="text" id="keyword" name="keyword" size="15"/>
		                    </div> 
		                 	<button type="submit">검색</button>
		                 </div> 
		                 <input type="button" id="arroundbtn" name="arroundbtn" value="내 위치 주변에서 찾기" /> 
		                </form>
		            </div>
		        </div>
		        <hr>
		        <ul id="placesList"></ul>
		        <div id="pagination"></div>
		    </div>
		</div>
	</div>
	<!--end of <div class="content_wrap">-->
</div>
<!--end of <div class="fithe_wrap">-->

<!--=========================// START footer //=========================-->
<div class="footer_group">
	<!--kosmo info-->
	<div>
		<div>
			<ul>
				<li><a href="#">이용약관 ㅣ </a></li>
				<li><a href="#">개인정보처리방침</a></li>
			</ul>
			<p>(153-759) 서울시 금천구 가산동 426-5 월드메르디앙 2차 404호</p>
			<p>Copyright (C) 2021 KOSMO FITHE. All rights reserved.</p>
			<ul class="sns">
				<li><a href="#"><img src="${pageContext.request.contextPath}/include/main/img/facebook_logo.png" width="25"></a></li>
				<li><a href="#"><img src="${pageContext.request.contextPath}/include/main/img/instagram_circle.png" width="27"></a></li>
				<li><a href="#"><img src="${pageContext.request.contextPath}/include/main/img/blog_logo.png" width="20"></a></li>
			</ul>
		</div>			
	</div>
	<!--footer-->
	<div>
		
	</div>
</div>
<!--=========================// END footer //=========================-->


<!-- map -->
<script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(); 
// console.log("ps >>> : " + ps);

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var content = null;

var marker = new kakao.maps.Marker({
	map: map
});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {
	console.log($("#keyword").val());
	if ($("#keyword").val() == null || $("#keyword").val() == '') {
		if ("${userAddress}" == null || "${userAddress}" == "") {
			alert("회원의 주소를 찾을 수 없습니다. 현재 위치 주변 헬스장을 검색합니다")
			myLocation();
			return;
		} else {
			$("#keyword").val("${userAddress}");
		}
	}
	
    var keyword = document.getElementById('keyword').value;
	
    // 검색어가 공백일 때 주는 alert창
    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색이 됐으면
        // 검색된 헬스장 목록과 마커를 표시
        displayPlaces(data);
        // console.log(data);
        // console.log("x 값 >>> : " + data[0]['x']);
        // console.log("y 값 >>> : " + data[0]['y']);

        // 리스트에 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        alert('검색 결과가 존재하지 않습니다.');
        return;
        
    } else if (status === kakao.maps.services.Status.ERROR) {
        alert('검색 결과 중 오류가 발생했습니다.');
        return;
    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    /*추가*/
    var placearray = [];
    var count = 0;
    /*추가*/
    for ( var i=0; i<places.length; i++ ) {
		
    	// 받아온 위도와 경도로
        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
		
            
	        /* 추가 */
	       	var click_marker = getListItem(i, places[i])
        
	        placearray[count] = places[i]
	        count++;
	       	/*추가*/
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title, places, map) {
            kakao.maps.event.addListener(marker, 'mouseover', function() { // 마커에 마우스 올려놓을때
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() { // 마커에 마우스 치울 때
                infowindow.close();
            });
            
            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
            
            kakao.maps.event.addListener(marker, 'click', function() { // 마커 클릭할 때
                //alert("누름");
            	clickmarker(marker, places, title, map);
            });
            itemEl.onclick = function(){
            	clickmarker(marker, places, title, map);
            };
            console.log("places >>> : " + places);
            console.log("title >>> : " + title);
            
        })(marker, places[i].place_name, [places[i].address_name, places[i].id, places[i].phone, places[i].place_url], map);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

	// console.log("places >>> : " + places);
	
    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}
// 마커를 클릭했을 때 정보창 띄우기(오버레이)
function clickmarker (marker, places, title, map){
	for (var i = 0; i < places.length; i++) {
		console.log(i + " : " + places[i]);
	}
	console.log(marker);
	console.log(map);
	var place_name = places[0]; // 주소
	var phone = places[2]; // 전화번호
	var link = places[3];
	var content = "<div class='wrap'> "
				+ "		<div class='info_overlay'>"
				+ "			<div class='title'>"
				+ "				<div>"
				+					title
				+ "				</div>"
				+ "				<div> <br>"
				+					"주소 : " + place_name + "<br>"
				+                   "전화번호: " + phone + "<br>"
				+ "				</div>"
				+ "				<div class='close' onclick='closeOverlay()' title='닫기'></div>"
				+ " 		</div> <br> <br>" 
				+ "			<div class='body'>"
				+ "				<div class='desc'>"
				+ "					<div><a href="+link+" target='+blank' class='link'>상세보기</a></div>"
				+ "				</div>"
				+ "			</div>"
				+ "		</div>"
				+ "</div>";
				
	overlay.setContent(content);
	overlay.setMap(map);
	overlay.setPosition(marker.getPosition());
	infowindow.close();
	
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

// 마커위에 커스텀오버레이를 표시
// 마커를 중심으로 커스텀 오버레이를 표시하기 위해 css를 이용해 위치를 설정
	var overlay = new kakao.maps.CustomOverlay({
		content: content,
		map: map,
		position: marker.getPosition()
	});
	// 닫기 버튼 클릭시 커스텀오버레이를 닫습니다.
	function closeOverlay(){
		overlay.setMap(null);	
	}

	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}
 
// 현재 위치 불러오기
function myLocation(){
	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        var lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
	            
	            console.log("현재 위도 >>> : " + lat);
	            console.log("현재 경도 >>> : " + lon);
	        
	        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	            message = '<div style="padding:5px;">현재위치</div>'; // 인포윈도우에 표시될 내용입니다
	        
	      	displayMarker(locPosition, message);
	        
	        // 위도, 경도로 주소 구하기
	        geocoder.coord2Address(lon, lat, callback);
	      	});
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	    
	       alert("현재 위치를 찾을 수 없습니다. 검색 기능을 이용해주세요");
	}
	var callback = function(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	        console.log("현재 위치 도로명 주소 >>> : " + result[0].address.address_name);
	        var address = result[0].address.address_name.split(" ");
	        var location = address[address.length-2] + " "+ address[address.length-1] + "주변 헬스장";
	        $("#keyword").val(location);
	        searchPlaces();
	    }
	};
}
// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition, message) {

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition,
    }); 
    
    var iwContent = message, // 인포윈도우에 표시할 내용
        iwRemoveable = true;

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // 인포윈도우를 마커위에 표시합니다 
   	infowindow.open(map, marker); // 마커 위에 문자 표시
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
}
</script>
	
</body>
</html>