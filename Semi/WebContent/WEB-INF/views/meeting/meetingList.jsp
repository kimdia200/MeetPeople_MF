<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="meeting.model.vo.Meeting"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<Meeting> list = (List<Meeting>)request.getAttribute("list");
	String location = (String)request.getAttribute("location");
	String category = (String)request.getAttribute("category");
	String search = (String)request.getAttribute("search");
	
	String cName;
	String lName;
	
	if(category.equals("C1")){
		cName="음악";
	}else if(category.equals("C2")){
		cName="게임";
	}else if(category.equals("C3")){
		cName="운동";
	}else if(category.equals("C4")){
		cName="요리";
	}else if(category.equals("C5")){
		cName="독서";
	}else if(category.equals("C6")){
		cName="재테크";
	}else if(category.equals("C7")){
		cName="자동차";
	}else{
		cName="전체";
	}
	
	if(location.equals("L1")){
		lName="서울";
	}else if(location.equals("L2")){
		lName="경기";
	}else if(location.equals("L3")){
		lName="인천";
	}else if(location.equals("L4")){
		lName="대전·충청";
	}else if(location.equals("L5")){
		lName="대구·경북";
	}else if(location.equals("L6")){
		lName="부산·경남";
	}else if(location.equals("L7")){
		lName="울산";
	}else if(location.equals("L8")){
		lName="광주";
	}else{
		lName="전국";
	}
%>

<div id="listWrapper">
	<div id="leftWrapper">
		<h4><%= cName+" > "+lName%></h4>
		<%
			if(search.length()!=0){
		%>
			<h4>제목 검색 : <%=search %></h4>
			<button type="button" onclick="location.href='<%=request.getContextPath()%>/meeting/meetingList?category=<%=category%>&location=<%=location%>'">초기화</button>	
		<%}%>
		<hr />
		<div>
			<h4>지역</h4>
		</div>
		<ol>
			<li><a href="<%=request.getContextPath()%>/meeting/meetingList?category=<%=category%>&search=<%=search%>">전국</a></li>
			<li><a href="<%=request.getContextPath()%>/meeting/meetingList?category=<%=category%>&location=L1&search=<%=search%>">서울</a></li>
			<li><a href="<%=request.getContextPath()%>/meeting/meetingList?category=<%=category%>&location=L2&search=<%=search%>">경기</a></li>
			<li><a href="<%=request.getContextPath()%>/meeting/meetingList?category=<%=category%>&location=L3&search=<%=search%>">인천</a></li>
			<li><a href="<%=request.getContextPath()%>/meeting/meetingList?category=<%=category%>&location=L4&search=<%=search%>">대전·충청</a></li>
			<li><a href="<%=request.getContextPath()%>/meeting/meetingList?category=<%=category%>&location=L5&search=<%=search%>">대구·경북</a></li>
			<li><a href="<%=request.getContextPath()%>/meeting/meetingList?category=<%=category%>&location=L6&search=<%=search%>">부산·경남</a></li>
			<li><a href="<%=request.getContextPath()%>/meeting/meetingList?category=<%=category%>&location=L7&search=<%=search%>">울산</a></li>
			<li><a href="<%=request.getContextPath()%>/meeting/meetingList?category=<%=category%>&location=L8&search=<%=search%>">광주</a></li>
		</ol>
	</div>
	
	<div id="rightWrapper">
		<h3>미플 모임</h3>
		<div id="search">
			<input type="text" name="" id="searchKeyword" placeholder="검색할 키워드를 입력하세요!"/>
			<button type="button" id="searchBtn">검색</button>
		</div>
		<%if(list.isEmpty()==false && list!=null){ %>
		<div class="boxWrapper">
		<%int i=0; int loop=list.size() >=3 ? 3 : list.size(); %>
		<%for(;i<loop;i++) { %>
		<% 
			Calendar now = Calendar.getInstance();
			now = new GregorianCalendar(now.get(Calendar.YEAR),now.get(Calendar.MONTH), now.get(Calendar.DATE));
			
			Calendar mDay = Calendar.getInstance();
			mDay.setTimeInMillis(list.get(i).getTime().getTime());
			mDay = new GregorianCalendar(mDay.get(Calendar.YEAR),mDay.get(Calendar.MONTH), mDay.get(Calendar.DATE));
			
			long mil2 = mDay.getTimeInMillis();
			long mil1 = now.getTimeInMillis();
			int diff = (int)((double)(mil2-mil1)/(1000*60*60*24));
			String dDay;
			if(diff>0){
				dDay="D-"+Integer.toString(diff);
			}else if(diff==0){
				dDay="D-Day!";
			}else{
				dDay="종료";
			}
		%>
			<div class="boxContents">
				<a href="<%=request.getContextPath()+"/meeting/meetingView?no="+list.get(i).getMeetingNo()%>">
					<img src="<%=request.getContextPath() %>/upload/<%=list.get(i).getAttach().getRenamedFilename() %>" width=220px height=150px/>
					<span><%=list.get(i).getTitle() %></span>
					<span id="dDay"><%=dDay %></span>
				</a>
			</div>
		<%} %>
		</div>
		<div class="boxWrapper">
		<%loop=list.size() >=6 ? 6 : list.size(); %>
		<%for(;i<loop;i++) { %>
		<% 
			Calendar now = Calendar.getInstance();
			now = new GregorianCalendar(now.get(Calendar.YEAR),now.get(Calendar.MONTH), now.get(Calendar.DATE));
			
			Calendar mDay = Calendar.getInstance();
			mDay.setTimeInMillis(list.get(i).getTime().getTime());
			mDay = new GregorianCalendar(mDay.get(Calendar.YEAR),mDay.get(Calendar.MONTH), mDay.get(Calendar.DATE));
			
			long mil2 = mDay.getTimeInMillis();
			long mil1 = now.getTimeInMillis();
			int diff = (int)((double)(mil2-mil1)/(1000*60*60*24));
			String dDay;
			if(diff>0){
				dDay="D-"+Integer.toString(diff);
			}else if(diff==0){
				dDay="D-Day!";
			}else{
				dDay="종료";
			}
		%>
			<div class="boxContents">
				<a href="<%=request.getContextPath()+"/meeting/meetingView?no="+list.get(i).getMeetingNo()%>">
					<img src="<%=request.getContextPath() %>/upload/<%=list.get(i).getAttach().getRenamedFilename() %>" width=220px height=150px/>
					<span><%=list.get(i).getTitle() %></span>
					<span id="dDay"><%=dDay %></span>
				</a>
			</div>
		<%} %>
		</div>
		<div class="boxWrapper">
		<%loop=list.size() >=9 ? 9 : list.size(); %>
		<%for(;i<loop;i++) { %>
		<% 
			Calendar now = Calendar.getInstance();
			now = new GregorianCalendar(now.get(Calendar.YEAR),now.get(Calendar.MONTH), now.get(Calendar.DATE));
			
			Calendar mDay = Calendar.getInstance();
			mDay.setTimeInMillis(list.get(i).getTime().getTime());
			mDay = new GregorianCalendar(mDay.get(Calendar.YEAR),mDay.get(Calendar.MONTH), mDay.get(Calendar.DATE));

			long mil2 = mDay.getTimeInMillis();
			long mil1 = now.getTimeInMillis();
			int diff = (int)((double)(mil2-mil1)/(1000*60*60*24));
			String dDay;
			if(diff>0){
				dDay="D-"+Integer.toString(diff);
			}else if(diff==0){
				dDay="D-Day!";
			}else{
				dDay="종료";
			}
			
		%>
			<div class="boxContents">
				<a href="<%=request.getContextPath()+"/meeting/meetingView?no="+list.get(i).getMeetingNo()%>">
					<img src="<%=request.getContextPath() %>/upload/<%=list.get(i).getAttach().getRenamedFilename() %>" width=220px height=150px/>
					<span><%=list.get(i).getTitle() %></span>
					<span id="dDay"><%=dDay %></span>
				</a>
			</div>
		<%} %>
		</div>
		<%}else{ %>
			<h1 style="line-height: 500px;">조회결과가 없습니다</h1>
		<% } %>
		<div id='pageBar'>
			<%= request.getAttribute("pageBar") != null ? request.getAttribute("pageBar") : ""%>
		</div>
	</div>
