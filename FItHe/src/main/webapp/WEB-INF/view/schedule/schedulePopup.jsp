<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fithe.schedule.vo.ScheduleVO" %>
<%
	Object obj = request.getAttribute("list");
	List<ScheduleVO> lists = (List)obj;
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>일정 추가</title>
		<!-- datepicker -->
		<link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script>
			$(function(){
				$.datepicker.setDefaults({
					dateFormat: 'yy-mm-dd', //fullcalendar의 형식에 맞게 날짜형식 설정
					monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			        showMonthAfterYear: true,
			        yearSuffix: '년'
						
				});
				$("#startDate").datepicker();
			});
			
			function click_ok(){
					
				$.ajax({
					url : "scheduleinsert.do",
					type : "POST",
					data : {
						sdate :$("#startDate").val(),
						smemo1 : $("#memo1").val(),
						smemo2 : $("#memo2").val(),
						smemo3 : $("#memo3").val(),
						smemo4 : $("#memo4").val(),
						smemo5 : $("#memo5").val(),
					},
					success : function(data){
						if(data == "G"){
							alert("일정 추가");
							opener.parent.location.reload(); //일정추가시 새로고침하여 바로추가되는것이 보이도록
							window.close();
						}else{
							alert("다시입력해주세요");
						}
					},
					error : function(error){
						alert("error : " + error);
					}
				});
			}
		</script>
	</head>
	<body>
			
	<div>
		<form id="scheduleData">
			<h1>일정 추가</h1>
			<tr>
				<td><h3>선택하신 날짜</h3></td>
				<td><input type="text" class="date" id="startDate" name="startDate" /></td>
			</tr>
			<tr>
				<h3>메모</h3>
				<td><input type="text" id="memo1" name="memo1" placeholder="입력"/></td>
				<td><input type="text" id="memo2" name="memo2" placeholder="입력"/></td>
				<td><input type="text" id="memo3" name="memo3" placeholder="입력"/></td>
				<td><input type="text" id="memo4" name="memo4" placeholder="입력"/></td>
				<td><input type="text" id="memo5" name="memo5" placeholder="입력"/></td>
			</tr>
			<tr>
				<td><button type="button" onclick="click_ok()">확인</button></td>
			</tr>	
		</form>
	</div>
	</body>
</html>