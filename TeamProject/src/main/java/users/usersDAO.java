package users;

import java.util.ArrayList;
import java.util.List;

import career.careerVO;
import db.DBManager;
import resume.resumeVO;

public class usersDAO extends DBManager{
	//회원가입
	//로그인
	//회원수정
	//회원탈퇴
	//아이디, 이메일, 닉네임 중복체크
	//회원목록조회
	
	//회원가입
	public void join(usersVO vo) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into users(id, pw, nick, email, name, birth, gender, number)";
		sql += "values('"+vo.getId()+"', '"+vo.getPw()+"', '"+vo.getNick()+"', '"+vo.getEmail()+"', '"+vo.getName()+"', '"+vo.getBirth()+"', '"+vo.getGender()+"', '"+vo.getNumber()+"');";
		System.out.println(sql);
		executeUpdate(sql);
		
		String insertSql = "insert into resume(id)values('"+vo.getId()+"');";
		System.out.println(insertSql);
		executeUpdate(insertSql);
		
		DBDisConnect();
	}
	
	//로그인
	public usersVO login(usersVO uvo) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from users where ";
		sql += "id='"+uvo.getId()+"' and pw='"+uvo.getPw()+"' and user_type!=99;";
		executeQuery(sql);
		
		if(next()) {
			usersVO vo = new usersVO();
			vo.setId(getString("id"));
			vo.setId(getString("pw"));
			vo.setId(getString("nick"));
			vo.setId(getString("email"));
			vo.setId(getString("name"));
			vo.setId(getString("birth"));
			vo.setId(getString("gender"));
			vo.setId(getString("number"));
			
			DBDisConnect();
			return vo;
		}else {
			DBDisConnect();
			return null;
		}
	}
	
	//회원수정
	public void modify(usersVO vo) {
		driverLoad();
		DBConnect();
		
		String sql = "update users set ";
		sql += "pw='"+vo.getPw()+"', update_date = now() ";
		sql += "where id = '"+vo.getId()+"'";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//회원탈퇴
	public void delete(String id) {
		driverLoad();
		DBConnect();
		
		String sql="update users set user_type = 99 where id = '"+id+"'";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//아이디 중복체크 -> 이메일, 닉네임 한번에 하는 방법 없는지 물어볼것
	public int idCheck(String id) {
		driverLoad();
		DBConnect();
		
		String sql="select count(*) as cnt from users where id = '"+id+"';";
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
	
	//이메일 중복체크
	public int emailCheck(String email) {
		driverLoad();
		DBConnect();
		
		String sql="select count(*) as cnt from users where email = '"+email+"';";
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
	
	//닉네임 중복체크
	public int nickCheck(String nick) {
		driverLoad();
		DBConnect();
		
		String sql="select count(*) as cnt from users where nick = '"+nick+"';";
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
	
	//전화번호 중복체크
	public int numberCheck(String number) {
		driverLoad();
		DBConnect();
		
		String sql="select count(*) as cnt from users where number = '"+number+"';";
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
	
	//회원목록조회
	public List<usersVO> getAllUser() {
		driverLoad();
		DBConnect();
		
		String sql="";
		executeQuery(sql);
		
		List<usersVO> list = new ArrayList<>();
		
		while(next()) {
			usersVO vo = new usersVO();
			vo.setId(getString("id"));
			vo.setPw(getString("pw"));
			vo.setId(getString("nick"));
			vo.setId(getString("email"));
			vo.setId(getString("name"));
			vo.setId(getString("birth"));
			vo.setId(getString("gender"));
			vo.setId(getString("number"));
			
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
}
