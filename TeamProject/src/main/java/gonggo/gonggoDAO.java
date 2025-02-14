package gonggo;

import java.util.ArrayList;
import java.util.List;

import board.boardVO;
import db.DBManager;

public class gonggoDAO extends DBManager{
	
	//글작성
	public void write(gonggoVO vo) {
		String title = vo.getTitle();
		String content = vo.getContent();
		String author = vo.getAuthor();
		String career = vo.getCareer();
		String education = vo.getEducation();
		String location = vo.getLocation();
		String deadline = vo.getDeadline();
		String link = vo.getLink();
		int gonggoType = vo.getGonggo_type();
				
		
		driverLoad();
		DBConnect();
		
		String sql="insert gonggo into(title, content, author, career, education, location, deadline, link, gonggo_type)";
		sql+="values('"+title+"', '"+content+"', '"+author+"', "+career+", "+education+", '"+location+"', '"+deadline+"', '"+link+"', "+gonggoType+")";
		executeUpdate(sql);
		
		DBDisConnect();
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
		
		String sql = "update gonggo set title = '"+title+"', content = '"+content+"', career = "+career+", education = "+education+", location = '"+location+"', deadline = '"+deadline+"', link = '"+link+"' ;";
		sql += "update_date = now() where no = "+no+" ";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//글삭제
	public void delete(gonggoVO vo) {
		String no = vo.getNo();
		
		driverLoad();
		DBConnect();
		
		String sql = "update gonggo set gonggo_type = 99 where no = " + no;
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//글목록 조회
	public List<gonggoVO> gonggoList(gonggoVO vo){
		List<gonggoVO> list = new ArrayList<gonggoVO>();
		
		driverLoad();
		DBConnect();
		
		String sql = "select * from gonggo where gonggo_type != 99";
		executeQuery(sql);
		
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
			vo2.setCreate_date(getString("create_date"));
			vo2.setUpdate_date(getString("update_date"));
			vo2.setGonggo_type(getInt("gonggo_type"));
			list.add(vo2);
		}
		
		DBDisConnect();
		
		return list;
	}
	
	//글 상세조회
	public gonggoVO view(String no) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from gonggo where no = " + no;
		executeQuery(sql);
		
		gonggoVO vo = new gonggoVO();
		if(next()) {
			vo.setNo(getString("no"));
			vo.setTitle(getString("title"));
			vo.setContent(getString("content"));
			vo.setAuthor(getString("author"));
			vo.setCareer(getString("career"));
			vo.setEducation(getString("education"));
			vo.setLocation(getString("location"));
			vo.setDeadline(getString("deadline"));
			vo.setLink(getString("link"));
			vo.setCreate_date(getString("create_date"));
			vo.setUpdate_date(getString("update_date"));
			vo.setGonggo_type(getInt("gonggo_type"));
			DBDisConnect();
			return vo;
		}else {
			DBDisConnect();
			return null;
		}
	}
	
	
	
}
