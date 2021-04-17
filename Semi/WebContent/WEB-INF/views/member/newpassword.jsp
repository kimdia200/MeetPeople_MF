<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/find.css" />

    <form action="<%=request.getContextPath()%>/member/newpassword"
		method="POST">
		
		
		<div class="new_password_div" id="new_password_div">
			<div>새로운 비밀번호</div>
            <br> 
            <input type="password" name="new_password_input1" id="new_password_input1"placeholder="새로운 비밀번호를 입력해주세요"> 
			<br> <input type="password" name="new_password_input2" id="new_password_input2"
				placeholder="새로운 비밀번호를 다시한번 입력해주세요"> 
                <br>
				<input type="hidden" name="hidden_id" id="hidden_id" value="<%= request.getParameter("id") %>"/>
				<input type="hidden" name="hidden_email" id="hidden_email"  value="<%= request.getParameter("email") %>"/>
				<input type="submit"name="new_password_button" id="new_password_button" value="비밀번호 변경하기">
		</div>
	</form>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>