window.onload = function() { // 처음에 창이 켜질때 실시간 시계와 날씨 api를 사용해서 날씨를 보여주기 위해서
								// 실행되는 함수
	show_my_list();
	realtimeClock();
	show_weather_now_loc();
	show_weather_Seoul();
	show_weather_Daejeon();
};

function show_my_list() {
	var user_id_text = $("#user_id_text").val();
	$(document).ready(
			function() {
				$("#my_todolist").load(
						"read_todo_list.jsp?ID=" + user_id_text + " .Box");
			});
}

function show_weather_now_loc() {
	if (navigator.geolocation) { // geolocation을 이용하기 위해서 지원 여부 확인
		navigator.geolocation
				.getCurrentPosition(
						// 위치를 가져와서 위도, 경도를 사용
						function(position) {
							var apiURI = "http://api.openweathermap.org/data/2.5/weather?lat="
									+ position.coords.latitude
									+ "&lon="
									+ position.coords.longitude
									+ "&appid=80605a349c9f3fa15c5ac3a4481cf9fc"; // 날씨
																					// api를
																					// 현재
																					// 위치를
																					// 이용해서
																					// 사용
							$
									.ajax({
										url : apiURI,
										dataType : "json",
										type : "GET",
										async : "false",
										success : function(resp) { // ajax를
											// 이용해서 날씨를
											// 가져와서 메인
											// 화면에 원하는 곳에 보여줌
											console.log(resp);

											var imgURL = "http://openweathermap.org/img/w/"
													+ resp.weather[0].icon
													+ ".png";
											$("#now_location_img").attr("src",
													imgURL);
											$('#now_location_temp').html(
													(resp.main.temp - 273.15)
															.toFixed(1)
															+ "°C");
											$('#now_location_state').html(
													resp.weather[0].main);
											$('#now_location_city').html(
													resp.name);
											$('#now_location_wind_power').html(
													resp.wind.speed + "m/s");
											$('#now_location_wind_size').html(
													"Cloud "
															+ (resp.clouds.all)
															+ "%");
										}
									});
						}, function(error) {
							console.error(error);
						}, {
							enableHighAccuracy : false,
							maximumAge : 0,
							timeout : Infinity
						});
	} else {
		alert('GPS를 지원하지 않습니다');
	}
}

function show_weather_Seoul() { // 날씨 api를 사용해서 서울 날씨를 보여주는 함수
	var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=80605a349c9f3fa15c5ac3a4481cf9fc"; // 날씨
																													// api를
																													// 지역이름을
																													// 사용해서
																													// 날씨를
																													// 가져옴
	$.ajax({
		url : apiURI,
		dataType : "json",
		type : "GET",
		async : "false",
		success : function(resp) { // ajax를 이용해서 날씨를 가져와서 메인 화면에 원하는 곳에 보여줌
			console.log(resp);

			var imgURL = "http://openweathermap.org/img/w/"
					+ resp.weather[0].icon + ".png";
			$("#Seoul_weather_img").attr("src", imgURL);
			$('#Seoul_temp').html((resp.main.temp - 273.15).toFixed(1) + "°C");
			$('#Seoul_state').html(resp.weather[0].main);
			$('#Seoul_city').html(resp.name);
			$('#Seoul_wind_power').html(resp.wind.speed + "m/s");
			$('#Seoul_wind_size').html("Cloud " + (resp.clouds.all) + "%");
		}
	});
}

