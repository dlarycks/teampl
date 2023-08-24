package dao;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kh.teampl.vo.BoardVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class BoardDaoTest {

	@Autowired
	private SqlSession sqlSession;
	
	private final String NAMESPACE = "com.kh.teampl.BoardMapper.";
	
//	@Transactional
	@Test
	public void testInput50() throws Exception {
		BoardVo boardVo = new BoardVo();
		boardVo.setMember_id("hong");
		boardVo.setBoard_type("잡담");
		for (int i = 1; i <= 50; i++) {
			 boardVo.setBoard_title("테스트" + (50 + i));
			 boardVo.setBoard_content("내용" + (50 + i));
			 sqlSession.insert(NAMESPACE + "testInput300", boardVo);
			 Thread.sleep(100);
		}
	}
	
}
