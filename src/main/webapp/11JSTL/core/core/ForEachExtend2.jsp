<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>list 컬렉션 사용하기</h4>
	<%
	//list계열의 컬렉션을 생성한다.
	LinkedList<Person> lists = new LinkedList<Person>();
	lists.add(new Person("맹사성",34));
	lists.add(new Person("장영실",44));
	lists.add(new Person("신숙주",54));
	%>
	<!-- set태그로 page영역세 속성(변수)을 저장한다.  -->
	<c:set var="lists" value="<%= lists %>"/>
	<!-- 해당 변수를 통해 확장 for문을 실행한다. items에 지정한 컬렉션에
	저장된 객체의 갯수만큼 반복하여 list롤 하나씩 전달한다. -->
	<c:forEach items="${ lists }" var="list">
	<!-- 저장된 순서대로 Person객체를 변수 lsit에 저장 후 getter를 통해
	멤버변수에 저장된 값을 출력한다. -->
	<li>
		이름 : ${ list.name }, 나이 : ${ lists.age }
	</li>
	</c:forEach>
	
	<h4>Java 코드를 통한 출력</h4>
	<%
	/* Java코드를 사용하면 출력할 객체를 명시하고, getter를 직접 호출해야 한다. */
	for(Person p : lists){
		out.println("이름:"+p.getName()+",나이:"+p.getAge() +"<br>");
	}
	%>
	
	<h4>Map 컬렉션 사용하기</h4>
	<%
	/* Map 계열의 컬렉션을 생성한다. key는 String, Value를 Person 타입으로
	지정한다.*/
	Map<String,Person> maps = new HashMap<String, Person();
	
	maps.put("1st", new Person("맹사성", 34));
	maps.put("2nd", new Person("장영실", 44));
	maps.put("3rd", new Person("신숙주", 54));
	%>
	<!-- JSTL을 통해 변수 저장   -->
	<c:set var="maps" value="<%= maps %>"/>
	<!-- Map컬렉션 사용시 key를 별도로 얻어올 필요없이 객체.key 혹은 
	객체.value를 통해 값을 출력할 수 있다. -->
	<c:forEach items="${ maps }" var="map">
		<li>key => ${maps.key} <br/>
		      value => 이름 : ${ map.value.name }, 나이 : ${map.value. age}</li>
	
	</c:forEach>
	<h4>Java 코드를 통한 출력</h4>
	<%
	//Map 컬렉션은 항상 key를 먼저 얻어와야한다.
	Set<String> keys=maps.keySet();
	//앞에서 얻어온 key의 갯수만큼 반복한다.
	for(string key : keys){
		//key를 통해 value를 얻어온다.
		Person p= maps.get(key);
		/* key와 Value를 출력한다. 여기서 Value는 Person객체이므로
		맴버변수에 저장된값은 getter를 통해 출력할 수 있다.*/
		out.println("key=>"+key +"<br>");
		out.println("Value => "+p.getName()+","+p.getAge()+"<br>");
	}
	/* JSTL의 확장 for문을 사용하면 Key를 별도롤 얻어와야 하는 번거로움이
	없으므로 편리하다.*/
	
	%>
</body>
</html>