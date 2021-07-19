package com.cos.security1.pdfimage;

import java.awt.Color;
import java.awt.*;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import com.cos.security1.entity.Article;

public class Imagetest {

	static boolean deleteFilesRecursively(File rootFile) {
		File[] allFiles = rootFile.listFiles();
		if (allFiles != null) {
			for (File file : allFiles) {
				deleteFilesRecursively(file);
			}
		}
		System.out.println("Remove file: " + rootFile.getPath());
		return rootFile.delete();

	}

	public static void makeSignPage(String input_path, Article article){
		PDFConverter pdfConverter = null;
		  try {
		   // 인원수 DB에서 받아오시고.
		   int n=article.getPeople_size();
		  
		   int max=0;
		   String FilePath = new File("input"+File.separator+article.getSer_fileName()).getAbsolutePath();
		   String destFolderPath;
		   File dest;
		 
		   dest = new File(article.getCreateDate().toString().replaceAll("[^0-9]",""));
		   if(!dest.exists())
		   {
			   dest.mkdirs();
		   }
		   destFolderPath = dest.getAbsolutePath();
		   
		   String resultPath = new File("result"+File.separator+article.getSer_fileName()).getAbsolutePath();
		 
		   
		   File file = new File(FilePath);
		   
		   if (!file.exists()) {
				throw new Exception("convertJPGFileToPDFFile : this path not exists. [" + file.getAbsolutePath() + "]");
			}
			
			String fileName = file.getName();
			System.out.println(fileName);
			if (fileName == null || fileName.length() == 0) {
				throw new Exception("convertJPGFileToPDFFile : fileName is null or empty. [" + file.getAbsolutePath() + "]");
			}
		   
		   String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
		   String fileNameOnly = null;
		   String imageFileName;
		   //pdf 일때.
		   if(ext.equals("pdf") == true) {
		   pdfConverter = new PDFConverter();
		   pdfConverter.convertPDFFileToJPGFile(FilePath,destFolderPath);
		   
			
			int dotIndex = fileName.lastIndexOf(".");
			if (dotIndex > -1) {
				fileNameOnly = fileName.substring(0, dotIndex);
			} else {
				fileNameOnly = fileName;
			}
			
			if (fileNameOnly.indexOf(".") > -1) {
				fileNameOnly = fileNameOnly.replace(".", "_");
			}
			
			imageFileName = article.getCreateDate().toString().replaceAll("[^0-9]","")+File.separator+fileNameOnly + "-" + 1 + ".jpg";
		   }
		   //jpg 일때 png는 아직 테스트 해보지 않음.
		   else {
			   imageFileName = FilePath;
		   }
			System.out.println(imageFileName);
			
		   	
		   Image[] imageit = new Image[4];
		   imageit[0] = ImageIO.read(new File(imageFileName));
		  
		   // 여기 for문으로 N 만큼 DB에서 받아오도록 수정.
		   System.out.println("사용자1의 서명 : "+input_path + File.separator +"userSign" +File.separatorChar+article.getPeople1_signname() + ".png");
		   imageit[1] = ImageIO.read(new File(input_path + File.separator +"userSign" +File.separatorChar+article.getPeople1_signname() + ".png"  ));
		   
		   if(n>=2)
			   imageit[2] = ImageIO.read(new File(input_path + File.separator + "userSign" +File.separatorChar+article.getPeople2_signname() + ".png" ));
		   
		   if(n==3)
			   imageit[3] = ImageIO.read(new File(input_path + File.separator + "userSign" +File.separatorChar+article.getPeople3_signname()+ ".png" ));

		   for(int i =1; i<=n;i++) {
			   int h = (int)(imageit[i].getWidth(null)*0.4);
			   int w = (int)(imageit[i].getHeight(null)*0.4);
			   imageit[i] = imageit[i].getScaledInstance(h, w, Image.SCALE_SMOOTH);
			   if(max < imageit[i].getHeight(null))
				   max = imageit[i].getHeight(null);
		   }
		   
		   int width = imageit[0].getWidth(null);
		   int height = imageit[0].getHeight(null);

		   BufferedImage mergedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		   Graphics2D graphics = (Graphics2D) mergedImage.getGraphics();

		   graphics.setBackground(Color.WHITE);
		   	       
	       
		   graphics.drawImage(imageit[0], 0, 0, null);
		   
		    //실제 글씨 쓰는곳
		  
	         
	         Font f1 = new Font("굴림", Font.PLAIN, 20);
	         graphics.setColor(Color.BLACK); 
	         graphics.setFont(f1);
	         graphics.drawString("전자서명 일련번호:"+article.getCreateDate().toString().replaceAll("[^0-9]",""),width*1/3,height-30);
		   
	         int temp_width = 128*imageit[0].getWidth(null)/793;

			   int temp_height = imageit[1].getHeight(null)*128*imageit[0].getHeight(null)/(imageit[1].getWidth(null)*1122);

			   System.out.println(temp_height);

			   switch(n) {

			   case 3:
				   graphics.drawImage(imageit[3], article.getSign3_xpos()*imageit[0].getWidth(null)/793, article.getSign3_ypos()*imageit[0].getHeight(null)/1122, temp_width, temp_height, null);

			   	   
			   case 2:
				   graphics.drawImage(imageit[2], article.getSign2_xpos()*imageit[0].getWidth(null)/793, article.getSign2_ypos()*imageit[0].getHeight(null)/1122, temp_width, temp_height, null);


			   case 1:
				  
				   graphics.drawImage(imageit[1], article.getSign1_xpos()*imageit[0].getWidth(null)/793, article.getSign1_ypos()*imageit[0].getHeight(null)/1122, temp_width, temp_height, null);

			   }
		   
		   
		   if(ext.equals("pdf")) {
			  
			  
			ImageIO.write(mergedImage, "jpg", new File(imageFileName));
			 // ImageIO.write(mergedImage, "jpg", new File("c:\\mergedImage.jpg"));
			 // ImageIO.write(mergedImage, "png", new File("c:\\mergedImage.png"));
			 System.out.println("이미지 합성이 완료되었습니다...");		   
		  
		 
		   pdfConverter.convertJPGFileToPDFFile(destFolderPath,resultPath);
		   
		   File rootDir = new File(destFolderPath);
	       deleteFilesRecursively(rootDir);
		   }
		   else {		   
		   String resultFileName = "result"+File.separator+fileName;
		   System.out.println(resultFileName);
		   ImageIO.write(mergedImage, "jpg", new File(resultFileName));
		   // ImageIO.write(mergedImage, "jpg", new File("c:\\mergedImage.jpg"));
		   // ImageIO.write(mergedImage, "png", new File("c:\\mergedImage.png"));
		   System.out.println("이미지 합성이 완료되었습니다...");
		   File rootDir = new File(destFolderPath);
	       deleteFilesRecursively(rootDir);
		   }
		  } catch (IOException ioe) {
		   ioe.printStackTrace();
		  } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		 
	}
	
}