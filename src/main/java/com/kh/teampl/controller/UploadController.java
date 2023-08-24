package com.kh.teampl.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.teampl.service.BoardService;
import com.kh.teampl.util.FileUploadUtil;


@RestController
@RequestMapping("/upload")
public class UploadController {
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@Resource(name = "productUploadPath")
	private String productUploadPath;
	
	@Autowired
	private BoardService boardService;
		
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST,	produces = "text/plain;charset=utf-8")
	public String uploadFile(MultipartFile file) {
		try {
			byte[] bytes = file.getBytes();
			String saveFilename = FileUploadUtil.upload(bytes, uploadPath, file.getOriginalFilename());
			return saveFilename;
		} catch (IOException e) {
			e.printStackTrace();
		} 
		return null;
	}
	
	@RequestMapping(value = "/displayImage", method = RequestMethod.GET)
	public byte[] displayImage(String filePath) {
//		System.out.println("filePath:" + filePath);
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(uploadPath + "/" + filePath);
			// org.apache.commons.io.IOUtils
			byte[] data = IOUtils.toByteArray(fis);
			return data;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@RequestMapping(value = "/deleteFile", method = RequestMethod.DELETE)
	public String deleteFile(@RequestBody String filename) {
		System.out.println("UploadController, filename : " + filename);
		FileUploadUtil.deleteFile(uploadPath, filename);
		boardService.deleteSingleAttach(filename);
		return "SUCCESS";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getImageList", method = RequestMethod.POST)
	public List<String> getImageList(int board_no) {
		return boardService.getImageList(board_no);
	}
	
}