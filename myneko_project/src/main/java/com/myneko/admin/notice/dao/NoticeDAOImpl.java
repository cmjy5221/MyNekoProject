package com.myneko.admin.notice.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.admin.notice.vo.NoticeVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {

	@Autowired
	private SqlSession session;

	@Override
	public List<NoticeVO> getNoticeList(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return session.selectList("getNoticeList", nvo);
	}

	@Override
	public int insertNotice(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return (Integer)session.insert("insertNotice", nvo);
	}

	@Override
	public int noticeListCnt(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return (Integer)session.selectOne("noticeListCnt", nvo);
	}

	@Override
	public NoticeVO getNoticeDetail(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return (NoticeVO) session.selectOne("getNoticeDetail", nvo);
	}

	@Override
	public int noticeModify(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return (Integer) session.update("noticeModify", nvo);
	}

	@Override
	public int noticeDelete(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return (Integer) session.delete("noticeDelete", nvo);
	}
	
}
