package com.chffy.ssm.controller;

import com.chffy.ssm.bean.Employee;
import com.chffy.ssm.bean.Msg;
import com.chffy.ssm.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/")
    public String index() {
        return "index";
    }

    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable(value = "ids")String ids) {
        if (ids.contains("-")){
            String[] splits = ids.split("-");
            List<Integer> list = new ArrayList<>();
            for (String split: splits)
                list.add(Integer.parseInt(split));

            employeeService.deleteEmpBatch(list);
        }else {
            employeeService.deleteEmp(Integer.parseInt(ids));
        }
        return Msg.success();
    }

    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") int id) {
        Employee emp = employeeService.getEmp(id);
        return Msg.success().add("emp", emp);
    }

    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkUser(String empName){
        String regName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regName)) {
            return Msg.fail().add("va_msg", "用户名不合法：必须是6-16位数字，字母或者_-，也可以是2-5位中文组成");
        }
        if (employeeService.checkUser(empName))
            return Msg.success();
        return Msg.fail().add("va_msg", "用户名已存在！");
    }

    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            List<FieldError> fieldErrors = result.getFieldErrors();
            Map<String, String> errors = new HashMap<>();
            for (FieldError fieldError: fieldErrors) {
                String field = fieldError.getField();
                String defaultMessage = fieldError.getDefaultMessage();
                errors.put(field, defaultMessage);
            }

            return Msg.fail().add("errors", errors);
        }
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1")int pn) {
        PageHelper.startPage(pn, 5);

        List<Employee> employees = employeeService.getAll();
        PageInfo page = new PageInfo(employees, 5);

        return Msg.success().add("pageInfo", page);
    }

//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1")int pn, Model model) {
        PageHelper.startPage(pn, 5);

        List<Employee> employees = employeeService.getAll();
        PageInfo page = new PageInfo(employees, 5);

        model.addAttribute("pageInfo", page);

        return "list";
    }
}
