<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*, javax.sql.*, java.sql.*" %>
<%@ page import="java.util.Properties"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>jdbc test</title></head>
<body>
<%
Context ctx = null ;
DataSource ds = null ;
Connection conn = null ;
Statement stmt = null ;
ResultSet rs = null ;
try
{
        ctx = new InitialContext() ;
        ds = (DataSource)ctx.lookup("jboss/jdbc/tmax");
        conn = ds.getConnection() ;
        stmt = conn.createStatement() ;
        rs = stmt.executeQuery("select * from departments" ) ;
while(rs.next()) {%>
emp_no=<%out.println(rs.getString(1)) ;%><br>
<% }
}
catch(Exception e)
{
out.print("error : " + e.getMessage()) ;
}
finally
{
try { if(rs != null) rs.close(); } catch (SQLException ignore) { }
try { if(stmt != null) rs.close(); } catch (SQLException ignore) { }
try { if(conn != null) rs.close(); } catch (SQLException ignore) { }
ds = null ;
try { if(ctx != null) ctx.close(); } catch (NamingException ignore) { }
}
%>
</body>
</html>
