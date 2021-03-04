<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
	//비정상적인 접근 확인
	if ('${wrongAccess}' == 'wrongAccess'){
		alert("비정상적인 접근으로 세션이 종료됩니다");
	}
	// 관리자 페이지 권한 없음
	else if ('${unauthorized}' == 'unauthorized'){
		alert("관리자 권한이 없습니다. 이전 페이지로 이동합니다.");
		history.go(-1);
	}
	
	// 글 작성할 때 로그인이 되어있지 않으면
	if ('${notlogin}' == 'notlogin') {
		alert("로그인을 하셔야 글 작성이 가능합니다. 로그인 창으로 이동합니다.");
		location.href = "memberLoginForm.do"
	}
	
	// 관리자페이지에서 넘어올 때
	if ('${boardtype}' == 'manage') {
		// Insert 확인
		if ('${insertManageResult}' == '1'){
			alert("${insertManageResult}건 입력되었습니다");
		} else if ('${insertManageResult}' == '0') {
			alert("입력에 실패했습니다");
		// Update 확인
		} else if ('${updateManageResult}' == '1') {
			alert("${updateManageResult}건 수정되었습니다");
		} else if ('${updateManageResult}' == '0') {
			alert("수정에 실패했습니다");
		// Delete 확인
		} else if ('${deleteManageResult}' == '1') {
			alert("${deleteManageResult}건 삭제되었습니다");
		} else if ('${deleteManageResult}' == '0') {
			alert("삭제에 실패했습니다");
		}
		
		location.href = "communityManagement.do";
	}
	
	// 일반페이지에서 넘어올 때
	if ('${boardtype}' == 'common') {
		// Insert 확인
		if ('${insertResult}' == '1') {
			alert("${insertResult}건 입력되었습니다");
		} else if('${insertResult}' == '0'){
			alert("입력에 실패했습니다");
		}
		// Update 확인
		else if ('${updateResult}' == '1') {
			alert("${updateResult}건 수정되었습니다");
		} else if('${updateResult}' == '0') {
			alert("수정에 실패했습니다");
		}
		// Delete 확인
		else if ('${deleteResult}' == '1') {
			alert("${deleteResult}건 삭제되었습니다");
		} else if ('${deleteResult}' == '0') {
			alert("삭제에 실패했습니다");
		} 
		
		location.href = "communityList.do";
	}
	
</script>

</body>
</html>