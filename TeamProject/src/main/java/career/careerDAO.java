package career;

import db.DBManager;
import resume.resumeVO;
import career.careerVO;

import java.util.ArrayList;
import java.util.List;



public class careerDAO extends DBManager {
	//목록조회
	public List<careerVO> select(String no) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from career where no = " + no;
		sql += " order by cno desc";
		executeQuery(sql);
		
		List<careerVO> list = new ArrayList<>();
		
		while(next()) {
			String company = getString("company");
			String careerStartDate = getString("career_start_date");
			String careerEndDate = getString("career_end_date");
			String work = getString("work");
			String cno = getString("cno");
			
			careerVO vo = new careerVO();
			vo.setCno(cno);
			vo.setCompany(company);
			vo.setCareer_start_date(careerStartDate);
			vo.setCareer_end_date(careerEndDate);
			vo.setWork(work);
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
		String careerStartDate = vo.getCareer_start_date();
		String careerEndDate = vo.getCareer_end_date();
		String work = vo.getWork();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "update career set company = '"+company+"', career_start_date = '"+careerStartDate+"', work = '"+work+"', career_end_date = '"+careerEndDate+"' ";
		sql += "update_date = now() ";
		sql += "where cno = "+cno+" and no = "+no+"";
		executeUpdate(sql);
		
		DBDisConnect(); 
	}
	
	//추가?!
	public int write(careerVO vo) {
		String no = vo.getNo();
		String company = vo.getCompany();
		String careerStartDate = vo.getCareer_start_date();
		String work = vo.getWork();
		String careerEndDate = vo.getCareer_end_date();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into career(no, company, career_start_date, work, career_end_date)";
		sql += "values('"+no+"', '"+company+"', '"+careerStartDate+"', '"+work+"', '"+careerEndDate+"')";
		executeUpdate(sql);
		
		sql = "select last_insert_id() as cno";
		executeQuery(sql);
		
		if(next()) {
			int cno = getInt("cno");
			DBDisConnect();
			return cno;
		}else {
			DBDisConnect();
			return 0;
		}
	}
}


	
	

