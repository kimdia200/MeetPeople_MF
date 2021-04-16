<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/meeting.css" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
      crossorigin="anonymous"
    />
	<div class="container-view">
      <div class="content-img">
        <img class="img-green" src="<%=request.getContextPath() %>/images/tower.jpg" alt="img" />
      </div>

      <div class="content-info">
        <div>
          <h2>제목</h2>
        </div>

        <ul class="list-group">
          <li class="list-group-item">- 작성일자</li>
          <li class="list-group-item">- 장소</li>
          <li class="list-group-item">- 시간</li>
          <li class="list-group-item">- 참가비용</li>
          <li class="list-group-item">- 현재인원</li>
          <li class="list-group-item">- 마감인원</li>
        </ul>

        <div class="text-center">
          <button type="button" class="btn btn-outline-success">신청</button>
          <button type="button" class="btn btn-outline-warning">수정</button>
          <button type="button" class="btn btn-outline-danger">취소</button>
        </div>
      </div>

      <div class="content-meddle">
        <div>
          <h3>내용</h3>
        </div>
      </div>

      <div class="content-comment">
        <button
          type="button"
          class="btn btn-primary btn-lg btn-block float-end"
        >
          등록
        </button>
        <div>
          <h3>댓글</h3>
        </div>
      </div>
    </div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>