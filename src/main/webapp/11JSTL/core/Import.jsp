<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>JSTL - import</title></head>
<body>
<!--  
import 태그
: 외부의 문서를 현재문서에 포함시킨다. include 지시어 처럼 외부문서를 
먼저 포함시킨 후 컴파일하는 형식이 아니라, include 액션태그와 같은 
기능으로 컴파일이 먼저 진행된 후 결과를 포함시키게 된다. 
따라서 서로 다른 페이지이므로 page영역은 공유되지 않고, request영역만
공유된다. 
url속성에 절대경로로 지정할 경우 컨텍스트 루트명은 포함하지 않는다.
-->
	<!-- request영역에 변수를 생성한다.  -->
    <c:set var="requestVar" value="MustHave" scope="request" />
    <!--  
    var 속성을 
    	미사용시 : include 액션태그와 동일하게 현재 위치에 즉시 
    		외부문서를 포함시킨다. 
    	사용시 : var에 지정한 변수를 EL로 출력하는곳에 포함된다. 
    		선언과 출력을 별도로 할수 있으므로 코드의 가독성이 높아진다.
    -->
    <c:import url="/11JSTL/inc/OtherPage.jsp" var="contents">
        <c:param name="user_param1" value="JSP" />
        <c:param name="user_param2" value="기본서" />
    </c:import>
    <!--  
    import 태그의 하위태그로 param을 사용할 수 있다. 쿼리스트링을 통해
    전달하듯 지정된 페이지로 파라미터를 전달한다.
    -->
    
    <!--  
    아래와 같이 이미지를 삽입할때는 주로 상대경로를 사용하는것이 좋다. 
    만약 절대경로를 사용해야 한다면 하드코딩을 하는것 보다는 request
    내장객체에서 제공하는 메서드를 사용하는것이 좋다. 
    웹프로그래밍은 웹서버에 배포하는것이 목적이므로 서버의 환경이 
    달라지면 경로도 수정되야 하므로 이를 최소화할수 있도록 개발하는것이
    좋다. 
    특히 JSTL에서 url 지정할때 컨텍스트루트 경로는 명시하지 않아도 되므로
    일반적인 방식보다 작성에 유리한점이 있다. 
    -->
   	<div>
   		<h4>이미지 삽입하기</h4>
   		<!-- 상대경로 삽입하기-->
   		<img src="../../images/disk.png" width="100"/>
   		<!-- 절대경로 삽입하기 (하드코딩으로 기술) -->
   		<img src="/JSPStudy/images/disk.png" width="100"/>
   		<!-- 컨텍스트 루트명을 가져온 후 절대경로로 삽입하기 (내장객체 사용)-->
   		<img src="<%=request.getContextPath() %>/images/disk.png" width="100"/>
   	</div>        
    
    <!-- 앞에서 선언한 import 태그의 var속성의 변수를 통해 문서의 
    내용을 출력한다.  -->
    <h4>다른 문서 삽입하기</h4>
    ${contents }
    
    <!-- http로 시작하는 외부 URL도 import태그를 통해 삽입할 수 있다. -->
    <h4>외부 자원 삽입하기</h4>    
    <iframe src="../inc/GoldPage.jsp" 
    	style="width:100%;height:600px;"></iframe>
</body>
</html>



