package board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.service.BoardService;
import board.model.vo.Board;

/**
 * Servlet implementation class IndexBoardServlet
 */
@WebServlet("/member/indexAdminBoard")
public class IndexAdminBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Board> list = null;

		// 페이지당 표시할 목록을 가져와야함 
		response.setContentType("text/plain; charset=utf-8");
		PrintWriter out = response.getWriter();
		list = boardService.selectAdminBoardList(1, 10);
		for(int i=0; i<list.size(); i++) {
			Board b = list.get(i);
			b.setCommentCnt(boardService.selectCommentCnt(b.getBoardNo()));
			if(i!=list.size()-1) {
				out.println("<h4><a href='"+request.getContextPath()+"/board/adminBoardView?no="+b.getBoardNo()+"'>"+b.getTitle()+
						(b.getCommentCnt()!=0 ? " ("+b.getCommentCnt()+")" : "")+
						"</a></h4>");
			}else {
				out.print("<h4><a href='"+request.getContextPath()+"/board/adminBoardView?no="+b.getBoardNo()+"'>"+b.getTitle()+
						(b.getCommentCnt()!=0 ? " ("+b.getCommentCnt()+")" : "")+
						"</a></h4>");
			}
		}
	}
}
