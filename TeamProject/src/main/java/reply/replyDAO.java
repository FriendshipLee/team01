package reply;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class replyDAO extends DBManager{
	//쓰기
	//수정
	//삭제
	//조회
	
	//1. 쓰기
	public void write(replyVO vo) {
		driverLoad();
		DBConnect();
		
		String sql = "insert into reply(bno, rautor, content)";
		sql += "valuse('"+vo.getBno()+"', '"+vo.getRauthor()+"', '"+vo.getContent()+"');";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//2. 수정
	public int modify(replyVO vo) {
		driverLoad();
		DBConnect();
		
		String sql = "update reply set content='"+vo.getContent()+"', update_date = now() where rno = '"+vo.getRno()+"';";
		executeUpdate(sql);
		
		String selectSql = "select last_insert_id() as rno";
		executeQuery(selectSql);
		
		if(next()) {
			int rno = getInt("rno");
			DBDisConnect();
			return rno;
		}else {
			DBDisConnect();
			return 0;
		}	
	}
	
	//3. 삭제
	public void delete(String rno) {
		driverLoad();
		DBConnect();
		
		String sql = "delete from reply where rno = " + rno;
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//4. 조회
	public List<replyVO> select(String bno) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from reply where bno = " + bno;
		executeQuery(sql);
		
		List<replyVO> list = new ArrayList<>();
		
		while(next()) {
			replyVO vo = new replyVO();
			vo.setRauthor(getString("rauthor"));
			vo.setContent(getString("content"));
			vo.setCreateDate(getString("createDate"));
			vo.setCreateDate(getString("updateDate"));
			
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
	
}
