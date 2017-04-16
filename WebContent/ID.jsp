<%@page import="homework.Student"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>成绩单</title>
</head>
<body>
	<h2>学生成绩单</h2>
	<a href = "Normal.jsp">原始顺序</a>
	<a href = "ID.jsp">学号顺序</a>
	<a href = "Sum.jsp">总评顺序</a>
	<hr>
	<%
	String path = request.getServletContext().getRealPath("/data/student.txt"); 
	File file = new File(path);
	Scanner scanner = new Scanner(file);
	ArrayList<Student> students = new ArrayList<Student>();
	while(scanner.hasNextLine()){
		long id = scanner.nextLong();
		String name = scanner.next();
		String banji = scanner.next();
		int pgrade = scanner.nextInt();
		int qgrade = scanner.nextInt();
		double zgrade = (pgrade + qgrade)/2;
		Student student = new Student(id,name,banji,pgrade,qgrade,zgrade);
		students.add(student);	
	}		
	Student[] students2 = new Student[students.size()];
	students.toArray(students2);
	
	for(int i = 0;i<students2.length;i++){
		for(int j = i+1;j<students2.length;j++){
			if(students2[j].getId()<students2[i].getId()){
				Student temp = students2[j];
				students2[j] = students2[i];
				students2[i] = temp;
			}
		}
	}
	
	%>

	<table border="1">
		<tr>
			<td>学号</td>
			<td>姓名</td>
			<td>班级</td>
			<td>平时成绩</td>
			<td>期末成绩</td>
			<td>总评成绩</td>
		</tr>	

	<% for(int i = 0;i<students2.length;i++){ %>
		<tr>
		<td><%=students2[i].getId() + "&nbsp"%></td>
		<td><%=students2[i].getName() + "&nbsp"%></td>
		<td><%=students2[i].getBanji() + "&nbsp"%></td>
		<td><%="&nbsp"+ students2[i].getPgrade() + "&nbsp"%></td>
		<td><%="&nbsp"+ students2[i].getQgrade() + "&nbsp"%></td>
		<td><%=students2[i].getZgrade()%>
		</tr>
	<% }%>
	</table>
</body>
</html>