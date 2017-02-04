package com.cms.manager.main;

import java.util.Date;

import com.cms.entity.main.CmsConfig;
import com.cms.entity.main.MarkConfig;
import com.cms.entity.main.MemberConfig;

public interface CmsConfigMng {
	public CmsConfig get();

	public void updateCountCopyTime(Date d);

	public void updateCountClearTime(Date d);

	public CmsConfig update(CmsConfig bean);

	public MarkConfig updateMarkConfig(MarkConfig mark);

	public void updateMemberConfig(MemberConfig memberConfig);
}