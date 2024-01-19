<%-- 
    Document   : processVote
    Created on : 24-Oct-2023, 4:56:50 am
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
        <c:if test="${sessionScope.voter_id eq 0}">
            <c:redirect url="index.html"></c:redirect>
        </c:if>
        <sql:setDataSource 
        var="con" driver="com.mysql.jdbc.Driver" 
         url="jdbc:mysql://localhost/voting_system" user="root" password="Password67*"/> 
        <c:set var="party" value="${param.vote}"></c:set>
        <%--<c:out value="${party}"></c:out>--%>
        <c:if test="${party eq 'BJP'}">
            <sql:query dataSource="${con}" var="result">
            select count from candidate where c_id = (select c_id from candidate where party='BJP'); 
            </sql:query>
            <c:set var="bjpvote" value="${result.rows[0].count}"></c:set>
            <c:set var="bjpvote" value="${bjpvote+1}"></c:set>
            <sql:update dataSource="${con}" var="count">
            UPDATE candidate SET count = ? WHERE party='BJP';
            <sql:param value="${bjpvote}" />
            </sql:update>  
            
        </c:if>
            <c:if test="${party eq 'congress'}">
            <sql:query dataSource="${con}" var="result">
            select count from candidate where c_id = (select c_id from candidate where party='Congress'); 
            </sql:query>
            <c:set var="congressvote" value="${result.rows[0].count}"></c:set>
            <c:set var="congressvote" value="${congressvote+1}"></c:set>
            <sql:update dataSource="${con}" var="count">
            UPDATE candidate SET count = ? WHERE party='Congress';
            <sql:param value="${congressvote}" />
            </sql:update>  
        </c:if>
          <sql:update dataSource="${con}" var="count">
            UPDATE voters set voted_for = ? where voting_id = ?;
            <sql:param value="${party}" />
            <sql:param value="${voter_id}" />
          </sql:update>   
            <c:set var="voter_id" value="0" scope="session"/>
            <%--<c:out value="${voter_id}"></c:out>--%>
            <c:remove var="sessionScope" scope="session" />
            <c:redirect url="thankyou.html"></c:redirect>
    </body>
</html>
