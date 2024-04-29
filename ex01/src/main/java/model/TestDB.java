package model;

public class TestDB {
	
	public static void main(String[] args) {
		UserDAO dao = new UserDAO();
		UserVO vo = dao.read("김상균");
		System.out.println(vo.toString());
	}

}
