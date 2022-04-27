<%@ page language="java" import="java.sql.*"%>
<%! Connection con;Statement stmt;ResultSet rs=null; %>
<% java.time.format.DateTimeFormatter dtf = java.time.format.DateTimeFormatter.ofPattern("yyyy/MM/dd"); %>
<% java.time.LocalDateTime now = java.time.LocalDateTime.now(); %>
<% String day=String.valueOf(dtf.format(now)); %>
<% dtf = java.time.format.DateTimeFormatter.ofPattern("HH:mm:ss"); %>
<% now = java.time.LocalDateTime.now(); %>
<% String time=String.valueOf(dtf.format(now)); %>
<%
try
{
Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","admin");  
stmt=con.createStatement();
rs=stmt.executeQuery("Select * From zohoparklot");

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

.img1{position:relative;top:-40px}
.pos1{position:sticky;}
.pos3{position:relative; top:-40px;left: 20px; font-size:22px;font-weight:bold;color:green;}
.pos4{padding: 30px 30px 30px 30px;}
.pos5{position:relative; top:100px;left: 20px;}
</Style>

</Head>

<Body>


<Center class="pos1">
	<H1>Welcome To Zoho Parking</H1>
	<img class="img1" src="Rule1.gif" height=3px width=630>
<Table class="pos3">
	<tr>
		<td>
			<h3 class="pos4">RACK DETAILS </h3>
		</td>
	</tr>
</Table>

<Table class="pos3" border=5px>
<tr>
<th>FLOOR</th>
<th>RACK1</th>
<th>RACK2</th>
<th>RACK3</th>
<th>RACK4</th>
<th>RACK5</th>
<th>FREE</th>
<th>FILLED</th>
</tr>
<%
try
{
while(rs.next())
{
String floor=rs.getString("floor");
floor=floor.trim();
String rack1=rs.getString("rack1");
rack1=rack1.trim();
String rack2=rs.getString("rack2");
rack2=rack2.trim();
String rack3=rs.getString("rack3");
rack3=rack3.trim();
String rack4=rs.getString("rack4");
rack4=rack4.trim();
String rack5=rs.getString("rack5");
rack5=rack5.trim();
String free=rs.getString("free");
free=free.trim();
String filled=rs.getString("filled");
filled=filled.trim();
%>

	<tr>
		<td>
			<%=floor%>
		</td>
		<td>
			<%=rack1%>
		</td>
		<td>
			<%=rack2%>
		</td>
		<td>
			<%=rack3%>
		</td>
		<td>
			<%=rack4%>
		</td>
		<td>
			<%=rack5%>
		</td>
		<td>
			<%=free%>
		</td>
		<td>
			<%=filled%>
		</td>

	</tr>
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

<form action="http://localhost:8080/ZohoPark/CheckIn.jsp">
<table class="pre1">
<tr>
	<td>Vehicle No </td>
	<td><input type=text name="vno"></td>
</tr>
<tr>
	<td>Vehicle Type</td>
	<td>
	<select name="vtype" id="vtype">
		<option value="car">Car</option>
		<option value="twr">TwoWheeler</option>
	</select>
	</td>
</tr>
<tr>
	<td>Enter Floor</td>
	<td><input type=text name="floor"></td>
</tr>
<tr>
	<td>Enter RackNo</td>
	<td><input type=text name="rno"></td>
</tr>
<tr>
	<td>Enter Date</td>
	<td><input type=text name="date" value=<%=day%>></td>
</tr>
<tr>
	<td>Enter Time</td>
	<td><input type=text name="time" value=<%=time%>></td>
</tr>

<tr>
	<td><input class="button" type=submit value="Check In"></td>
	<td><input class="button" type=reset value="Reset"></td>
</tr>
</table>
<Table class="pos5">
	<tr>
		<td class="pos4"><a href="ZohoPark.html"><img src="Home.jpg" width=180px height=60px></td>
	</tr>
</Table>

</form>

</Center>

</Body>
</Html>
