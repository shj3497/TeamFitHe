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
		<!-- stylesheet -->
		<style>			
			/*layout*/
			form{width:100%; margin: auto; padding-top:10px; text-align: center; color: #333;}		
			/*calendar date section*/
			form div:first-of-type span{color: gray;}
			.date{height: 25px; text-align: center; margin-bottom: 10px; border: 1px solid gray; border-radius: 30px;}
			/*basic exercise-value input-section*/			
			.memo_section{width:90%; margin: 50px auto;}
			ul,li{list-style: none; padding:0; margin:0;}			
			li{height: 30px; margin-bottom: 5px;}
			li span{width: 170px; height: 25px; display: inline-block; text-align: left;}
			li input{width: 100px; height: 25px; text-align: center;}
			button{width: 60%; height: 30px; margin: 40px auto; background-color: lightgray; border: 1px solid lightgray; border-radius: 4px; color: white;}
			button:hover{background-color: #03CFCF;}			
		</style>
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
						situp : $("#situp").val(),
						bend : $("#bend").val(),
						jump : $("#jump").val(),
						around : $("#around").val(),
						race : $("#race").val(),
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
		<iframe src="https://giphy.com/embed/d1GpZTVp2eV7gQk8" width="280" height="261" frameBorder="0" class="giphy-embed" allowFullScreen></iframe>
			<h1>일정 추가</h1>
			<div>
				<h3>선택하신 날짜</h3>
				<span>------------<input type="text" class="date" id="startDate" name="startDate" />------------</span>
			</div>
			<div class="memo_section">				
				<h3>나의 기록</h3>
				<ul>					
					<li>
						<span>10미터 왕복 달리기</span>
						<input type="text" id="around" name="around" placeholder="입력" value="${svo.around}"/>
					</li>
					<li>
						<span>오래 달리기</span>
						<input type="text" id="race" name="race" placeholder="입력" value="${svo.race}"/><br>
					</li>
					<li>
						<span>윗몸구부리기</span>
						<input type="text" id="bend" name="bend" placeholder="입력" value="${svo.bend}"/>
					</li>					
					<li>
						<span>윗몸일으키기</span>
						<input type="text" id="situp" name="situp" placeholder="입력" value="${svo.situp}"/>
					</td>					
					<li>
						<span>제자리  멀리뛰기</span>
						<input type="text" id="jump" name="jump" placeholder="입력" value="${svo.jump}"/>
					</li>
				</ul>
			</div>
			<tr>
				<td><button type="button" onclick="click_ok()">확인</button></td>
			</tr>	
		</form>
	</div>
	</body>
</html>