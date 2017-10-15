package com.fh.service.system.fhlog.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.UuidUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/** 
 * 说明： 操作日志记录
 * 创建人：FH Q313596790
 * 创建时间：2016-05-10
 * @version
 */
@Service("fhlogService")
public class FHlogService implements FHlogManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param
	 * @throws Exception
	 */
	public void save(String USERNAME, String CONTENT)throws Exception{
		PageData pd = new PageData();
		pd.put("USERNAME", USERNAME);					//用户名
		pd.put("CONTENT", CONTENT);						//事件
		pd.put("FHLOG_ID", UuidUtil.get32UUID());		//主键
		pd.put("CZTIME", Tools.date2Str(new Date()));	//操作时间
		dao.save("FHlogMapper.save", pd);
	}

	public void save(String USERNAME, String CONTENT,String model,String function,String type,String operName,String companyId)throws Exception{
		PageData pd = new PageData();
		pd.put("USERNAME", USERNAME);					//用户名
		pd.put("CONTENT", CONTENT);						//事件
		pd.put("FHLOG_ID", UuidUtil.get32UUID());		//主键
		pd.put("CZTIME", Tools.date2Str(new Date()));	//操作时间

		pd.put("MODEL", model);
		pd.put("FUNCTION", function);
		pd.put("TYPE", type);
		pd.put("OPER_NAME", operName);
		pd.put("COMPANY_ID", companyId);
		pd.put("LOG_TYPE", 0);
		dao.save("FHlogMapper.save", pd);
	}

	public void save(String USERNAME, String CONTENT,String ip,String operName,String companyId)throws Exception{
		PageData pd = new PageData();
		pd.put("USERNAME", USERNAME);					//用户名
		pd.put("OPER_NAME", operName);
		pd.put("CONTENT", CONTENT);						//事件
		pd.put("FHLOG_ID", UuidUtil.get32UUID());		//主键
		pd.put("CZTIME", Tools.date2Str(new Date()));	//操作时间
		pd.put("LOG_TYPE", 1);
		pd.put("COMPANY_ID", companyId);
		dao.save("FHlogMapper.save", pd);
	}

	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("FHlogMapper.delete", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FHlogMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FHlogMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FHlogMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("FHlogMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

