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
<body>
	<%
		//나의 할일을 load를 이용해서 보여질 화면
		request.setCharacterEncoding("utf-8");
		String user_profile = request.getParameter("ID");
		String filepath1 = application.getRealPath("/user_todolist/"+user_profile+"/");
		File dir = new File(filepath1);
		File[] fileList = dir.listFiles();
		//저장된 파일을 마감일이 가까운 순으로 정렬
		Arrays.sort(fileList, new Comparator<Object>() {
			@Override
			public int compare(Object object1, Object object2) {
				String s1 = "";
				String s2 = "";
				s1 = ((File) object1).getName();
				s2 = ((File) object2).getName();
				return s1.compareTo(s2);

			}
		});
		//ArrayList fl생성
		ArrayList<String> fl = new ArrayList<String>();

		for (int i = 0; i < fileList.length; i++) {
			fl.add(fileList[i].getName());
		}

		String path = application.getRealPath("/user_todolist/"+user_profile+"/");
		File dirFile = new File(path);

		try {
			//for문을 사용하여 현재 나의 계정의 할일을 div로 만들어서 보여주는 부분
			for (int i = 0; i < fl.size(); i++) {
				String fp = application.getRealPath("/user_todolist/"+user_profile+"/" + fl.get(i));
				BufferedReader reader = new BufferedReader(new FileReader(fp));
				String todo_title = reader.readLine();
				String todo_date = reader.readLine();

				if (todo_title != null) {
	%>
	<%-- 할일을 정리해서 div로 만들어 주는 화면 --%>
	<div class="Box">
		<div style="border:1px solid black">
			<span>마감일 : </span><%=todo_date%>
		</div>
		<div style="border:1px solid black">
			<span>할일 : </span><%=todo_title%>
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

</body>
</html>