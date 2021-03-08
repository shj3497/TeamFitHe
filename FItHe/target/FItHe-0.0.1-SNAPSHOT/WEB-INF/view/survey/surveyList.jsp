<%@page import="java.util.List"%>
<%@page import="com.fithe.survey.vo.SurveyVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="//code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function(){
	
	// 삽입
	$(document).on("click", "#insert", function(){
		location.href="surveyForm.do";
	});

	
});
</script>
</head>
<body>
<% request.setCharacterEncoding("UTF-8");%> 
<%
	Object obj = request.getAttribute("listAll");
	List<SurveyVO> list = (List)obj;
	
	int nCnt = list.size();
	System.out.println("nCnt >>> : " + nCnt);	
%>
<a href="index.jsp">index페이지로 이동</a>

<h2>게시판</h2>
<form name="boardList" id="boardList">
<table border="1" align="center">
<thead>
<tr>

</tr>
<tr>
	<td class="tt">번호</td>
	<td class="tt">아이디</td>
	<td class="tt">성별</td>		
	<td class="tt">나이</td>
	<td class="tt">키</td>
	<td class="tt">몸무게</td>
	<td class="tt">허리둘레</td>
	<td class="tt">윗몸 일으키기</td>
	<td class="tt">제자리 멀리뛰기</td>
	<td class="tt">윗몸 앞으로 굽히기</td>
	<td class="tt">왕복 달리기</td>
	<td class="tt">오래 달리기</td>
	<td class="tt">입력 날짜</td>
</tr>
</thead>
<%
for(int i=0; i<nCnt; i++){		
	SurveyVO svo = list.get(i);	
	
%>					
<tbody>
<tr>	
	<td class="tt"><a href="surveySelect.do?snum=<%= svo.getSnum() %>"><%= svo.getSnum() %></a></td>
	<td class="tt"><%= svo.getMid() %> </td>
	<td class="tt"><% if(svo.getSgender().equals("0")){%>여성<% }else{%>남성<% }  %> </td>
	<td class="tt"><%= svo.getSage() %> </td>
	<td class="tt"><%= svo.getSheight() %> </td>
	<td class="tt"><%= svo.getSweight() %> </td>
	<td class="tt"><%= svo.getSwaist() %> </td>
	<td class="tt"><%= svo.getSitup() %> </td>
	<td class="tt"><%= svo.getBend() %> </td>
	<td class="tt"><%= svo.getJump() %> </td>
	<td class="tt"><%= svo.getAround() %> </td>
	<td class="tt"><%= svo.getRace() %> </td>
	<td class="tt"><%= svo.getSinsertdate() %> </td>
</tr>	
	
<%
}//end of for
%>						
<tr>
	<td colspan="13" align="right">						
	</td>
	<td>
	<input type="button" value="추가" id='insert'>
	</td>
</tr>

</tbody>			
</table>
</form>			
</body>
</html>