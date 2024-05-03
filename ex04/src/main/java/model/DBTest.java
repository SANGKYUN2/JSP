package model;

public class DBTest {

	public static void main(String[] args) {
		//BBSDAOImpl dao = new BBSDAOImpl();
		//dao.list();
		//dao.read(2);
		//System.out.println("갯수............................." + dao.total());
		//dao.list(1, 3, "자바");
		//System.out.println("우래옥 갯수 : " + dao.total("우래옥"));
		CommentDAOImpl dao = new CommentDAOImpl();
		//dao.list(503, 1, 5);
		//System.out.println("503의 댓글수......" + dao.total(503));
		CommentVO vo = new CommentVO();
		vo.setBid(503);
		vo.setWriter("iu");
		vo.setContents("좋은날입니다.");
		dao.insert(vo);
	}

}
