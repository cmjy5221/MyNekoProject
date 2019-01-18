package com.myneko.admin.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.admin.notice.dao.NoticeDAO;
import com.myneko.admin.notice.vo.NoticeVO;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDAO nDao;

	@Override
	public List<NoticeVO> getNoticeList(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return nDao.getNoticeList(nvo);
	}

	@Override
	public int insertNotice(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return nDao.insertNotice(nvo);
	}

	@Override
	public int noticeListCnt(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return nDao.noticeListCnt(nvo);
	}

	@Override
	public NoticeVO getNoticeDetail(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return nDao.getNoticeDetail(nvo);
	}

	@Override
	public int noticeModify(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return nDao.noticeModify(nvo);
	}

	@Override
	public int noticeDelete(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return nDao.noticeDelete(nvo);
	}
	
}
