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
	// solr ��������ַ
	public static final String solrServerUrl = "http://localhost:8080/solr";
	// solrhome�µ�core
	public static final String solrCroeHome = "my_solr";
	// ����������ѯ�ֶ�
	public static String[] docs = { "Solr��һ����������ҵ������Ӧ�÷�����",
			"�������ṩ������Web-service��API�ӿ�", "�û�����ͨ��http����",
			"����������������ύһ����ʽ��XML�ļ���������", "Ҳ����ͨ��Http Get���������������",
			"���õ�XML��ʽ�ķ��ؽ��", "LJH������������" };

	public static void main(String[] args) {
		addIndex();

	}

	/*private static void queryIndex() {
		HttpSolrServer server = getSolrClient();

		SolrQuery query = new SolrQuery();// ��ѯ
		query.setQuery("title:����");
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
			doc.addField("content_title", "���Ա���" + i);
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
