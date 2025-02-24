package resume_file;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class resumeFileDAO extends DBManager{
	
	//첨부파일 업로드
	//여러개의 첨부파일이 업로드 될 때 각 첨부파일이 가지고있는 pk(fno)를 반환하기 위해 
	//메서드의 반환타입을 정수형 배열로 선언
	public int[] upload(List<resumeFileVO> fileList) {
		driverLoad();
		DBConnect();
		
		if(fileList.size() == 0) {
			DBDisConnect();
			return null;
		}
		
		int[] fnoList = new int[fileList.size()];
		//업로드된 파일의 fno를 저장하는 배열
		//업로드된 파일의 개수와 업로드 되고난 뒤 반환되는 fno 개수는 동일
		
		for(int i = 0; i < fileList.size(); i++) {
			String no = fileList.get(i).getRno();
			String originName = fileList.get(i).getAttachOriginName();
			String uploadName = fileList.get(i).getAttachUploadName();
			String location = fileList.get(i).getAttachLocation();
			long fileSize = fileList.get(i).getFileSize();
			
			String sql = "insert into resume_file(rno, attach_origin_name, attach_upload_name, attach_location, file_size) ";
			sql += "values("+no+", '"+originName+"', '"+uploadName+"', '"+location+"', "+fileSize+")";
			executeUpdate(sql);
			
			//resume_file에 인서트된 파일의 pk(fno)를 조회
			sql = "select last_insert_id() as fno";
			executeQuery(sql);
			
			if(next()) {
				int fno = getInt("fno");
				fnoList[i] = fno;
				//fnoList 배열에 순서대로 저장
			}else {
				fnoList[i] = 0;
			}
		}
		DBDisConnect();
		
		return fnoList;
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
			vo.setFno(getString("fno"));
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
	public void delete(String fno) {
		driverLoad();
		DBConnect();
		
		String sql = "delete from resume_file where fno = "+fno+"";
		executeUpdate(sql);
		
		DBDisConnect();
	}
}
