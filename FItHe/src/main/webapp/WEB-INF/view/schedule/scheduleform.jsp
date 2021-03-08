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
		<title>Insert title here</title>
		<style>
			.calendar_section{width: 85%; positoin: absolute; margin: auto; padding: 200px 0 30px;}
		</style>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<!-- fullcalendar cdn -->
		<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.js"></script>
		<script>	
		document.addEventListener('DOMContentLoaded', function() {
			    var calendarEl = document.getElementById('calendar');
			    
			    var calendar = new FullCalendar.Calendar(calendarEl, {
			    	headerToolbar : {  //상단탭위치에 놓일 것들
			    		left: '', 
			    		center: 'title', 
			    		right: 'today prevYear,prev,next,nextYear' },
			    	footerToolbar :{
			    		left: '',
			    		center: '',
			    		right: 'coustom1'
			    	},
			    	timeZone : 'local', //우리나라 시간기준
			    	locale : "ko", //한글화
			    	fixedWeekCount : false, // flase 일경우 4~5주만 보이도록, true이면 6주가보이게 됨
			    	navLinks: true,
			    	customButtons:{
			    		coustom1:{
			    			text : '입력',
			    			click: function(){
			    				var url = "schedulePopup.do";
			    				var name = "schedulePopup";
			    				var option = "width=600, height = 900, left=100, top=50, location=no ";
			    				window.open(url,name,option)
			    			}
			    		}
			    	},
			    	events: [
			    		   <%
			    		   	for(int i=0; i<lists.size(); i++){
			    		   		ScheduleVO svo = (ScheduleVO)lists.get(i);
			    		   %>
			    		   		{
			    		   			title : '윗몸일으키기 : ' + '<%=svo.getSitup() %>',
			    		   			start : '<%=svo.getSdate()%>'
			    		   		},
			    		   		
			    		   		{
			    		   			title : '윗몸구부리기 : ' + '<%=svo.getBend() %>',
			    		   			start : '<%=svo.getSdate()%>'
			    		   		},
			    		   		
			    		   		{
			    		   			title : '제자리 멀리뛰기 : ' + '<%=svo.getJump() %>',
			    		   			start : '<%=svo.getSdate()%>'
			    		   		},
			    		   		
			    		   		{
			    		   			title : '10미터 왕복 달리기 : ' + '<%=svo.getAround() %>',
			    		   			start : '<%=svo.getSdate()%>'
			    		   		},
			    		   		
			    		   		{
			    		   			title : '오래 달리기 : ' + '<%=svo.getRace() %>',
			    		   			start : '<%=svo.getSdate()%>'
			    		   		},

			    		   <%
			    		   	}
			    		   %>
			    	]
			    });
		    calendar.render();
	    });
		</script>
	</head>
	<body>
		<!--navigator-->
		<jsp:include page="../common/mainnav.jsp"></jsp:include>
		
		<div class="calendar_section">
			<div id='calendar'></div>
		</div>
		
		<!-- footer -->
		<jsp:include page="../common/mainfooter.jsp"></jsp:include>
	</body>
</html>