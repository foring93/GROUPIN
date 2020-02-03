// 가입한 모임 이동
function goGroup(groupKey) {
	var f = document.myForm;		// 폼 name
	f.groupKey.value = groupKey;	// input 태그 중 name이 groupKey인 값에 대해서 groupkey를 넘긴다.
	f.action = "groupmain.net";		// 이동할 페이지
	f.method = "post";				// POST 방식으로 데이터 전송
	f.submit();						// 폼 전송
};

// 게시글 이동
function board(groupKey, postKey) {
	var f = document.myForm;		// 폼 name
	f.groupKey.value = groupKey;	// input 태그 중 name이 groupKey인 값에 대해서 groupkey를 넘긴다.
	f.postKey.value = postKey;		// input 태그 중 name이 postKey인 값에 대해서 postkey를 넘긴다.
	f.action = "detailBoard.net";	// 이동할 페이지
	f.method = "post";				// POST 방식으로 데이터 전송
	f.submit();						// 폼 전송
}

$(function() {
	var status = 0;	// 어떤 메뉴를 눌렀는지 확인
	var add = '';	// append시킬 변수 
	
	// 일반적으로 회원 누르고 왔을 때 / 모임 내 프로필 상에서 내가 쓴 글, 내가 쓴 댓글 보려고 왔을 때 구분
	var getStatus = $('#getStatus').val();
	
	if (getStatus == 0)
		$('.user-active li').eq(0).addClass('selected-menu');
	else if (getStatus == 1)
		$('.user-active li').eq(1).addClass('selected-menu');
	else
		$('.user-active li').eq(2).addClass('selected-menu');
		
	
	/* 가입한 모임, 작성글, 작성댓글 중 선택한 메뉴에 대한 색 변경 */ 
	$('.user-active li').click(function(){
		$('.user-active li').removeClass('selected-menu');
		$(this).addClass('selected-menu');
		viewList($('#userKey').val(), $('#groupKey').val(), $(this).index());	// 선택될 때마다 넘긴다.
	});
	
	/* 가입한 모임, 작성글, 작성댓글 중 선택한 메뉴 클릭 시 이동 X */
	$('.user-active a').click(function() {
		event.preventDefault();
	});
	
	// 메뉴 클릭할 때마다 ajax로 불러오기 
	function viewList(userkey, groupkey, status) {
		$.ajax({
			type : "POST",
			url : "G_mem_detail_Ajax",
			data : {userKey : userkey, groupKey : groupkey, menu : status},
			dataType : 'json',
			cache : false,
			success : function(data) {
				$('table').html('');
				switch (data.menu) {
					case 0:
						add = signedGroup(data);
						break;
					case 1:
						add = wroteTitle(data);
						break;
					case 2:
						add = wroteComment(data);
						break;
				}
				$('table').append(add);
				//$('table').append("<h1>돌겠네</h1>");
			},
			error : function(request, status, error) {
				console.log("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
			}
		}); // ajax end
	}; // function go end
	
	/* ##### 가입한 모임 ##### */
	function signedGroup (data) {
		console.log(data.list);
		var doc = '';
		doc += '<thead>';
		doc += '	<tr>';
		doc += '		<th scope = "col">Name</th>';
		doc += '		<th scope = "col">Member</th>';
		doc += '		<th scope = "col">Date</th>';
		doc += '	</tr>';
		doc += '</thead>';
		doc += '<tbody>';
		$(data.list).each(function(index, item) {
			doc += '	<tr>';
			doc += '		<td>';
			// \' 는 ' 이다. \" 는 " 이구.
			doc += "			<img src= \"<spring:url value='/image" + item.groupDFile + "'/>\" class = 'group-img' alt = ''/>";
			doc += '			<a href = "javascript:goGroup(' + "'" + item.groupKey + "'" + ');" title = "">' + item.groupName + '</a>';
			doc += '		</td>';
			doc += '		<td>';
			doc += 				item.memberCount + '명';
			doc += '		</td>';
			doc += '		<td>';
			doc += 				item.groupDate;
			doc += '		</td>';
			doc += '	</tr>';
		}); 
		doc += '</tbody>';
		return doc;
	} // signedGroup end

	/* ##### 작성한 글 ##### */
	function wroteTitle(data) {
		console.log(data.list);
		var doc = '';
		doc += '<thead>';
		doc += '	<tr>';
		doc += '		<th scope = "col">Subject</th>';
		doc += '		<th scope = "col">ViewCount</th>';
		doc += '		<th scope = "col">Date</th>';
		doc += '	</tr>';
		doc += '</thead>';
		doc += '<tbody>';
		if ((data.list).length != 0) {
			$(data.list).each(function(index, item){
				doc += '	<tr>';
				doc += '		<td>';
				doc += '			<a href = "detailBoard?postkey=' + item.postKey + '&groupkey=' + item.groupKey + '" title = "">' + item.postTitle + '</a>';
				doc += '		</td>';
				doc += '		<td>';
				doc += 				item.postReadcount;
				doc += '		</td>';
				doc += '		<td>';
				doc += 				item.postDate;
				doc += '		</td>';
				doc += '	</tr>';
			});
		} else {
			doc += '<tr><td colspan = 3>작성글이 존재하지 않습니다.</td></tr>'
		}
		doc += '</tbody>';
		return doc;
	} // wroteTitle end

	/* ##### 작성한 댓글 ##### */
	function wroteComment(data) {
		console.log(data.list);
		var doc = '';
		doc += '<thead>';
		doc += '	<tr>';
		doc += '		<th scope = "col">Comment</th>';
		doc += '		<th scope = "col">ViewCount</th>';
		doc += '		<th scope = "col">Date</th>';
		doc += '	</tr>';
		doc += '</thead>';
		doc += '<tbody>';
		if ((data.list).length != 0) {
			$(data.list).each(function(index, item){
				doc += '	<tr>';
				doc += '		<td>';
				doc += '			<div class = "comment-info">';
				doc += '				<div class = "comment-content">';
				doc += '					<span>';
				doc += '						<a href = "detailBoard?postkey=' + item.postKey + '&groupkey=' + item.groupKey + '" title = "">' + item.commentContent + '</a>';
				doc += '					</span>';
				doc += '				</div>';
				doc += '				<div class = "comment-subject">';
				doc += '					<span>';
				doc += '						<a href = "detailBoard?postkey=' + item.postKey + '&groupkey=' + item.groupKey + '" title = "">' + item.postTitle + '</a>';
				doc += '					</span>';
				doc += '					<span class = "comment-num">';
				doc += 						'[' + item.replyCount + ']';
				doc += '					</span>';
				doc += '				</div>';
				doc += '		</td>';
				doc += '		<td>';
				doc +=				item.postReadcount;
				doc += '		</td>';
				doc += '		<td>';
				doc += 				item.commentDate;
				doc += '		</td>';
				doc += '	</tr>';
			});
		} else {
			doc += '<tr><td colspan = 3>댓글이 존재하지 않습니다.</td></tr>'
		}
		doc += '</tbody>';
		return doc;
	} // wroteComment end
});
