package com.fithe.common;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

public class FileUploadUtil {
	
	private String imgfilePaths;
	private int imgfileSize; 
	private String encodeType;	
	private MultipartRequest mr;;

	public FileUploadUtil() {
		this.imgfilePaths = CommonUtils.IMG_UPLOAD_PATH;
		this.imgfileSize = CommonUtils.IMG_FILE_SIZE;
		this.encodeType = CommonUtils.EN_CODE;			
	}
	
	public boolean imgfileUpload(HttpServletRequest req) {	
		System.out.println("imgfileUploadSize req >>> : " + req);
		System.out.println("imgfileUploadSize imgfilePaths >>> : " + imgfilePaths);
		String root = req.getSession().getServletContext().getRealPath("/");
		boolean bool = imgfileUpload(req, root + imgfilePaths);
		
		return bool;
	}
	
	public boolean imgfileDelete(HttpServletRequest req, String fileName) {
		String root = req.getSession().getServletContext().getRealPath("/");
		boolean bool = imgfileDelete(root + imgfilePaths, fileName);
		return bool;
	}
	public boolean imgfileUpload(HttpServletRequest req, String filePath) {
		boolean bool = false;
		try {
			mr = new MultipartRequest(req, filePath, imgfileSize, encodeType, new FileRename());
			System.out.println("mr >>> : " + mr);
			System.out.println("mr.getOriginalFileName(\"nfile\") >>> : " + mr.getOriginalFileName("nfile"));
			System.out.println("mr.getFilesystemName(\"nfile\") >>> : " + mr.getFilesystemName("nfile"));
			
			////////////////////////////////////////////////////
			System.out.println("파일이름? >>> : " + mr.getFileNames());
//			System.out.println("" + mr.);
//			ThumnailImg.thumnailFun(filePath, mr.getFilesystemName("nfile"));	
			bool=true;						
		}catch(Exception e) {
			System.out.println("imgfileUploadUtil.imgfileUpload() >>> : " + e);			
		}		
		return bool;
	}
	
	public String getParameter(String s){
		System.out.println("s >> : " + s);
		return mr.getParameter(s);
	}
	
	public String getFileName(String f){
		return mr.getFilesystemName(f);
	}
	
	public static boolean imgfileDelete(String filePath, String fileName) {
		boolean result = false;
		File fileDelete = new File(filePath+"/"+fileName);
		
		if(fileDelete.exists() && fileDelete.isFile()){
			result = fileDelete.delete();
		}
		System.out.println("파일 삭제 여부 >>> : " + result);
		return result;
	}
	
	public ArrayList<String> getFileNames(){
		@SuppressWarnings("unchecked")
		Enumeration<String> en = mr.getFileNames();
		ArrayList<String> a = new ArrayList<String>();
		
		while (en.hasMoreElements()){
			String f = en.nextElement().toString();
			a.add(mr.getFilesystemName(f));
		}		
		return a;
	}
	
	public static String nullOrEmptyToReplaceString(String str, String replaceStr) {
		if (str == null || "".equals(str)) {
			return replaceStr;
		}
		return "samplename";
	}
	
}
