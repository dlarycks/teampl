package com.kh.teampl.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.teampl.dto.Product_noDto;

@Repository
public class CheckDao {

	private final String NAMESPACE = "com.kh.teampl.CheckMapper.";

	@Autowired
	SqlSession sqlSession;
	// 메서드 이름 비교 할 각 부품의 첫 이니셜 따서 만듦.
	// 단, 중복을 피하고자 케이스와 호환되는 메서드는 모든 이름을 씀.

	int count = 0;
	
	public boolean crCheck(Product_noDto product_noDto) {
		count = sqlSession.selectOne(NAMESPACE + "crCheck", product_noDto);
		if (count > 0) {
			return true;
		}
		return false;
	}

	public boolean cmCheck(Product_noDto product_noDto) {
		count = sqlSession.selectOne(NAMESPACE + "cmCheck", product_noDto);
		if (count > 0) {
			return true;
		}
		return false;
	}

	public boolean mrCheck(Product_noDto product_noDto) {
		count = sqlSession.selectOne(NAMESPACE + "mrCheck", product_noDto);
		if (count > 0) {
			return true;
		}
		return false;
	}

	public boolean mvCheck(Product_noDto product_noDto) {
		count = sqlSession.selectOne(NAMESPACE + "mvCheck", product_noDto);
		if (count > 0) {
			return true;
		}
		return false;
	}

	public boolean msCheck(Product_noDto product_noDto) {
		count = sqlSession.selectOne(NAMESPACE + "msCheck", product_noDto);
		if (count > 0) {
			return true;
		}
		return false;
	}

	public boolean caseMbCheck(Product_noDto product_noDto) {
		count = sqlSession.selectOne(NAMESPACE + "caseMbCheck", product_noDto);
		if (count > 0) {
			return true;
		}
		return false;
	}

	public boolean casePowerCheck(Product_noDto product_noDto) {
		count = sqlSession.selectOne(NAMESPACE + "casePowerCheck", product_noDto);
		if (count > 0) {
			return true;
		}
		return false;
	}

	public boolean caseVgaCheck(Product_noDto product_noDto) {
		count = sqlSession.selectOne(NAMESPACE + "caseVgaCheck", product_noDto);
		if (count > 0) {
			return true;
		}
		return false;
	}

}
