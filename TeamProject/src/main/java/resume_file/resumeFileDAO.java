package resume_file;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class resumeFileDAO extends DBManager{
	
	//첨부파일 업로드
	public int upload(resumeFileVO vo) {
		String rno = vo.getRno();
		String originName = vo.getAttachOriginName();
		String uploadName = vo.getAttachUploadName();
		String location = vo.getAttachLocation();
		long fileSize = vo.getFileSize();
		
		driverLoad();
		DBConnect();
		
		String sql = "insert into resume_file(rno, attach_origin_name, attach_upload_name, attach_location, file_size) ";
		sql += "values("+rno+", '"+originName+"', '"+uploadName+"', '"+location+"', "+fileSize+")";
		executeUpdate(sql);
		
		sql = "select last_insert_id() as no";
		executeQuery(sql);
		
		if(next()) {
			int no = getInt("no");
			DBDisConnect();
			return no;
		}else {
			DBDisConnect();
			return 0;
		}
	}
	
	//첨부파일 수정
	public void modify(resumeFileVO vo) {
		String rno = vo.getRno();
		String originName = vo.getAttachOriginName();
		String uploadName = vo.getAttachUploadName();
		String location = vo.getAttachLocation();
		long fileSize = vo.getFileSize();
		
		driverLoad();
		DBConnect();
		
		String sql = "update resume_file set attach_origin_name = '"+originName+"', attach_upload_name = '"+uploadName+"', attach_location = '"+location+"', file_size = "+fileSize+" ";
		sql += "where rno = " + rno;
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//첨부파일 목록조회
	public List<resumeFileVO> list(String rno){
		List<resumeFileVO> list = new ArrayList<resumeFileVO>();
		
		driverLoad();
		DBConnect();
		
		String sql = "select * from resume_file where rno =" + rno;
		executeQuery(sql);
		
		while(next()) {
			resumeFileVO vo = new resumeFileVO();
			vo.setRno(getString("rno"));
			vo.setAttachOriginName(getString("attach_origin_name"));
			vo.setAttachUploadName(getString("attach_upload_name"));
			vo.setAttachLocation(getString("attach_location"));
			vo.setFileSize(getInt("file_size"));
			list.add(vo);
		}
		
		DBDisConnect();
		return list;
	}
	
	//첨부파일 삭제
	public void delete(resumeFileVO vo) {
		String rno = vo.getRno();
		driverLoad();
		DBConnect();
		
		String sql = "delete from resume_file where rno = " + rno;
		executeUpdate(sql);
		
		DBDisConnect();
	}
}
