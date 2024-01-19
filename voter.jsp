<!-- <%-- 
    Document   : voter
    Created on : 24-Oct-2023, 3:37:38 am
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %> -->
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Vote</title>
    <link rel="stylesheet" href="two.css" />
  </head>
  <body>
      <%
   response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
   response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
   response.setDateHeader("Expires", 0); // Proxies.
      %>
<%--<c:out value="${sessionScope.voter_id}"></c:out>--%>
    <c:if test="${voter_id eq 0}">
      <c:redirect url="login.html"></c:redirect>
    </c:if>
    <c:set var="name" value="${sessionScope.voter_name}"></c:set>
    <c:set var="voterid" value="${sessionScope.voter_id}"></c:set>

    <div class="container">
      <h1 class="Voin">Voter Information</h1>
      
      <div class="voter-info">
        <label for="name" style="display: inline-block">Name: ${name}</label> <br />
        <br />
        <label for="voterId" style="display: inline-block">Voter ID: ${voterid}</label>
      </div>
  
      <sql:setDataSource
        var="con"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost/voting_system"
        user="root"
        password="Password67*"
      />

      <sql:query dataSource="${con}" var="result">
        Select * from candidate;
      </sql:query>
      <h1>Candidate Information</h1>
      <div class="candidate-details">
        <c:forEach var="row" items="${result.rows}">
          <p> ${row.name}: - ${row.party}</p>
        </c:forEach>
      </div>
      <h1>Vote for a Candidate</h1>
      <form method="post" action="processVote.jsp">
 
      <div class="options">
          <!-- <div>
            <input type="radio" id="radio01" name="vote" value="BJP" />
            <label for="radio01"><span></span>BJP</label>
          </div> -->
          
          <div>
            <input type="radio" id="radio02" name="vote" value="congress" />
            <label for="radio02"><span></span>CONGRESS</label>
          </div>
          
          <div>
            <input type="radio" id="radio03" name="vote" value="BJP" />
            <label for="radio03"><span></span>BJP</label>
          </div>
          
          <div>
            <input type="radio" id="radio04" name="vote" value="N.O.T.A" />
            <label for="radio04"><span></span>N.O.T.A</label>
          </div>
          
          <button id="submit-button">Submit Vote</button>
          <div id="result"></div>
      </div>

    </div> <br> <br>

        <!-- <input type="submit" id="animate-button" value="Vote" /> -->
        <!-- <button id="animate-button">Animate</button> -->
        <!--<script src="script.js"></script>-->
      </form>
    </div>
  </body>
</html>
