package com.chffy.ssm.test;

import com.chffy.ssm.bean.Department;
import com.chffy.ssm.bean.Employee;
import com.chffy.ssm.bean.EmployeeExample;
import com.chffy.ssm.dao.DepartmentMapper;
import com.chffy.ssm.dao.EmployeeMapper;
//import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCrud(){
//        System.out.println(departmentMapper);

//        Department dept1 = new Department(null, "开发部");
//        Department dept2 = new Department(null, "资源部");
//        departmentMapper.insertSelective(dept1);
//        departmentMapper.insert(dept2);
//        employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@atguigu.com", 1));
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for(int i = 0;i<10;i++){
//            String uid = UUID.randomUUID().toString().substring(0,5)+i;
//            mapper.insertSelective(new Employee(null,uid, "F", uid+"@atguigu.com", 2));
//        }

//        EmployeeExample example = new EmployeeExample();
//        EmployeeExample.Criteria criteria = example.createCriteria();
//        criteria.andEmpIdBetween(2,4);
//        List<Employee> employee =employeeMapper.selectByExample(example);
//        System.out.println(employee);
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo("12345");
        System.out.println(employeeMapper.selectByExample(example));
    }
}