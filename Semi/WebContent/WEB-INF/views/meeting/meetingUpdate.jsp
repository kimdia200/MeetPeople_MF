<%@page import="java.text.SimpleDateFormat"%>
<%@page import="meeting.model.vo.Meeting"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<% Meeting m = (Meeting)request.getAttribute("meeting"); %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet" />
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!-- include summernote css/js-->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css"
	rel="stylesheet" />
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath() %>/css/meetingView.css" />

		
	<div id="meetingViewWrapper">
		<div id="meetingViewLeft">
			<div id="imgWrapper">
				<img src="<%=request.getContextPath() %>/upload/no_img.png"/>
			</div>	
			<div id="contentWrapper">
			</div>	
		</div>
		
		
		<div id="meetingViewRight">
			<div id="description">
			<form action="<%=request.getContextPath()%>/meeting/meetingUpdate" method="post" id="updateFrm">

				<input type="text" name="title" id="title" required placeholder="제목을 입력해주세요" value="<%=m.getTitle()%>"/>			
				<table>
					<tr>
						<th>카테고리</th>
						<td>
							<select name="category" id="category">
								<option value="C1" <%=m.getCategoryCode().equals("C1") ? "checked" : ""%>>음악</option>
								<option value="C2" <%=m.getCategoryCode().equals("C2") ? "checked" : ""%>>게임</option>
								<option value="C3" <%=m.getCategoryCode().equals("C3") ? "checked" : ""%>>운동</option>
								<option value="C4" <%=m.getCategoryCode().equals("C4") ? "checked" : ""%>>요리</option>
								<option value="C5" <%=m.getCategoryCode().equals("C5") ? "checked" : ""%>>독서</option>
								<option value="C6" <%=m.getCategoryCode().equals("C6") ? "checked" : ""%>>재테크</option>
								<option value="C7" <%=m.getCategoryCode().equals("C7") ? "checked" : ""%>>자동차</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>지역</th>
						<td>
							<select name="location" id="location">
								<option value="L1" <%=m.getLocationCode().equals("L1") ? "checked" : "" %>>서울</option>
								<option value="L2" <%=m.getLocationCode().equals("L2") ? "checked" : "" %>>경기</option>
								<option value="L3" <%=m.getLocationCode().equals("L3") ? "checked" : "" %>>인천</option>
								<option value="L4" <%=m.getLocationCode().equals("L4") ? "checked" : "" %>>대전·충청</option>
								<option value="L5" <%=m.getLocationCode().equals("L5") ? "checked" : "" %>>대구·경북</option>
								<option value="L6" <%=m.getLocationCode().equals("L6") ? "checked" : "" %>>부산·경남</option>
								<option value="L7" <%=m.getLocationCode().equals("L7") ? "checked" : "" %>>울산</option>
								<option value="L8" <%=m.getLocationCode().equals("L8") ? "checked" : "" %>>광주</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>장소</th>
						<td><input type="text" name="place" id="place" value="<%=m.getPlace()%>" required/></td>
					</tr>
					<tr>
						<th>일자</th>
						<!-- 2021-04-23T23:32 -->
						<%SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-ddThh:mm"); %>
						<td><input type="datetime-local" name="time" id="time" value="<%=sdf.format(m.getTime())%>" required/></td>
					</tr>
					<tr>
						<th>참가비용</th>
						<td><input type="number" name="cost" id="cost" required min="0" step="1000" value="<%=m.getCost()%>"/>원</td>
					</tr>
					<tr>
						<th>최대인원</th>
						<td><input type="number" name="max" id="max" min="1" value="<%=m.getMaxPeople()%>" required/>명</td>
					</tr>
				</table>
				<input type="hidden" name="no" value="<%=m.getMeetingNo()%>" />
				<input type="hidden" name="writer" value="<%=loginMember.getMemberId() %>" />
				<input type="hidden" name="content" value="" id="realContent"/>
			</form>
			</div>
		</div>
	</div>
	<div id="updateDeleteWrapper">
		<input type="button" value="수정"  onclick="updatee();" />
		<input type="button" value="취소"  onclick="deletee();" />
	</div>
	
	<script>
	$(document).ready(function(){
		$("#contentWrapper").summernote({
	        width: 800,
	        height: 500,
	        focus: true,
	        disableResizeEditor: true,
	    }).summernote("code","<%=m.getContent()%>");
	})
	
	function updatee(){
		var content = $("#contentWrapper").summernote("code");
		$("#realContent").val(content);
		//유효성 검사 넣어야함
		
		
		if(confirm("게시물을 수정하시겠습니까?")){
			$("#updateFrm").submit();
		}
	}
	</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>