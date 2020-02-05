<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<jsp:include page="../mainpage/header.jsp" />

<style>
.nearby-contct>li {
	background: #fff none repeat scroll 0 0;
	border: 1px solid #eaf1f6;
	display: inline-block;
	margin-bottom: 0px;
	padding: 20px;
	width: 100%;
	transition: all 0.15s linear 0s;
}

.nearby-contct>li:hover {
	box-shadow: 0 0 0 0 #e1e8ec;
	border-color: transparent;
}

.mtr-btn {
	margin-top: 0px;
	width: 100%;
	height: 80px;
}

#prModal {
	display: none;
}

.modal-backdrop {
	z-index: -1;
}

.modal.fade.show {
	background: rgba(0, 0, 0, 0.5);
}

#exampleModal .modal-dialog {
	-webkit-transform: translate(0, -50%);
	-o-transform: translate(0, -50%);
	transform: translate(0, -50%);
	top: 50%;
	margin: 0 auto;
}

.modal.fade.show {
	background: rgba(0, 0, 0, 0.5);
}

#prModal .modal-dialog {
	-webkit-transform: translate(0, -50%);
	-o-transform: translate(0, -50%);
	transform: translate(0, -50%);
	top: 50%;
	margin: 0 auto;
}

.prtitle {
	font-weight: bold;
	font-size: 16pt;
}

.center-block {
	display: flex;
	justify-content: center;
}

 .btn {
    padding: .12rem .12rem;


 }
</style>

<section>
	<div class="gap gray-bg">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="row" id="page-contents">
						<div class="col-lg-3">
								<aside class="sidebar static">
								<div class="widget">
									<h4 class="widget-title">ī�װ�</h4>
									<ul class="naves">
										<c:forEach items="${dcategory }" var="item" varStatus="status">
											<li><a data-toggle="collapse" href="#collapseExample${status.index }" role="button"
												aria-expanded="false" aria-controls="collapseExample${status.index }">
												${item.DCategoryName }</a>
												
											</li>
										</c:forEach>
									</ul>
								</div>
								<!-- Shortcuts -->
							</aside>
						</div>
						<!-- sidebar -->
						<div class="col-lg-6">
							<div class="central-meta">
								<div class="groups">
									<span><i class="fa fa-users"></i>���� ȫ�� �Խ���</span>
								</div>
								<c:if test="${listcount > 0 }">
									<ul class="nearby-contct">
										<c:forEach var="boardlist" items="${boardlist}">
											<li>
												<div class="nearly-pepls">
													<figure>
														<span>${boardlist.prKey }</span>
														<img src="<spring:url value='/image${boardlist.groupDFile }'/>" />
														<input type="hidden" name="userkey"
															value="${boardlist.userKey }" id="user">
							                                     						</figure>
													<div class="pepl-info">
														<h4>${boardlist.groupName }</h4>
														<span>${boardlist.dateWrite}</span>
														<p>${boardlist.content }</p>
														
														<a class="add-butn" href="groupmain?groupkey=${boardlist.groupKey}"> �湮�ϱ�</a>
														<!-- �ۼ��ڿ� �����ڸ� ����/���� �����ϰ� -->
														<c:if test="${boardlist.userKey == userInfo.userKey || id == 'admin'}"> 
															<a href="./prmodify?prKey=${boardlist.prKey}">
																<button type="button" class="btn btn-outline-info">����</button>
															</a>
															<!-- �� ���� -->
															<a href="#">
															<input type="hidden" name="prKey" value="${boardlist.prKey}" />
																<button class="btn btn-outline-danger" id="myModalbtn"
																	data-toggle="modal" data-target="#myModal">����</button>
															</a>
														</c:if> 
													</div>
												</div>
											</li>
										</c:forEach>
									</ul>
								</c:if>
								<c:if test="${listcount == 0 }">
									<font size=5>��ϵ� ȫ������ �����ϴ�.</font>
								</c:if>
								<br>
								<br>
								<br>
								<div class="center-block">
									<div class="row">
										<div class="col">
											<ul class="pagination">
												<c:if test="${page <= 1 }">
													<li class="page-item"><a class="page-link" href="#">����&nbsp;</a>
													</li>
												</c:if>
												<c:if test="${page > 1 }">
													<li class="page-item"><a
														href="prboard?page=${page-1 }" class="page-link">����</a>&nbsp;
													</li>
												</c:if>
												<c:forEach var="a" begin="${startpage }" end="${endpage }">
													<c:if test="${a == page }">
														<li class="page-item"><a class="page-link" href="#">${a }</a>
														</li>
													</c:if>
													<c:if test="${a != page }">
														<li class="page-item"><a href="prboard?page=${a }"
															class="page-link">${a }</a></li>
													</c:if>
												</c:forEach>
												<c:if test="${page >= maxpage }">
													<li class="page-item"><a class="page-link" href="#">&nbsp;����</a>
													</li>
												</c:if>
												<c:if test="${page < maxpage }">
													<li class="page-item"><a
														href="prboard?page=${page+1 }" class="page-link">&nbsp;����</a>
													</li>
												</c:if>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<!-- photos -->

						</div>
						<!-- centerl meta -->
						<div class="col-lg-3">
							<aside class="sidebar static">
							<!-- �׷� �α��� ���� -->
								<c:if test="${empty id}">
									
								</c:if>
								<!-- �׷� �α��� ���� -->

								<!-- �׷� ���� ���� ���� -->
								<c:if test="${!empty id}">
									<div class="widget">
										<h4 class="widget-title">���� ����</h4>
										<div class="your-page your-page-groupListDiv">

											<div class="page-meta">
												<a title="" class="underline">
											 <c:choose>
												<c:when test="${userInfo.logintype == 0}">
													${userInfo.userId }
												</c:when>
												<c:otherwise>
												īī���� ����
												</c:otherwise>
											</c:choose>

												</a> <em><i class="ti-bell"></i>��������</em>
											</div>
											<div class="page-likes">
												<ul class="nav nav-tabs likes-btn">
													<li class="nav-item"><a class="active" href="#link1"
														data-toggle="tab">���Ǹ�������</a></li>
													<li class="nav-item"><a class="" href="#link2"
														data-toggle="tab">���Ը��Ӹ��</a></li>
												</ul>
												<!-- Tab panes -->
												<div class="tab-content">
													<div class="tab-pane active fade show" id="link1">
														<span><i class="ti-heart"></i>884</span> <a href="#"
															title="weekly-likes">35 new likes this week</a>
														<div class="users-thumb-list">
															<a href="#" title="Anderw" data-toggle="tooltip"> <img
																src="resources/images/resources/userlist-1.jpg" alt="">
															</a> <a href="#" title="frank" data-toggle="tooltip"> <img
																src="resources/images/resources/userlist-2.jpg" alt="">
															</a> <a href="#" title="Sara" data-toggle="tooltip"> <img
																src="resources/images/resources/userlist-3.jpg" alt="">
															</a> <a href="#" title="Amy" data-toggle="tooltip"> <img
																src="resources/images/resources/userlist-4.jpg" alt="">
															</a> <a href="#" title="Ema" data-toggle="tooltip"> <img
																src="resources/images/resources/userlist-5.jpg" alt="">
															</a> <a href="#" title="Sophie" data-toggle="tooltip"> <img
																src="resources/images/resources/userlist-6.jpg" alt="">
															</a> <a href="#" title="Maria" data-toggle="tooltip"> <img
																src="resources/images/resources/userlist-7.jpg" alt="">
															</a>
														</div>
													</div>
													<div class="tab-pane fade" id="link2">
														<div>
															<ul class="your-page-groupList">
																<li>��.Ź</li>
																<li>��.Ź</li>
																<li>��.Ź</li>
															</ul>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</c:if>
								<!-- ���� ���� ���� -->
								<!-- who's following -->
								<div class="widget">
									<button type="button" class="mtr-btn" id="prwritebtn">
										<span><h4>���� ȫ���ϱ�</h4></span>
									</button>
								</div>
						</div>
						<!-- creat page-->
						</aside>
					</div>
					<!-- sidebar -->
				</div>
			</div>
		</div>
	</div>
	</div>
