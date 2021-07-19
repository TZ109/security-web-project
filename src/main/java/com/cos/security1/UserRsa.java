package com.cos.security1;

//import org.apache.commons.codec.binary.Base64;
import java.util.Base64;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

public class UserRsa {
	private Key publicKey;
	private Key privateKey;

	
	public Key getPublicKey() {
		return publicKey;
	}

	public void setPublicKey(Key publicKey) {
		this.publicKey = publicKey;
	}

	public Key getPrivateKey() {
		return privateKey;
	}

	public void setPrivateKeyByString(String privateKey){
		try {
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		byte[] bytePrivateKey = Base64.getDecoder().decode(privateKey.getBytes());
		//X509EncodedKeySpec privateKeySpec = new X509EncodedKeySpec(bytePrivateKey);
		PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(bytePrivateKey);
       //KCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(bytePrivateKey);
        this.privateKey = keyFactory.generatePrivate(privateKeySpec);
		}catch(NoSuchAlgorithmException | InvalidKeySpecException e)
		{
			
		}
	}
	
	public void setPublicKeyByString(String publicKey)
	{
		KeyFactory keyFactory;
		try {
			keyFactory = KeyFactory.getInstance("RSA");
			byte[] bytePublicKey = Base64.getDecoder().decode(publicKey.getBytes());
		    X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(bytePublicKey);
		    this.publicKey = keyFactory.generatePublic(publicKeySpec);
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			// TODO Auto-generated catch block
		}
       
	}

/*	
	public String encrypt(String inputStr) throws InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException,
			IllegalBlockSizeException, BadPaddingException, UnsupportedEncodingException {
		Cipher c = Cipher.getInstance("RSA");
		c.init(Cipher.ENCRYPT_MODE, publicKey);
		byte[] encrypted = c.doFinal(inputStr.getBytes("UTF-8"));

// 암호화된 데이터(byte 배열)
		return new String(Base64.encodeBase64(encrypted));
	}
*/
	public String decrypt(String inputStr) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException,
			IllegalBlockSizeException, BadPaddingException, UnsupportedEncodingException {
		Cipher c = Cipher.getInstance("RSA");
		byte[] encrypted = hexToByteArr(inputStr);
		c.init(Cipher.DECRYPT_MODE, privateKey);
		byte[] decrypted = c.doFinal(encrypted);
		String returnValue = new String(decrypted,"UTF-8");
		//byte[] decrypted = Base64.getDecoder().decode(inputStr.getBytes());
		return returnValue;
	}
	
	public static byte[] hexToByteArr(String hex)
	{
		if(hex==null || hex.length()%2 != 0)
		{
			return new byte[] {};
		}
		byte[] bytes = new byte[hex.length()/2];
		for(int i=0; i<hex.length(); i+=2)
		{
			byte value = (byte)Integer.parseInt(hex.substring(i,i+2),16);
			bytes[(int)Math.floor(i/2)]=value;
		}
		return bytes;
	}
	
	
	
	  /**
     * 암호화
     */
    static String encode(String plainData, String stringPublicKey) {
        String encryptedData = null;
        try {
            //평문으로 전달받은 공개키를 공개키객체로 만드는 과정
            PublicKey publicKey =  getPublicKey(stringPublicKey);
            //만들어진 공개키객체를 기반으로 암호화모드로 설정하는 과정
            Cipher cipher = Cipher.getInstance("RSA");
            cipher.init(Cipher.ENCRYPT_MODE, publicKey);
            //평문을 암호화하는 과정
            byte[] byteEncryptedData = cipher.doFinal(plainData.getBytes());
            encryptedData = Base64.getEncoder().encodeToString(byteEncryptedData);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return encryptedData;
    }
    /**
     * 복호화
     */
    static String decode(String encryptedData, String stringPrivateKey) {
        String decryptedData = null;
        try {
            //평문으로 전달받은 개인키를 개인키객체로 만드는 과정
            PrivateKey privateKey = getPrivateKey(stringPrivateKey);
            //만들어진 개인키객체를 기반으로 암호화모드로 설정하는 과정
            Cipher cipher = Cipher.getInstance("RSA");
            cipher.init(Cipher.DECRYPT_MODE, privateKey);
            //암호문을 평문화하는 과정
            byte[] byteEncryptedData = Base64.getDecoder().decode(encryptedData.getBytes());
            byte[] byteDecryptedData = cipher.doFinal(byteEncryptedData);
            decryptedData = new String(byteDecryptedData);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return decryptedData;
    }

    static PublicKey getPublicKey (String stringPublicKey) {
        PublicKey publicKey = null;
        try {
            //평문으로 전달받은 공개키를 공개키객체로 만드는 과정
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            byte[] bytePublicKey = Base64.getDecoder().decode(stringPublicKey.getBytes());
            X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(bytePublicKey);
            publicKey = keyFactory.generatePublic(publicKeySpec);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return publicKey;
    }
    static PrivateKey getPrivateKey (String stringPrivateKey) {
        PrivateKey privateKey = null;
        try {
            //평문으로 전달받은 개인키를 개인키객체로 만드는 과정
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            byte[] bytePrivateKey = Base64.getDecoder().decode(stringPrivateKey.getBytes());
            PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(bytePrivateKey);
            privateKey = keyFactory.generatePrivate(privateKeySpec);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return privateKey;
    }
    
    public static String sign(String plainText,String strPrivateKey) {
        try {
            PrivateKey privateKey = getPrivateKey(strPrivateKey);
            Signature privateSignature = Signature.getInstance("SHA256withRSA");
            privateSignature.initSign(privateKey);
            privateSignature.update(plainText.getBytes("UTF-8"));
            byte[] signature = privateSignature.sign();
            return Base64.getEncoder().encodeToString(signature);
        } catch (NoSuchAlgorithmException | InvalidKeyException | UnsupportedEncodingException | SignatureException e) {
            throw new RuntimeException(e);
        }
    }
    public static boolean verifySignarue(String plainText, String signature, String strPublicKey) {
        Signature sig;
        try {
            PublicKey publicKey = getPublicKey(strPublicKey);
            sig = Signature.getInstance("SHA256withRSA");
            sig.initVerify(publicKey);
            sig.update(plainText.getBytes());
            if (!sig.verify(Base64.getDecoder().decode(signature)));
        } catch (NoSuchAlgorithmException | SignatureException e) {
            throw new RuntimeException(e);
        } catch(InvalidKeyException e)
        {
        	return false;
        }
        return true;
    }
	
	
}
