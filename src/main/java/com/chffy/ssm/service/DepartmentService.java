package com.chffy.ssm.service;

import com.chffy.ssm.bean.Department;
import com.chffy.ssm.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getAll(){
        return departmentMapper.selectByExample(null);
    }
}
