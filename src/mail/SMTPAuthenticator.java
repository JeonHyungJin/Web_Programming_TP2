package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		//Mail인증을 위한 gmail등록
		return new PasswordAuthentication("hyungjin.jeon94", "tjems135");
	}
}
