<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="mainpage/header.jsp" />

<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 스타일 추가 -->
<style>
.avatar {
	border-radius: 100%;
}

.profile-img {
	display: inline-block !important;
	float: left;
	margin-right: 25px;
}

.profile-img img {
	width: 80px;
}

.form-group.half {
	display: inline-block;
}

.nick-status {
	font-size: 9pt;
}

.form-group .control-label {
	font-size: 10pt;
}


.forgroupname {
	list-style: none;
	padding-top: 20px;
}

.forgroupnamewidth {
	width: 29%;
	display: inline-block;
}

.forgroupnamewidth1 {
	width: 69%;
	display: inline-block;
	position: relative;
	top: 7px;
}

.forgroupnameleft {
	float: left;
	list-style: none;
	margin-right: 20px;
}

.forlogintitle {
	margin-bottom: 10px !important;
}

.forSubmitBtnDiv {
	margin-top: 0px !important;
	margin-bottom: 5px;
	width:100%;
}

.forLoginBtn {
	padding-left: 25px !important;
	padding-right: 25px !important;
	margin-bottom:10px;
	width: 90%;
}

.forMemberCountBtnOne {
	margin-top: 0px !important;
	padding: 3px !important;
}

.forMemberCountBtnTwo {
	margin-top: 0px !important;
	padding: 3px !important;
}

.forMemberCountBtnThree {
	margin-top: 0px !important;
	padding: 3px !important;
}

.forMemberCountBtnFour {
	margin-top: 0px !important;
	padding: 3px !important;
}

.forMemberCountBtnFive {
	margin-top: 0px !important;
	padding: 3px !important;
}

.forMemberCountBtnSix {
	margin-top: 0px !important;
	padding: 3px !important;
}

.forMemberCountBtnSeven {
	margin-top: 0px !important;
	padding: 3px !important;
}

.forJoinBtn {
	margin-top: 0px !important;
	padding: 5px !important;
	float: right;
	font-size: 14px !important;
}

.forRegisterBtn {
	padding-left: 20px !important;
	padding-right: 20px !important;
	margin-left: 10%;
}

.forRememberIdDiv {
	margin-bottom: 0px !important;
	margin-top: 5px !important;
}

.forcheckbox {
	margin-top: 3px;
}

.calendarDiv {
	text-align: center;
	width: 95%;
	margin: 0 auto;
}

.calendarTable {
	width: 80%;
	margin: 0 auto;
}

.calendarBtn {
	cursor: pointer;
}

.calendarCell {
	cursor: pointer;
}

.calendarDiv td {
	border-radius: 13px;
}

.calendarCellSelected {
	background-color: #4F93CE;
	color: white !important;
}

.calendarCellMy {
	background-color: black;
	color: white !important;
}

.scheduleDiv {
	width: 80%;
	margin: 0 auto;
}

.scheduleUl {
	padding-left: 0px !important;
}

.card-header-bgcolor {
	background: white none repeat scroll 0 0 !important;
}

.schedule-span {
	margin-bottom: 7px;
	width: 70% !important;
}

.schedule-span1 {
	width: 35% !important;
}

.nearby-contct>li {
	padding: 15 px !important;
}

.paddingZero[aria-expanded="true"] {
	background: #088dcd;
	color: #fff;
	text-decoration: none;
}

.groupMember {
	display: inline-block;
	list-style: outside none none;
	margin-bottom: 0;
	padding: 0 25px 20px;
	width: 100%;
	max-height: 300px !important;
}

.groupMember li {
	display: inline-block;
	margin-bottom: 20px;
	position: relative;
	width: 100%;
}

.your-page-groupList li {
	margin-bottom: 3px !important;
}

.your-page-groupListDiv {
	min-height: 273px;
}

.min-width-h4 {
	margin-bottom: 0px !important;
}

.height-for-white {
	height: 70px !important;
}

.calendarBtn{
cursor:pointer}

#calendar td{
cursor:pointer
}
.katalkbtn{
background-color: #423630 !important;
color: white !important;
}

.katalkbtn:hover{
background-color: #594941 !important;
}

.katalkbtnw{
color: #423630 !important;
}

.logintitle{
font-size:14px;
margin-top:10px;
}

.logintitlehr{
margin-top:5px;
margin-bottom:2px;
width:100%;
}

.logincenter{
text-align:center;
}

.logindiv{
margin-top:10px;
}

.loginleft{
float:left;
font-size:14px;
margin-left:14px;
}

.loginright{
float:right;
font-size:14px;
margin-right:14px;
}
.leftrightwidth{
padding-left: 0px !important;
padding-right: 0px !important;
width:90%;
}