</section>
</div>

<%-- modal ���� --%>
      <div class="modal" id="myModal" >
      <div class="modal-dialog" >
         <div class="modal-content">
            <!-- Modal body -->
            <div class="modal-body">
               <form name="deleteForm" action="prDeleteAction"  method="post">
                <input type="hidden" name="prKey">
                  <div class="form-group">
                                                         ���� ���� �Ͻðڽ��ϱ�?
                  </div>
                  <button type="submit" class="btn btn-primary" >����</button>
                   <button type="button" class="btn btn-danger" data-dismiss="modal" >���</button>
               </form>
            </div>
         </div>
      </div>
   </div> <!-- ���� ��� �� -->


<jsp:include page="../mainpage/footer.jsp" />


<script data-cfasync="false"
	src="../../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
<script src="resources/js/map-init.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA8c55_YHLvDHGACkQscgbGLtLRdxBDCfI"></script>
<script>
   
   //���� ��� �ȿ� ���� Ű�� �ִ°�
    $("#myModalbtn").on('click', function(){
    	var prkey = $(this).prev().val(); //Ŭ���� �� ��ư�� ��..
    	$('input[name=prKey]').attr('value', prkey);
    })
   
   
	$("#prwritebtn").click(function() {
		
	  /*
		//�Ϸ� �� �� ����
		if(userwrite == 5){
			alert("ȫ������ �Ϸ� 5ȸ�� �ۼ� �����մϴ�.");
			location.href = "prboard";
		}else{
			location.href = "prwrite";
		}
	  */

		location.href = "prwrite";
	});
	
	
</script>
</body>

</html>