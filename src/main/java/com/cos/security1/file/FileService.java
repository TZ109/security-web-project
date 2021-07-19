package com.cos.security1.file;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.cos.security1.model.User;

@Service
public class FileService {

	//1차 파일 업로드 테스트
	
    // application.properties 에 app.upload.dir을 정의하고, 없는 경우에 default 값으로 user.home (System에 종속적인)
    @Value("${app.upload.dir:${user.home}}")
    private String uploadDir;
    
    private String upDownloadDir;

    private String upResultDir;
    
    private String upBoard;
    
    private String upCustomerCenter;
    
    public FileService()
    {
    	File inputfile = new File("input");
    	File result = new File("result");
    	File userSign = new File("input"+File.separator + "userSign");
    	File board = new File("board");
    	File customerCenter = new File("customerCenter");
    	
    	if(!inputfile.exists())
    	{
    		inputfile.mkdir();
    	}
    	if(!result.exists())
    	{
    		result.mkdir();
    	}
    	if(!userSign.exists())
    	{
    		userSign.mkdir();
    	}
    	if(!board.exists())
    	{
    		board.mkdir();
    	}
    	
    	if(!customerCenter.exists())
    	{
    		customerCenter.mkdir();
    	}
    	
    	upDownloadDir=new File("input").getAbsolutePath();
    	upResultDir=new File("result").getAbsolutePath();
    	upBoard= new File("board").getAbsolutePath();
    	upCustomerCenter = new File("customerCenter").getAbsolutePath();
    	
    	System.out.println("다운로드 경로 : " + upDownloadDir+"\n완료된 계약서 경로 : "+upResultDir+"\n\n");
    }
    
    public String fileUpload(MultipartFile multipartFile, String user_sign_name) {
        // File.seperator 는 OS종속적이다.
        // Spring에서 제공하는 cleanPath()를 통해서 ../ 내부 점들에 대해서 사용을 억제한다
    	
    	//확장자
    	String extension = FilenameUtils.getExtension(multipartFile.getOriginalFilename());
    	
       // Path copyOfLocation = Paths.get(uploadDir + File.separator + StringUtils.cleanPath(multipartFile.getOriginalFilename()));
    	String serverFilename;
    	File target;
    	
    	//계약서 업로드
    	if(user_sign_name == null)
    	{
    		serverFilename =getRandomString()+"."+extension;
        
    		target = new File(upDownloadDir, serverFilename);
    	}
    	
    	//사용자 서명 이미지 업로드
    	else
    	{
    		
    		if(extension.length()>=1)
    			serverFilename =user_sign_name+"."+extension;
    		else
    			serverFilename=user_sign_name;
    		
    		
            
    		target = new File(upDownloadDir+File.separator + "userSign" , serverFilename);
    		
    	}
        
        try {
            // inputStream을 가져와서
            // copyOfLocation (저장위치)로 파일을 쓴다.
            // copy의 옵션은 기존에 존재하면 REPLACE(대체한다), 오버라이딩 한다
        	
            //Files.copy(multipartFile.getInputStream(), copyOfLocation, StandardCopyOption.REPLACE_EXISTING);
            
            multipartFile.transferTo(target);
           // System.out.println("저장 경로 베이스 : "+upDownloadDir+"\n" +"실제 저장 경로 : "+target.getPath()+"\n복사한 파일이름 : "+target.getName());
            
            
        } catch (IOException e) {
            e.printStackTrace();
            //throw new FileStorageException("Could not store file : " + multipartFile.getOriginalFilename());
        }
        
        //서버에 저장된 파일이름을 반환
        return serverFilename;

    }
    
	public void fileCustomerCenterUpload(MultipartFile multipartFile, String user_sign_name) {
		// File.seperator 는 OS종속적이다.
		// Spring에서 제공하는 cleanPath()를 통해서 ../ 내부 점들에 대해서 사용을 억제한다

		// 확장자
		//String extension = FilenameUtils.getExtension(multipartFile.getOriginalFilename());

		// Path copyOfLocation = Paths.get(uploadDir + File.separator +
		// StringUtils.cleanPath(multipartFile.getOriginalFilename()));
		//String serverFilename;
		File target;

		

		target = new File(upCustomerCenter, user_sign_name);
        
        try {
            // inputStream을 가져와서
            // copyOfLocation (저장위치)로 파일을 쓴다.
            // copy의 옵션은 기존에 존재하면 REPLACE(대체한다), 오버라이딩 한다
        	
            //Files.copy(multipartFile.getInputStream(), copyOfLocation, StandardCopyOption.REPLACE_EXISTING);
            
            multipartFile.transferTo(target);
           // System.out.println("저장 경로 베이스 : "+upDownloadDir+"\n" +"실제 저장 경로 : "+target.getPath()+"\n복사한 파일이름 : "+target.getName());
            
            
        } catch (IOException e) {
            e.printStackTrace();
            //throw new FileStorageException("Could not store file : " + multipartFile.getOriginalFilename());
        }
        
        //서버에 저장된 파일이름을 반환
       

    }
    