.center-pagination {
	justify-content: center;
	margin-bottom: 0px;
}
.widthpagination{
width:18% !important;
}
.imground{
border-radius:16px;
margin-right:10px;
}
.hrmargin{
margin-top:5px !important;
margin-bottom:5px !important;
}

.leftpadding{
padding-left:20px !important;
padding-right:20px !important;
}

.commentmargin {
    margin-right: 7px !important;
}
.groupname{
position:relative;
top:-9px;
}

.figure-myimg{
	width:80px !important;
	max-width: 100px !important;
	margin-left: 20px;
}

.figure-myimg1{
	width:100%;
	
}

.page-metaclass{
	margin-left: 20px;
    width: 55% !important;
}

.forDeleteMargin {
	margin-right: 2%
}

.addScheduleBtn {
	float: right;
	padding-left: 13px !important;
	padding-right: 13px !important;
}

.search-text-field {
	margin-left: 3%;
}

.search-text-free {
	background: #f5f5f5 none repeat scroll 0 0;
	border: 1px solid #dadede;
	border-radius: 30px;
	color: #7b7b7b;
	font-size: 15px;
	padding: 7px 20px;
	width: 70%;
	margin-left: 2%;
	margin-bottom: 10px;
	margin-top: 3px;
}

.search-text-btn {
	margin-left: 2%;
	padding-left: 20px;
	padding-right: 20px;
}

.row-pagination {
	padding-top: 30px;
}

.center-pagination {
	justify-content: center;
}

.inline-flex {
	display: inline-flex;
}

.text-align-center {
	text-align: center;
}

.search-condition {
	margin-right: 10px;
}

.margin-Bottom{
	margin-bottom: 0px !important;
}
</style>
<script>
	$(function() {
		$('#nickname').keyup(function() {
					// 형식에 맞든 안 맞든 첫 메시지가 계속 뜨기 때문에 keyup 이벤트 발생할 때마다 메시지 비운다.
					$('.nick-status').empty();

					var reg = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,10}$/;
					var nick = $('#nickname').val();
					if (reg.test(nick)) { // 정규표현식에 맞을 때 
						console.log('### keyup 테스트 ### ' + nick);
						$.ajax({
							type : "POST",
							url : "groupNickCheck",
							data : {
								nickname : nick,
								groupkey : $('#checkGroupkey').val()
							},
							cache : false,
							success : function(data) {
								console.log('data = ' + data + ', isNaN(data) = ' + isNaN(data));
								if (data == 1) {
									$('.nick-status').css('color', 'red').text('이미 존재하는 닉네임입니다.');
								} else {
									$('.nick-status').css('color', 'blue').text('사용 가능한 닉네임입니다.');
								}
							},
							error : function(request, status, error) {
								console.log("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
							}
						}); // ajax end
					} else {
						if ($(this).val().length == 1) {
							$('.nick-status').css('color', 'lightgray').text('한글, 영어, 숫자로 2~10글자만 작성해주세요.');
						} else if ($(this).val().length == 11) {
							var input = '';
							input = $(this).val().substr(0,$(this).val().length - 1);
							console.log('input = ' + input);
							$(this).val(input);
							$('.nick-status').css('color', 'lightgray').text('한글, 영어, 숫자로 2~10글자만 작성해주세요.');
						}
					}
				}); // keyup end

		$('#uploadfile').on('change', view);

		function view(e) {
			// 선택한 그림의 File 객체를 취득
			var file = e.target.files[0]; // File 객체 리스트에서 첫 번째 File 객체를 가져온다.

			// file.type : 파일의 형식 (MIME 타입 - 예) text/html)
			if (!file.type.match('image.*')) { // 파일 타입이 image인지 확인한다.
				alert('확장자는 이미지 확장자만 가능합니다.');
				return;
			}

			// 파일을 읽기 위한 객체 생성
			var reader = new FileReader();

			// DataURL 형식으로 파일을 읽어온다.
			// 읽어온 결과는 reader 객체의 result 속성에 저장된다.
			reader.readAsDataURL(file);

			// 읽기에 성공했을 때 실행되는 이벤트 핸들러
			reader.onload = function(e) {
				// result : 읽기 결과가 저장된다.
				// reader.result 또는 e.target.result
				$('#upImg').attr('src', e.target.result);
			} // reader.onload end
		}
		; // view end
	}); // function end
</script>
<!-- 그룹 페이지 상단 -->
<jsp:include page="group/group_header.jsp" />
<!-- 그룹 페이지 상단 -->

