<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID FIND</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var vue = new Vue({
			el:'#show',
			data:{
				id:"${memberVO.mid}",
				minsertdate:"${memberVO.minsertdate}"
			}
		})
		
		$('#loginGo').on('click',function(){
			
			console.log("로그인 버튼 선택");
			location.href="memberLoginForm.do"

		});
		
		$('#findPW').on('click',function(){
			
			console.log("패스워드 찾기 버튼 선택");
			location.href="memberPwFindForm.do"
		})
	})

</script>
</head>
<body>
	<form>
		<div id="show" v-cloak>
			<div>
				<ul>
					<li>{{id}}&nbsp;&nbsp;&nbsp;가입 : {{minsertdate}}</li>
				</ul>
			</div>
		</div>
		<div>
			<input type="button" id="loginGo" value="로그인">
			<input type="button" id="findPW" value="패스워드 찾기">
		</div>
	</form>
</body>
</html>