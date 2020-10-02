package passEncryption;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;
 
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

@SuppressWarnings("serial")
public class passEncryption implements Serializable {
	 
	    private SecretKeySpec secretKey;
	    private byte[] key;
	 
	    public void setKey(String myKey) 
	    {
	        MessageDigest sha = null;
	        try {
	            key = myKey.getBytes("UTF-8");
	            sha = MessageDigest.getInstance("SHA-1");
	            key = sha.digest(key);
	            key = Arrays.copyOf(key, 16); 
	            secretKey = new SecretKeySpec(key, "AES");
	        } 
	        catch (NoSuchAlgorithmException e) {
	            e.printStackTrace();
	        } 
	        catch (UnsupportedEncodingException e) {
	            e.printStackTrace();
	        }
	    }
	 
	    public String encrypt(String strToEncrypt, String secret) 
	    {
	        try
	        {
	            setKey(secret);
	            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
	            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
	            return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes("UTF-8")));
	        } 
	        catch (Exception e) 
	        {
	            System.out.println("Error while encrypting: " + e.toString());
	        }
	        return null;
	    }
	 
	    public String decrypt(String strToDecrypt, String secret) 
	    {
	        if (!strToDecrypt.matches("^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$"))
        	{
	        	return strToDecrypt;
        	};
        	
	        try
	        {
	        	
	            setKey(secret);
	            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
	            cipher.init(Cipher.DECRYPT_MODE, secretKey);
	            return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
	        } 
	        catch (Exception e) 
	        {
	            System.out.println("Error while decrypting: " + e.toString());
	        }
	        return null;
	    }
	    
	    
	   /*public static void main(String[] args) 
	    {
	        final String secretKey = "ssshhhhhhhhhhh!!!!";
	        
	        passEncryption passEncryption = new passEncryption();
	         
	        String originalString = "cena69";
	        String encryptedString = passEncryption.encrypt(originalString, secretKey) ;
	        
	        String test = passEncryption.decrypt(encryptedString, secretKey) ;
	        String decryptedString = passEncryption.decrypt(originalString, secretKey) ;
	         
	        System.out.println("Original: " +originalString);
	        System.out.println("Encrypted: " +encryptedString+ " |||||| Decrypt Encrypted: " +test);
	        System.out.println("Decrypt Decrypted: " +decryptedString);
	    }*/
}