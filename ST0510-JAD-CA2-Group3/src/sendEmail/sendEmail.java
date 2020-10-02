package sendEmail;

import java.io.Serializable;
import java.util.*; 
import javax.mail.*; 
import javax.mail.PasswordAuthentication;
import javax.mail.internet.*;

@SuppressWarnings("serial")
public class sendEmail implements Serializable {
	
	public String generatePassword() {
		// function to generate a random string of length n 
		int n = 10; 
	  
	        // chose a Character random from this String 
	        String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	                                    + "0123456789"
	                                    + "abcdefghijklmnopqrstuvxyz"; 
	  
	        // create StringBuffer size of AlphaNumericString 
	        StringBuilder sb = new StringBuilder(n); 
	  
	        for (int i = 0; i < n; i++) { 
	  
	            // generate a random number between 
	            // 0 to AlphaNumericString variable length 
	            int index 
	                = (int)(AlphaNumericString.length() 
	                        * Math.random()); 
	  
	            // add Character one by one in end of sb 
	            sb.append(AlphaNumericString 
	                          .charAt(index)); 
	        } 
	  
	        return sb.toString(); 
	    }
	
	public void dispatchEmail(String userEmail, String newPassword) {
		final String username = "dit2b21group3@gmail.com";
		final String password = "FusionTech22@";
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(username, password);
			}
		  });
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("dit2b21group3@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
			InternetAddress.parse(userEmail));
			String resetPassMsg = "Dear User,"
					+ "<br><br> Here is an updated password for your Fusion Tech Account:<br><b>"
					+ newPassword + "</b>";
			message.setContent(resetPassMsg, "text/html; charset=utf-8");
			message.setSubject("Fusion Tech - Password reset confirmation");
			Transport.send(message);
			System.out.println("Done");
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	
}