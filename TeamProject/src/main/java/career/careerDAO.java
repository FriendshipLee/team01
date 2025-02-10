package career;

import db.DBManager;
import resume.resumeVO;
import career.careerVO;

import java.util.ArrayList;
import java.util.List;



public class careerDAO extends DBManager {
	//목록조회
	public List<resumeVO> select(String no) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from career where no = " + no;
		sql += " order by cno desc";
		executeQuery(sql);
		
		List<resumeVO> list = new ArrayList<>();
		
		while(next()) {
			String cno = getString("no");
			String id= getString("id");
			String school = getString("school");
			String major = getString("major");
			String graduation = getString("graduation_date");
			
			
			resumeVO vo = new resumeVO();
			vo.setNo(no);
			vo.setId(id);
			vo.setSchool(school);
			vo.setMajor(major);
			vo.setGraduation_date(graduation);
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
	
	//삭제
	public void delete(String cno) {
		driverLoad();
		DBConnect();
		
		String sql = "delete from career where cno = " + cno;
		executeUpdate(sql);
		
		DBDisConnect();
	}

	//수정
	public void modify(careerVO vo) {
		String cno = vo.getCno();
		String no = vo.getNo();
		String company = vo.getCompany();
		String careerDate = vo.getCareer_date();
		String work = vo.getWork();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "update career set company = '"+company+"', career_date = '"+careerDate+"', work = '"+work+"', ";
		sql += "update_date = now() ";
		sql += "where cno = " + cno;
		executeUpdate(sql);
		
		DBDisConnect(); 
	}
	
	//추가?!
	public void write(careerVO vo) {
		String no = vo.getNo();
		String company = vo.getCompany();
		String careerDate = vo.getCareer_date();
		String work = vo.getWork();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into career(no, company, career_date, work)";
		sql += "values('"+no+"', '"+company+"', '"+careerDate+"', '"+work+"')";
		executeUpdate(sql);
		
		DBDisConnect();
		
	}
}


	
	

