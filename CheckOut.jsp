<%@ page language="java" import="java.sql.*"%>
<%! Connection con;Statement stmt;String SQL;ResultSet rs=null,rs1=null; %>
<% boolean res=false;int i=0,j=0;String pvno="",vno,vtype,floor,rno,date,time; %>
<%
try
{
Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","admin");  
stmt=con.createStatement();
rs=stmt.executeQuery("select * from VehicleNo");
}
catch(ClassNotFoundException cnfe)
{
throw new ClassNotFoundException(cnfe.getMessage());
}
catch(SQLException se)
{
throw new SQLException(se.getMessage());
}
catch(Exception e)
{
throw new Exception(e.getMessage());
}
%>
<Html>

<Head>

<style type="text/css">

BODY { background-color:rgb(243,200,171);}

H1{font-family:monotype corsiva;color:brown;font-size:400%;font-weight:bold;}

.img1{position:relative;top:-40px;left:10px}
.pos1{position:sticky;}
.pos3{position:relative; top:20px;left: 20px; font-size:33px;font-weight:bold;color:green;}
.pos4{padding: 50px 50px 50px 50px;}
.pos6{padding: 0px 50px 50px 50px;}
.pos5{position:relative; top:50px;left: 10px;}
.button{width:132px;}
</Style>

</Head>

<Body>


<Center class="pos1">
	<H1>Welcome To Zoho Parking</H1>
	<img class="img1" src="Rule1.gif" height=3px width=630>

<form action="http://localhost:8080/ZohoPark/CheckOutFin.jsp">
<Table class="pos3">
	<tr>
		<td class="pos4">Vehicle No </td>
	</tr>
	<tr>
		<td class="pos4">
		<select name="vtype" id="vtype">
	
<%
try
{
while(rs.next())
{

pvno=rs.getString("VNo");
pvno=pvno.trim();
%>
		<option value=<%=pvno%>><%=pvno%></option>
<%
}
}
catch(SQLException se)
{
out.println("From RS1	:"+se.getMessage());
}
catch(Exception e)
{
out.println("From RS1	:"+e.getMessage());
}
%>
	</select>
	</td>
</tr>

</table>
<Table class="pos6">
	<tr>
		<td><input class="button" type=submit></td>
	</tr>
</Table>

<Table class="pos5">
	<tr>
		<td class="pos5"><a href="ZohoPark.html"><img src="Home.jpg" width=180px height=60px></td>
	</tr>
</Table>
</form>
</Center>

</Body>
</Html>
