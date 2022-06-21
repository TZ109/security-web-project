package com.cos.security1.thread;

import java.io.File;

import com.cos.security1.service.PaperFileService;

public class FileThread extends Thread{
	String title;
	String body;
	
	public FileThread(String title, String body) {
		
		this.title = title;
		this.body = body;
	}
	
	public FileThread ()
	{
		
	}
	
	@Override
	public void run()
	{
		PaperFileService.makeTextFile(title, body);
		
	}
}
