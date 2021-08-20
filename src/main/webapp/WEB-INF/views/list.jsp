<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: chffy
  Date: 2021/8/17
  Time: 23:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        pageContext.setAttribute("BASE_PATH", request.getContextPath());
    %>
    <title>员工列表</title>
    <script type="text/javascript" src="${BASE_PATH}/static/js/jquery-1.7.2.js"></script>
    <link type="text/css" rel="stylesheet" href="${BASE_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script src="${BASE_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
<%--        标题--%>
        <div class="row">
            <div class="col-lg-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
<%--    按钮--%>
        <div class="row">
            <div class="col-lg-4 col-lg-offset-8">
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
<%--    表格数据--%>
        <div class="row">
            <div class="col-lg-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender == 'M' ? '男': '女'}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil"></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash"></span>
                                    删除
                                </button>
                            </th>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
<%--       分页信息 --%>
        <div class="row">
            <div class="col-lg-6">
                当前${pageInfo.pageNum}页，总共${pageInfo.pages}页，总${pageInfo.total}条记录
            </div>
            <div class="col-lg-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${BASE_PATH}/emps?pn=${pageInfo.firstPage}">首页</a></li>
                        <c:if test="${not pageInfo.isFirstPage}">
                            <li>
                                <a href="${BASE_PATH}/emps?pn=${pageInfo.prePage}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                            <c:if test="${page == pageInfo.pageNum}">
                                <li class="active"><a href="${BASE_PATH}/emps?pn=${page}">${page}</a></li>
                            </c:if>
                            <c:if test="${page != pageInfo.pageNum}">
                                <li><a href="${BASE_PATH}/emps?pn=${page}">${page}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${not pageInfo.isLastPage}">
                            <li>
                                <a href="${BASE_PATH}/emps?pn=${pageInfo.nextPage}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="${BASE_PATH}/emps?pn=${pageInfo.lastPage}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
