package banco;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Base64;
import java.util.Random;

import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;


public class Password {

	private String pwd;
	private String hash=null;
	
	public Password(String pwd) {
		this.pwd = pwd;
	}
	
	public void comphash(byte[] salt) throws Exception {
        if (this.pwd == null || this.pwd.length() == 0)
            throw new IllegalArgumentException("Empty passwords are not supported.");
        SecretKeyFactory f = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
        SecretKey key = f.generateSecret(new PBEKeySpec(
            this.pwd.toCharArray(), salt, iterations, desiredKeyLen)
        );
        this.hash = Base64.encodeBase64String(key.getEncoded());
    }
	
	public String gethash(){
		if (this.hash==null){
			comphash();
		}
		return this.hash;
	}
}
