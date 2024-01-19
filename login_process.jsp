<%-- 
    Document   : login_process
    Created on : 24-Oct-2023, 12:30:11 am
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <c:set var="bjpvote" value="0" scope="application"></c:set>
        <c:set var="congressvote" value="0" scope="application"></c:set>
    <c:set var="uname" value="${param.username}"/>
    <c:set var="pass" value="${param.password}"/>
        <sql:setDataSource 
        var="con" driver="com.mysql.jdbc.Driver" 
         url="jdbc:mysql://localhost/voting_system" user="root" password="Password67*"/>
        <sql:query dataSource="${con}" var="result">
            Select * from voters;
        </sql:query>
           
         <c:forEach var = "row" items = "${result.rows}">
                 
             <c:set var="s1" value="${row.username}" scope="page"></c:set>
             <c:set var="s2" value="${row.password}" scope="page"></c:set>
             <c:set var="s3" value="NONE" scope="page"></c:set>
             <c:if test="${s1 eq uname && s2 eq pass}">
                 <c:choose>
                     
                     <c:when test="${row.voted_for eq s3}">
                     <c:set var="voter_name" value="${row.name}" scope="session" />
                     <c:set var="voter_id" value="${row.Voting_id}" scope="session" />
                     <c:redirect url="new.html"/>
                     </c:when>
                 
                 <c:otherwise> 
                     <c:redirect url="vote_twice.html"/>
                 </c:otherwise>
                </c:choose>
            </c:if>
         </c:forEach>
                 <c:redirect url="invalid.html"></c:redirect>
    </body>
</html>
