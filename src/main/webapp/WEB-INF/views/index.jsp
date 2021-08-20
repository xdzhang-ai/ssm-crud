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
    <script type="text/javascript" src="${BASE_PATH}/static/js/jquery.min.js"></script>
    <link type="text/css" rel="stylesheet" href="${BASE_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script src="${BASE_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="add_emp_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="add_emp_form">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_add_input" placeholder="1@1.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dId_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dId_add_input">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_emp">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">

                <%------------------------------ 表单 ------------------------------%>
                <form class="form-horizontal">
                    <%-- empName --%>
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <%-- email --%>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_update_input" placeholder="1@1.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%-- gender --%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <%-- 内联单选 --%>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <%-- department --%>
                    <div class="form-group">
                        <label for="dId_update_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%-- 下拉列表，部门选项只要提交部门id即可 --%>
                            <select class="form-control" id="dId_update_input" name="dId"></select>
                        </div>
                    </div>
                </form>
                <%------------------------------------------------------------------%>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

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
            <button class="btn btn-primary" id="add_emp_button">新增</button>
            <button class="btn btn-danger" id="emp_delete_batch_btn">删除</button>
        </div>
    </div>
    <%--    表格数据--%>
    <div class="row">
        <div class="col-lg-12">
            <table class="table table-hover" id="emp_table">
                <thead>
                    <th>
                        <%-- 一键全选 --%>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%--       分页信息 --%>
    <div class="row">
        <div class="col-lg-6" id="page_info_area">

        </div>
        <div class="col-lg-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    $(function (){
       to_page(1);
    });
    var pageTotal;

    function build_emps_table(result) {
        $("#emp_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item){
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var emailTd = $("<td></td>").append(item.email);
            var genderTd = $("<td></td>").append(item.gender==='M'?'男':'女');
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var button_edit = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
            button_edit.attr("edit-id", item.empId);
            var button_delete = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
            button_delete.attr("del-id", item.empId);
            var button = $("<td></td>").append(button_edit).append("  ").append(button_delete);
            // var empIdTd = $("<td></td>").append(item.empId);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(button)
                .appendTo("#emp_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
            result.extend.pageInfo.pages+"页,总"+
            result.extend.pageInfo.total+"条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
        pageTotal = result.extend.pageInfo.pages;
    }
    //解析显示分页条，点击分页要能去下一页....
    function build_page_nav(result) {
        //page_nav_area
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.isFirstPage){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }
        firstPageLi.click(function(){
            to_page(1);
        });
        prePageLi.click(function(){
            to_page(result.extend.pageInfo.pageNum -1);
        });

        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        if (result.extend.pageInfo.isLastPage){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }
        nextPageLi.click(function(){
            to_page(result.extend.pageInfo.pageNum +1);
        });
        lastPageLi.click(function(){
            to_page(result.extend.pageInfo.pages);
        });

        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, page){
            var numLi = $("<li></li>").append($("<a></a>").append(page).attr("href", "#"));
            if (page == result.extend.pageInfo.pageNum)
                numLi.addClass("active");
            numLi.click(function (){
               to_page(page);
            });
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(lastPageLi);
        var nav = $("<nav></nav>").append(ul);
        nav.appendTo("#page_nav_area");
    }

    function to_page(pn){
        $("#check_all").prop("checked", false);
        $.ajax({
            url:"${BASE_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                //console.log(result);
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    $("#add_emp_button").click(function (){
        reset_form("#add_emp_modal form");
        $.ajax({
            url: "${BASE_PATH}/depts",
            type: "GET",
            success: function (result){
                get_depts(result, "#dId_add_input");
            }
        });
        $('#add_emp_modal').modal({
            backdrop:"static"
        });
    });

    function get_depts(result, ele){
        $(ele).empty();
        $.each(result.extend.depts, function (index, dept){
            $("<option></option>").append(dept.deptName).attr("value", dept.deptId).appendTo(ele);
        });
    }

    $("#save_emp").click(function (){
        if($(this).attr("ajax-value") === "error"){
            return false;
        }
        if (!validate_add_form())
            return false;
       $.ajax({
           url:'${BASE_PATH}/emp',
           type:"POST",
           data: $("#add_emp_form").serialize(),
           success:function (result){
               if (result.code == 100) {
                   $('#add_emp_modal').modal('hide')
                   alert(result.msg);
                   to_page(pageTotal+1);
               }else {
                   //如果邮箱有误
                   if (res.extend.errors.email != undefined){
                       //    显示邮箱错误信息
                       show_validate_msg("#email_add_input", "error", res.extend.errorField.email);
                   }
                   //如果用户名有误
                   if(res.extend.errors.empName != undefined){
                       //显示用户名错误信息
                       show_validate_msg("#empName_add_input", "error", res.extend.errorField.empName);
                   }
               }
           }
       })
    });

    //==========================================================================================
    //这里将校验结果的提示信息全部抽取出来
    function show_validate_msg(ele, status, msg) {
        // 当一开始输入不正确的用户名之后，会变红。
        // 但是之后输入了正确的用户名却不会变绿，
        // 因为has-error和has-success状态叠加了。
        // 所以每次校验的时候都要清除当前元素的校验状态。
        $(ele).parent().removeClass("has-success has-error");
        //提示信息默认为空
        $(ele).next("span").text("");
        if("success" == status){
            //如果校验成功
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            //如果校验失败
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //校验方法，判断用户名是否重复或者不可用
    function validate_add_form(){
        // $("#empName_add_input").parent().removeClass("has-success has-error");
        // $("#empName_add_input").next("span").text("");
        // $("#email_add_input").parent().removeClass("has-success has-error");
        // $("#email_add_input").next("span").text("");
        // 拿到要校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        //允许数字字母以及_-，6-16位或者中文2-5位
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        //1、校验用户名
        if(!regName.test(empName)){
            //失败
            // alert("用户名必须是6-16位数字，字母或者_-，也可以是2-5位中文组成");
            //添加错误样式到输入框
            // $("#empName_add_input").parent().addClass("has-error");
            //给empName_add_input所在标签的下一个span标签加上文本
            // $("#empName_add_input").next("span").text("用户名必须是6-16位数字，字母或者_-，也可以是2-5位中文组成");
            show_validate_msg("#empName_add_input", "error", "用户名必须是6-16位数字，字母或者_-，也可以是2-5位中文组成");
            return false;
        }else{
            //成功
            // $("#empName_add_input").parent().addClass("has-success");
            // $("#empName_add_input").next("span").text("");
            // console.log("1");
            show_validate_msg("#empName_add_input", "success", "");
        }
        //2、校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            // alert("邮箱格式不正确!");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式不正确!");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确!");
            return false;
        }else{
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("");
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        //    发送ajax请求校验用户名是否可用
        //  输入框中的值
        var empName = this.value;
        $.ajax({
            url:"${BASE_PATH}/checkuser",
            data:"empName=" + empName,
            type:"POST",
            success:function (res) {
                if(res.code == 100){
                    //成功
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    //    如果用户名可用，将success标志保存到ajax-value属性中
                    $("#save_emp").attr("ajax-value", "success");
                }else{
                    //失败
                    show_validate_msg("#empName_add_input", "error", res.extend.va_msg);
                    //    如果用户名不可用，将error标志保存到ajax-value属性中
                    $("#save_emp").attr("ajax-value", "error");
                }
            }
        })
    })

    //清空表单样式及内容
    function reset_form(ele){
        //清空表单内容，取出dom对象，调用reset()方法
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        //清空提示信息
        $(ele).find(".help-block").text("");
    }

    $(document).on("click", ".edit_btn", function (){
        $.ajax({
            url: "${BASE_PATH}/depts",
            type: "GET",
            success: function (result){
                get_depts(result, "#dId_update_input");
            }
        });
        get_emp($(this).attr("edit-id"));
        // console.log($(this).attr("edit-id"));
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $('#empUpdateModal').modal({
            backdrop:"static"
        });
    });

    function get_emp(id){
        $.ajax({
            url: "${BASE_PATH}/emp/"+id,
            type:"GET",
            success:function (result){
                $("#empName_update_static").text(result.extend.emp.empName);
                $("#email_update_input").val(result.extend.emp.email);
                $("#empUpdateModal input[name=gender]").val([result.extend.emp.gender]);
                $("#empUpdateModal select").val([result.extend.emp.dId]);
            }
        })
    }

    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确!");
            return false;
        }else{
            show_validate_msg("#email_update_input", "success", "");
        }
        // console.log($(this).attr("edit-id"));
        //发送ajax请求保存更新的员工数据
        $.ajax({
            //加上之前在修改按钮上保存的edit-id的值
            url:"${BASE_PATH}/emp/" + $(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),// + "&_method=PUT",
            success:function (res) {
                // alert(res.msg);
                //关闭对话框
                $('#empUpdateModal').modal('hide');
                //回到本页面
                to_page(currentPage);
            }
        })
    })

    //单个删除
    $(document).on("click", ".delete_btn", function () {
        //    弹出是否删除确认框，并显示员工姓名
        //    找tr标签下的第三个td标签，对应的就是员工名字
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        //拿到当前员工的id
        var empId = $(this).attr("del-id");
        //弹出确认框，点击确认就删除
        if(confirm("确认删除 [" + empName + "] 吗？")){
            //    确认，发送ajax请求删除
            $.ajax({
                url:"${BASE_PATH}/emp/" + empId,
                type:"DELETE",
                success:function (res) {
                    alert(res.msg);
                    //回到本页
                    to_page(currentPage);
                }
            })
        }
    });

    $("#check_all").click(function (){
        $(".check_item").prop("checked", $("#check_all").prop("checked"));
    });

    //    当本页面所有复选框都选上时，自动将全选复选框选上
    $(document).on("click", ".check_item", function () {
        //判断当前选择中的元素是否是当前页面所有check_item的个数
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    })

    //    为批量删除绑定单击事件
    $("#emp_delete_batch_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        //遍历每一个被选中的复选框
        $.each($(".check_item:checked"), function () {
            // 获取要删除的员工姓名
            empNames += $(this).parents("tr").find("td:eq(2)").text() + "\n";
            //获取要删除的员工的id
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        //去除多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if(confirm("确认删除 \n" + empNames + " 吗？")){
            $.ajax({
                url:"${BASE_PATH}/emp/" + del_idstr,
                type:"DELETE",
                success:function (res) {
                    alert(res.msg);
                    to_page(currentPage);
                }
            })
        }
    });

</script>
</body>
</html>
