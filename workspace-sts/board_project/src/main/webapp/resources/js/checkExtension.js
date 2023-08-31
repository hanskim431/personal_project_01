/*
참고 : https://hamait.tistory.com/342
*/

// 파일 업로드 제한 
function checkFileExtension(fileName, fileSize) { 
		let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); // 업로드 불가 파일 형식
		let maxSize = 10485760;
		if(fileSize > maxSize){
			alert('파일 크기는 최대 10MB까지 업로드 가능합니다.');
			return false;
		}
		if(regex.test(fileName)){
			alert('해당 파일 형식은 업로드 할 수 없습니다.');
			return false;
		}
		return true;
	}
	
// 이메일 형식 검증
function checkEmailExtension(email) { 
	/*
	 ^[0-9a-zA-Z]*([-_\.]?[0-9a-zA-Z])*@([0-9a-zA-Z]+)*[-_\.][a-zA-Z]{2,3}$
		 ^ : 문자열 시작 
		 [0-9a-zA-Z]* : 0-9,a-z,A-Z 0번 또는 그 이상 반복  
		 [-_\.]? : -_. 중 하나 존재할 수도, 존재하지 않을 수도
		 @ : @ 존재
		 [0-9a-zA-Z]+ : [0-9a-zA-Z]가 반드시 한번 이상 반복
		 [-_\.] : -_. 중 하나, 한번 존재
		 [a-zA-Z]{2,3} : [a-zA-Z] 2~3 글자
		 $ : 문자열 끝 
	*/
	let regex = new RegExp("^[0-9a-zA-Z]*([-_\.]?[0-9a-zA-Z])*@([0-9a-zA-Z]+)*[-_\.][a-zA-Z]{2,3}$"); // 이메일 형식
	
	if(!regex.test(email)){
		return false;
	}
	return true;
}	


// ID 유효성 검사
function checkIDExtension(memberId) {
	let regex = new RegExp("^[a-zA-Z0-9]*$"); // ID 형식

	if (!regex.test(memberId)) {
		return false;
	}
	return true;
}

// 이름 유효성 검사
function checkNameExtension(memberId) {
	let regex = new RegExp("^[a-zA-Z0-9가-힣]*$"); // ID 형식

	if (!regex.test(memberId)) {
		return false;
	}
	return true;
}

// PWD 유효성 검사
function checkPwdExtension(memberPwd) {
	let regexLength = new RegExp("^.{8,15}$");
	let regexHasNumber= new RegExp("^.*\d.*$");
	let regexHasAlphabet= new RegExp(".*[a-zA-Z].*$");
	let regexHasSpecialCharacter = new RegExp("^.*[!@#$%^&+=].*$");
	
	
	let result = [
		regexLength.test(memberPwd),
		regexHasNumber.test(memberPwd),
		regexHasAlphabet.test(memberPwd),
		regexHasSpecialCharacter.test(memberPwd)
	];
	
	return result;
}
