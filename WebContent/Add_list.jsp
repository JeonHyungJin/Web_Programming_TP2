<%@page import="java.io.*"%>
<%--사용자가 등록한 할일을 txt파일로 등록하는 jsp파일--%>
<%@page language="java" contentType="text; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String user_profile = request.getParameter("ID");
	//사용자가 입력한 할일의 값을 내장 객체 request의 getParameter함수를 이용하여 받아온다.
	String todo_title = request.getParameter("todo_title");
	//사용자의 할일의 마감일을 받아온다.
	String todo_date = request.getParameter("todo_date");

	/*파일 제목 포멧 변경*/

	String fileName = todo_date + ".txt";
	String filePath = application.getRealPath("/") + "user_todolist/" + user_profile + "/";

	//사용자가 입력한 명언을 저장하기 위해서 파일을 만들어 주는 과정
	filePath += fileName;
	try {
		File temp_file = new File(filePath);
		if (!temp_file.exists())
			temp_file.createNewFile(); //파일생성
		BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, true));
		PrintWriter pw = new PrintWriter(bw, true);
		if (!todo_title.equals("")) {
			pw.println(todo_title); //파일 작성
			pw.println(todo_date);
		}
		bw.close();
		pw.close(); //파일핸들 닫기
	} catch (IOException e) {
		System.out.print(e.toString());
	}
%>