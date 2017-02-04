package com.ljh.solr.initdata;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;

public class InsertProgarm {
	// solr 服务器地址
	public static final String solrServerUrl = "http://localhost:8080/solr";
	// solrhome下的core
	public static final String solrCroeHome = "my_solr";
	// 待索引、查询字段
	public static String[] docs = { "Solr是一个独立的企业级搜索应用服务器",
			"它对外提供类似于Web-service的API接口", "用户可以通过http请求",
			"向搜索引擎服务器提交一定格式的XML文件生成索引", "也可以通过Http Get操作提出查找请求",
			"并得到XML格式的返回结果", "LJH测试推送数据" };

	public static void main(String[] args) {
		addIndex();

	}

	/*private static void queryIndex() {
		HttpSolrServer server = getSolrClient();

		SolrQuery query = new SolrQuery();// 查询
		query.setQuery("title:主题");
		query.setRows(20);
		query.setHighlight(b)
		
		SolrDocumentList docs = client.query(query).getResults();
		for (SolrDocument doc : docs) {
			System.out.println("id: " + doc.getFieldValue("id"));
			System.out.println("title: " + doc.getFieldValue("title"));
			System.out.println("content_test: "
					+ doc.getFieldValue("content_test"));
			System.out.println("content_title: "
					+ doc.getFieldValue("content_title"));
		}
	}*/

	private static void addIndex() {
		SolrClient client = getSolrClient();
		int i = 0;
		List<SolrInputDocument> solrDocs = new ArrayList<SolrInputDocument>();
		for (String content : docs) {
			SolrInputDocument doc = new SolrInputDocument();
			doc.addField("id", i++);
			doc.addField("content_test", content);
			doc.addField("content_title", "测试标题" + i);
			solrDocs.add(doc);
		}
		try {
			client.add(solrDocs);
			client.commit();
		} catch (SolrServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static SolrClient getSolrClient() {
		return new HttpSolrClient(solrServerUrl + "/" + solrCroeHome);
	}
	
}
