<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="member.model.vo.Member"%>


<%
	String msg = (String) session.getAttribute("msg");
	if (msg != null)
	session.removeAttribute("msg");
	Member loginMember = (Member) session.getAttribute("loginMember");
	//사용자 쿠키처리
	String saveId = null;
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie c : cookies) {
			String name = c.getName();
			String value = c.getValue();
			System.out.println(name + " : " + value);
			if ("saveId".equals(name))
		saveId = value;
		}
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/index.css" />
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
</head>
<body>
	<header>
	
			<a href="<%=request.getContextPath()%>"><img src="<%=request.getContextPath() %>/images/Logo.png" id="Logo"/></a>
			<div class="login">
			<%
				if (loginMember == null) {
			%>
			
			<input type="button" value="로그인" id="login_button">
			<input type="button" value="회원가입" id="signup_button" onclick="location.href='<%=request.getContextPath()%>/member/enroll';">
			<%
				} else {
			%>
		
			<%-- 로그인 성공시 --%>
			<table id="login">
				<tr>
					<td><%=loginMember.getName()%>님, 안녕하세요.</td>
				</tr>
				<tr>
					<td><input type="button" value="mypage"
						onclick="location.href='<%=request.getContextPath()%>/member/mypage';" class="loginbtn" />
						<input type="button" value="logout"
						onclick="location.href='<%=request.getContextPath()%>/member/logout';" class="loginbtn"/>
					</td>
				</tr>
			</table>

			<%
				}
			%>
			</div>
			<div class="loginEnd"></div>
		<!-- Loginframe 평소에 hide -->
		<div id="login_frame_div">
			<img src="<%=request.getContextPath()%>/images/city1.png" id="login_image">

			<!-- 로그인 포지션-->
			<form id="login_form"
				action="<%=request.getContextPath()%>/member/login" method="POST">
					<input type="button" id="login_closeBtn" value="X" style="float:right;"/>
					<h1 style="clear:both;">로그인</h1>
					<br> 
					<input type="text" name="id_input" id="id_input" placeholder="아이디를 입력해주세요."<%=saveId != null ? "value='" + saveId + "'" : ""%>> <br>
					<input type="password" name="password_input" id="password_input" placeholder="비밀번호를 입력해주세요."> <br> 
					<input type="submit" name="login_submit" id="login_submit" value="로그인">
					<br>
					<div id="checkbox_findbox_wrapper">
						<div id="checkbox_wrapper">
							<input type="checkbox" name="saveid" id="saveid" <%=saveId != null ? "checked" : ""%> /> 
							<label for="saveid">로그인 유지하기</label>
						</div>

						<a href="<%=request.getContextPath()%>/member/find"><span id="find_span">아이디+비밀번호 찾기</span></a>
					</div>
					<br> <br>
					<div class="enroll_div" id="enroll_div"  onclick="location.href='<%=request.getContextPath()%>/member/enroll';" style="clear:both";>
						미플 회원가입하기
						<!-- 회원이 아니신가요? <span id="enroll_span" onclick="enroll_span()">회원가입</span> -->
					</div>
			</form>
		</div>			
			
		<ol>
			<li><a href="">전체</a></li>
			<li><a href="<%=request.getContextPath()%>/meeting/meetingEnrollUpdate">mt:enrollUpdate</a></li>
			<li><a href="<%=request.getContextPath()%>/meeting/meetingView">mt:View</a></li>
			<li><a href="">음악</a></li>
			<li><a href="">게임</a></li>
			<li><a href="">운동</a></li>
			<li><a href="">요리</a></li>
			<li><a href="">독서</a></li>
			<li><a href="">재테크</a></li>
			<li><a href="">자동차</a></li>
			<li><a href="<%=request.getContextPath()%>/board/boardList">자유게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/adminBoardList">공지사항</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/memberList">회원관리</a></li>
		</ol>

		<script>
			<%if(msg!=null){%>
				alert("<%=msg%>");
			<%}%>
			$(signup_button).click(function(){
				location.href="<%=request.getContextPath()%>/member/enroll";
			});
			$(login_button).click(function() {
				var top = screen.availHeight / 2 - 200;
				$("#login_frame_div").attr('style', 'display:flex; top:'+top+'px;');
				if(id_input.value.length==0){
					$('#id_input').focus();
				}else{
					$('#password_input').focus();
				}
			});
			$(login_closeBtn).click(function(){
				$("#login_frame_div").attr('style', 'display:none;');
			});
		</script>
		
		
	<style>
	

		
#login_frame_div {
	width: 700px;
	height: 500px;
	border: 1px solid black;
	z-index: 1;
	background-color: pink;
	position: fixed;
	display: none;
	margin: 0 auto;
	left: 0;
	right: 0;
}


/* image */
#login_image {
	width: 50%;
    height: 100%;
}


/* 우측 div */
#login_form {
	width: 99%;
	display: inline-block;
}

#login_form>h1 {
	text-align: center;
}

#login_form>[type=text], #login_form>[type=password] {
	width: 280px;
	height: 38px;
	margin-top: 7px;
	border: 1px solid #e6e6e6;
	border-radius: 4px;
	font-size: 14px;
	
}

#login_button, #signup_button{
	margin: 0px;
	margin-top:20px;
	margin-right:10px;
	width: 80px;
	height: 40px;
	background:white;
	border-radius: 8px;
	cursor:pointer;
}
.loginbtn{
	width: 70px;
	height: 30px;
	background:white;
	border-radius: 8px;
	cursor:pointer;
}

/*로그인유지하기 + 아이디비밀번호찾기*/
#checkbox_findbox_wrapper {
	display: flex;
    margin-top: 25px;
    margin-left: 35px;
}

#enroll_div {
	line-height: 65px;
    width: 289px;
    height: 61px;
    border-radius: 4px;
    background-color: orange;
    margin-left: 35px;
    font-size: 17px;
}
.login{
	float:right;
}
.loginEnd{
	clear:both;
}
		
		/*여기서부터 새로쓰는  위에도 복붙해야함*/
		
		/* 로그인버튼 */
		#login_submit{
	    width: 289px;
	    height: 61px;
	    margin-top: 7px;
	    /* border: 1px solid #e6e6e6; */
	    border-radius: 4px;
	    background-color: orange;
	    font-size: 17px;
   		}
   		
   		#checkbox_wrapper, #find_span{
   		font-size: 8px;
   		}
   		/*아이디 비밀번호 찾기 오른쪽으로  */
   		#find_span{
   		font-size: 8px;
   		padding-left: 67px;
   		
   		}
</style>
	</header>

	<section>