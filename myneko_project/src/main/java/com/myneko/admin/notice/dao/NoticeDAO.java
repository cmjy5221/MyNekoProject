package com.myneko.admin.notice.dao;

import java.util.List;

import com.myneko.admin.notice.vo.NoticeVO;

public interface NoticeDAO {

	public List<NoticeVO> getNoticeList(NoticeVO nvo);
	public int insertNotice(NoticeVO nvo);
	public int noticeListCnt(NoticeVO nvo);
	public NoticeVO getNoticeDetail(NoticeVO nvo);
	public int noticeModify(NoticeVO nvo);
	public int noticeDelete(NoticeVO nvo);
	
}
