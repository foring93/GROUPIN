<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Drawing undo, redo</title>
    <style>
.map_wrap {width: 100%;position: relative;}
.modes {position: absolute;top: 10px;left: 10px;z-index: 1;}
.edit {position: absolute;top: 62px;left: 10px;z-index: 1;}
#drawingMap {width: 100%;height: 350px;}
#undo.disabled, #redo.disabled {background-color:#ddd;color:#9e9e9e;}
</style>
</head>
<body>
<div class="map_wrap">
    <div id="drawingMap"></div>
    <p class="modes">
	    <button onclick="selectOverlay('MARKER')">마커</button>
	    <button onclick="selectOverlay('POLYLINE')">선</button>
	    <button onclick="selectOverlay('CIRCLE')">원</button>
	    <button onclick="selectOverlay('RECTANGLE')">사각형</button>
	    <button onclick="selectOverlay('POLYGON')">다각형</button>
	</p>
	<p class="edit">
		<button id="undo" class="disabled" onclick="undo()" disabled>UNDO</button>
	    <button id="redo" class="disabled" onclick="redo()" disabled>REDO</button>
	</p>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=81901835c348429fbab043210a118692&libraries=drawing"></script>
<script>
// Drawing Manager로 도형을 그릴 지도 div
var drawingMapContainer = document.getElementById('drawingMap'),
    drawingMap = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var drawingMap = new kakao.maps.Map(drawingMapContainer, drawingMap); 

var options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
    map: drawingMap, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
    drawingMode: [ // Drawing Manager로 제공할 그리기 요소 모드입니다
        kakao.maps.Drawing.OverlayType.MARKER,
        kakao.maps.Drawing.OverlayType.POLYLINE,
        kakao.maps.Drawing.OverlayType.RECTANGLE,
        kakao.maps.Drawing.OverlayType.CIRCLE,
        kakao.maps.Drawing.OverlayType.POLYGON
    ],
    // 사용자에게 제공할 그리기 가이드 툴팁입니다
    // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
    guideTooltip: ['draw', 'drag', 'edit'], 
    markerOptions: { // 마커 옵션입니다 
        draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다 
        removable: true // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다  
    },
    polylineOptions: { // 선 옵션입니다
        draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
        removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
        editable: true, // 그린 후 수정할 수 있도록 설정합니다 
        strokeColor: '#39f', // 선 색
        hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
        hintStrokeOpacity: 0.5  // 그리중 마우스를 따라다니는 보조선의 투명도
    },
    rectangleOptions: {
        draggable: true,
        removable: true,
        editable: true,
        strokeColor: '#39f', // 외곽선 색
        fillColor: '#39f', // 채우기 색
        fillOpacity: 0.5 // 채우기색 투명도
    },
    circleOptions: {
        draggable: true,
        removable: true,
        editable: true,
        strokeColor: '#39f',
        fillColor: '#39f',
        fillOpacity: 0.5
    },
    polygonOptions: {
        draggable: true,
        removable: true,
        editable: true,
        strokeColor: '#39f',
        fillColor: '#39f',
        fillOpacity: 0.5,
        hintStrokeStyle: 'dash',
        hintStrokeOpacity: 0.5
    }
};

// 위에 작성한 옵션으로 Drawing Manager를 생성합니다
var manager = new kakao.maps.Drawing.DrawingManager(options);

// undo, redo 버튼의 disabled 속성을 설정하기 위해 엘리먼트를 변수에 설정합니다
var undoBtn = document.getElementById('undo');
var redoBtn = document.getElementById('redo');

// Drawing Manager 객체에 state_changed 이벤트를 등록합니다
// state_changed 이벤트는 그리기 요소의 생성/수정/이동/삭제 동작 
// 또는 Drawing Manager의 undo, redo 메소드가 실행됐을 때 발생합니다
manager.addListener('state_changed', function() {

	// 되돌릴 수 있다면 undo 버튼을 활성화 시킵니다 
	if (manager.undoable()) {
		undoBtn.disabled = false;
		undoBtn.className = "";
	} else { // 아니면 undo 버튼을 비활성화 시킵니다 
		undoBtn.disabled = true;
		undoBtn.className = "disabled";
	}

	// 취소할 수 있다면 redo 버튼을 활성화 시킵니다 
	if (manager.redoable()) {
		redoBtn.disabled = false;
		redoBtn.className = "";
	} else { // 아니면 redo 버튼을 비활성화 시킵니다 
		redoBtn.disabled = true;
		redoBtn.className = "disabled";
	}

});

// 버튼 클릭 시 호출되는 핸들러 입니다
function selectOverlay(type) {
    // 그리기 중이면 그리기를 취소합니다
    manager.cancel();

    // 클릭한 그리기 요소 타입을 선택합니다
    manager.select(kakao.maps.Drawing.OverlayType[type]);
}

// undo 버튼 클릭시 호출되는 함수입니다.
function undo() {
	// 그리기 요소를 이전 상태로 되돌립니다
	manager.undo();
}

// redo 버튼 클릭시 호출되는 함수입니다.
function redo() {
	// 이전 상태로 되돌린 상태를 취소합니다
	manager.redo();
}
</script>
</body>
</html>