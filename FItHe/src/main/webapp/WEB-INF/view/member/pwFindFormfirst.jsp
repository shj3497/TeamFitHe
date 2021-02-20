<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PW 찾기</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$('#findPW_next').on('click',function(){
			
			if(!chkSubmit($('#mid'), "FitHe 아이디를")){
				return ;
			} else{
				$('#pwFindForm_1').attr('method','POST')
				$('#pwFindForm_1').attr('action','pwFindfirst.do')
				$('#pwFindForm_1').submit();
			}
		})
	})
	
</script>
</head>
<body>
<!-- pw를 찾는 과정에 있어 첫번쨰로 id를 입력받는다. -->
<!-- 해당하는 정보가 있으면 다음페이지로 이동하여 이름,이메일을 입력받아 인증번호를 확인한다. -->
<!-- 인증번호가 확인되면 새로운 비밀번호 설정에 들어간다. -->
<!-- 새로운 비밀번호가 입력되면 db에 있는 pw업데이트해주고, 로그인 페이지로 이동한다. -->
	<form id="pwFindForm_1">
		<div>
			<input type="text" id="mid" name="mid" placeholder="FitHe 아이디">		
		</div>
		<div>
			<input type="button" id="findPW_next" value="다음">
		</div>
	</form>
</body>
</html>