package com.cos.security1.img;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.awt.image.ImageProducer;
import java.awt.image.RGBImageFilter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

public class RmBackgroundImg {
		public static void loadFile(String path) {
	
	    	ByteArrayOutputStream baos = new ByteArrayOutputStream();

	
	    	byte[] fileBuffer = null;
	
	    	Integer width = null;
	
	    	Integer height = null;
	
	
	
	    	try {
	
	    		File fnew=new File(path);
	
	
	    		String filename = fnew.getName();
	    		String extension = filename.substring(filename.lastIndexOf(".")+1);
	
	
	
	    		BufferedImage originalImage = ImageIO.read(fnew);
	
	
	
	    		width = originalImage.getWidth();
	
	    		height = originalImage.getHeight();
	
	    			/*
	    			for(int w=0; w< width; w++) {
	    				for(int h=0; h<height; h++) {
	    					if(originalImage.getRGB(w, h) == -1) {
	    						originalImage.setRGB(w, h, Color.TRANSLUCENT);
	    					} 
	    				}
	    			}
					*/
	    			//Image img = makeColorTransparent(originalImage,new Color(200,200,200),40);
	    			BufferedImage resultImage = imageToBufferedImageTransparency(originalImage, originalImage.getWidth(), originalImage.getHeight());
	
	    			for(int w=0; w< width; w++) {
	    				for(int h=0; h<height; h++) {
	    					if(resultImage.getRGB(w, h) == -1) {
	    						resultImage.setRGB(w, h, Color.TRANSLUCENT);
	    					} 
	    				}
	    			}
	    			
	    			ImageIO.write(resultImage, extension, fnew);
	    			//ImageIO.write(originalImage, extension, fnew);
	    			System.out.println(extension+"서명파일 누끼완료");
	

	
	    	}catch (IOException e) {
	
	    		System.err.println("Can't read input file! - " + path);
	
			}
	}
	
	
	
	private static BufferedImage imageToBufferedImageTransparency(Image image, int width, int height) {
	
			BufferedImage dest = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
	
			Graphics2D g2 = dest.createGraphics();
	
	
	
			g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
	
	        //g2.setRenderingHint(RenderingHints.KEY_DITHERING, RenderingHints.VALUE_DITHER_ENABLE);
	
	        //g2.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
	
	        //g2.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
	
	
	
			g2.drawImage(image, 0, 0, null);
	
			g2.dispose();
			
	
			return dest;
	
	}


	private static Image makeColorTransparent(final BufferedImage im, final Color color, int tolerance) {
	    int temp = 0;

	    if (tolerance < 0 || tolerance > 100) {

	        System.err.println("The tolerance is a percentage, so the value has to be between 0 and 100.");

	        temp = 0;

	    } else {

	        temp = tolerance * (0xFF000000 | 0xFF000000) / 100;

	    }

	    final int toleranceRGB = Math.abs(temp);
	    System.out.println("toleranceRGB : "+toleranceRGB);
	    System.out.println((color.getRGB()));
	    

	    final ImageFilter filter = new RGBImageFilter() {

	        // The color we are looking for (white)... Alpha bits are set to opaque

	        public int markerRGBFrom = (color.getRGB() | 0xFF000000) - toleranceRGB;

	        public int markerRGBTo = (color.getRGB() | 0xFF000000) + toleranceRGB;



	        public final int filterRGB(final int x, final int y, final int rgb) {
	            if ((rgb | 0xFF000000) >= markerRGBFrom && (rgb | 0xFF000000) <= markerRGBTo) {

	                // Mark the alpha bits as zero - transparent
	                return 0x00FFFFFF & rgb;

	            } else {

	                // Nothing to do

	                return rgb;

	            }

	        }

	    }; 

	    final ImageProducer ip = new FilteredImageSource(im.getSource(), filter);

	    return Toolkit.getDefaultToolkit().createImage(ip);
	}
}
