package controller;

import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;


@WebServlet(value= {"/user/login", "/user/logout", "/user/mypage", "/user/join"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO dao = new UserDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/user/login" : //로그인
			request.setAttribute("pageName", "/user/login.jsp");
			System.out.println("로그인");
			dis.forward(request, response);
			break;
		case "/user/logout" : //로그아웃
			HttpSession session = request.getSession();
			session.invalidate();
			System.out.println("로그아웃");
			response.sendRedirect("/");
			break;
		case "/user/mypage" :
			break;
		case "/user/join" :
			break;
			
		}

	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/user/login" :
			String uid = request.getParameter("uid");
			String upass = request.getParameter("upass");
			System.out.println(uid + ":" + upass);

			int result = 0;
			UserVO vo = dao.read(uid);
			if(vo.getUid() != null) { //성공한경우
				if(upass.equals(vo.getUpass())) {
					HttpSession session = request.getSession();
					session.setAttribute("uid", uid);
					result = 1;
				}
				else {
					result = 2;
				}
			}
			out.print(result);
			break;
		}
	}
	
}
