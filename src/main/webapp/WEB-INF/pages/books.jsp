<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>

<%@ page contentType="text/html; charset=UTF-8"
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
<body vlink="#0000FF" background="66FF00">
<a href="../../index.jsp">На главное меню</a>

<br/>
<br/>

<form:form action="/books">
    <div>
        <h3>Поиск книг по названию:</h3>
        <input type="text" name="searchName" id="searchName" value="${searchName}">
        <div>
            <h5>Только непрочитанные книги</h5>
            <input type="checkbox" name="isNotReadAlready" id="isNotReadAlready">
        </div>
        <input class="btn btn-xs" type='submit' value='Search'/>
    </div>
</form:form>
<h1 align="center">Список книг</h1>

<c:if test="${!empty listBooks}">
    <h4>Всего найдено: ${booksSearch}</h4>

    <form:form action="/books?isNotReadAlready=${isNotReadAlready}&searchName=${searchName}">
        <button name="page" value="${page-1} "
                <c:if test="${page <=1}">disabled="disabled"</c:if>  >
            <h4> < </h4></button>
        <button name="page" value="${page+1}"
                <c:if test="${page >=maxPages}">disabled="disabled"</c:if> >
            <h4> > </h4></button>
    </form:form>
    <table class="tg">
        <tr>

            <th width="120">Название</th>
            <th width="120">Описание</th>
            <th width="120">Автор</th>
            <th width="120">IBSN</th>
            <th width="120">Год печати</th>
            <th width="120">Прочитана</th>
            <th width="60">Пометить как прочитанную</th>
            <th width="60">Изменить</th>
            <th width="60">Удалить</th>
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

</c:if>


<c:if test="${!empty book.title}">
    <h1>Изменить книгу</h1>
</c:if>
<c:if test="${empty book.title}">
    <h1>Добавить книгу</h1>
</c:if>
<c:url var="addAction" value="/books/add?page=${page}"/>

<form:form action="${addAction}" commandName="book">
    <table>
        <!-- если убрать id то не работает изменение книги-->
        <tr>
            <td>
                <form:label path="id">
                    <spring:message text="Id"/>
                </form:label>
            </td>
            <td>
                <form:input path="id" readonly="true"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="title">
                    <spring:message text="Title"/>
                </form:label>
            </td>

            <td>
                <c:if test="${!empty book.title}">
                    <c:set var="g" value="true"/>

                </c:if>

                <c:if test="${ empty book.title}">
                    <c:set var="g" value="false"/>

                </c:if>
                <form:input path="title" readonly="${g}"/>
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
                           value="<spring:message text="Изменить"/>"/>
                </c:if>
                <c:if test="${empty book.title}">
                    <input type="submit"
                           value="<spring:message text="Добавить"/>"/>
                </c:if>
            </td>
        </tr>


    </table>
</form:form>
</body>
</html>