    public Resource loadFile(String server_fileName) throws FileNotFoundException {

        try {
        	Path copyOfLocation = Paths.get(upDownloadDir);
        	Path file = copyOfLocation.resolve(server_fileName).normalize();
            Resource resource = new UrlResource(file.toUri());

            if(resource.exists() || resource.isReadable()) {
                return resource;
            }else {
                throw new FileNotFoundException("Could not find file");
            }
        } catch (MalformedURLException e) {
            throw new FileNotFoundException("Could not download file");
        }

    }
    
    public void fileBoardUpload(MultipartFile multipartFile, String user_sign_name) {
		// File.seperator 는 OS종속적이다.
		// Spring에서 제공하는 cleanPath()를 통해서 ../ 내부 점들에 대해서 사용을 억제한다

		
		// Path copyOfLocation = Paths.get(uploadDir + File.separator +
		// StringUtils.cleanPath(multipartFile.getOriginalFilename()));
		File target;


		target = new File(upBoard, user_sign_name);
        
        try {
            // inputStream을 가져와서
            // copyOfLocation (저장위치)로 파일을 쓴다.
            // copy의 옵션은 기존에 존재하면 REPLACE(대체한다), 오버라이딩 한다
        	
            //Files.copy(multipartFile.getInputStream(), copyOfLocation, StandardCopyOption.REPLACE_EXISTING);
            
            multipartFile.transferTo(target);
           // System.out.println("저장 경로 베이스 : "+upDownloadDir+"\n" +"실제 저장 경로 : "+target.getPath()+"\n복사한 파일이름 : "+target.getName());
            
            
        } catch (IOException e) {
            e.printStackTrace();
            //throw new FileStorageException("Could not store file : " + multipartFile.getOriginalFilename());
        }
       

    }
    
    
    public String getUpBoard() {
		return upBoard;
	}

	public void setUpBoard(String upBoard) {
		this.upBoard = upBoard;
	}

	public String getUpCustomerCenter() {
		return upCustomerCenter;
	}

	public void setUpCustomerCenter(String upCustomerCenter) {
		this.upCustomerCenter = upCustomerCenter;
	}

	public void setUploadDir(String uploadDir) {
		this.uploadDir = uploadDir;
	}

	public String getUpResultDir() {
		return upResultDir;
	}

	public void setUpResultDir(String upResultDir) {
		this.upResultDir = upResultDir;
	}

	private final String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	public String getUploadDir() {
		return uploadDir;
	}

	public String getUpDownloadDir() {
		return upDownloadDir;
	}

	public void setUpDownloadDir(String upDownloadDir) {
		this.upDownloadDir = upDownloadDir;
	}

    
    
	/*
    //2차 파일 업로드 테스트
    private final Path dirLocation;

    @Autowired
    public FileService(FileUploadProperties fileUploadProperties) {
        this.dirLocation = Paths.get(fileUploadProperties.getLocation())
                .toAbsolutePath().normalize();
    }

    @PostConstruct
    public void init() {
        try {
            Files.createDirectories(this.dirLocation);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public Resource loadFile(String fileName) throws FileNotFoundException {

        try {
            Path file = this.dirLocation.resolve(fileName).normalize();
            Resource resource = new UrlResource(file.toUri());

            if(resource.exists() || resource.isReadable()) {
                return resource;
            }else {
                throw new FileNotFoundException("Could not find file");
            }
        } catch (MalformedURLException e) {
            throw new FileNotFoundException("Could not download file");
        }

    }
    
    public String saveFile(MultipartFile multipartFile) {

    	  String fileName = multipartFile.getOriginalFilename();
    	  Path location = this.dirLocation.resolve(fileName);
    	  try {
    	    /* 실제 파일이 upload 되는 부분 * /
    	    Files.copy(multipartFile.getInputStream(), location, StandardCopyOption.REPLACE_EXISTING);
    	  } catch (IOException e) {
    	  	e.printStackTrace();
    	  }

    	  return fileName;
    	}
    
    */
}
