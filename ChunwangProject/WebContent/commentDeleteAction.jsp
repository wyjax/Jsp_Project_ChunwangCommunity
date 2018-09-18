<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.CommentDTO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.TimeZone"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String boardType = null;
	int commentID = 0;
	int writeID = 0;
	
	if(request.getParameter("boardType") != null) {
		boardType = request.getParameter("boardType");
	}
	if(request.getParameter("commentID") != null) {
		commentID = Integer.parseInt(request.getParameter("commentID"));
	}
	if(request.getParameter("writeID") != null) {
		writeID = Integer.parseInt(request.getParameter("writeID"));
	}
	
	if(boardType == null || commentID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('댓글 삭제 오류 입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}

	CommentDAO cmtdao = new CommentDAO();
	boolean result = cmtdao.Delete(boardType, commentID);

	if(result == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('댓글 삭제에 실패했습니다.')");
		script.println("location.href = \'" + boardType + ".jsp'");
		script.println("<script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'contentView.jsp?boardType=" + boardType + "&idx=" + writeID +"';");
		script.println("</script>");
		script.close();
		return;
	}
%>