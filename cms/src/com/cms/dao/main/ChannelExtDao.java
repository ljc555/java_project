package com.cms.dao.main;

import com.cms.entity.main.ChannelExt;
import com.common.hibernate3.Updater;

public interface ChannelExtDao {
	public ChannelExt save(ChannelExt bean);

	public ChannelExt updateByUpdater(Updater<ChannelExt> updater);
}