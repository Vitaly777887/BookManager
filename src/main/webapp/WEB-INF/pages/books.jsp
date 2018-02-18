<%@ page import="net.bookmanager.service.BookServiceImpl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Books Page</title>

    <style type="text/css">
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }

        .tg td {
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #fff;
        }

        .tg th {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #f0f0f0;
        }

        .tg .tg-4eph {
            background-color: #f9f9f9
        }
    </style>
</head>
<body>
<a href="../../index.jsp">Back to main menu</a>

<br/>
<br/>

<form action="/books?page=1">
    <div class="row">
        <div class="col-md-2">Search users by name:</div>
        <div class="col-md-2"><input type="text" name="searchName" id="searchName"
                                     placeholder="type name here.."></div>
        <div class="col-md-2"><input class="btn btn-xs" type='submit' value='Search'/></div>
    </div>
</form>
<h1>Book List</h1>

<c:if test="${!empty listBooks}">

    <table class="tg">
        <tr>

            <th width="120">Title</th>
            <th width="120">Description</th>
            <th width="120">Author</th>
            <th width="120">IBSN</th>
            <th width="120">Print year</th>
            <th width="120">Is read already</th>
            <th width="60">isReadAlready</th>
            <th width="60">Edit</th>
            <th width="60">Delete</th>
        </tr>
        <c:forEach items="${listBooks}" var="book">
            <tr>
                <td>${book.title}</td>
                <td><a href="/bookdata/${book.id}" target="_blank">${book.description}</a></td>
                <td>${book.author}</td>
                <td>${book.isbn}</td>
                <td>${book.printYear}</td>
                <td>${book.readAlready}</td>
                <td><a href="/isReadAlready/${book.id}?page=${page}">isReadAlready</a></td>
                <td><a href="<c:url value='/edit/${book.id}?page=${page}'/>">Edit</a></td>
                <td><a href="<c:url value='/remove/${book.id}?page=${page}'/>">Delete</a></td>

            </tr>
        </c:forEach>
    </table>
    <h4>всего найдено ${pagesSerch}</h4>

    <form >
        <button name="page" value="${page-1}" <c:if test="${page <=1}">disabled="disabled"</c:if>  > <h2><</h2></button>
        <button name="page" value="${page+1}"  <c:if test="${page >=maxPages}">disabled="disabled"</c:if> > <h2>></h2></button>
    </form>
</c:if>




<c:if test="${!empty book.title}">
    <h1>Edit a Book</h1>
</c:if>
<c:if test="${empty book.title}">
    <h1>Add a Book</h1>
</c:if>

<c:url var="addAction" value="/books/add?page=${page}"/>

<form:form action="${addAction}" commandName="book">
    <table>
        <tr>
            <td>
                <form:label path="id">
                    <spring:message text="id"/>
                </form:label>
            </td>
            <td>
                <form:input path="id"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="title">
                    <spring:message text="Title"/>
                </form:label>
            </td>
            <td>
                <form:input path="title" />
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="description">
                    <spring:message text="Description"/>
                </form:label>
            </td>
            <td>
                <form:input path="description"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="author">
                    <spring:message text="Author"/>
                </form:label>
            </td>
            <td>
                <form:input path="author"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="isbn">
                    <spring:message text="ISBN"/>
                </form:label>
            </td>
            <td>
                <form:input path="isbn"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="printYear">
                    <spring:message text="Print year"/>
                </form:label>
            </td>
            <td>
                <form:input path="printYear"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">
            <c:if test="${!empty book.title}">
                <input type="submit"
                       value="<spring:message text="Edit Book"/>"/>
            </c:if>
            <c:if test="${empty book.title}">
                <input type="submit"
                       value="<spring:message text="Add Book"/>"/>
            </c:if>
        </td>
        </tr>




    </table>
</form:form>
</body>
</html>
