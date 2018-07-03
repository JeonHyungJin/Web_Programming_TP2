<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%-- 회원가입을 하는 페이지 --%>
<%
	request.setCharacterEncoding("utf-8");
	
	//회원가입을 하는 경우 회원 정보를 파일로 저장해야 하므로 txt파일의 이름에 맞게 파일 경로를 생성
	String IDFilePath = application.getRealPath("usersID") + ".txt";
	File IDFile = new File(IDFilePath);	//파일객체 생성

	String IDCheck = request.getParameter("duple");	//
	String ID = request.getParameter("ID");
%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="css/join.css">
<title>HAND</title>
<script>
   var IDCheck = false;	//중복 Idcheck여부를 확인하기 위한 boolean변수 
   
   //아이디 중복체크했으면 ID 중복체크 여부 변수 true로 변경
   if (<%=IDCheck%> != null) {
      if (<%=IDCheck%> == false) {
         IDCheck = true;
      }
   }
</script>
<!-- favicon 사용 -->
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
<script src="js/join.js"></script>
</head>

<body>
	<header>
		<!-- Main title부분으로 사용되는 header 태그 -->
		<h1>H &nbsp; A &nbsp; N &nbsp; D</h1>
	</header>
	<br />
	<br />
	<!-- 회원 가입을 위해서 작성해야 하는 폼들 -->
	<div class="col-md-6 col-md-offset-3">
		<form id="checkForm" action="dupleCheckID.jsp" method="post"></form><!-- id중복여부 확인 -->
		<form id="joinForm" action="joinProcess.jsp" method="post">	<!-- 회원 가입을 위해 이메일 전송 -->
			<div class="form-group">
			<!-- 각 input tag마다 enter키 입력시 form전송이 되는 것을 막기위해서 enter키 입력을 방지 -->
				<label for="username">ID</label> <input type="text"
					class="form-control" id="ID" name="ID" placeholder="영문자 or 숫자"
					autofocus onkeypress="if(event.keyCode==13) {return false;}">
				<!-- id의 중복 여부 확인 -->
				<!-- 각 onclick과 onchange를 이용해서 포멧에 맞는지 여부를 확인 -->
				<input type="button" class="btn btn-info" value="중복 체크"
					onclick="CheckID()"> <input type="hidden" id="checkID"
					name="checkID" form="checkForm"
					onkeypress="if(event.keyCode==13) {return false;}">
			</div>
			<div class="form-group">
				<label for="InputEmail">이메일 주소</label> <input type="email"
					class="form-control" id="emailAdr" name="emailAdr"
					onchange="checkEmail()" placeholder="이메일 주소"
					onkeypress="if(event.keyCode==13) {return false;}">
			</div>
			<div class="form-group">
				<label for="InputPassword1">비밀번호</label> <input type="password"
					class="form-control" id="PW" name="PW" onchange="checkValidPW()"
					placeholder="비밀번호"
					onkeypress="if(event.keyCode==13) {return false;}">
				<script>
// 						if(document.getElementById("joinForm").checked) {
// 						   document.getElementById("hiddenCheckID").value = "checked";
// 					   }
						//아이디 중복체크 하고와서 사용가능한 아이디는 value 채워주기
               			if (<%=IDCheck%> != null) {
                  			if (<%=IDCheck%> == false) {
                    		 document.getElementById("ID").value = "<%=ID%>";
							document.getElementById("PW").focus();
						}
					}
				</script>
			</div>
			<div class="form-group">
				<label for="InputPassword2">비밀번호 확인</label> <input type="password"
					class="form-control" id="checkPW" onchange="checkEqualPW()"
					placeholder="비밀번호 확인"
					onkeypress="if(event.keyCode==13) {return false;}">
				<p class="help-block">비밀번호 확인을 위해 다시한번 입력 해 주세요</p>
			</div>
			<div class="form-group">
				<label for="InputPassword2">전화 번호 입력</label> <input type="text"
					class="form-control" id="teleNum" name="teleNum"
					onchange="checkTeleNum()" placeholder="전화 번호 입력 (ex)010-1234-1234)"
					onkeypress="if(event.keyCode==13) {return false;}">
			</div>
			<div class="form-group">
				<label for="username">이름</label> <input type="text"
					class="form-control" id="userName" name="userName"
					onchange="checkName()" placeholder="영문자열만 입력 가능(영어 이니셜)"
					onkeypress="if(event.keyCode==13) {return false;}">
			</div>

			<div class="form-group text-center">
				<button type="submit" class="btn btn-info">
					회원가입<i class="fa fa-check spaceLeft"></i>
				</button>
			</div>
		</form>
	</div>
</body>

</html>
