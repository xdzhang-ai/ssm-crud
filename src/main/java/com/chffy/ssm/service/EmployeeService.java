package com.chffy.ssm.service;

import com.chffy.ssm.bean.Employee;
import com.chffy.ssm.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

public interface EmployeeService {
    List<Employee> getAll();

    void saveEmp(Employee employee);

    boolean checkUser(String empName);

    Employee getEmp(int id);

    void updateEmp(Employee employee);

    void deleteEmp(int id);

    void deleteEmpBatch(List<Integer> list);
}
