<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="java.text.*"%>

<%! Connection con;Statement stmt;String SQL;ResultSet rs=null,rs1=null; %>
<% boolean res=false;int i=0,j=0;String pvno="",vno,vtype,floor,rno,stime,etime,VeType,Vfloor1="",Vrno1="";%>
<% java.time.format.DateTimeFormatter dtf = java.time.format.DateTimeFormatter.ofPattern("yyyy/MM/dd"); %>
<% java.time.LocalDateTime now = java.time.LocalDateTime.now(); %>
<% String day=String.valueOf(dtf.format(now)); %>
<% dtf = java.time.format.DateTimeFormatter.ofPattern("HH:mm:ss"); %>
<% now = java.time.LocalDateTime.now(); %>
<% String time=String.valueOf(dtf.format(now)); %>

<%
vtype=request.getParameter("vtype");
vtype=vtype.trim();
%>

<%
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","admin");  
	
	stmt=con.createStatement();
	stmt.executeUpdate("update "+vtype+" set ETime='"+time+"' where pdate='"+day+"'");


	rs1=stmt.executeQuery("select vehicletype,STime,ETime from "+vtype+" Where pdate='"+day+"'");

	if(rs1.next())
	{
		double chr=50.0;

		double cm=chr/60.0;
		double amount=0.0;
		double bhr=20.0;

		double bm=bhr/60.0;

		VeType=rs1.getString("vehicletype");
		stime=rs1.getString("STime");
		etime=rs1.getString("ETime");

		SimpleDateFormat simpleDateFormat= new SimpleDateFormat("HH:mm:ss");

		java.util.Date date1,date2;

		date1 = simpleDateFormat.parse(stime);
		date2 = simpleDateFormat.parse(etime);

		long differenceInMilliSeconds = Math.abs(date2.getTime() - date1.getTime());
		long differenceInMinutes = (differenceInMilliSeconds / (60 * 1000));


		if(VeType.charAt(0)=='C')
		{
			amount=differenceInMinutes*cm;
		}
		else
		{
			amount=differenceInMinutes*bm;
		}
	stmt.executeUpdate("update "+vtype+" set amount='"+amount+"' where pdate='"+day+"'");
		
	rs=stmt.executeQuery("Select * From "+vtype);
	}
}
catch(ClassNotFoundException cnfe)
{

out.println(cnfe.getMessage());

}
catch(SQLException se)
{
out.println(se.getMessage());
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
			<h3 class="pos4">CHECK OUT DETAILS </h3>
		</td>
	</tr>
</Table>

<Table class="pos3" border=5px cellpadding="4" cellspacing="5">
<tr>
<th>VEHICLE NO</th>
<th>VEHICLE TYPE</th>
<th>FLOOR</th>
<th>RACK NO</th>
<th>PARKING DATE</th>
<th>START TIME</th>
<th>END TIME</th>
<th>AMOUNT</th>
</tr>
<%
try
{
while(rs.next())
{
String Vno1=rs.getString("VehicleNo");
Vno1=Vno1.trim();
String Vtype1=rs.getString("VehicleType");
Vtype1=Vtype1.trim();
Vfloor1=rs.getString("Floor");
Vfloor1=Vfloor1.trim();
Vrno1=rs.getString("RackNo");
Vrno1=Vrno1.trim();
String Vpd1=rs.getString("PDate");
Vpd1=Vpd1.trim();
String Vst1=rs.getString("STime");
Vst1=Vst1.trim();
String Vet1=rs.getString("ETime");
Vet1=Vet1.trim();
String Vam1=rs.getString("Amount");
Vam1=Vam1.trim();
%>

	<tr>
		<td>
			<%=Vno1%>
		</td>
		<td>
			<%=Vtype1%>
		</td>
		<td>
			<%=Vfloor1%>
		</td>
		<td>
			<%=Vrno1%>
		</td>
		<td>
			<%=Vpd1%>
		</td>
		<td>
			<%=Vst1%>
		</td>
		<td>
			<%=Vet1%>
		</td>
		<td>
			<%=Vam1%>
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
<%
try
{
	String Zero="0";
	stmt.executeUpdate("delete from vehicleno where vno ='"+vtype+"'");
	stmt.executeUpdate("update zohoparklot set free=free+1,filled=filled-1,"+Vrno1+"='"+Zero+"' where floor='"+Vfloor1+"'");
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
