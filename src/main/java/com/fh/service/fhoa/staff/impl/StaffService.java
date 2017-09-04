package com.fh.service.fhoa.staff.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.fhoa.staff.StaffManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/** 
 * 说明： 员工管理
 * 创建人：FH Q313596790
 * 创建时间：2016-04-23
 * @version
 */
@Service("staffService")
public class StaffService implements StaffManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("StaffMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.update("StaffMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("StaffMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("StaffMapper.datalistPage", page);
	}

	/**
	 * 下拉框查询列表
	 * @param page
	 * @return
	 * @throws Exception
     */
	public List<PageData> listSelect(Page page)throws Exception{
		return (List<PageData>)dao.findForList("StaffMapper.listSelect", page);
	}

	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("StaffMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("StaffMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.update("StaffMapper.deleteAll", ArrayDATA_IDS);
	}
	
	/**绑定用户
	 * @param pd
	 * @throws Exception
	 */
	public void userBinding(PageData pd)throws Exception{
		dao.update("StaffMapper.userBinding", pd);
	}
	
}

