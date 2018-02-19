<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>JavaRush task</title>
    <style type="text/css">

        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        .parent {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            overflow: auto;
        }

        .block {
            width: 70%;
            height: 50%;
            position: absolute;
            top: 25%;
            left: 15%;

            background: #4fffaf;

        }

    </style>
</head>
<body>
<div class="parent">
    <div class="block">
        <h1 align="center"> Добро Пожаловать</h1>
        <br/>
        <div align="center"><h2><a href="<c:url value="/books"/>">Список книг</a></h2></div>
        <br/>
    </div>
</div>
</body>
</html>