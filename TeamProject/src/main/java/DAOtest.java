import board.boardDAO;
import board.boardVO;

public class DAOtest {

	public static void main(String[] args) {
		boardDAO dao = new boardDAO();
		boardVO vo = new boardVO();
		
//		vo.setTitle("제목");
//		vo.setContent("본문");
//		vo.setNo("2");
		
		dao.delete("2");
	}

}
