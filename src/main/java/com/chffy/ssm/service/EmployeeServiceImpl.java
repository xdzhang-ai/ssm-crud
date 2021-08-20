package com.chffy.ssm.service;

import com.chffy.ssm.bean.Employee;
import com.chffy.ssm.bean.EmployeeExample;
import com.chffy.ssm.dao.EmployeeMapper;
import com.chffy.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    @Override
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    @Override
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        return employeeMapper.selectByExample(example).size() == 0;
    }

    @Override
    public Employee getEmp(int id) {
        return employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    @Override
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    @Override
    public void deleteEmp(int id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteEmpBatch(List<Integer> list) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(list);
        employeeMapper.deleteByExample(example);
    }
}
