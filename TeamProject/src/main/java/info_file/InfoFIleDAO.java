package info_file;

import java.util.List;

import db.DBManager;

public class InfoFIleDAO extends DBManager {
	
	public void upload(List<infoFileVO> fileList) {
		driverLoad();
		DBConnect();
		
		if(fileList.size() == 0) {
			DBDisConnect();
			return;
		}
		
		for(int i = 0; i < fileList.size(); i ++) {
			String no = fileList.get(i).getNo();
			String attachOriginName = fileList.get(i).getAttachOriginName();
			String attachLocation = fileList.get(i).getAttachLocation();
			String attachUploadName = fileList.get(i).getAttachUploadName();
			int fileSize = fileList.get(i).getFileSize();
			
			String sql = "insert into info_file(bno, attach_origin_name, attach_upload_name, attach_location, file_size)";
			sql += "values("+no+", '"+ attachOriginName +"', '"+attachUploadName+"', '"+attachLocation+"', "+fileSize+")";
			executeUpdate(sql);
		}
		
		DBDisConnect();
	}
	
}
