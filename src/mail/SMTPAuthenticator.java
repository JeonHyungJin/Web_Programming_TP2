package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		//Mail������ ���� gmail���
		return new PasswordAuthentication("hyungjin.jeon94", "tjems135");
	}
}