</div>
<style>
		.boxWrapper{
			width:900px;
			height:194px;
			display: flex;
			transition-duration: 1s;
			transition-timing-function: ease;
			margin:0 auto;
		}
		.boxContents{
			position:relative;
			width:220px;
			height:150px;
			margin:40px;
			padding:0;
			border:2px solid black;
			border-radius: 5px;
			background:black;
		}
		.boxContents:hover{
			animation-name: ani;
			animation-duration: 0.5s;
			animation-iteration-count: infinite;
			animation-timing-function: ease;
		}
		.boxContents:hover span{
			color:black;
			text-shadow: -2px 0 white, 0 2px white, 2px 0 white, 0 -2px white;
		}
		@keyframes ani{
			0%{
				transform: scale(1, 1);
			}
			50%{
				transform: scale(1.1, 1.1);
			}
			100%{
				transform: scale(1, 1);
			}
		}
		.boxContents span{
			position:absolute;
			bottom:8px;
			right:8px;
			color:white;
			font-weight: bold;
			text-shadow: -2px 0 black, 0 2px black, 2px 0 black, 0 -2px black;
		}
		#dDay{
			top:8px;
			right:8px;
			color:red;
		}
		.boxContents img{
			border-radius: 10px;
		}
		section{
			overflow: hidden;
		}
		#search{
			position: absolute;
			right:10px;
			top:21px;
		}
</style>

<script>
	$("#searchBtn").click(function(){
		var keyword = $("#searchKeyword").val();
		
		location.href="<%=request.getContextPath()%>/meeting/meetingList?category=<%=category%>&location=<%=location%>&search="+keyword;
	});
	$(document).ready(function(){
		<% if(search.length()!=0) {%>
			$("#searchKeyword").val("<%=search%>")
		<% } %>
	});
</script>
<style>
#listWrapper{
	width:1200px;
	display:flex;
}
#leftWrapper{
	width:200px;
	height:800px;
	margin-left:50px;
	border:1px solid red;
}
#rightWrapper{
	clear:both;
	width:900px;
	min-height: 800px;
	border:1px solid red;
	position: relative;
}
#leftWrapper ol{
	list-style: none;
	margin:0;
	padding-left:30px;
	text-align:left;
}
#leftWrapper ol li{
	margin-bottom:20px;	
}

#pageBar{
	height:50px;
	margin-top:30px;
}

#pageBar span{
    border-radius: 15%;
    padding: 9px 15px;
    background-color: skyblue;
    text-decoration: none;
    color: white;
}
#pageBar a{
	border-radius: 15%;
    padding: 9px 15px;
    background-color: white;
    text-decoration: none;
    color: black;
}

#pageBar a:hover{
    background-color: skyblue;
    color: white;
    transition: all ease 0.5s;
}

#pageBar a:active{
    background-color: skyblue;
    color: gray;
}
#search{
	disdplay:flex;
}
</style>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>