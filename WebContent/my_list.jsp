<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.IOException" import="java.io.*"
	import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

<head>
<meta charset="UTF-8">
<title>HAND</title>
<link type="text/css" rel="stylesheet" href="css/my_list.css">
<!-- favicon 설정 -->
<link rel="shortcut icon" href="./img/favicon.ico">
<!-- 기본적인 제이쿼리, css파일등을 연동 -->
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
</head>
<body>
<%-- 자신의 할일을 보여지는 페이지 --%>
	<%
		request.setCharacterEncoding("utf-8");
		String user_profile = request.getParameter("ID");
		String filepath1 = application.getRealPath("/user_todolist/" + user_profile + "/");
		File dir = new File(filepath1);
		File[] fileList = dir.listFiles();
		//디렉토리를 읽어서 자신의 할일을 리스트로 가져온다.
		ArrayList<String> fl = new ArrayList<String>();

		for (int i = 0; i < fileList.length; i++) {
			fl.add(fileList[i].getName());
		}
	%>

	<header>
		<!-- Main title부분으로 사용되는 header 태그 -->
		<h1>H &nbsp; A &nbsp; N &nbsp; D</h1>
	</header>
	<br />
	<div id="my_list_div">
			<input style="margin-bottom:20px" type="button" value="나의 페이지로 돌아가기"
				class="btn btn-info" 
				onclick="location.href='onlogin_main.jsp?ID=<%=user_profile%>'">
		<%
			try {	//자신의 할일을 div로 나타내기 위해서 파일을 여는 부분
				for (int i = 0; i < fl.size(); i++) {
					String fp = application.getRealPath("/user_todolist/" + user_profile + "/" + fl.get(i));
					BufferedReader reader = new BufferedReader(new FileReader(fp));
					String todo_title = reader.readLine();
					String todo_date = reader.readLine();

					if (todo_title != null) {
		%>
		<div class="my_lists"
			style="width: 200px; margin-bottom: 20px; margin-left: 600px">
				<br/>	<%-- 기존의 나의 페이지로 돌아가는 버튼 --%>
			<div style="border: 1px solid black">
				<span>마감일 : </span><%=todo_date%>
			</div>
			<div style="border: 1px solid black">
				<span>할일 : </span><%=todo_title%>
			</div>
			<div style="border: 1px solid black; height: 50px">
				<input style="margin-top: 6px" type="button" value="파일 삭제"
					class="btn btn-info" id="<%=todo_date%>"
					onclick="location.href='delete_list.jsp?fileName=<%=todo_date%>&ID=<%=user_profile%>'">
					<%-- 파일을 삭제하기 위해서 버튼을 누르면 delete page로 이동해서 파일을 삭제 --%>
			</div>
		</div>
		
		<%
			}
					reader.close();
				}

			} catch (Exception e) {
				out.println(e);
			}
		%>

	</div>
	<div style="text-align:center">
			<h3>보여지는 것이 없다면 모든 일을 마치신겁니다!</h3>
		</div>
	<!-- 저작권 표시 -->
	<footer> 2018. (Hyungjin.Jeon) All Rights Reserved.</footer>

</body>

</html>
