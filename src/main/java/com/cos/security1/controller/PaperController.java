package com.cos.security1.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.cos.security1.service.DownloadService;
import com.cos.security1.service.PDFService;
import com.cos.security1.service.PaperFileService;
import com.cos.security1.service.PythonService;
import com.cos.security1.thread.FileThread;



//특허문서 요약
@Controller
public class PaperController {
	
	@Autowired
	PaperFileService fileService;
	@Autowired
	PDFService pdfService;
	@Autowired
	DownloadService downloadService;
	@Autowired
	PythonService pythonService;

	@RequestMapping(path = {"/paper"}, method = RequestMethod.GET)
	public String main()
	{
		return "main";
	}
	
	@ResponseBody
	@PostMapping(value = { "/pdf_upload" }, consumes = { "multipart/form-data" })
	public JSONObject upload(@RequestParam(value="file", required=true) MultipartFile file) throws IOException
	{
		String filename = file.getOriginalFilename();
		
		//사용자가 업로드한 파일 서버에 저장
		File result_file = fileService.MultipartFile_to_File(file);
		//pdf파일의 텍스트 추출
		String text = pdfService.getText_spire(result_file);
		//정규표현식으로 필요없는 띄어쓰기, 줄바꿈 제거
		text = text.replace(System.lineSeparator(), "");
		text = text.replaceAll("-\\s[0-9]+\\s-", "");
		text = text.replaceAll("\\[[0-9]+\\]", "");
		text = text.replace("                 ", "");
		text = text.replace(", ", ",");
		text = text.replace(". ", ".");
		text = text.replace(",", ", ");
		text = text.replace(".", ". ");
		
		String title = fileService.get_format_time()+filename.substring(0, filename.indexOf(".pdf"));
		
		//쓰레드 생성해서 파이썬에 전달해줄 텍스트 파일 만들기
		FileThread thread1 = new FileThread(title, text);
		
		thread1.start();
		try {
			//파일 만드는 동안 메인 쓰레드 대기
			thread1.join();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("쓰레드 종료 : ");
		
		File textfile = new File("python" + File.separator+title+".txt");
		
		
		//파이썬 실행, 요약 텍스트 받아옴
		text = pythonService.execApachePy(textfile);
		String firstbody = text.substring(0, text.indexOf('\n'));
		String mainbody = text.substring(text.indexOf('\n')+1);
		textfile.delete();
		
		
		//json형태로 리턴
		HashMap<String,String> mymap = new HashMap<String,String>();
		mymap.put("title", filename.substring(0, filename.indexOf(".pdf"))+"의 요약본");
		mymap.put("body", mainbody);
		mymap.put("firstbody", firstbody);
		JSONObject data = new JSONObject(mymap);
		

		return data;
	}
	
	//텍스트 입력
	@ResponseBody
	@GetMapping(value = { "/text_upload" })
	public JSONObject text_upload(String textbody) throws IOException
	{
		System.out.println(textbody);
		
		String title = fileService.get_format_time();
		
		//쓰레드 생성해서 파이썬에 전달해줄 텍스트 파일 만들기
		FileThread thread1 = new FileThread(title, textbody);
		
		thread1.start();
		try {
			//파일 만드는 동안 메인 쓰레드 대기
			thread1.join();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("쓰레드 종료 : "+textbody);
		
		File textfile = new File("python" + File.separator+title+".txt");
		
		
		//파이썬 실행, 요약 텍스트 받아옴
		String text = pythonService.execApachePy(textfile);
		String firstbody = text.substring(0, text.indexOf('\n'));
		String mainbody = text.substring(text.indexOf('\n')+1);
		textfile.delete();
		
		
		//json형태로 리턴
		HashMap<String,String> mymap = new HashMap<String,String>();
		mymap.put("title", "텍스트 요약본");
		mymap.put("body", mainbody);
		mymap.put("firstbody", firstbody);
		JSONObject data = new JSONObject(mymap);
		

		return data;
	}
	
	@PostMapping("/download")
	public void download(String title, String original, String body, HttpServletResponse response){
		//System.out.println("body : "+body);
		body = "1차요약\r\n"+original+"\r\n최종요약\r\n" + body;
		File file = fileService.makePDFFile(title, body);
		downloadService.downloadResult(title, body, response, file);
	}

}
