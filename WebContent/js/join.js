//회원 가입시 회원 가입 폼 확인을 위한 함수들

function CheckID() {	//아이디 형식 확인과 중복ID체크
	var inputID = document.getElementById("ID").value;	//사용자가 입력한 id값을 가져온다
	var pattern = /^[a-zA-Z가-힣0-9]+$/;	//id의 패턴을 정규표현식으로 표현
	var duple = false;

	if (!pattern.test(inputID)) {	//아이디 형식 맞지 않음
		alert("아이디는 문자 혹은 숫자로만 지정할 수 있습니다.");	//alert창을 이용해서 틀림 여부를 알려줌
		document.getElementById("ID").value = " ";
		document.getElementById("ID").focus();
	} else {	//아이디 형식 맞아서 중복 체크 하러 보냄.
		document.getElementById("checkID").value = inputID;
		document.getElementById("checkForm").submit();
	}
}

function checkValidPW() {	//비밀번호가 형식에 맞는지 확인
	var inputPW = document.getElementById("PW").value;	//사용자가 입력한 비밀번호를 가져온다
	var pattern = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/;	//원하는 비밀 번호 패턴을 정규표현식으로 표현
	if (!pattern.test(inputPW)) {	//사용자가 입력한 비밀번호가 원하는 패턴과 일치하지 않는 경우
		alert("비밀번호는 문자+숫자 조합의 8자리 이상으로 설정해주세요.");	//경고차을 보여준다.
		document.getElementById("PW").value = "";
		document.getElementById("PW").focus();
	}
}

function checkEqualPW() {	//비밀번호 동일값 입력한 지 확인
	var PW = document.getElementById("PW").value;	//사용자가 기존에 입력한 비밀번호를 가져온다.
	var checkPW = document.getElementById("checkPW").value;	//확인을 위해서 작성한 비밀번호를 가져온다.
	if (PW != checkPW) {	//두 개의 값이 다른 경우
		alert("위에 입력한 비밀번호와 값이 다릅니다. 다시 입력해주세요.");	//다시 입력을 받는다.
		document.getElementById("checkPW").value = "";
		document.getElementById("checkPW").focus();
	}
}

function checkName() {	//이름 형식 확인
	var inputName = document.getElementById("userName").value;	//사용자가 입력한 이름을 가져온다.
	var pattern = /^[a-zA-Z]+$/;	//이름의 패턴 확인
	if (!pattern.test(inputName)) {	//패턴과 불일치시
		alert("이름은 영어문자열만 입력 가능합니다.");	//경고창을 띄어준다.
		document.getElementById("userName").value = "";
		document.getElementById("userName").focus();
	}
}

function checkTeleNum() {	//전화번호 형식 확인
	var inputTeleNum = document.getElementById("teleNum").value;
	var pattern = /^\d{2,3}-\d{3,4}-\d{4}$/;
	if (!pattern.test(inputTeleNum)) {
		alert("전화번호 형식을 지켜주세요.");
		document.getElementById("teleNum").value = "";
		document.getElementById("teleNum").focus();
	}
}

function checkEmail() {	//이메일 형식 확인
	var inputEmail = document.getElementById("emailAdr").value;
	var pattern = /@/;
	if (!pattern.test(inputEmail)) {
		alert("이메일 형식을 지켜주세요.");
		document.getElementById("emailAdr").value = "";
		document.getElementById("emailAdr").focus();
	}
}

function checkJoin() {	//회원가입 버튼 클릭 시
	if (!IDCheck) {
		alert("ID 중복체크를 해주세요.");
	} else if (document.getElementById("PW").value == "") {
		alert("password를 입력해주세요.");
	} else if (document.getElementById("checkPW").value == "") {
		alert("password 확인을 해주세요.");
	} else if (document.getElementById("userName").value == "") {
		alert("이름을 입력해주세요.");
	} else if (document.getElementById("teleNum").value == "") {
		alert("전화번호를 입력해주세요.");
	} else if (document.getElementById("emailAdr").value == "") {
		alert("이메일을 입력해주세요.");
	} else  {
		document.getElementById("joinForm").submit();
	}
}
