<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%--실제 사용자의 정보가 이메일 인증을 통해서 저장이 되는 jsp파일 --%>
<%
	request.setCharacterEncoding("UTF-8");

	String emailAdr = request.getParameter("emailAdr");

	boolean permitJoin = true;

	/* waiting에 임시로 회원 정보 저장해놓은 파일에 접근 */
	String waitingDir = application.getRealPath("waiting");
	String waitingFilePath = waitingDir + "/" + emailAdr + ".txt";
	File waitingFile = new File(waitingFilePath);

	/* 입력한 이메일을 가진 회원이 존재하는지 확인 */
	String referenceDir = application.getRealPath("referenceData");
	String emailFilePath = referenceDir + "/usersEmail.txt";
	File emailFile = new File(emailFilePath);
	BufferedReader reader = new BufferedReader(new InputStreamReader(
			new FileInputStream(emailFile), "UTF-8"));
	String cmpEmail = reader.readLine();
	while (cmpEmail != null) {
		if (cmpEmail.equals(emailAdr)) { //이메일 중복일 경우
			permitJoin = false;
			waitingFile.delete();
			break;
		} else {
			cmpEmail = reader.readLine();
		}
	}
	reader.close();

	if (permitJoin) { 
		reader = new BufferedReader(
				new InputStreamReader(new FileInputStream(waitingFile),"UTF-8"));
		String ID = reader.readLine();
		String PW = reader.readLine();
		String userName = reader.readLine();
		String teleNum = reader.readLine();
		reader.close();

		/* 회원가입시킨 후 정보 저장시킬 파일 */
		String userDir = application.getRealPath("users");
		String userFilePath = userDir + "/" + ID + ".txt";
		File userFile = new File(userFilePath);
		//회원 정보 작성
		BufferedWriter writer = new BufferedWriter(
				new OutputStreamWriter(new FileOutputStream(userFile),
						"UTF-8"));
		writer.write(PW + "\n" + userName + "\n" + teleNum + "\n"
				+ emailAdr );
		writer.close();

		//회원가입한 email 추가
		writer = new BufferedWriter(new OutputStreamWriter(
				new FileOutputStream(emailFile, true), "UTF-8"));
		writer.write("\n" + emailAdr);
		writer.close();

		//회원가입한 ID 추가
		String userIDFilePath = referenceDir + "/usersID.txt";
		File userIDFile = new File(userIDFilePath);
		writer = new BufferedWriter(new OutputStreamWriter(
				new FileOutputStream(userIDFile, true), "UTF-8"));
		writer.write("\n" + ID);
		writer.close();
		
		waitingFile.delete();
		
		String dir_path = application.getRealPath("/user_todolist/");	//todolist를 위한 dir생성
		dir_path = dir_path + "/" + ID;
		
		File fPath = new File(dir_path); //경로생성

		if (!fPath.exists()) {
			fPath.mkdirs(); //상위 디렉토리가 존재하지 않으면 상위디렉토리부터 생성.
		}
		
		//get방식으로 id를 넘기며 메인 페이지 실행
		String temp_url = "<script>location.href='onlogin_main.jsp?ID="+ID+"';</script>";
		out.println(temp_url);
	} else { //유효하지 않은 이메일URL인 경우
		out.println("<script>location.href='failJoin.html';</script>");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>certificate process</title>
</head>
<body>

</body>
</html>