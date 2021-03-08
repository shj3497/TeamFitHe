<%@page import="java.util.List"%>
<%@page import="com.fithe.survey.vo.SurveyVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 입력 폼</title>

<script src="//code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		
		// 다음버튼 클릭시 처리 이벤트
		$("#sUpdate").click(function(){
			
			
			// null 체크
		    if($.trim($("#situp").val())==''||$.trim($("#bend").val())==''||$.trim($("#jump").val())==''
		    	||$.trim($("#race").val())==''||$("#around").val()==''){
		    	alert("빈 칸이 존재합니다");
    				 return false;
  				 } 	
		
			$('#f_writeForm').attr({
				'action':'surveyUpdate.do',
				'method':'POST',
			});
			$('#f_writeForm').submit();
		});
		

		
	});
			


</script>
</head>
<body>
<form id="f_writeForm">
	<div id="boardTit">
		<h3> 체력 측정 </h3>
	</div>


	<!-- 넘어가야 하는 값 -->
	<input type="hidden" name="snum" id="snum" value="${su.snum}">


	<label>윗몸일으키기</label>
	<input type="text" name="situp" id="situp" class="health"/>
	<br>
	
	<label>윗몸 앞으로 굽히기</label>
	<input type="text" name="bend" id="bend" class="health"/>
	<br>
	
	<label>제자리 멀리뛰기</label>
	<input type="text" name="jump" id="jump" class="health"/>
	<br>
	
	<label>오래 달리기</label>
	<input type="text" name="race" id="race" class="health"/>
	<br>
	
	<label>왕복 달리기</label>
	<input type="text" name="around" id="around" class="health"/>
	<br>



	<div id="boardBut">
		<input type="button" value="다음" class="but" id="sUpdate">
	</div>

<hr>
</form>
</body>
</html>