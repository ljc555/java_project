package com.cms.dao.main;

import com.cms.entity.main.CmsConfig;
import com.common.hibernate3.Updater;

public interface CmsConfigDao {
	public CmsConfig findById(Integer id);

	public CmsConfig updateByUpdater(Updater<CmsConfig> updater);
}