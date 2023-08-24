package com.kh.teampl.util;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

public class FileUploadUtil {

	public static String upload(byte[] bytes, String uploadPath, String originalFilename) {
		
		UUID uuid = UUID.randomUUID();
		String dirPath = makeDir(uploadPath);
		String filename = uuid + "_" + originalFilename;
		String saveFilename = uploadPath + "/" + dirPath + "/" + filename;
		File target = new File(saveFilename);
		
		try {
			FileCopyUtils.copy(bytes, target);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(isImage(filename)) {
			makeThumbnail(uploadPath, dirPath, filename);
		}
		 
		String filePath = saveFilename.substring(uploadPath.length());
		return filePath;
	}
	
	public static boolean isImage(String filename) {
		String formatName = getFormatName(filename);
		String uName = formatName.toUpperCase();
		if (uName.equals("JPG") || uName.equals("GIF") || uName.equals("PNG")) { 
			return true;
		} 
		return false;
	}
	
	private static String getFormatName(String filename) {
		int dotIndex = filename.lastIndexOf(".");
		String formatName = filename.substring(dotIndex + 1);
		return formatName;
	}
	
	private static void makeThumbnail(String uploadPath, String dirPath, String filename) {
		
		String sourcePath = uploadPath + "/" + dirPath + "/" + filename;
		String thumbnailPath = uploadPath + "/" + dirPath + "/s_" + filename;
		
		try {
			BufferedImage sourceImage = ImageIO.read(new File(sourcePath));
			BufferedImage destImage = Scalr.resize(sourceImage, Scalr.Method.AUTOMATIC,	Scalr.Mode.FIT_TO_HEIGHT, 100);
			
			File file = new File(thumbnailPath);
			String formatName = getFormatName(filename);
			ImageIO.write(destImage, formatName.toUpperCase(), file);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private static String makeDir(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int date = cal.get(Calendar.DAY_OF_MONTH);
		String dirPath = year + "/" + month + "/" + date; // -> 2023/7/21
		 
		File f = new File(uploadPath + "/" + dirPath);
		if (!f.exists()) {
			f.mkdirs();
		}
		return dirPath;
	}
	
	public static void deleteFile(String uploadPath, String filename) {
		
		boolean isImage = FileUploadUtil.isImage(filename);
		// filename이 이미지파일이면 썸네일과 함께 제거
		if (isImage) {
			int slashIndex = filename.lastIndexOf("/");
			String front = filename.substring(0, slashIndex + 1);
			String rear = filename.substring(slashIndex + 1);
			String thumbnail = front + "s_" + rear;
			File f = new File(uploadPath + thumbnail);
			if (f.exists()) {
				f.delete();
			}
		}
		File f = new File(uploadPath + filename);
		if (f.exists()) {
			f.delete();
		}
	}
}