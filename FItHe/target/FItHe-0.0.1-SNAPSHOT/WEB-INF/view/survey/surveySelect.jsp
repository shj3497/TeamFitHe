<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	// 클릭이벤트
	$("#sDelete").click(function(){
		$('#selectForm').attr({
			'action':'surveyDelete.do',
			'method':'POST'
		});
		$('#selectForm').submit();
	});
	
	$("#sList").click(function(){
		$('#selectForm').attr({
			'action':'surveyList.do',
			'method':'POST'
		});
		$('#selectForm').submit();
	});
	
});


// 다음버튼 클릭시 처리 이벤트

</script>
</head>
<body>
결과지페이지
${listS.snum} 

<form name="selectForm" id="selectForm">

	<input type="hidden" name="snum" id="snum" value="${listS.snum}">
	
<input type="button" value="결과 삭제" id="sDelete" >
<input type="button" value="목록 보기" id="sList" >
</form>
</body>
</html>