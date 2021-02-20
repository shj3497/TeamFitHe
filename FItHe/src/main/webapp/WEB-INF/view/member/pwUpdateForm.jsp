<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PW CHANGE</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#show',
			data:{
				mid:"${memberVO.mid}",
				pw:"",
				pw_r:"",
				msg:""
			},
			watch:{
				pw:function(pw){
					if(this.pw.length < 8){
						let msg = "8자리 이상 입력하세요";
						this.msg = msg;
					}else if(this.pw.length > 16){
						this.pw = pw.substring(0,16);
					}else {
						let msg = " ";
						this.msg = msg;
					}
				},
				pw_r:function(pw_r){
					
					if(this.pw == this.pw_r){
						var msg = " ";
						this.msg = msg;
					}else{
						var msg = "일치하지않습니다.";
						this.msg = msg;
					}
				}
			}
		}) // end of Vue()
		
		$('#pwUpdate').on('click',function(){

			if(!chkSubmit($('#mpw'),"새 비밀번호를 ")){
				return ;
			}else if(!chkSubmit($('#mpw_r'),"새 비밀번호 확인을")){
				return ;
			}else{
				let goURL="pwUpdate.do";
				let method = "POST";
				let params = {
						mid:$('#mid').val(),
						mpw:$('#mpw').val()
				}
				
				$.ajax({
					url:goURL,
					type:method,
					data:params,
					success:whenSuccess,
					error:whenError
				})
				
				function whenSuccess(resData){
					alert("패스워드가 변경 되었습니다.");
					
					if(resData == 1){
						location.href="memberLoginForm.do"
					}else if(resData == 0){
						alert("패스워드 변경에 실패하였습니다. 관리자에게 문의하세요");
					}
				}
				
				function whenError(e){
					alert("시스템 오류입니다. 관리자에게문의해주세요." + e);
				}
			}// end of else{}
		})	
		
	})

</script>
</head>
<body>
	<form id="pwUpdateForm">
		<div id="show" v-cloak>
			<input type="hidden" id="mid" name="mid" value="${memberVO.mid}">
			<div>
				<label>네이버 아이디 : {{mid}}</label>
			</div>
			<div>
				<input type="password" id="mpw" name="mpw" placeholder="새 비밀번호" v-model="pw"><br>
				<input type="password" id="mpw_r" placeholder="새 비밀번호 확인" v-model="pw_r">
				<h6><label>{{msg}}</label></h6>
			</div>
			<div>
				<input type="button" id="pwUpdate" value="확인">
			</div>
			<div>
				<ul>
					<li>영문, 숫자, 특수문자를 함께 사용하면(8자 이상 16자 이하)보다 안전합니다.</li>
					<li>다른 사이트와 다른 FitHe 아이디만의 비밀번호를 만들어 주세요.</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>