<%@page import="java.io.*"%>
<%--사용자가 등록한 명언을 txt파일로 등록하는 jsp파일--%>
<%@page language="java" contentType="text; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	//사용자가 입력한 명언의 값을 내장 객체 request의 getParameter함수를 이용하여 받아온다.
	String best_word_text = request.getParameter("best_word");
	//사용자의 명언이 등록될 파일의 제목을 위해서 index를 넘겨 받는다.
	String best_word_index = request.getParameter("best_word_index");

	String fileName = best_word_index + ".txt";
	String filePath = application.getRealPath("/") + "best_words/";

	//사용자가 입력한 명언을 저장하기 위해서 파일을 만들어 주는 과정
	filePath += fileName;
	try {
		File temp_file = new File(filePath);
		if (!temp_file.exists())
			temp_file.createNewFile(); //파일생성
		BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, true));
		PrintWriter pw = new PrintWriter(bw, true);
		if (!best_word_text.equals("")) {
			pw.println(best_word_text); //파일 작성
		}
		bw.close();
		pw.close(); //파일핸들 닫기
	} catch (IOException e) {
		System.out.print(e.toString());
	}
%>