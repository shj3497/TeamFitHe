<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fithe.youtube.vo.YoutubeVO" %>
<%
	Object obj = request.getAttribute("listy");
	List<YoutubeVO> listy = (List)obj;
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YOUTUBE FORM_manager</title>
    <!--common stylesheet-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/include/youtube/style.css">
    <!---->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/include/youtube/manager.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/include/youtube/youtube.css">
    <!--font-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
    <!--common script-->
    <script src="${pageContext.request.contextPath}/include/youtube/js/menu.js" defer></script>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <!--javascript-->
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).on("click", "#button1", function () {
                $.ajax({
                    url: "youtubeselect.do",
                    type: "POST",
                    data: {
                        yid: $("#btn1").val(),
                    },
                    success: function (data) {
                        if (data == "G") {
                            alert("근지구력");
                            $("#yid").val("1");
                            $("#youtubeform").attr({
                                "method": "POST",
                                "action": "youtubeList.do"
                            }).submit();
                        } else {
                            alert("동영상이 없습니다.")
                        }
                    },
                    error: function (error) {
                        alert("error : " + error)
                    }
                });
            });
            $(document).on("click", "#button2", function () {
                $.ajax({
                    url: "youtubeselect.do",
                    type: "POST",
                    data: {
                        yid: $("#btn2").val(),
                    },
                    success: function (data) {
                        if (data == "G") {
                            alert("유연성");
                            $("#yid").val("2");
                            $("#youtubeform").attr({
                                "method": "POST",
                                "action": "youtubeList.do"
                            }).submit();
                        } else {
                            alert("동영상이 없습니다.")
                        }
                    },
                    error: function (error) {
                        alert("error : " + error)
                    }
                });

            });

            $(document).on("click", "#button3", function () {
                $.ajax({
                    url: "youtubeselect.do",
                    type: "POST",
                    data: {
                        yid: $("#btn3").val(),
                    },
                    success: function (data) {
                        if (data == "G") {
                            alert("순발력");
                            $("#yid").val("3");
                            $("#youtubeform").attr({
                                "method": "POST",
                                "action": "youtubeList.do"
                            }).submit();
                        } else {
                            alert("동영상이 없습니다.")
                        }
                    },
                    error: function (error) {
                        alert("error : " + error)
                    }
                });
            });

            $(document).on("click", "#button4", function () {
                $.ajax({
                    url: "youtubeselect.do",
                    type: "POST",
                    data: {
                        yid: $("#btn4").val(),
                    },
                    success: function (data) {
                        if (data == "G") {
                            alert("민첩성");
                            $("#yid").val("4");
                            $("#youtubeform").attr({
                                "method": "POST",
                                "action": "youtubeList.do"
                            }).submit();
                        } else {
                            alert("동영상이 없습니다.")
                        }
                    },
                    error: function (error) {
                        alert("error : " + error)
                    }
                });
            });

            $(document).on("click", "#button5", function () {
                $.ajax({
                    url: "youtubeselect.do",
                    type: "POST",
                    data: {
                        yid: $("#btn5").val(),
                    },
                    success: function (data) {
                        if (data == "G") {
                            alert("심폐지구력");
                            $("#yid").val("5");
                            $("#youtubeform").attr({
                                "method": "POST",
                                "action": "youtubeList.do"
                            }).submit();
                        } else {
                            alert("동영상이 없습니다.")
                        }
                    },
                    error: function (error) {
                        alert("error : " + error)
                    }
                });
            });

            $(document).on("click", "#insertbutton", function () {
                var url = "youtubeinsertform.do";
                var name = "youtubeinsertform";
                var option = "width=600, height = 600, left=100, top=50, location=no ";
                window.open(url, name, option);

            });

            $(document).on("click", "#updatebutton", function () {
                var url = "youtubeupdateform.do";
                var name = "youtubeupdateform";
                var option = "width=600, height = 600, left=100, top=50, location=no ";
                window.open(url, name, option);
            });
        });        
    </script>
</head>

<body>
    <div class="fithe_wrap">
        <div>
            <!--(1) management bar-->
            <div class="menu_align">
                <div class="navbar_logo">
                    <a href="#"><img src="${pageContext.request.contextPath}/include/youtube/img/fithe_txt.png" width="100px"></a>
                </div>
                <!--manager info-->
                <div class="thumb">
                    <img class="img-circle" width="68" height="68" alt="관리자 이미지" src="${pageContext.request.contextPath}/include/youtube/img/sports.jpg" />
                    <div>관리자</div>
                    <div><a href="memberLogout.do">로그아웃</a></div>
                </div>
                <!--menu link-->
                <div class="menu_link">
                    <ul>
                        <li><a href="memberList.do">회원관리</a></li>
                        <li><a href="#">게시판 관리</a></li>
                        <li><a href="#">공지사항 관리</a></li>
                        <li><a href="youtubeList.do">동영상 관리</a></li>
                    </ul>
                </div>
            </div>
            <!--end of <div class="menu_align">-->

            <div class="gif_head">
                <img src="${pageContext.request.contextPath}/include/youtube/img/giphy.gif" class="giphy-embed" height="200px">
            </div>
            <!--(2) content-->
            <div class="manage_group">
                <!--title : web version-->
                <div class="content_title">동영상 컨텐츠 관리</div>
                <!--title : pad version-->
                <div class="content_head">
                    <select onchange="window.location.href=this.value">
                        <option value="none">=== 선택 ===</option>
                        <option value="memberList.do">회원관리</option>
                        <option value="#">게시판 관리</option>
                        <option value="#">공지 게시판 관리</option>
                        <option value="youtubeList.do" selected>동영상 관리</option>
                    </select>
                </div>

                <!--##################################################################-->
                <div>
                    <form id="youtubeform" class="youtubeform">
                        <input type="hidden" name="yid" id="yid" value="${yid }">
                        <table>
                            <thead>
                                <tr class="in_up_btn">
                                    <td colspan="2">
                                        <input type="button" id="insertbutton" name="insertbutton" value="입력">
                                        <input type="button" id="updatebutton" name="updatebutton" value="수정">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type="button" id="button1" name="button1" value="근지구력" />
                                        <input type="hidden" id="btn1" value="1">
                                        <input type="button" id="button2" name="button2" value="유연성" />
                                        <input type="hidden" id="btn2" value="2">
                                        <input type="button" id="button3" name="button3" value="순발력" />
                                        <input type="hidden" id="btn3" value="3">
                                        <input type="button" id="button4" name="button4" value="민첩성" />
                                        <input type="hidden" id="btn4" value="4">
                                        <input type="button" id="button5" name="button5" value="심폐지구력" />
                                        <input type="hidden" id="btn5" value="5">
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <% if(listy.size()> 0){
                                        for(int i=0; i<listy.size(); i++){ 
                                        	YoutubeVO yvo=(YoutubeVO)listy.get(i); 
                                    %>
                                    	<td>
                                        	<%=yvo.getYlink() %>
                                        </td>
                                        	<% if(i%2==1){ %>
                                </tr>
                                	<br>
                                <tr>
                                    <%			} 
                                        	}
                                        } %>
                                </tr>                
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
            <!--end of <div class="manage_group">-->
        </div>


    </div>
    <!--end of <div class="fithe_wrap">-->
    >
</body>

</html>