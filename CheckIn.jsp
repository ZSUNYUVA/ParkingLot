<%@ page language="java" import="java.sql.*"%>
<%! Connection con;Statement stmt;String SQL;ResultSet rs=null,rs1=null; %>
<% boolean res=false;int i=0,j=0;String pvno="",vno,vtype,floor,rno,date,time; %>
<%
vno=request.getParameter("vno");
vtype=request.getParameter("vtype");
floor=request.getParameter("floor");
rno=request.getParameter("rno");
date=request.getParameter("date");
time=request.getParameter("time");

vno=vno.trim();
vtype=vtype.trim();
floor=floor.trim();
floor=floor.toUpperCase();
rno=rno.trim();
rno=rno.toUpperCase();
date=date.trim();
time=time.trim();
%>
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
<%
try
{
while(rs.next())
{

pvno=rs.getString("VNo");
pvno=pvno.trim();

if(pvno.equalsIgnoreCase(vno))
{
i=1;
break;
}

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
<%
if(i>0)
{ 
stmt.executeUpdate("insert into "+pvno+"(VehicleNo,VehicleType,Floor,RackNo,PDate,STime)values('"+vno+"','"+vtype+"','"+floor+"','"+rno+"','"+date+"','"+time+"')");
}
else
{
try
{
stmt.executeUpdate("create table "+vno+"(VehicleNo varchar(9),VehicleType varchar(10),Floor varchar(10),RackNo varchar(10),PDate date,STime time,ETime time,Amount double(10,2))");
stmt.executeUpdate("insert into "+vno+"(VehicleNo,VehicleType,Floor,RackNo,PDate,STime)values('"+vno+"','"+vtype+"','"+floor+"','"+rno+"','"+date+"','"+time+"')");
stmt.executeUpdate("insert into VehicleNo(vno)values('"+vno+"')");
stmt.executeUpdate("update zohoparklot set "+rno+"='"+vno+"' where floor='"+floor+"'");
stmt.executeUpdate("update zohoparklot set free=free-1,filled=filled+1 where "+rno+"='"+vno+"' and floor='"+floor+"'");

}
catch(SQLException se)
{
out.println("From RS1	:"+se.getMessage());
}
catch(Exception e)
{
out.println("From RS1	:"+e.getMessage());
}
}
%>

<Html>

<Head>

<style type="text/css">

BODY { background-color:rgb(243,200,171);}

H1{font-family:monotype corsiva;color:brown;font-size:400%;font-weight:bold;}

.img1{position:relative;top:-40px}
.pos1{position:sticky;}
.pos3{position:relative; top:-40px;left: 20px; font-size:22px;font-weight:bold;color:green;}
.pos4{padding: 30px 30px 30px 30px;}
.pos5{position:relative; top:0px;left: 20px;}
</Style>

</Head>

<Body>


<Center class="pos1">
	<H1>Welcome To Zoho Parking</H1>
	<img class="img1" src="Rule1.gif" height=3px width=630>
<Table class="pos3">
	<tr>
		<td>
			<h3 class="pos4">TICKET</h3>
		</td>
	</tr>
</Table>
<Table class="pos3" class="pos4" border=5px>
<tr>
	<td>Vehicle No</td>
	<td><%=vno%></td>
</tr>
<tr>
	<td>Vehicle Type</td>
	<td><%=vtype%></td>

</tr>
<tr>
	<td>Floor No</td>
	<td><%=floor%></td>

</tr>
<tr>
	<td>RACK NO</td>
	<td><%=rno%></td>

</tr>
<tr>
	<td>Date</td>
	<td><%=date%></td>

</tr>
<tr>
	<td>Time</td>
	<td><%=time%></td>

</tr>
</table>
<Table class="pos5">
	<tr>
		<td class="pos4"><a href="ZohoPark.html"><img src="Home.jpg" width=180px height=60px></td>
	</tr>
</Table>

</Center>

</Body>
</Html>
