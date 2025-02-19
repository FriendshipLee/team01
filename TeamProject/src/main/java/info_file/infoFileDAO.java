package info_file;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;
import resume_file.resumeFileVO;

public class infoFileDAO extends DBManager {
	
	
	public void upload(List<infoFileVO> fileList) {
		driverLoad();
		DBConnect();
		
		if(fileList.size() == 0) {
			DBDisConnect();
			return;
		}
		
		for(int i = 0; i < fileList.size(); i ++) {
			String fno = fileList.get(i).getFno();
			String attachOriginName = fileList.get(i).getAttachOriginName();
			String attachLocation = fileList.get(i).getAttachLocation();
			String attachUploadName = fileList.get(i).getAttachUploadName();
			long fileSize = fileList.get(i).getFileSize();
			
			String sql = "insert into info_file(bno, attach_origin_name, attach_upload_name, attach_location, file_size)";
			sql += "values("+fno+", '"+ attachOriginName +"', '"+attachUploadName+"', '"+attachLocation+"', "+fileSize+")";
			executeUpdate(sql);
		}
		
		DBDisConnect();
	}
	
	public List<infoFileVO> list(String bno){
		List<infoFileVO> list = new ArrayList<infoFileVO>();
		driverLoad();
		DBConnect();
		
		String sql = "select * from info_file where bno = " + bno;
		executeQuery(sql);
		
		while(next()) {
			infoFileVO vo = new infoFileVO();
			vo.setFno(getString("fno"));
			vo.setBno(getString("bno"));
			vo.setAttachOriginName(getString("attach_origin_name"));
			vo.setAttachUploadName(getString("attach_upload_name"));
			vo.setAttachLocation(getString("attach_location"));
			vo.setFileSize(getInt("file_size"));
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
	
	public void delete(String fno) {
		driverLoad();
		DBConnect();
		
		String sql = "delete from info_file where fno = "+fno+"";
		executeUpdate(sql);
		
		DBDisConnect();
	}
}
