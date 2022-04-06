<%-- 
    Document   : delete_video
    Created on : 26 Feb, 2022, 2:38:08 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.util.Date;" pageEncoding="UTF-8"%>
<%
    String email = null;
            Cookie c[] = request.getCookies();
            for(int i=0;i<c.length;i++){
                if(c[i].getName().equals("user")){
                    email = c[i].getValue();
                    break;
                }
            }
            if(email==null){
                response.sendRedirect("index.jsp");
            }
            else{ 
                if(request.getParameter("ccode")==null && request.getParameter("vcode")==null){
                    response.sendRedirect("dashboard.jsp?delete_video_code_error=1");
                }
                else{
                    String channel_code = request.getParameter("ccode") ;
                    String vcode = request.getParameter("vcode") ;
                    String status = "1";
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                        PreparedStatement ps = cn.prepareStatement("update video set status=? where code=?");
                        ps.setString(1,status);
                        ps.setString(2,vcode);
                        if(ps.executeUpdate()>0){
                            response.sendRedirect("video.jsp?ccode="+channel_code+"&delete_success=1");
                        }
                        else{
                            response.sendRedirect("video.jsp?ccode="+channel_code+"&delete_again=1");
                        }
                    }
                    catch(Exception ec){
                        out.println(ec.getMessage());
                    }
                }
            }
%>