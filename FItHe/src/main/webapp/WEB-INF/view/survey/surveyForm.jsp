<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 신체 입력</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
	
		// 버튼 클릭 시 이벤트 
		$("#sInsert").click(function(){
			
			//null 체크			
		    if($.trim($("#sage").val())==''||$.trim($("#sheight").val())==''||$.trim($("#sweight").val())==''
		    	||$.trim($("#swaist").val())==''||$("#sgender").val()=='3'){
		    	alert("빈 칸이 존재합니다");
    				 return false;
  				 } 	
			$('#f_writeForm').attr({
				'action':'sInsert.do',
				'method':'POST',
			});
			$('#f_writeForm').submit();
			
	
			
	});
		
		$('.pressEvent').keypress(function(event){
			 
			  if (event.which && (event.which  > 47 && event.which  < 58 || event.which == 8 || event.which == 46)) {
					// 숫자
			  } else {
			    alert('숫자만 입력 가능합니다');
			    event.preventDefault();
			    }
		});
		

			


	});
</script>
</head>
<body>
	<div id="boardTit">
		<h3> 나의 신체 특징</h3>
	</div>
	<form id="f_writeForm" name="f_writeForm" >

		<div class="pressEvent">	
		
				<label>성별</label>
				<select id="sgender" name="sgender" class="check">
					<option value="3" selected></option>
			   		<option value="0" >여성</option>
					<option value="1" >남성</option>
				</select><br>

				<label>나이</label>
				<input type="text" name="sage" id="sage"  onkeyup="this.value=this.value.replace(/[^0-9\.]/g,'')"><br>
			
				
				<label>키</label>
				<input type="text" name="sheight" id="sheight" class="check"  onkeyup="this.value=this.value.replace(/[^0-9\.]/g,'')"><br>
			
			
				<label>몸무게</label>
				<input type="text" name="sweight" id="sweight" class="check"  onkeyup="this.value=this.value.replace(/[^0-9\.]/g,'')"><br>
			
				
				<label>허리둘레</label>
				<input type="text" name="swaist" id="swaist" class="check"  onkeyup="this.value=this.value.replace(/[^0-9\.]/g,'')"><br>
		</div>	

		<div id="boardBut">
			<input type="button" value="체력 측정하러 가기" class="but" id="sInsert"  onkeyup="this.value=this.value.replace(/[^0-9\.]/g,'')">
		</div>
	</form>
</body>
</html>