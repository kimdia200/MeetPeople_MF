<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date"%>
<%@page import="meeting.model.vo.Meeting"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<% 
	Meeting m = (Meeting)request.getAttribute("meeting");
	List<String> list = (List<String>)request.getAttribute("list");
%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/meetingView.css" />
	
	<div id="meetingViewWrapper">
		<div id="meetingViewLeft">
			<div id="imgWrapper">
				<img src="<%=request.getContextPath() %>/upload/<%=m.getAttach().getRenamedFilename()%>"/>
			</div>	
			<div id="contentWrapper">
				<%= m.getContent() %>
			</div>	
		</div>
		
		
		<div id="meetingViewRight">
			<div id="description">
				<h2><%= m.getTitle() %></h2>
				<!-- 카테고리, 지역,             장소 시간 참가비용 인원 작성일자 -->
				<table>
					<tr>
						<th>카테고리</th>
						<td><%=m.getCategoryName() %></td>
					</tr>
					<tr>
						<th>지역</th>
						<td><%= m.getLocationName() %></td>
					</tr>
					<tr>
						<th>장소</th>
						<td><%= m.getPlace() %></td>
					</tr>
					<tr>
						<th>일자</th>
						<% 
							SimpleDateFormat sdf =  new SimpleDateFormat("yy-MM-dd HH:mm");
							SimpleDateFormat sdf2 = new SimpleDateFormat("yy-MM-dd");
						%>
						<td><%= sdf.format(m.getTime()) %></td>
					</tr>
					<tr>
						<th>참가비용</th>
						<td><%= m.getCost() %>원</td>
					</tr>
					<tr>
						<th>인원</th>
						<td><%=m.getCountParticipation() %> / <%=m.getMaxPeople() %></td>
					</tr>
					<tr>
						<th>등록일자</th>
						<td><%= sdf2.format(m.getRegDate()) %></td>
					</tr>
					
				</table>
			</div>
				
			<form id="meetingViewFrm" method="post">
				<input type="hidden" name="memberId" value="<%=loginMember != null ? loginMember.getMemberId() : ""%>" />
				<input type="hidden" name="meetingNo" value="<%=m.getMeetingNo()%>" />
			</form>
			<!-- 작성자 본인은 취소 불가, 신청시 디비추가 -->
			<% if(m.getTime().getTime()< new java.util.Date().getTime()
				 || m.getCountParticipation()>=m.getMaxPeople()
					){%>
			<input type="button" value="마감" class="meetingViewBtn" id="deadline"/>
			<%}else if(loginMember!=null && list.contains(loginMember.getMemberId())){ %>
			<input type="button" value="취소" class="meetingViewBtn" id="cancel" onclick="cancel();"/>
			<%}else{ %>
			<input type="button" value="신청" class="meetingViewBtn" id="submit" onclick="apply();"/>
			<%} %>
		</div>
	</div>
	<%if(loginMember!=null && (loginMember.getMemberId().equals(m.getWriter())) || loginMember.getMemberRole().equals(MemberService.ADMIN_ROLE)) {%>

	<div id="updateDeleteWrapper">
		<input type="button" value="수정"  onclick="updatee();" />
		<input type="button" value="삭제"  onclick="deletee();" />
	</div>
	<%} %>
	
	<script>
		function cancel(){
			//취소버튼을 눌렀을때 모임 생성자이면 취소가 안되고 삭제를 안내해야함
			if(<%=loginMember!=null && loginMember.getMemberId().equals(m.getWriter())%>){
				alert("모임 주최자는 취소가 불가능 합니다.");
				return;
			}
			if(confirm("모임참여를 취소하시겠습니까?")){
				$("#meetingViewFrm").attr("action","<%=request.getContextPath()%>/meeting/meetingCancel").submit();
			}
		};
		
		function apply(){
			//신청 버튼 눌렀을때 로그인 안되어있으면 신청이 안되고 로그인 유도
			if(<%=loginMember==null%>){
				loginAlert();
				return;
			}
			if(confirm("모임에 참여 하시겠습니까?")){
				$("#meetingViewFrm").attr("action","<%=request.getContextPath()%>/meeting/meetingApply").submit();
			}
		};
		
		function loginAlert(){
			alert("로그인후 이용 하실수 있습니다.");
			$("#login_button").click();
			$("#password_input").focus();
			return;
		};
		
		function updatee(){
			$("#meetingViewFrm").attr("action","<%=request.getContextPath()%>/meeting/meetingUpdate").attr("method","get").submit();
		}
		function deletee(){
			if(confirm("모임을 삭제 하시겠습니까?")){
				$("#meetingViewFrm").attr("action","<%=request.getContextPath()%>/meeting/meetingDelete").submit();
			}
		}
	</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>