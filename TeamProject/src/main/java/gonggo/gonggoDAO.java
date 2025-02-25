package gonggo;

import java.util.ArrayList;
import java.util.List;

import board.boardVO;
import db.DBManager;

public class gonggoDAO extends DBManager{
	
	//글작성
	public int write(gonggoVO vo) {
		String title = vo.getTitle();
		String content = vo.getContent();
		String author = vo.getAuthor();
		String career = vo.getCareer();
		String education = vo.getEducation();
		String location = vo.getLocation();
		String deadline = vo.getDeadline();
		String link = vo.getLink();
		
		driverLoad();
		DBConnect();
		
		String sql="insert into gonggo(title, content, author, career, education, location, deadline, link)";
		sql+="values('"+title+"', '"+content+"', '"+author+"', "+career+", "+education+", '"+location+"', '"+deadline+"', '"+link+"')";
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
	
	//글수정
	public void modify(gonggoVO vo) {
			
		String title = vo.getTitle();
		String content = vo.getContent();
		String no = vo.getNo();
		String career = vo.getCareer();
		String education = vo.getEducation();
		String location = vo.getLocation();
		String deadline = vo.getDeadline();
		String link = vo.getLink();
		
		driverLoad();
		DBConnect();
		
		String sql = "update gonggo set title = '"+title+"', content = '"+content+"', career = "+career+", education = "+education+", location = '"+location+"', deadline = '"+deadline+"', link = '"+link+"', ";
		sql += "update_date = now() where no = "+no+" ";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//글삭제
	public void delete(String no) {
		
		driverLoad();
		DBConnect();
		
		String sql = "update gonggo set gonggo_type = 99 where no = " + no;
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//글목록 조회
	public List<gonggoVO> gonggoList(String searchType, String keyword, int startNum, int limitSize, String listArray){
		//List<gonggoVO> list = new ArrayList<gonggoVO>();
		
		driverLoad();
		DBConnect();
		
		String sql = "select *, if(deadline >= date(now()), '채용중', '접수마감') as due ";
		sql += "from gonggo left join company on gonggo.author = company.company_number where gonggo_type != 99";
		if(searchType != null && keyword != null && !searchType.equals("") && !keyword.equals("")) {
			sql += " and "+searchType+" like '%"+keyword+"%'";
		}
		sql += " order by no " + listArray;
		
		sql += " limit " + startNum +", " + limitSize;
		executeQuery(sql);
		System.out.println(sql);
		
		List<gonggoVO> list = new ArrayList<>();
		
		while(next()) {
			gonggoVO vo2 = new gonggoVO();
			vo2.setNo(getString("no"));
			vo2.setTitle(getString("title"));
			vo2.setContent(getString("content"));
			vo2.setAuthor(getString("author"));
			vo2.setCareer(getString("career"));
			vo2.setEducation(getString("education"));
			vo2.setLocation(getString("location"));
			vo2.setDeadline(getString("deadline"));
			vo2.setLink(getString("link"));
			vo2.setCreateDate(getString("create_date"));
			vo2.setUpdateDate(getString("update_date"));
			vo2.setGonggoType(getInt("gonggo_type"));
			vo2.setDue(getString("due"));
			vo2.setCompayName(getString("company_name"));
			list.add(vo2);
		}
		
		DBDisConnect();
		return list;
	}
	
	//글 상세조회
	public gonggoVO view(String no) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from gonggo left join company on gonggo.author = company.company_number where no = " + no;
		executeQuery(sql);
		
		gonggoVO vo = new gonggoVO();
		if(next()) {
			vo.setNo(getString("no"));
			vo.setTitle(getString("title"));
			vo.setContent(getString("content"));
			vo.setAuthor(getString("author"));
			vo.setCompayName(getString("company_name"));
			vo.setCareer(getString("career"));
			vo.setEducation(getString("education"));
			vo.setLocation(getString("location"));
			vo.setDeadline(getString("deadline"));
			vo.setLink(getString("link"));
			vo.setCreateDate(getString("create_date"));
			vo.setUpdateDate(getString("update_date"));
			vo.setGonggoType(getInt("gonggo_type"));
			DBDisConnect();
			return vo;
		}else {
			DBDisConnect();
			return null;
		}
	}
	
	/*
	 * //글 목록조회 public List<gonggoVO> gonggoList(){ List<gonggoVO> list = new
	 * ArrayList<gonggoVO>();
	 * 
	 * driverLoad(); DBConnect();
	 * 
	 * String sql = "select * from board where gonggo_type != 99 order by no desc";
	 * executeQuery(sql);
	 * 
	 * while(next()) { gonggoVO vo = new gonggoVO(); vo.setNo(getString("no"));
	 * vo.setAuthor(getString("author")); vo.setTitle(getString("title"));
	 * vo.setContent(getString("content"));
	 * vo.setCreateDate(getString("create_date"));
	 * vo.setUpdateDate(getString("update_date"));
	 * vo.setDeleteDate(getString("delete_date")); list.add(vo); }
	 * 
	 * DBDisConnect();
	 * 
	 * return list; }
	 */
	
	//게시글 갯수 조회
	public int getCount(String searchType, String keyword) {
		driverLoad();
		DBConnect();
		
		String sql = " select count(*) as cnt ";
		sql += "from gonggo left join company on gonggo.author = company.company_number where gonggo_type != 99";
		if(searchType != null && keyword != null && !searchType.equals("") && !keyword.equals("")) {
			sql += " and " + searchType + " like '%" + keyword + "%'";
		}
		System.out.println(sql);
		executeQuery(sql);
		
		if(next()) {
			int count = getInt("cnt");
			DBDisConnect();
			return count;
		}else {
			DBDisConnect();
			return 0;
		}
	}
}