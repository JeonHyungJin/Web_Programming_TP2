<%@page import="java.io.IOException" import="java.io.*"%>
<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- 자신이 삭제하고자 하는 할일을 삭제해주는 jsp페이지 --%>
	<%
		request.setCharacterEncoding("UTF-8");

		String file_name = request.getParameter("fileName");
		String user_profile = request.getParameter("ID");
		String path = application.getRealPath("/user_todolist/" + user_profile + "/");
		path = path + "/" + file_name + ".txt";
		File file = new File(path);

		if (file.exists()) {
			if (file.delete()) {	//파일을 삭제하고 원래 페이지로 돌아간다
				String temp_url = "<script>location.href='onlogin_main.jsp?ID=" + user_profile + "';</script>";
				out.println(temp_url);

			} else {
				out.println("삭제 실패");	//파일 삭제시 원래 페이지로 돌아간다
				String temp_url = "<script>location.href='onlogin_main.jsp?ID=" + user_profile + "';</script>";
				out.println(temp_url);
			}
		} else {
			out.println("파일 없음");	//파일 삭제시 원래 페이지로 돌아간다
			String temp_url = "<script>location.href='onlogin_main.jsp?ID=" + user_profile + "';</script>";
			out.println(temp_url);
		}
	%>
</body>
</html>