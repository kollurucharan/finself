<%@ page language="java"
	import="java.util.*,java.sql.*,java.io.*,javax.servlet.*,javax.servlet.http.* "
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<h1 style="text-align: center;">CRUD JSP</h1>
<style>
#d2, #d3, #d4, #d5, #d7, #d8, #d9, #d {
	display: flex;
	justify-content: center;
	align-items: flex-end;
	height: 5vh;
}
</style>

</head>
<body>
	<%

	%>
	<center>
		<form onsubmit='fun()'>
			<div id="d1">
				<label for="m">mode</label> <input type="text" id="m">
				<div id="d2">
					<lable for="l1">emp id</lable>
					<input type="text" id="t1" name="id">
				</div>
				<div id="d3">
					<lable for="l2">emp name</lable>
					<input type="text" id="t2" name="name">

				</div>
				<div id="d4">
					<lable for="l3">job</lable>
					<input type="text" id="t3" name="job">
				</div>
				<div id="d5">
					<lable for="l4">salary</lable>
					<input type="text" id="t4" name="salary">
				</div>

				<br> <br> <br> <br>
				<div id="d7">
					<input type="submit" name="but" value='first'> <input
						type="submit" name="but" value='prev'> <input
						type="submit" name="but" value='next'> <input
						type="submit" name="but" value='last'>
				</div>
				<div id="d8">
					<input type="submit" name="but" value='add'> 
					<input type="submit" name="but" value='del'>
					 <input type="submit"  name="but" value='edit'> 
						<input type="submit" name="but" value='save'>
				</div>
				<div id="d9">
				<input type="submit" name="but" value='search'>
					 <input type="submit"
						value='exit'> <input type="submit" value='clear'>
				</div>
		</form>
	</center>
	<%
	int cur = 0;
	Integer count = (Integer) session.getAttribute("count");
	int curr = (count != null) ? count.intValue() : 0;

	if (curr == 0) {

		cur = 1;
	} else {
		cur = (Integer) session.getAttribute("count");
	}
	
	int m = 0;
	Integer mode = (Integer) session.getAttribute("mode");
	int modee = (mode != null) ? mode.intValue() : 0;

	if (modee == 0) {

		m = 1;
	} else {
		m = (Integer) session.getAttribute("mode");
	}
	
	

	String but = request.getParameter("but");
	Connection conn;
	Statement stat;
	String mode1 = "";
	ResultSet rs;
	String query = null;
	int id=0;
	String emp = "";
	String job="";
	int salary=0;
	HttpSession sessio = request.getSession();
	int length = 0;
	Class.forName("org.postgresql.Driver");
	conn = DriverManager.getConnection("jdbc:postgresql://192.168.110.48:5432/plf_training", "plf_training_admin",
			"pff123");
	

	try {

		stat = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		query = "select count(*) from empp_pp;";
		rs = stat.executeQuery(query);
		if (rs.next()) {
		length = rs.getInt(1);
		System.out.println("length"+length);
		}
		
		mode1 = "read";
		sessio.setAttribute("count", cur);
		query = "select * from empp_pp limit 1;";
		rs = stat.executeQuery(query);
		while (rs.next()) {
	System.out.println("helo");
	id=rs.getInt(1);
	emp = rs.getString(2);
	job=rs.getString(3);
	salary=rs.getInt(4);
	System.out.println(emp);
		}
		if (but.equals("first")) {
			cur = 1;
			mode1 = "read";
			sessio.setAttribute("count", cur);
			query = "select * from empp_pp limit 1;";
			rs = stat.executeQuery(query);
			while (rs.next()) {
		System.out.println("helo");
		id=rs.getInt(1);
		emp = rs.getString(2);
		job=rs.getString(3);
		salary=rs.getInt(4);
		System.out.println(emp);
			}
		} else if (but.equals("last")) {
			mode1 = "read";
			query = "select count(*) from empp_pp;";
			rs = stat.executeQuery(query);
			if (rs.next()) {
		length = rs.getInt(1);
		cur = length;
		
			}

			sessio.setAttribute("count", cur);
			query = "select * from empp_pp LIMIT 1 OFFSET (SELECT COUNT(*) - 1 FROM empp_pp)";
			rs = stat.executeQuery(query);
			while (rs.next()) {
		System.out.println("helo");
		id=rs.getInt(1);
		emp = rs.getString(2);
		job=rs.getString(3);
		salary=rs.getInt(4);
		System.out.println(emp);
			}
		} else if (but.equals("next") && cur<length) {
			mode1 = "read";
			cur = cur + 1;
			sessio.setAttribute("count", cur);
			System.out.println(cur);
			query = "select * from empp_pp limit " + cur;
			rs = stat.executeQuery(query);
			while (rs.next()) {
				id=rs.getInt(1);
				emp = rs.getString(2);
				job=rs.getString(3);
				salary=rs.getInt(4);
			}
		}else if (but.equals("prev") && cur>1) {
			mode1 = "read";
			cur = cur - 1;
			sessio.setAttribute("count", cur);
			System.out.println(cur);
			query = "select * from empp_pp limit " + cur;
			rs = stat.executeQuery(query);
			while (rs.next()) {
				id=rs.getInt(1);
				emp = rs.getString(2);
				job=rs.getString(3);
				salary=rs.getInt(4);
			}
		} else if (but.equals("add")) {
			mode1 = "add";
			System.out.println("modeadd" + mode);
			m=1;
			
			sessio.setAttribute("mode", m);
			id= 0;
			emp = "";
			job="";
			salary= 0 ;
		}
		else if (but.equals("edit")) {
			mode1 = "edit";
			System.out.println("modeadd" + mode);
			m=2;
			sessio.setAttribute("mode", m);
			
		}
		else if (but.equals("del")) {
			mode1 = "delete";
			System.out.println("modeadd" + mode);
			m=3;
			sessio.setAttribute("mode", m);
		}
		
		else if (but.equals("search")) {
			mode1 = "read";
			System.out.println("search");
			int param2 = Integer.parseInt(request.getParameter("id"));
			query = "select * from empp_pp where id=?";
			PreparedStatement pstat = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			pstat.setInt(1, param2);
			
			rs=pstat.executeQuery();

			while (rs.next()) {
		System.out.println("searchhhh");
		id=rs.getInt(1);
		emp = rs.getString(2);
		job=rs.getString(3);
		salary=rs.getInt(4);
		System.out.println(emp);
			
		}
		}

		else if (but.equals("save")) {
			System.out.println("mode" + mode);
		
			
		if (m==1) {
		int param2 = Integer.parseInt(request.getParameter("id"));
		System.out.println("id" + param2);
		String param3 = (request.getParameter("name"));
		String param4 = (request.getParameter("job"));
		int param5 = Integer.parseInt(request.getParameter("salary"));
		query = "insert into empp_pp values(?,?,?,?)";
		PreparedStatement pstat = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE,
				ResultSet.CONCUR_UPDATABLE);
		pstat.setInt(1, param2);
		pstat.setString(2, param3);
		pstat.setString(3, param4);
		pstat.setInt(4, param5);
		pstat.executeQuery();
		

			}
			else if (m==2) {
				int param2 = Integer.parseInt(request.getParameter("id"));
				String param3 = (request.getParameter("name"));
				String param4 = (request.getParameter("job"));
				int param5 = Integer.parseInt(request.getParameter("salary"));
				query = "update empp_pp set name=?,department=?,salary=? where id=?;";
				PreparedStatement pstat = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				
				pstat.setString(1, param3);
				pstat.setString(2, param4);
				pstat.setInt(3, param5);
				pstat.setInt(4, param2);
				pstat.executeQuery();

					}
			else if (m==3) {
				System.out.println("m"+m);
			
				int param2 = Integer.parseInt(request.getParameter("id"));
			System.out.println(param2);
				query = "DELETE FROM empp_pp WHERE id = ?";
				PreparedStatement pstat = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				
				pstat.setInt(1, param2);
				pstat.executeQuery();
				}

					
		}

	} catch (Exception e) {
		System.out.println("pstat" + e);
	}
	%>
	<script>
	var f1=document.getElementById("m");
	f1.value = "<%=mode1%>";
	
	
		var xx=document.getElementById("t2");
		xx.value = "<%=emp%>";
		console.log("<%=emp%>");
		var xy=document.getElementById("t1");
		xy.value = <%=id%> || "";
		
		var yy=document.getElementById("t3");
		yy.value = "<%=job%>";
	
		var xx=document.getElementById("t4");
		xx.value = <%=salary%> || "";
		
	</script>

</body>
</html>