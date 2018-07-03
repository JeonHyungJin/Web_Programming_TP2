<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>

<%
	String referenceDir = application.getRealPath("referenceData");
	String IDFilePath = referenceDir + "/usersID.txt";
	File IDFile = new File(IDFilePath);

	request.setCharacterEncoding("UTF-8");

	String ID = request.getParameter("checkID");
	String agree = request.getParameter("hiddenCheckName");
	String cmpID;
	boolean duple = false;
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>checkDupleID</title>
</head>
<body>
	<form id="dupleForm" action="join.jsp" method="post">
		<input type="hidden" name="duple" value="true"> <input
			type="hidden" id="agree1" name="agree">
	</form>
	<form id="notDupleForm" action="join.jsp" method="post">
		<input type="hidden" name="duple" value="false"> <input
			type="hidden" name="ID" value="<%=ID%>"> <input type="hidden"
			id="agree2" name="agree">
	</form>

	<%
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				new FileInputStream(IDFile), "UTF-8"));
		cmpID = reader.readLine();
		while (cmpID != null) {
			if (cmpID.equals(ID)) {
				duple = true;
				break;
			} else {
				cmpID = reader.readLine();
			}
		}
		reader.close();
		if (agree != null) {
			if (agree.equals("checked")) {
	%>
	<script>
		document.getElementById("agree1").value = "true";
		document.getElementById("agree2").value = "true";
	</script>
	<%
		} else {
	%>
	<script>
		document.getElementById("agree1").value = "false";
		document.getElementById("agree2").value = "false";
	</script>
	<%
		}
		}

		if (duple) {
	%>
	<script>
		alert("이미 존재하는 ID입니다. 다른 ID를 입력해주세요.");
		document.getElementById("dupleForm").submit();
	</script>
	<%
		} else {
	%>
	<script>
		alert("사용 가능한 ID입니다.");
		document.getElementById("notDupleForm").submit();
	</script>
	<%
		}
	%>
</body>
</html>