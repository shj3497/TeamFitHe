<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#show',
			data:{
				msg:"FitHe/"+"${sessionScope.mid}",
				chkMsg:"",
			},
			watch:{
				chkMsg:function(chkMsg){
					var chkMsg = this.chkMsg;
					var msg = this.msg;
					if(msg == chkMsg){
						console.log("같음 진입")
					}
				}
			},
			methods:{
				goDelete:function(){
					console.log("탈퇴하기 버튼 선택")
					if(!chkSubmit($('#mpw'),"비밀번호를 ")){
						return ;
					}else{
						
						var goURL = "delMemberForm.do";
						var param = {
								mpw:$('#mpw').val()
						}
						var method = "POST";
						
						$.ajax({
							url:goURL,
							type:method,
							data:param,
							success:whenSuccess,
							error:whenError
						})
						
						function whenSuccess(resData){
							if(resData == "1"){
								alert("회원정보가 삭제되었습니다. FitHe를 이용해주셔서 감사합니다.");
								location.href="tempmain.do";
							}else if(resData == "2"){
								alert("비밀번호를 다시한번 확인해 주세요");
							}else if(resData == "0"){
								alert("관리자에게 문의하세요");
							}
								
						}
						
						function whenError(e){
							alert("에러가 발생하였습니다. 관리자에게 문의하세요" + e)
						}
					}
				}
			}
		})
	})
	
</script>
</head>
<body>
<form id="memWithdraw">
	<div id="show" v-cloak>
		<div>
		<p>확인메세지 <span>{{msg}}</span>를 입력하세요</p>
			<input type="text" id="chkMsg" v-model="chkMsg">
		</div>
		<div>
			<input type="password" id="mpw" name="mpw" placeholder="현재 비밀번호">
		</div>
		<div>
			<!-- 확인메세지를 입력해서 같으면 버튼이 활성화 비활성화된다. -->

			<span v-if="msg===chkMsg"><input type="button" id="memDelBtn" value="탈퇴하기" @click="goDelete"></span>
			<span v-else><input type="button" value="탈퇴하기" disabled></span>
			 <!-- <input type="button" id="memDelBtn" value="탈퇴하기"> -->
		</div>
	</div>
</form>
</body>
</html>