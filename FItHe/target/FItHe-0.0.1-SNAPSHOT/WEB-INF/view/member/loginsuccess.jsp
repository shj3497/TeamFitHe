<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#show',
			data:{
				msg:"${memberVO.mid}",
				msg1:"${sessionScope.mid}"
			}
		})
		
	})
	
</script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		$('#updateForm').on('click',function(){
			$('#loginSuccess').attr('method','POST');
			$('#loginSuccess').attr('action','updateForm.do');
			$('#loginSuccess').submit();
		});
	})

</script>
<title>Insert title here</title>
</head>
<body>
	<h1>로그인 성공!!</h1>
	<h3>${memberVO.mid}</h3>
	<h2>${sessionScope.mid }</h2>
	<h2>${sessionScope.mnum }</h2>
	<h2>${memberVO.mname}</h2>
	<h2>${memberVO.mzonecode}</h2>
	sessionScope는 세션에 설정해주었던 Attribute값으로 호출하는 것 입니다.<br>
	또는<br>
	Model로 전달해준 memberVO로도 호출이 가능합니다.<br>
	<form id="loginSuccess">
		<input type="button" id="updateForm" value="내정보보기">
	</form>
	<div id="show" v-cloak>
		<h1>{{msg}}</h1>
		<h1>세션호출 : {{msg1}}</h1>
	</div>
</body>
</html>