<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.activation.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="mail.SMTPAuthenticator"%>
<%-- 회원가입을 위해서 이메일을 보내는 과정 --%>

<%
	request.setCharacterEncoding("UTF-8");
	//회원 가입을 위해서 작성된 input tag들의 정보를 받음
	String ID = request.getParameter("ID");
	String PW = request.getParameter("PW");
	String userName = request.getParameter("userName");
	String teleNum = request.getParameter("teleNum");
	String emailAdr = request.getParameter("emailAdr");
	
	//이메일 인증을 통해서 제대로 가입이 이루어 지기 전까지는 waiting이라는 dir에 회원 정보를 임시적으로 저장
	String waitingDir = application.getRealPath("waiting");
	String waitingFilePath = waitingDir + "/" + emailAdr + ".txt";
	File waitingFile = new File(waitingFilePath);
	//파일에 회원 정보 작성
	BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(waitingFile), "UTF-8"));
	writer.write(ID + "\n" + PW + "\n" + userName + "\n" + teleNum );
	writer.close();
	
	/* 인증 메일 보내기 */
	
	String result;	//이메일 전송 여부를 확인하고 출력을 위한 출력문 저장
	String to = emailAdr;	//받는 사람의 이메일
	
	StringBuffer buf = new StringBuffer();	//이메일 작성을 위한 StringBuffer
	buf.append("<!DOCTYPE html>");
	buf.append("<html>");
	buf.append("<head>");
	buf.append("</head>");
	buf.append("<body>");
	buf.append("<h1>회원가입 인증 안내</h1>");
	buf.append("<hr/><br/>");
	buf.append("<p>아래 '인증하기' 버튼을 클릭하면 회원가입이 완료됩니다.</p><br/>");
	buf.append("<form action=\"http://localhost:8181/TP2_201402420/certificate_process.jsp\" method=\"post\">");
	buf.append("<input type=\"hidden\" name=\"emailAdr\" value=\"" + emailAdr + "\">");
	buf.append("<input type=\"submit\" value=\"인증하기\">");
	buf.append("</form>");
	buf.append("</body>");
	buf.append("</html>");
	
	
	// 정보를 담을 객체
	Properties properties = System.getProperties();
	properties.put("mail.smtp.starttls.enable", "true");	//gmail사용
	properties.put("mail.smtp.host","smtp.gmail.com");	//smtp 서버 주소
	properties.put("mail.smtp.auth", "true");
	properties.put("mail.smtp.port", "587");	 

	try {
		Authenticator auth = new SMTPAuthenticator();
		
		Session mailSession = Session.getDefaultInstance(properties, auth);
				
		MimeMessage message = new MimeMessage(mailSession);	//메일의 내용을 담을 객체
		
		message.setHeader("Content-Type", "text/html; charset=UTF-8");
		
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));//받는사람
		
		message.setSubject("HAND service 사용을 위한 인증 이메일 입니다.");	//제목
		
		message.setContent(buf.toString(), "text/html; charset=UTF-8");
		
		Transport.send(message);	//이메일 전송
		
		result = "인증 메일이 발송되었습니다.\n(" + to + ")로 발송된 이메일을 확인 후,\n이메일에 첨부된 URL을 클릭하시면 회원가입이 완료됩니다.";
	} catch (MessagingException mex) {
		mex.printStackTrace();
		result = "Error: unable to send message....";
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <title>HAND</title>
  <link type="text/css" rel="stylesheet" href="css/joinProcess.css">
  <!-- favicon 설정 -->
  <link rel="shortcut icon" href="./img/favicon.ico">
  <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <!-- font awesome -->
  <link rel="stylesheet" href="css/font-awesome.min.css" media="screen" title="no title" charset="utf-8">
  <!-- Custom style -->
  <link rel="stylesheet" href="css/style.css" media="screen" title="no title" charset="utf-8">
	<script src="js/joinProcess.js"></script>
</head>

<body>
<header>
    <!-- Main title부분으로 사용되는 header 태그 -->
    <h1>H &nbsp; A &nbsp; N &nbsp; D</h1>
  </header>
	<div align="center" id="result_div">
	<br/>
		<%
			out.println(result);
		%>
		<br/>
		<br/>
		<input type="button" value="로그인 창으로 돌아가기" onclick="goBack()">
		<br/>
        <img src="./img/mail.png" alt="mail" id="mail_img" draggable="false">
	</div>
</body>
</html>