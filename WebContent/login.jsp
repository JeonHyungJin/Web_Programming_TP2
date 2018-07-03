<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
</head>
<body>

<%
   request.setCharacterEncoding("UTF-8");

   //사용자가 입력한 id와 pw를 내장객체를 이용해서 넘겨 받음
   String ID = request.getParameter("ID");
   String PW = request.getParameter("PW");
   
   //로그인을 하기 위해서 사용자가 가입된 사용자인지 확인을 하기 위해서 user의 정보 파일에 접근
   String userDirPath = application.getRealPath("users");
   String userFilePath = userDirPath + "/" + ID + ".txt";	//실제 유저의 정보가 저장된 파일
   File userFile = new File(userFilePath);
   if(userFile.isFile()) {   //user파일이 존재하면 가입이 되어있는 사용자이다.
      BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(userFile), "UTF-8"));
      String checkPW = reader.readLine();   //파일에 저장되어있는 비밀번호
      if(PW.equals(checkPW)) {   //사용자가 입력한 비밀번호가 실제 저장된 비밀번호와 일치하는 경우 아이디와 비밀번호를 세션에 저장시킨다.
         session.setAttribute("ID", ID);
         session.setAttribute("PW", PW);
         response.setHeader("refresh", "0, URL=onlogin_main.jsp?ID="+ID);	//GET방식으로 id값을 넘기며 로그인을 시켜 다음 페이지로 넘어가게 한다.
      }
      else {	//비밀번호가 틀린 경우
         %>
         <script>
         	alert("비밀번호를 틀리셨습니다.");
         	<%--비밀번호가 틀린 경우 alert창을 이용해서 알려주고 메인 페이지로 돌아가도록 한다--%>
         	location.replace("main_login.html");
         </script>
         <%
      }
      reader.close();
   }
   else {   //user파일이 없는 경우는 가입이 제대로 되어 있지 않은 경우 이므로 ID가 존재하지 않음을 알려주고 전 페이지로 돌아간다.
      %>
      <script>
         alert("존재하지 않는 아이디입니다.");
         history.back();
      </script>
      <%
   }
   
%>

</body>
</html>