<!-- 그룹 페이지 메인 -->
<section>
	<div class="gap gray-bg">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="row" id="page-contents">

						<!-- 그룹 페이지 위젯 왼쪽 -->
						<div class="col-lg-3">
							<aside class="sidebar static">
								<!-- 그룹 게시판 위젯 -->
								<jsp:include page="group/group_leftWidget.jsp"/>
							</aside>
						</div>
						<!-- 그룹 페이지 위젯 왼쪽  -->

						<!-- 그룹 페이지 위젯 중간 -->
						<div class="col-lg-6">
							<div class="central-meta">
								<div class="editing-info">
									<h5 class="f-title"><i class="ti-info-alt"></i>모임 가입</h5>
									<!-- 모임 가입 폼 -->
									<form method="post" enctype="multipart/form-data" action="joinGroupAction">
										<input type="hidden" id = "checkGroupkey" name="groupKey" value="${groupkey}">	<!-- 현재 가입하는 모임의 모임키 -->
										<input type="hidden" name="userKey" value="${userkey}">							<!-- 현재 가입하는 유저의 유저키 -->
										
										<!-- 프사 -->
										<div class="profile-img">
											<label> <input type="file" id="uploadfile" name="uploadfile" accept="image/gif, image/jpeg, image/png" style="display: none"> 
											<img src="resources/images/default.png" id="upImg" alt="default" class="avatar">
											</label>
										</div>
										<!-- 프사 -->
										
										<!-- 닉네임 -->
										<div class="form-group half">
											<input type="text" id="nickname" name="groupNickname" required="required" /> 
											<label class="control-label" for="nickname">닉네임</label><i class="mtrl-select"></i> 
											<span class="nick-status"></span>
										</div>
										<!-- 닉네임 -->
										
										<!-- 효율적으로 코드 좀 짜보쟈 -->
										<c:if test="${quest1 ne null}">
											<div class="form-group">
												<input type="text" id="answer1" name="answer1" required="required" /> 
												<label class="control-label" for="answer1">${quest1}</label><i class="mtrl-select"></i>
											</div>
										</c:if>
										<c:if test="${quest2 ne null}">
											<div class="form-group">
												<input type="text" id="answer2" name="answer2" required="required" />
												<label class="control-label" for="answer2">${quest2}</label><i class="mtrl-select"></i>
											</div>
										</c:if>
										<c:if test="${quest3 ne null}">
											<div class="form-group">
												<input type="text" id="answer3" name="answer3" required="required" /> 
													<label class="control-label" for="answer3">${quest3}</label><i class="mtrl-select"></i>
											</div>
										</c:if>
										<c:if test="${quest4 ne null}">
											<div class="form-group">
												<input type="text" id="answer4" name="answer4" required="required" /> 
												<label class="control-label" for="answer4">${quest4}</label><i class="mtrl-select"></i>
											</div>
										</c:if>
										<c:if test="${quest5 ne null}">
											<div class="form-group">
												<input type="text" id="answer5" name="answer5" required="required" /> 
												<label class="control-label" for="answer5">${quest5}</label><i class="mtrl-select"></i>
											</div>
										</c:if>
										<c:if test="${introuduce ne null}">
											<div class="form-group">
												<textarea rows="4" id="introduce" name="introduce" required="required"></textarea>
												<label class="control-label" for="introduce">${introduce}</label><i class="mtrl-select"></i>
											</div>
										</c:if>
										<div class="submit-btns">
											<button type="reset" class="mtr-btn"><span>취소</span></button>
											<button type="submit" class="mtr-btn"><span>가입</span></button>
										</div>
									</form>
									<!-- 모임 가입 폼 -->
								</div>
							</div>
						</div>
						<!-- 그룹 페이지 위젯 중간 -->
						
						<!-- 그룹 페이지 위젯 오른쪽 -->
						<div class="col-lg-3">
							<aside class="sidebar static">
								<jsp:include page="group/group_rightWidget.jsp" />
							</aside>
						</div>
						<!-- 그룹 페이지 위젯 오른쪽 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	//달력시작==================================================================
	
	var today = new Date();//오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
	var date = new Date();//today의 Date를 세어주는 역할
	function prevCalendar() {//이전 달
		// 이전 달을 today에 값을 저장하고 달력에 today를 넣어줌
		//today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
		//getMonth()는 현재 달을 받아 오므로 이전달을 출력하려면 -1을 해줘야함
		today = new Date(today.getFullYear(), today.getMonth() - 1, today
				.getDate());
		buildCalendar(); //달력 cell 만들어 출력 
	}

	function nextCalendar() {//다음 달
		// 다음 달을 today에 값을 저장하고 달력에 today 넣어줌
		//today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
		//getMonth()는 현재 달을 받아 오므로 다음달을 출력하려면 +1을 해줘야함
		today = new Date(today.getFullYear(), today.getMonth() + 1, today
				.getDate());
		buildCalendar();//달력 cell 만들어 출력
	}
	function buildCalendar() {//현재 달 달력 만들기
		var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
		//이번 달의 첫째 날,
		//new를 쓰는 이유 : new를 쓰면 이번달의 로컬 월을 정확하게 받아온다.     
		//new를 쓰지 않았을때 이번달을 받아오려면 +1을 해줘야한다. 
		//왜냐면 getMonth()는 0~11을 반환하기 때문
		var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
		//이번 달의 마지막 날
		//new를 써주면 정확한 월을 가져옴, getMonth()+1을 해주면 다음달로 넘어가는데
		//day를 1부터 시작하는게 아니라 0부터 시작하기 때문에 
		//대로 된 다음달 시작일(1일)은 못가져오고 1 전인 0, 즉 전달 마지막일 을 가져오게 된다
		var tbCalendar = document.getElementById("calendar");
		//날짜를 찍을 테이블 변수 만듬, 일 까지 다 찍힘
		var tbCalendarYM = document.getElementById("tbCalendarYM");
		//테이블에 정확한 날짜 찍는 변수
		//innerHTML : js 언어를 HTML의 권장 표준 언어로 바꾼다
		//new를 찍지 않아서 month는 +1을 더해줘야 한다. 
		tbCalendarYM.innerHTML = today.getFullYear() + "년 "
				+ (today.getMonth() + 1) + "월";

		/*while은 이번달이 끝나면 다음달로 넘겨주는 역할*/
		while (tbCalendar.rows.length > 2) {
			//열을 지워줌
			//기본 열 크기는 body 부분에서 2로 고정되어 있다.
			tbCalendar.deleteRow(tbCalendar.rows.length - 1);
			//테이블의 tr 갯수 만큼의 열 묶음은 -1칸 해줘야지 
			//30일 이후로 담을달에 순서대로 열이 계속 이어진다.
		}
		var row = null;
		row = tbCalendar.insertRow();
		//테이블에 새로운 열 삽입//즉, 초기화
		var cnt = 0;// count, 셀의 갯수를 세어주는 역할
		// 1일이 시작되는 칸을 맞추어 줌
		for (i = 0; i < doMonth.getDay(); i++) {
			/*이번달의 day만큼 돌림*/
			cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
			cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
		}
		/*달력 출력*/
		for (i = 1; i <= lastDate.getDate(); i++) {
			//1일부터 마지막 일까지 돌림
			cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
			cell.innerHTML = "<span class='caldendarCell' id='day"+i+"'>" + i + "</span>";//셀을 1부터 마지막 day까지 HTML 문법에 넣어줌
			cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
			if (cnt % 7 == 1) {/*일요일 계산*/
				//1주일이 7일 이므로 일요일 구하기
				//월화수목금토일을 7로 나눴을때 나머지가 1이면 cnt가 1번째에 위치함을 의미한다
				cell.innerHTML = "<span class='caldendarCell' id='day"+i+"'><font color=#F79DC2>"
						+ i + "</span>";
				//1번째의 cell에만 색칠
			}
			if (cnt % 7 == 0) {/* 1주일이 7일 이므로 토요일 구하기*/
				//월화수목금토일을 7로 나눴을때 나머지가 0이면 cnt가 7번째에 위치함을 의미한다
				cell.innerHTML = "<span class='caldendarCell' id='day"+i+"'><font color=skyblue>"
						+ i + "</span>";
				//7번째의 cell에만 색칠
				row = calendar.insertRow();
				//토요일 다음에 올 셀을 추가
			}
			/*오늘의 날짜에 노란색 칠하기*/
			if (today.getFullYear() == date.getFullYear()
					&& today.getMonth() == date.getMonth()
					&& i == date.getDate()) {
				//달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
				cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
			}
		}
	}
	//달력끝==================================================================
