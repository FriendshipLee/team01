package resume;

import db.DBManager;

public class resumeDAO extends DBManager{
	
	//학력 추가
	public int addEducation(resumeVO vo) {
		String id = vo.getId();
		String school = vo.getSchool();
		String major = vo.getMajor();
		String graduation = vo.getGraduation_date();
		String enter = vo.getEnter_date();
		
		driverLoad();
		DBConnect();
		
		String sql = "update resume set school = '"+school+"', major = '"+major+"', graduation_date = '"+graduation+"', enter_date = '"+enter+"' where id = '"+id+"'";
		executeUpdate(sql);
		
		sql = "select count(*) as cnt from resume where id = '"+id+"'";
		executeQuery(sql);
		
		if(next()) {
			int eno = getInt("cnt");
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
		String enter = vo.getEnter_date();
		
		driverLoad();
		DBConnect();
		
		String sql = "update resume set school = '"+school+"', major = '"+major+"', graduation_date = '"+graduation+"', enter_date = '"+enter+"' where id = '"+id+"'";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//학력 삭제
	public void delete(String id) {
		driverLoad();
		DBConnect();
		String sql = "update resume set school = null, major = null, graduation_date = null, enter_date = null where id = '"+id+"'";
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
			String enter = getString("enter_date");
			
			resumeVO vo = new resumeVO();
			vo.setNo(eno);
			vo.setId(eid);
			vo.setSchool(school);
			vo.setMajor(major);
			vo.setGraduation_date(graduation);
			vo.setEnter_date(enter);
			DBDisConnect();
			return vo;
		}else {
			DBDisConnect();
			return null;
		}
		
	}
}
