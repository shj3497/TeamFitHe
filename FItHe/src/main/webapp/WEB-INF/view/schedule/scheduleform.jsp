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
			    				var option = "width=600, height = 600, left=100, top=50, location=no ";
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
			    		   			title : '근지구력 : ' + '<%=svo.getSmemo1() %>',
			    		   			start : '<%=svo.getSdate()%>'
			    		   		},
			    		   		
			    		   		{
			    		   			title : '유연성 : ' + '<%=svo.getSmemo2() %>',
			    		   			start : '<%=svo.getSdate()%>'
			    		   		},
			    		   		
			    		   		{
			    		   			title : '순발력 : ' + '<%=svo.getSmemo3() %>',
			    		   			start : '<%=svo.getSdate()%>'
			    		   		},
			    		   		
			    		   		{
			    		   			title : '민첩성 : ' + '<%=svo.getSmemo4() %>',
			    		   			start : '<%=svo.getSdate()%>'
			    		   		},
			    		   		
			    		   		{
			    		   			title : '심폐지구력 : ' + '<%=svo.getSmemo5() %>',
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
		<div id='calendar'></div>
	</body>
</html>