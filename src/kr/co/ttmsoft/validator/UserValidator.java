package kr.co.ttmsoft.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import kr.co.ttmsoft.beans.UserBean;

//#3-1
public class UserValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {

		return UserBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
	//유효성 검사를 해야 할 객체는 target으로 넘어옴
		UserBean userBean = (UserBean)target;
		
		if(userBean.getUser_pw().equals(userBean.getUser_pw2()) == false) {
			errors.rejectValue("user_pw", "NotEquals");
			errors.rejectValue("user_pw2", "NotEquals");
		}
	}
	
}