function show_weather_Daejeon() { // 날씨 api를 사용해서 대전의 날씨를 출력
	var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=Daejeon&appid=80605a349c9f3fa15c5ac3a4481cf9fc"; // 대전
																													// 지역명을
																													// 사용해서
																													// 날씨
																													// api사용
	$.ajax({
		url : apiURI,
		dataType : "json",
		type : "GET",
		async : "false",
		success : function(resp) { // ajax를 이용해서 날씨를 가져와서 메인 화면에 원하는 곳에 출력
			console.log(resp);
			var imgURL = "http://openweathermap.org/img/w/"
					+ resp.weather[0].icon + ".png";
			$("#Daejeon_weather_img").attr("src", imgURL);
			$('#Daejeon_temp')
					.html((resp.main.temp - 273.15).toFixed(1) + "°C");
			$('#Daejeon_state').html(resp.weather[0].main);
			$('#Daejeon_city').html(resp.name);
			$('#Daejeon_wind_power').html(resp.wind.speed + "m/s");
			$('#Daejeon_wind_size').html("Cloud " + (resp.clouds.all) + "%");
		}
	});
}

function show_add_best() { // 명언 추가 화면 modal창을 보여주기 위한 버튼
	document.getElementById("add_best_word_div").style.display = "block";
}

function cancel_best_word() { // 명언 추가 취소시 value를 null로 바꿔주고 modal창을 닫음
	document.getElementById("best_word").value = null;
	document.getElementById("add_best_word_div").style.display = "none";
}

function add_best_word() { // 명언 추가를 위해서 ajax를 이용해서 add_best_word.jsp로 값을 넘김
	$
			.ajax({
				type : "POST",
				url : "./add_best_word.jsp",
				async : false,
				data : {
					"best_word" : document.getElementById("best_word").value,
					"best_word_index" : document
							.getElementById("best_word_text_index").value
				},
				success : function(xml) {
				},
				error : function(xhr, status, error) {
					alert(error);
				}
			});
	cancel_best_word(); // 명언 추가 후 창을 닫음
	window.location.reload(); // index를 새로 받아오기 위해서 창을 새로고침시킴
}

// /////////

function show_todo_list() { // 명언 추가 화면 modal창을 보여주기 위한 버튼
	document.getElementById("add_todo_list_div").style.display = "block";
}

function cancel_todo_list() { // 명언 추가 취소시 value를 null로 바꿔주고 modal창을 닫음
	document.getElementById("todo_title").value = null;
	document.getElementById("todo_date").value = null;
	document.getElementById("add_todo_list_div").style.display = "none";
}

function add_todo_list() { // 명언 추가를 위해서 ajax를 이용해서 add_best_word.jsp로 값을 넘김
	var user_id_text = $("#user_id_text").val();
	var todo_url = "./Add_list.jsp?ID=" + user_id_text;
	$.ajax({
		type : "POST",
		url : todo_url,
		async : false,
		data : {
			"todo_title" : document.getElementById("todo_title").value,
			"todo_date" : document.getElementById("todo_date").value
		},
		success : function(xml) {
			console.log(xml);
		},
		error : function(xhr, status, error) {
			alert(error);
		}
	});
	cancel_todo_list(); // 할일 추가 후 창을 닫음
	window.location.reload(); // index를 새로 받아오기 위해서 창을 새로고침시킴
}

function realtimeClock() { // 실시간으로 시계를 업데이트 해주기 위한 함수
	document.rtcForm.rtcInput.value = getTimeStamp();
	setTimeout("realtimeClock()", 1000);
}

function getTimeStamp() { // 24시간제로 표기
	var d = new Date();

	var s = leadingZeros(d.getFullYear(), 4) + '-'
			+ leadingZeros(d.getMonth() + 1, 2) + '-'
			+ leadingZeros(d.getDate(), 2) + ' ' +

			leadingZeros(d.getHours(), 2) + ':'
			+ leadingZeros(d.getMinutes(), 2) + ':'
			+ leadingZeros(d.getSeconds(), 2);

	return s; // 시계 표시
}

function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();

	if (n.length < digits) {
		for (i = 0; i < digits - n.length; i++)
			zero += '0';
	}
	return zero + n;
}

function del_todo_list() {	//삭제를 위해서 이동하는 페이지
	var user_id_text = $("#user_id_text").val();
	var todo_url = "./my_list.jsp?ID=" + user_id_text;
	location.href = todo_url;
}