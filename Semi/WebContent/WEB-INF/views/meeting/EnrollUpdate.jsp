<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/meetingEnrollUpdate.css" />
 
<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<div class="container-enrollUpdate">
      <div class="content-img">
        <img class="img-green" src="<%=request.getContextPath() %>/images/green.jpg" alt="img" />
        
        <div>
          <button type="button">대표이미지 등록</button>
          <button type="button">대표이미지 등록 취소</button>
          <button type="button">등록</button>
        </div>
      </div>

      <div class="content-info">
        <div>
          <h2>제목</h2>
        </div>

        <ul>
          <li class="center-li">작성일자</li>
          <li class="center-li">장소</li>
          <li class="center-li">시간</li>
          <li class="center-li">참가비용</li>
          <li class="center-li">현재인원</li>
          <li class="center-li">마감인원</li>
        </ul>

        <div class="center-applyCancel">
          <button type="button">신청</button>
          <button type="button">수정</button>
          <button type="button">취소</button>
        </div>
      </div>

      <div class="content-meddle">
        <div>
          <h3>내용</h3>
        </div>
      </div>
    </div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>