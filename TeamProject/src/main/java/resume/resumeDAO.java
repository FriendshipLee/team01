package resume;

import db.DBManager;

public class resumeDAO extends DBManager{
	
	//학력 추가
	public int addEducation(resumeVO vo) {
		String id = vo.getId();
		String school = vo.getSchool();
		String major = vo.getMajor();
		String graduation = vo.getGraduation_date();
		
		driverLoad();
		DBConnect();
		
		String sql = "update resume set school = '"+school+"', major = '"+major+"', graduation_date = '"+graduation+"' where id = '"+id+"'";
		executeUpdate(sql);
		
		sql = "select last_insert_id() as rno";
		executeQuery(sql);
		
		if(next()) {
			int eno = getInt("no");
			DBDisConnect();
			return eno;
		}else {
			DBDisConnect();
			return 0;
		}
	}
	
	//학력 수정
	public void modify(resumeVO vo) {
		String id = vo.getId();
		String school = vo.getSchool();
		String major = vo.getMajor();
		String graduation = vo.getGraduation_date();
		String eno = vo.getNo();
		
		driverLoad();
		DBConnect();
		
		String sql = "update resume set school = '"+school+"', major = '"+major+"', graduation = '"+graduation+"' where id = '"+id+"'";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//학력 삭제
	public void delete(String id) {
		driverLoad();
		DBConnect();
		
		String sql = "delete from resume where id = '"+id+"'";
		executeUpdate(sql);
	}
	
	//학력 조회
	public resumeVO select(String id) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from resume where id = '"+id+"'";
		executeQuery(sql);
		
		if(next()) {
			String eno = getString("no");
			String eid = getString("id");
			String school = getString("school");
			String major = getString("major");
			String graduation = getString("graduation_date");
			
			resumeVO vo = new resumeVO();
			vo.setNo(eno);
			vo.setId(eid);
			vo.setSchool(school);
			vo.setMajor(major);
			vo.setGraduation_date(graduation);
			DBDisConnect();
			return vo;
		}else {
			DBDisConnect();
			return null;
		}
		
	}
}
