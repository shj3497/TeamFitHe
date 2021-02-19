<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>패스워드 변경</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#show',
			data:{
				pw:"",
				pw_r:"",
				msg:""
			},
			watch:{
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
		});// end of Vue
		
		// 확인 버튼 선택시
		$('#pwChange').on('click',function(){
			
			if(!chkSubmit($('#mpw_c'), "현재 비밀번호 입력을 ")){
				return ;
			} else if(!chkSubmit($('#mpw'), "새 비밀번호 입력을 ")){
				return ;
			} else if(!chkSubmit($('#mpw_r'), "새 비밀번호 확인 입력을 ")){
				return ;
			} else{
				
				var method = "POST";
				var goURL = "changePw.do";
				var param = {
						mpw_c:$('#mpw_c').val(),
						mpw:$('#mpw').val(),
						mpw_r:$('#mpw_r').val()
				};
				
				$.ajax({
					url:goURL,
					type:method,
					data:param,
					success:whenSuccess,
					error:whenError
				});
				
				function whenSuccess(resData){
					
					if(resData == "1"){
						alert("비밀번호가 변경되었습니다.")
						
						location.href="mySecpage.do";
					} else if(resData == "0"){
						
						alert("비밀번호 변경에 실패하였습니다.")
						
						console.log("업데이트 실패")
						$('#mpw_c').val('');
						$('#mpw').val('');
						$('#mpw_r').val('');
						$('#mpw_c').focus();
						
					} else if(resData == "2"){
						alert("비밀번호 변경에 실패하였습니다.")
						
						console.log("현재비밀번호 불일치")
						
						$('#mpw_c').val('');
						$('#mpw').val('');
						$('#mpw_r').val('');
						$('#mpw_c').focus();
					}
				}
				
				function whenError(e){
					alert("관리자에게 문의하세요");
					location.href="mySecpage.do";
				}
			}
		})// end of 확인버튼
		
	})




</script>
</head>
<body>
	<form id="changePwForm">
		<div id="show" v-cloak>
			<div>
				<h3><label>비밀번호변경</label></h3>
				<p>안전한 비밀번호로 내정보를 보호하세요</p>
				<p>다른 아이디/사이트에서 사용한 적 없는 비밀번호</p>
				<p>이전에 사용한 적 없는 비밀번호</p>
			</div>
			<div>
				<input type="password" id="mpw_c" name="mpw_c" placeholder="현재 비밀번호">
			</div>
			<div>
				<input type="password" id="mpw" name="mpw" placeholder="새 비밀번호" v-model="pw"><br>
				<input type="password" id="mpw_r" name="mpw_r" placeholder="새 비밀번호 확인" v-model="pw_r">
				<h6>{{msg}}</h6><!-- 글자크기 조정하면 될듯 -->
			</div>
			<div>
				<input type="button" id="pwChange" value="확인">
				<input type="reset" value="취소">
			</div>
		</div>
	</form>
</body>
</html>