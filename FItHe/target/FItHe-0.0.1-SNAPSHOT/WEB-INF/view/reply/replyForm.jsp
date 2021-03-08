<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.fithe.reply.vo.ReplyVO" %>

<%
	String cnum = request.getParameter("cnum");
	String mid = request.getParameter("mid");
%>
<!-- rnum (댓글번호), cnum (자유게시판 번호), mid (아이디), rcontent (내용), rupdatedate (등록일), rdelyn (삭제) -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>REPLY BOARD</title>
    <script  src="//code.jquery.com/jquery-latest.min.js"></script>

    <script type="text/javascript" defer>
    	$(document).ready(function(){
 	
    		var bnum = "<%= cnum %>";

    		// select all
    		replyList(bnum);
    		
    		// insert
    		$(document).on("click", "#insert", function(){
    			
    			let insertURL = "replyInsert.do";
    			let method = "POST";
    			/*
    			let dataParam = {
    				//cnum: $("#cnum").val(${communityDetail.cnum}),	
    				//cnum : '${communityDetail.cnum}',
    				cnum : ${communityDetail.cnum},
    				//mid:'${communityDetail.mid}',
    				//mid: $("#mid").val(),			//아이디
    				rcontent: $("#rcontent").val(),
    			};
    			*/
    			// form 객체 받기
    			dataParam = $("#rboardForm").serialize();
    			//alert("dataParam >>> : " + dataParam);
    			
    			// parameter--object로 받기
    			$.ajax({
    				url: insertURL,			//data 받아올 page
    				type: "POST",			//http method
    				data: {
    					"cnum" : $("#cnum").val(),
    					"rcontent" : $("#rcontent").val()
    				},		//보내는 parameter
    				success: whenSuccess,	//성공시 수행할 핸들러
    				error: whenError		//실패시 수행할 핸들러
    			});
    			function whenSuccess(resData){
    				alert("댓글이 등록되었습니다.");
    				console.log("resData >>> : " + resData);
					window.location.reload();
    				rboardFormData();
    				replyList(bnum);
    			}
    			function whenError(e){
    				//console.log("e >>> : " + e.responseText);
    				alert("e >>> : " + e.responseText);
    			}
    		});
    		
    		// 길이 제한 : 키 입력 후 이벤트 발생
    		$("#rcontent").keyup(function(){
    			cut_90(this);
    		});
    		
    		// 단건 조회
			$(document).on("click", "#S", function(){
				alert("S >>> : ");
				
				let insertURL = "replySelect.do";
				let method = "POST";
				let dataParam = {
					rnum: $("#rnum").val(),	
				};
				//dataParam = $("#jsonTestForm").serialize();
				//alert("dataParam >>> : " + dataParam);
				
				$.ajax({
					url: insertURL,
					type: method,
					data: dataParam,
					success: whenSuccess,
					error: whenError
				});
				
				function whenSuccess(resData){	
					
					alert("resData >>> : " + resData);				
					let v = resData.split(",");
					
					for(let i=0; i < v.length; i++){
						console.log("v[0] : " + v[0] 
								 + " v[1] : " + v[1] 
								 + " v[2] : " + v[2] 
								 + " v[3] : " + v[3]);					
						addNewItem(v[0], v[1], v[2], v[3]);
					}
				}
				
				function whenError(e){
					alert("e >>> : " + e.responseText);
				}
			});
    		
    		// 댓글 삭제		
			$(document).on("click", ".deleteBtn", function(){
				//alert("D >>> : ");
				
				var num = $(this).parents("li").attr("dataNum");
				alert("num >>> : " + num);
				var target = $(this).parents(".rbmemoItem");
				console.log("target >>> : " + target);
				
				let selectURL = "replyDelete.do";
				let method = "POST";
				let dataParam = {
					 "rnum" : num,
				};
				 dataParam = $("#rboardForm").serialize();
				alert("dataParam >>> : " + dataParam);
				if(confirm("정말 삭제하시겠습니까?")==true){
					
					$.ajax({
						url: selectURL,
						type: method,
						data: {
							 "rnum" : num,
						},
						success: whenSuccess,
						error: whenError
					});
				
					function whenSuccess(resData) {	
						
						if ("GOOD" == resData){
							alert("삭제되었습니다");	
							target.remove();
						}
					}
					function whenError(e) {
						alert("e >>> : " + e.responseText);
					}
				}
			});
    		
    	});//--$(document).ready(function(){
    		
    	// 전체 조회
		// 게시글 번호로 댓글 전체조회
		function replyList(bnum){
			// alert("SALL >>> : ");
			//alert("갔냐?");
			//alert("bnum >>> : " + bnum);
			//alert("$('#cnum').val() >>> : " + $("#cnum").val());
			
			$("#rboardlist").html(""); 
			
			let selectAllURL = "replyList.do";
			let method = "POST";
			let dataParam = { "cnum" : $("#cnum").val() };		
			 //dataParam = $("#jsonTestForm").serialize();
			//alert("dataParam >>> : " + dataParam);
			
			$.ajax({
				url: selectAllURL,
				type: "POST",
				data: {
					"cnum" : $("#cnum").val(),
					},
				// contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				success: whenSuccess,
				error: whenError
			});
			
			function whenSuccess(resData){	
				//alert("resData >>> : " + resData);
							
				if (isEmpty(resData)) {
					//alert("댓글이 없음 !! "); 
					return false;			
				}
				
				let v = resData.split("&");
				for(let i=0; i < v.length; i++){
					console.log(v[i]);
					let vv = v[i].split(",");
					let j=0
					for (; j < vv.length-1; j++){
						console.log("vv[0] >>> : " + vv[0]);
						console.log("vv[1] >>> : " + vv[1]);
						console.log("vv[2] >>> : " + vv[2]);
						console.log("vv[3] >>> : " + vv[3]);					
					}
					addNewItem(vv[1], vv[2], vv[3], vv[4]);
				}
			}
			function whenError(e){
				alert("e >>> : " + e.responseText);
			}	
			
		}
    	
		//새로운 글 화면에 추가	
		function addNewItem(num, writer, content, datetime){
			
			if (isEmpty(num)) return false;		
			
			// 새로운 글이 추가될 li태그 
			var newLi = $("<li>");
			newLi.attr("dataNum", num);
			newLi.addClass("rbmemoItem");
			// 작성자 정보가 지정될 <p> 태그 
			var writerP = $("<p>");
			writerP.addClass("writer");
			// 작성자 정보의 이름 
			var nameSpan = $("<span>");
			nameSpan.addClass("name");
			nameSpan.html(decodeURIComponent(writer) + "님");
			// 작성일시 
			var dateSpan = $("<span>");
			dateSpan.html(" / " + datetime + " ");
			
			// 삭제 버튼(본인 댓글만 삭제 가능) 
			if (writer == "${sessionScope.mid}") {
			var delInput = $("<input>");
			delInput.attr({"type":"button", "value":"삭제하기"});
			delInput.addClass("deleteBtn");
			}
			
			// 내용
			var contentP = $("<p>");
			contentP.html(decodeURIComponent(content));
			
			// 조립하기
			writerP.append(nameSpan).append(dateSpan).append(delInput);
			newLi.append(writerP).append(contentP);
			$("#rboardlist").append(newLi);
		}
		
		function cut_90(obj){
		    var t = $(obj).val();
		    var l = t.length;
		    while(getTextLength(t) > 90){
		        l--;
		        t = t.substring(0, l);
		    }
		    $(obj).val(t);
		    $('.bytes').text(getTextLength(t));
		}
		
		// 댓글 등록시 입력한 데이터 초기화 
		function rboardFormData(){
			// $("#mid").val("");
			$("#rcontent").val("");
		}
		
		// 데이터 체크 
		function isEmpty(val) {
			if(typeof val == "undefined" || val == null || val == ""){ 
				return true; 
			}else {
				return false;
			}			
		}
		
		// 한글포함 문자열 길이를 구한다
		function getTextLength(s) {
			var len = 0;
			for (var i = 0; i < s.length; i++) {
			    if (escape(s.charAt(i)).length == 6) {
			        len++;
			    }
			    len++;
			}
			return len;
		}
		
    </script>
</head>
<body>

    
    <div class="fithe_wrap">
        <div class="content_wrap">
            <!--id="rbwriterdiv"-->
            <form name="rboardForm" id="rboardForm" class="rboard_form" method="POST">
                <input type="hidden" name="cnum" id="cnum" value="${communityDetail.cnum}">
                <fieldset>
                    <legend>댓글 작성</legend>
                    <div class="rboard_user">
                        <span id="mid">${mid}</span>
                        <button class="com_btn" id="insert" >저장하기</button>
                    </div>
                    
                    <div class="rboard_txt">
                        <textarea name="rcontent" id="rcontent" rows="3" cols="30"
                            placeholder="건전한 토론문화와 양질의 댓글 문화를 위해, 타인에게 불쾌감을 주는 욕설 또는 특정 계층/민족, 종교 등을 비하하는 단어들은 자제하여 주시길 바랍니다."></textarea>
                        <div><span class="bytes">0</span>/90</div>
                    </div>
                </fieldset>

                <ul name="rboardlist" id="rboardlist">
                    <!-- 여기에 동적 생성 요소가 들어온다. -->
                </ul>
            </form>
        </div>
    </div>
    <!--end of <div class="fithe_wrap">-->
</body>
</html>