</script>
<script>
$(function() {
	buildCalendar();
	var mycalendarlistcount = $('#gclc').val();
	for(var i = 1; i<=mycalendarlistcount;i++){
		var temp = $('#cal'+i).val();
		$('#day'+temp).parent().addClass('calendarCellMy');
	}
	
	$("#calendar").on('click', '#prevcal', function(event) {
		var userkey = $('#UserKey').val();
		prevCalendar();
		var date = $('#tbCalendarYM').text();
		ajaxcallist(userkey,date);
		$('#shortschedule').empty();
		$('#shortschedule').append('<li><span>날짜를 선택하세요</span></li>');
		
    })
    
    $("#calendar").on('click', '#nextcal', function(event) {
    	var userkey = $('#UserKey').val();
    	nextCalendar();
    	var date = $('#tbCalendarYM').text();
    	ajaxcallist(userkey,date);
    	$('#shortschedule').empty();
    	$('#shortschedule').append('<li><span>날짜를 선택하세요</span></li>');
    })
    
    
	$(".nearby-contct").on('click', '.gmtljoinbtn', function(event) {
		var userkey = $('#UserKey').val();
        var postkey = $(this).next().val();
        var n = $(this).next().next().val();
        var groupkey = $('#hiddenGroupKey').val();
        ajaxJoinBtn(postkey, groupkey, userkey, n);
        $(this).removeClass('gmtljoinbtn');
        $(this).addClass('gmtlcancelbtn');
        $(this).children().html('취소하기');
    })

    $(".nearby-contct").on('click', '.gmtlcancelbtn', function(event) {
        var userkey = $('#UserKey').val();
        var postkey = $(this).next().val();
        var n = $(this).next().next().val();
        var groupkey = $('#hiddenGroupKey').val();
        ajaxJoinCancelBtn(postkey, groupkey, userkey, n);
        $(this).removeClass('gmtlcancelbtn');
        $(this).addClass('gmtljoinbtn');
        $(this).children().html('참여하기');
    })
	$(".calendarDiv").on('click', 'td', function(event) {
        if ($(this).text() != "" || $(this).text().length() > 2) {
            $('td').removeClass('calendarCellSelected');
            $(this).addClass('calendarCellSelected');
            var userkey = $('#UserKey').val(); 
            var date = $('#tbCalendarYM').text();
            var day = $(this).text();
            if($(this).hasClass('calendarCellMy')){
            	ajaxcal(userkey,date,day);
            }else{
            	$('#shortschedule').empty();
            	$('#shortschedule').append('<li><span>일정이 없습니다</span></li>');
            }
        }
    })
    
    
    
    $(".forMemberCountBtnOne").click(function() {
    	var postkey = $(this).next().val();
        var n = $(this).next().next().val();
        var groupkey = $('#hiddenGroupKey').val();
        ajax(postkey, groupkey, n);
        if ($("#collapseOne").hasClass("show")) {
            $('.i-changeOne').removeClass('fa-arrow-up');
            $('.i-changeOne').addClass('fa-arrow-down');
        } else {
            $('.i-changeOne').removeClass('fa-arrow-down');
            $('.i-changeOne').addClass('fa-arrow-up');
        }
    })
    $(".forMemberCountBtnTwo").click(function() {
    	var postkey = $(this).next().val();
        var n = $(this).next().next().val();
        var groupkey = $('#hiddenGroupKey').val();
        ajax(postkey, groupkey, n);
        if ($("#collapseTwo").hasClass("show")) {
            $('.i-changeTwo').removeClass('fa-arrow-up');
            $('.i-changeTwo').addClass('fa-arrow-down');
        } else {
            $('.i-changeTwo').removeClass('fa-arrow-down');
            $('.i-changeTwo').addClass('fa-arrow-up');
        }
    })
    $(".forMemberCountBtnThree").click(function() {
        var postkey = $(this).next().val();
        var n = $(this).next().next().val();
        var groupkey = $('#hiddenGroupKey').val();
        ajax(postkey, groupkey, n);
        if ($("#collapseThree").hasClass("show")) {
            $('.i-changeThree').removeClass('fa-arrow-up');
            $('.i-changeThree').addClass('fa-arrow-down');
        } else {
            $('.i-changeThree').removeClass('fa-arrow-down');
            $('.i-changeThree').addClass('fa-arrow-up');
        }
    })

    //=======================================================
    $('input[type=file]:eq(0)').on('change', function() {
        $('#groupMainImgForm').submit();
    });
    $('input[type=file]:eq(1)').on('change', function() {
        $('#groupImgForm').submit();
    });


    //===== Search Filter =====//
    (function($) {
        // custom css expression for a case-insensitive contains()
        jQuery.expr[':'].Contains = function(a, i, m) {
            return (a.textContent || a.innerText || "").toUpperCase()
                .indexOf(m[3].toUpperCase()) >= 0;
        };

        function listFilter(searchDir, list) {
            var form = $("<form>").attr({
                    "class": "filterform",
                    "action": "#"
                }),
                input = $("<input>").attr({
                    "class": "filterinput",
                    "type": "text",
                    "placeholder": "회원 찾기"
                });
            $(form).append(input).appendTo(searchDir);

            $(input).change(
                function() {
                    var filter = $(this).val();
                    if (filter) {
                        $(list).find(
                                "li:not(:Contains(" + filter + "))")
                            .slideUp();
                        $(list).find("li:Contains(" + filter + ")")
                            .slideDown();
                    } else {
                        $(list).find("li").slideDown();
                    }
                    return false;
                }).keyup(function() {
                $(this).change();
            });
        }

        //search friends widget
        $(function() {
            listFilter($("#searchDir"), $("#people-list"));
        });
    }(jQuery));

    //===== Search Filter =====//나상엽추가===============================================
    (function($) {
        // custom css expression for a case-insensitive contains()
        jQuery.expr[':'].Contains = function(a, i, m) {
            return (a.textContent || a.innerText || "").toUpperCase()
                .indexOf(m[3].toUpperCase()) >= 0;
        };

        function listFilter1(searchDir1, list1) {
            var form = $("<form>").attr({
                    "class": "filterform",
                    "action": "#"
                }),
                input = $("<input>").attr({
                    "class": "filterinput",
                    "type": "text",
                    "placeholder": "회원 찾기"
                });
            $(form).append(input).appendTo(searchDir1);

            $(input).change(
                function() {
                    var filter = $(this).val();
                    if (filter) {
                        $(list1).find(
                                "li:not(:Contains(" + filter + "))")
                            .slideUp();
                        $(list1).find("li:Contains(" + filter + ")")
                            .slideDown();
                    } else {
                        $(list1).find("li").slideDown();
                    }
                    return false;
                }).keyup(function() {
                $(this).change();
            });
        }

        //search friends widget
        $(function() {
            listFilter1($("#searchDir1"), $("#people-list1"));
        });
    }(jQuery));

    //===========================================================================

    //===== Search Filter =====//나상엽추가===============================================
    (function($) {
        // custom css expression for a case-insensitive contains()
        jQuery.expr[':'].Contains = function(a, i, m) {
            return (a.textContent || a.innerText || "").toUpperCase()
                .indexOf(m[3].toUpperCase()) >= 0;
        };

        function listFilter2(searchDir2, list2) {
            var form = $("<form>").attr({
                    "class": "filterform",
                    "action": "#"
                }),
                input = $("<input>").attr({
                    "class": "filterinput",
                    "type": "text",
                    "placeholder": "회원 찾기"
                });
            $(form).append(input).appendTo(searchDir2);

            $(input).change(
                function() {
                    var filter = $(this).val();
                    if (filter) {
                        $(list2).find(
                                "li:not(:Contains(" + filter + "))")
                            .slideUp();
                        $(list2).find("li:Contains(" + filter + ")")
                            .slideDown();
                    } else {
                        $(list2).find("li").slideDown();
                    }
                    return false;
                }).keyup(function() {
                $(this).change();
            });
        }

        //search friends widget
        $(function() {
            listFilter2($("#searchDir2"), $("#people-list2"));
        });
    }(jQuery));

    //===========================================================================

    //===== Search Filter =====//나상엽추가===============================================
    (function($) {
        // custom css expression for a case-insensitive contains()
        jQuery.expr[':'].Contains = function(a, i, m) {
            return (a.textContent || a.innerText || "").toUpperCase()
                .indexOf(m[3].toUpperCase()) >= 0;
        };

        function listFilter3(searchDir3, list3) {
            var form = $("<form>").attr({
                    "class": "filterform",
                    "action": "#"
                }),
                input = $("<input>").attr({
                    "class": "filterinput",
                    "type": "text",
                    "placeholder": "회원 찾기"
                });
            $(form).append(input).appendTo(searchDir3);

            $(input).change(
                function() {
                    var filter = $(this).val();
                    if (filter) {
                        $(list3).find(
                                "li:not(:Contains(" + filter + "))")
                            .slideUp();
                        $(list3).find("li:Contains(" + filter + ")")
                            .slideDown();
                    } else {
                        $(list3).find("li").slideDown();
                    }
                    return false;
                }).keyup(function() {
                $(this).change();
            });
        }

        //search friends widget
        $(function() {
            listFilter3($("#searchDir3"), $("#people-list3"));
        });
    }(jQuery));

    //===========================================================================
    //===== Search Filter =====//나상엽추가===============================================
    (function($) {
        // custom css expression for a case-insensitive contains()
        jQuery.expr[':'].Contains = function(a, i, m) {
            return (a.textContent || a.innerText || "").toUpperCase()
                .indexOf(m[3].toUpperCase()) >= 0;
        };

        function listFilter4(searchDir4, list4) {
            var form = $("<form>").attr({
                    "class": "filterform",
                    "action": "#"
                }),
                input = $("<input>").attr({
                    "class": "filterinput",
                    "type": "text",
                    "placeholder": "회원 찾기"
                });
            $(form).append(input).appendTo(searchDir4);

            $(input).change(
                function() {
                    var filter = $(this).val();
                    if (filter) {
                        $(list4).find(
                                "li:not(:Contains(" + filter + "))")
                            .slideUp();
                        $(list4).find("li:Contains(" + filter + ")")
                            .slideDown();
                    } else {
                        $(list4).find("li").slideDown();
                    }
                    return false;
                }).keyup(function() {
                $(this).change();
            });
        }

        //search friends widget
        $(function() {
            listFilter4($("#searchDir4"), $("#people-list4"));
        });
    }(jQuery));

    //===========================================================================
    //===== Search Filter =====//나상엽추가===============================================
    (function($) {
        // custom css expression for a case-insensitive contains()
        jQuery.expr[':'].Contains = function(a, i, m) {
            return (a.textContent || a.innerText || "").toUpperCase()
                .indexOf(m[3].toUpperCase()) >= 0;
        };

        function listFilter5(searchDir5, list5) {
            var form = $("<form>").attr({
                    "class": "filterform",
                    "action": "#"
                }),
                input = $("<input>").attr({
                    "class": "filterinput",
                    "type": "text",
                    "placeholder": "회원 찾기"
                });
            $(form).append(input).appendTo(searchDir5);

            $(input).change(
                function() {
                    var filter = $(this).val();
                    if (filter) {
                        $(list5).find(
                                "li:not(:Contains(" + filter + "))")
                            .slideUp();
                        $(list5).find("li:Contains(" + filter + ")")
                            .slideDown();
                    } else {
                        $(list5).find("li").slideDown();
                    }
                    return false;
                }).keyup(function() {
                $(this).change();
            });
        }

        //search friends widget
        $(function() {
            listFilter5($("#searchDir5"), $("#people-list5"));
        });
    }(jQuery));

    //===========================================================================
    //===== Search Filter =====//나상엽추가===============================================
    (function($) {
        // custom css expression for a case-insensitive contains()
        jQuery.expr[':'].Contains = function(a, i, m) {
            return (a.textContent || a.innerText || "").toUpperCase()
                .indexOf(m[3].toUpperCase()) >= 0;
        };

        function listFilter6(searchDir6, list6) {
            var form = $("<form>").attr({
                    "class": "filterform",
                    "action": "#"
                }),
                input = $("<input>").attr({
                    "class": "filterinput",
                    "type": "text",
                    "placeholder": "회원 찾기"
                });
            $(form).append(input).appendTo(searchDir6);

            $(input).change(
                function() {
                    var filter = $(this).val();
                    if (filter) {
                        $(list6).find(
                                "li:not(:Contains(" + filter + "))")
                            .slideUp();
                        $(list6).find("li:Contains(" + filter + ")")
                            .slideDown();
                    } else {
                        $(list6).find("li").slideDown();
                    }
                    return false;
                }).keyup(function() {
                $(this).change();
            });
        }

        //search friends widget
        $(function() {
            listFilter6($("#searchDir6"), $("#people-list6"));
        });
    }(jQuery));

    //===========================================================================
    //===== Search Filter =====//나상엽추가===============================================
    (function($) {
        // custom css expression for a case-insensitive contains()
        jQuery.expr[':'].Contains = function(a, i, m) {
            return (a.textContent || a.innerText || "").toUpperCase()
                .indexOf(m[3].toUpperCase()) >= 0;
        };

        function listFilter7(searchDir7, list7) {
            var form = $("<form>").attr({
                    "class": "filterform",
                    "action": "#"
                }),
                input = $("<input>").attr({
                    "class": "filterinput",
                    "type": "text",
                    "placeholder": "회원 찾기"
                });
            $(form).append(input).appendTo(searchDir7);

            $(input).change(
                function() {
                    var filter = $(this).val();
                    if (filter) {
                        $(list7).find(
                                "li:not(:Contains(" + filter + "))")
                            .slideUp();
                        $(list7).find("li:Contains(" + filter + ")")
                            .slideDown();
                    } else {
                        $(list7).find("li").slideDown();
                    }
                    return false;
                }).keyup(function() {
                $(this).change();
            });
        }

        //search friends widget
        $(function() {
            listFilter7($("#searchDir7"), $("#people-list7"));
        });
    }(jQuery));

    //===========================================================================

    function ajax(postkey, groupkey, n) {
        output = "";
        var data = "postkey=" + postkey + "&groupkey=" + groupkey;
        var empty = "people-list" + n;
        $.ajax({
            type: "post",
            url: "group_main_ajax.net",
            data: data,
            dataType: "json",
            cache: false,
            success: function(data) {
                $("#" + empty).empty();
                output = "";
                $(data.groupcalendarmemberlist).each(
                    function(index, item) {
                        output += "<li><figure>";
                        output += "<img src='resources/images/resources/friend-avatar.jpg' alt=''>";
                        output += "</figure><div class='friendz-meta'>";
                        output += "<a href='time-line.html'></a>" + item.groupnickname;
                        output += "<i class='__cf_email__'>모임장</i></div></li>";
                    })
                $("#" + empty).append(output);
            },
            error: function() {
                console.log('에러')
            }
        }) // ajax
    } // function ajax end
    
    function ajaxJoinBtn(postkey, groupkey, userkey, n) {
        output = "";
        var data = "postkey=" + postkey + "&groupkey=" + groupkey + "&userkey=" + userkey;
        var empty = "people-list" + n;
        $.ajax({
            type: "post",
            url: "group_main_ajaxJoin.net",
            data: data,
            dataType: "json",
            cache: false,
            success: function(data) {
                $("#" + empty).empty();
                $(".currentperson"+n).empty();
                $(".currentperson"+n).html(data.currentperson);
                output = "";
                $(data.groupcalendarmemberlist).each(
                    function(index, item) {
                        output += "<li><figure>";
                        output += "<img src='resources/images/resources/friend-avatar.jpg' alt=''>";
                        output += "</figure><div class='friendz-meta'>";
                        output += "<a href='time-line.html'></a>" + item.groupnickname;
                        output += "<i class='__cf_email__'>모임장</i></div></li>";
                    })
                $("#" + empty).append(output);
            },
            error: function() {
                console.log('에러')
            }
        }) // ajax
    } // function ajax end

    function ajaxJoinCancelBtn(postkey, groupkey, userkey, n) {
        output = "";
        var data = "postkey=" + postkey + "&groupkey=" + groupkey + "&userkey=" + userkey;
        var empty = "people-list" + n;
        $.ajax({
            type: "post",
            url: "group_main_ajaxJoinCancel.net",
            data: data,
            dataType: "json",
            cache: false,
            success: function(data) {
                $("#" + empty).empty();
                output = "";
                $(".currentperson"+n).empty();
                $(".currentperson"+n).html(data.currentperson);
                $(data.groupcalendarmemberlist).each(
                    function(index, item) {
                        output += "<li><figure>";
                        output += "<img src='resources/images/resources/friend-avatar.jpg' alt=''>";
                        output += "</figure><div class='friendz-meta'>";
                        output += "<a href='time-line.html'></a>" + item.groupnickname;
                        output += "<i class='__cf_email__'>모임장</i></div></li>";
                    })
                $("#" + empty).append(output);
            },
            error: function() {
                console.log('에러')
            }
        }) // ajax
    } // function ajax end
    
    function ajaxCalendarList(userkey) {
        output = "";
        var data = "postkey=" + postkey + "&groupkey=" + groupkey + "&userkey=" + userkey;
        var empty = "people-list" + n;
        $.ajax({
            type: "post",
            url: "group_main_ajaxJoinCancel.net",
            data: data,
            dataType: "json",
            cache: false,
            success: function(data) {
                $("#" + empty).empty();
                output = "";
                $(".currentperson"+n).empty();
                $(".currentperson"+n).html(data.currentperson);
                $(data.groupcalendarmemberlist).each(
                    function(index, item) {
                        output += "<li><figure>";
                        output += "<img src='resources/images/resources/friend-avatar.jpg' alt=''>";
                        output += "</figure><div class='friendz-meta'>";
                        output += "<a href='time-line.html'></a>" + item.groupnickname;
                        output += "<i class='__cf_email__'>모임장</i></div></li>";
                    })
                $("#" + empty).append(output);
            },
            error: function() {
                console.log('에러')
            }
        }) // ajax
    } // function ajax end
    
    function ajaxcallist(userkey,date) {
        output = "";
        var data = "userkey=" + userkey + "&date=" + date;
        $.ajax({
            type: "post",
            url: "group_main_ajaxCalList.net",
            data: data,
            dataType: "json",
            cache: false,
            success: function(data) {
                $(data.groupcalendarlist).each(
                    function(index, item) {
                       if(!$('#day'+item.startdate).parent().hasClass('calendarCellMy')){
                    		$('#day'+item.startdate).parent().addClass('calendarCellMy');
                       }
                    })

            },
            error: function() {
                console.log('에러')
            }
        }) // ajax
    } // function ajax end
    
    function ajaxcal(userkey,date,day) {
        output = "";
        var data = "userkey=" + userkey + "&date=" + date + "&day=" + day;
        $.ajax({
            type: "post",
            url: "group_main_shortschedule.net",
            data: data,
            dataType: "json",
            cache: false,
            success: function(data) {
            	$('#shortschedule').empty();
                output = "";
            	$(data.shortscheduleSelected).each(
                        function(index, item) {
                        	output += "<li><span>"+item.posttitle+"</span>";
                        	output += "<p>모임명: "+item.groupname +"<br>시간: "+item.startdate+"<br>장소:"+item.location+"</p></li>";
                        })
                        $('#shortschedule').append(output);
            },
            error: function() {
                console.log('에러')
            }
        }) // ajax
    } // function ajax end
})
</script>

<script src="resources/js/script.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />