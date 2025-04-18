package com.edu.member.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.edu.member.domain.MemberVo;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	private String namespace = "com.edu.member.";
	
	@Override
	public List<MemberVo> memberSelectList() {
		// TODO Auto-generated method stub
		
		return sqlSession.selectList(namespace + "memberSelectList");
	}

	@Override
	public MemberVo memberExist(String email, String password) {
		// TODO Auto-generated method stub
		HashMap<String, String> paramMap = new HashMap<>(); 
		
		paramMap.put("email", email);
		paramMap.put("pwd", password);
		
		return sqlSession.selectOne(namespace + "memberExist", paramMap);
	}

	@Override
	public int memberInsertOne(MemberVo memberVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace + "memberInsertOne"
			, memberVo);
	}

	@Override
	public MemberVo memberSelectOne(int memberNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + "memberSelectOne", memberNo);
	}

	@Override
	public int memberUpdateOne(MemberVo memberVo) {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace + "memberUpdateOne", memberVo);
	}

	@Override
	public int memberDeleteOne(int no) {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace + "memberDeleteOne", no);
	}

	@Override
	public MemberVo findMemberByEmail(String email) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + "findMemberByEmail", email);
	}

	@Override
	public MemberVo googleMemberExist(String email) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + "googleMemberExist", email);
	}
}
