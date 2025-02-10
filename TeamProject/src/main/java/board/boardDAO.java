package board;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class boardDAO extends DBManager{
	
	//글작성
	public int write(boardVO vo) {
		
		String author = vo.getAuthor();
		String title = vo.getTitle();
		String content = vo.getContent();
		int boardType = vo.getBoardType();
		
		driverLoad();
		DBConnect();
		
		String sql = "insert into board(author, title, content, board_type) ";
		sql += "values('"+author+"', '"+title+"', '"+content+"', "+boardType+" )";
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
	public void modify(boardVO vo) {
		
		String title = vo.getTitle();
		String content = vo.getContent();
		String no = vo.getNo();
		
		driverLoad();
		DBConnect();
		
		String sql = "update board set title = '"+title+"', content = '"+content+"', ";
		sql += "update_date = now() where no = "+no+" ";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//글삭제
	public void delete(String no) {
		driverLoad();
		DBConnect();
		
		String sql = "update board set board_type = 99 where no = " + no;
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//글목록보기
	public List<boardVO> boardList(int boardType){
		List<boardVO> list = new ArrayList<boardVO>();
		
		driverLoad();
		DBConnect();
		
		String sql = "select * from board where board_type != 99 and board_type = "+boardType+" ";
		executeQuery(sql);
		
		while(next()) {
			boardVO vo = new boardVO();
			vo.setNo(getString("no"));
			vo.setAuthor(getString("author"));
			vo.setTitle(getString("title"));
			vo.setContent(getString("content"));
			vo.setBoardType(getInt("board_type"));
			vo.setCreateDate(getString("create_date"));
			vo.setUpdateDate(getString("update_date"));
			vo.setDeleteDate(getString("deleteDate"));
			list.add(vo);
		}
		
		DBDisConnect();
		
		return list;
	}
	
	//상세조회
	public boardVO view(String no) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from board where board_type != 99 and no = " + no;
		executeQuery(sql);
		
		boardVO vo = new boardVO();
		if(next()) {
			vo.setNo(getString("no"));
			vo.setAuthor(getString("author"));
			vo.setTitle(getString("title"));
			vo.setContent(getString("content"));
			vo.setBoardType(getInt("board_type"));
			vo.setCreateDate(getString("create_date"));
			vo.setUpdateDate(getString("update_date"));
			vo.setDeleteDate(getString("deleteDate"));
			DBDisConnect();
			return vo;
		}else {
			DBDisConnect();
			return null;
		}
	}
}
