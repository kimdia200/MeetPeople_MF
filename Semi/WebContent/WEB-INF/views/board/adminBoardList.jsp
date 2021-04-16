<%@page import="member.model.service.MemberService"%>
<%@page import="board.model.vo.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ include file="/WEB-INF/views/common/header.jsp"%>
<% 
	List<Board> list = (List<Board>)request.getAttribute("list");  
	int cPage = (int)request.getAttribute("cPage");
%>


<!-- css링크 -->
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/css/board.css" />
	<h2>공지사항</h2>
<div id="boardListWrapper">
	<%if(loginMember!=null && loginMember.getMemberRole().equals(MemberService.ADMIN_ROLE)){ %>
	<input type="button" value="글쓰기" id="btn-add"
		onclick="location.href='<%= request.getContextPath() %>/board/adminBoardEnroll?writer=<%= loginMember.getMemberId() %>'" />
	<% } %>
	<table id="tbl-board">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<%if(list == null || list.isEmpty()){%>
		<tr>
			<td colspan="6" style="text-align: center">조회된 게시글이 없습니다.</td>
		</tr>
		<%}else{ 
			for(Board b:list){
			%>
		<tr>
			<td><%= b.getBoardNo()%></td>
			<td>
				<a
				href="<%= request.getContextPath()%>/board/adminBoardView?no=<%=b.getBoardNo()%>&cPage=<%=cPage %>">
					<%= b.getTitle() %>
			</a></td>
			<td><%= b.getWriter() %></td>
			<td><%= b.getRegDate() %></td>
		</tr>
		<%}} %>
	</table>
</div>
<div id='pageBar'>
	<%= request.getAttribute("pageBar") != null ? request.getAttribute("pageBar") : ""%>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>