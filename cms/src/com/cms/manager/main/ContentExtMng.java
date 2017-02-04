package com.cms.manager.main;

import com.cms.entity.main.Content;
import com.cms.entity.main.ContentExt;

public interface ContentExtMng {
	public ContentExt save(ContentExt ext, Content content);

	public ContentExt update(ContentExt ext);
}