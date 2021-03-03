<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!--css-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/include/youtube/style.css">
    <style>
        h3{text-align: center; margin-top: 30px; color: #333;}
        table{width: 100%; max-width: 800px; margin: auto;}
        tr{height: 50px;}
        tr:not(tr:last-of-type) td:first-of-type{text-align: center;}
        tr:not(tr:last-of-type) td input{width: 80%; height: 30px; border: 1px solid gray;}
        tr:last-of-type{height: 100px;}
        input[type=button]{width: 100%; height: 50px; border-radius: 30px; border: none; font-size: 15pt; color: lightgray;}
        input[type=button]:hover{background-color: var(--accent-color); color: white; font-weight: 900;}
    </style>
    <!--javascript-->
     <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        function click_insert() {

            $.ajax({
                url: "youtubeinsert.do",
                type: "POST",
                data: {
                    yid: $("#yid").val(),
                    ynum: $("#ynum").val(),
                    ylink: $("#ylink").val(),
                },
                success: function (data) {
                    if (data == "GOOD") {
                        alert("동영상 추가");
                        opener.parent.location.reload();
                        window.close();
                    } else {
                        alert("분류와 링크를입력해주세요");
                    }
                },
                error: function (error) {
                    alert("error : " + error);
                }
            });
        }
    </script>
</head>

<body>
    <div>
        <form id="youtubeinsertForm">
            <h3>새 동영상 입력</h3>
            <table>            
                <tr>
                    <td>분류</td>
                    <td><input type="text" id="yid" name="yid" maxlength="1"></td><br>
                </tr>
                <tr>
                    <td>소분류</td>
                    <td><input type="text" id="ynum" name="ynum" maxlength="1"></td><br>
                </tr>
                <tr>
                    <td>링크</td>
                    <td><input type="text" id="ylink" name="ylink"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="button" onclick="click_insert()" value="확인" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>

</html>