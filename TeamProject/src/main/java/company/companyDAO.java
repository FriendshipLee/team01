package company;

import db.DBManager;
import company.companyVO;

import java.util.ArrayList;
import java.util.List;

public class companyDAO extends DBManager{
	//1.기업회원 회원가입
	public void join(companyVO vo) {
		String companyNumber = vo.getCompanyNumber();
		String pw = vo.getPw();
		String companyName = vo.getCompanyName();
		String ceoName = vo.getCeoName();
		String number = vo.getNumber();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into company(company_number, pw, company_name, ceo_name, number)";
		sql += "values('"+companyNumber+"', '"+pw+"', '"+companyName+"', '"+ceoName+"', '"+number+"');";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//2. 로그인
	//select * from user where id = '??' and pw = '??';
	public companyVO login(companyVO cvo) {
		String companyNumber = cvo.getCompanyNumber();
		String pw = cvo.getPw();
		
		driverLoad();
		DBConnect();
		
		String sql = "select * from company where";
		sql += " company_number = '"+companyNumber+"' and pw = '"+pw+"' and company_type != 99";
		executeQuery(sql);
		
		if(next()) {
			int companyType = getInt("company_type");
			
			companyVO vo = new companyVO();
			vo.setCompanyNumber(companyNumber);
			vo.setPw(pw);
			vo.setCompanyType(companyType);
		
			DBDisConnect();
			return vo;
		}else {
			DBDisConnect();
			return null;
		}
	}
		
	//3. 기업회원정보 수정
	//update user set pw = '?', nick = '?' where id = '?';
	public void modify(companyVO vo) {
		String pw = vo.getPw();
		String companyNumber = vo.getCompanyNumber();
		String companyName = vo.getCompanyName();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "update company set ";
		sql += "pw = '"+pw+"', company_name = '"+companyName+"', update_date = now() ";
		sql += "where company_number = '"+companyNumber+"'";
		executeUpdate(sql);
		DBDisConnect();
	}
	


	//4. 기업회원 탈퇴
	//update user set delete_date = now(), user_type = 2 where id = '?'
	public void delete(String companyNumber) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "update company set delete_date = now(), ";
		sql += "company_type = 1 where company_number = '"+companyNumber+"'";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//5. 기업회원 중복체크
	//select count(*) as cnt from user where id = '??';
	public int idCheck(String companyNumber) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "select count(*) as cnt from company where company_number = '"+companyNumber+"'";
		executeQuery(sql);
		
		if(next()) {
			int cnt = getInt("cnt");
			DBConnect();
			return cnt;
		}else {
			DBConnect();
			return 1;
		}
		
	}
	
	
	//6.회원 목록 조회
	//select * from user where user_type != 0;
	public List<companyVO> getAllUser(){
		//회원관리 페이지에서 조회하는 유저 목록
		driverLoad();
		DBConnect();
		
		String sql = "select * from company where company_type != 0";
		executeQuery(sql);
		
		List<companyVO> list = new ArrayList<>();
		while(next()){
			String companyNumber = getString("companyNumber");
			String companyName = getString("companyName");
			String ceoName = getString("ceoName");
			int companyType = getInt("company_type");
			
			companyVO vo = new companyVO();
			vo.setCompanyNumber(companyNumber);
			vo.setCompanyName(companyName);
			vo.setCeoName(ceoName);
			vo.setCompanyType(companyType);
			
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
	
	//사업자등록번호 중복체크
	public int companyNumberCheck(String companyNumber) {
		driverLoad();
		DBConnect();
		
		String sql="select count(*) as cnt from company where company_number = '"+companyNumber+"';";
		executeQuery(sql);
		
		if(next()) {
			int cnt = getInt("cnt");
			DBDisConnect();
			return cnt;
		}else {
			DBDisConnect();
			return 1;
		}
	}
	
	//담당자전화번호 중복체크
	public int numberCheck(String number) {
		driverLoad();
		DBConnect();
		
		String sql="select count(*) as cnt from company where number = '"+number+"';";
		executeQuery(sql);
		
		if(next()) {
			int cnt = getInt("cnt");
			DBDisConnect();
			return cnt;
		}else {
			DBDisConnect();
			return 1;
		}
	}
}
