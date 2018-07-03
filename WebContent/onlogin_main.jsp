<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>HAND</title>
<link type="text/css" rel="stylesheet" href="css/onlogin_main.css">
<!-- favicon 설정 -->
<link rel="shortcut icon" href="./img/favicon.ico">
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<!-- font awesome -->
<link rel="stylesheet" href="css/font-awesome.min.css" media="screen"
	title="no title" charset="utf-8">
<!-- Custom style -->
<link rel="stylesheet" href="css/style.css" media="screen"
	title="no title" charset="utf-8">
<script src="js/onlogin_main.js"></script>
</head>

<%
	request.setCharacterEncoding("utf-8");

	String user_name = request.getParameter("ID");

	String filepath = application.getRealPath("/best_words/");
	File dir = new File(filepath);
	File[] fileList = dir.listFiles();
	int file_length = fileList.length; //명언 폴더 총 파일 갯수 

	int random_num = (int) (Math.random() * file_length);
	String best_word = "";
	String fp = application.getRealPath("/best_words/" + random_num + ".txt");
	File checking_file = new File(fp); // 파일객체생성
	if (checking_file.exists()) {
		BufferedReader reader = new BufferedReader(new FileReader(fp));
		best_word = reader.readLine();
	}
%>
<script>
	function goBack() {
		location.href = "main_login.html";
	}
</script>
<body>

	<header>
		<!-- Main title부분으로 사용되는 header 태그 -->
		<h1>
			<input type="button" class="btn btn-info" value="로그 아웃"
				style="visibility: hidden">H &nbsp; A &nbsp; N &nbsp; D <input
				type="button" value="로그 아웃" id="logout_but" class="btn btn-info"
				onclick="goBack()">
		</h1>
	</header>

	<div id="add_best_word_div" style="display: none">
		<div id="best_word_writingTransparentBorder"></div>
		<div id="best_word_writingFormContainer">
			<h4>명언 추가</h4>
			<input type="text" name="best_word" id="best_word"
				placeholder="명언을 입력하세요." /> &nbsp; <input type="button"
				id="best_word_button" name="best_word_button"
				onclick="add_best_word()" value="추가하기" class="btn btn-info" />
			&nbsp; <input type="button" id="cancel_best_word"
				onclick="cancel_best_word()" value="취소" class="btn btn-info" /> <input
				type="text" style="visibility: hidden" id="best_word_text_index"
				value="<%=file_length%>">
		</div>
	</div>

	<div id="add_todo_list_div" style="display: none">
		<div id="todo_list_writingTransparentBorder"></div>
		<div id="todo_list_writingFormContainer">
			<h4>할일 추가</h4>
			<span>할일 : </span><input type="text" name="todo_title"
				id="todo_title" placeholder="해야하는 일을 입력하시오." /> <br /> <br /> <span>마감일
				: </span><input type="date" name="todo_date" id="todo_date">
			<hr />
			<input type="button" id="todo_list_button" name="todo_list_button"
				onclick="add_todo_list()" value="추가하기" class="btn btn-info" />
			&nbsp; <input type="button" id="cancel_todo_title"
				onclick="cancel_todo_list()" value="취소" class="btn btn-info" />
		</div>
	</div>

	<div id="onlogin_main_back">
		<!-- js를 이용해서 추후 기본 명언들과 이용자들이 추가한 명언들이 랜덤으로 나옴 -->
		<div id="today_letter" class="round_div">
			<input type="button" value="명언 추가하기" class="btn btn-info"
				id="best_word_add" onclick="show_add_best()"> <br />
			<div id="real_best_word_div">
				<h2>
					<center id="best_idea"><%=best_word%></center>
				</h2>
			</div>
		</div>

		<div id="clock_div">
			<!-- 실시간으로 시간을 표현해 주는 div부분 -->
			<form name="rtcForm">
				<input type="text" name="rtcInput" size="20" readonly="readonly" />
			</form>
		</div>

		<!-- 자주 사용하는 웹사이트의 링크가 걸려잇는 div -->
		<div id="web_list" class="round_div">
			<ul>
				<li><a href="https://www.google.co.kr"><img
						src="img/google.png" alt="google" class="a_link_img"></a></li>
				<li><a href="https://www.github.com"><img
						src="img/GitHub.png" alt="github" class="a_link_img"></a></li>
				<li><a href="https://www.w3schools.com"><img
						src="img/w3schools.png" alt="w3schools" class="a_link_img"></a></li>
				<li><a href="http://e-learn.cnu.ac.kr/main/MainView.dunet"><img
						src="img/cnu_cyber.png" alt="cnu_cyber" class="a_link_img"></a></li>
				<li><a href="https://www.naver.com/"><img
						src="img/naver.png" alt="naver" class="a_link_img"></a></li>
			</ul>
		</div>
		<div id="wheather_div" class="round_div">
			<h2>
				<center>오늘의 날씨</center>
			</h2>
			<hr />
			<!-- 날씨 API를 사용해서 날씨 정보에 대한 table을 넣을  -->
			<table id="now_location">
				<tr>
					<td colspan="2">현위치</td>
				</tr>
				<tr>
					<td rowspan="3"><img id="now_location_img" alt="" src=""></td>
					<td id="now_location_temp"></td>
				</tr>
				<tr>
					<td id="now_location_state"></td>
				</tr>
				<tr>
					<td id="now_location_city"></td>
				</tr>
				<tr>
					<td id="now_location_wind_power"></td>
					<td id="now_location_wind_size"></td>
				</tr>
			</table>

			<table id="Seoul">
				<tr>
					<td colspan="2">서울</td>
				</tr>
				<tr>
					<td rowspan="3"><img id="Seoul_weather_img" alt="" src=""></td>
					<td id="Seoul_temp"></td>
				</tr>
				<tr>
					<td id="Seoul_state"></td>
				</tr>
				<tr>
					<td id="Seoul_city"></td>
				</tr>
				<tr>
					<td id="Seoul_wind_power"></td>
					<td id="Seoul_wind_size"></td>
				</tr>
			</table>

			<table id="Daejeon">
				<tr>
					<td colspan="2">대전</td>
				</tr>
				<tr>
					<td rowspan="3"><img id="Daejeon_weather_img" alt="" src=""></td>
					<td id="Daejeon_temp"></td>
				</tr>
				<tr>
					<td id="Daejeon_state"></td>
				</tr>
				<tr>
					<td id="Daejeon_city"></td>
				</tr>
				<tr>
					<td id="Daejeon_wind_power"></td>
					<td id="Daejeon_wind_size"></td>
				</tr>
			</table>
		</div>
		<div id="todo_list_div" class="round_div">
			<h2>나의 할일</h2>
			<div id="todo_list_button">
				<input type="button" value="할일 추가" class="btn btn-info"
					id="list_todo" onclick="show_todo_list()"> <input
					type="button" value="할일 관리" class="btn btn-info" id="list_del"
					onclick="del_todo_list()">
			</div>
			<input type="text" style="visibility: hidden" value="<%=user_name%>"
				id="user_id_text">
			<div id="my_todolist"></div>
		</div>

	</div>
	<!-- 저작권 표시 -->
	<footer>ⓒ 2018. (Hyungjin.Jeon) All Rights Reserved.</footer>
</body>

</html>
