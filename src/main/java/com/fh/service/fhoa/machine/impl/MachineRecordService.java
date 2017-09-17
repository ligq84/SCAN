package com.fh.service.fhoa.machine.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.fhoa.machine.MachineRecordManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;



/** 
 * 说明： 机器操作记录
 * 创建人：FH Q313596790
 * 创建时间：2017-09-16
 * @version
 */
@Service("machinerecordService")
public class MachineRecordService implements MachineRecordManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("MachineRecordMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("MachineRecordMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("MachineRecordMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("MachineRecordMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("MachineRecordMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MachineRecordMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("MachineRecordMapper.deleteAll", ArrayDATA_IDS);
	}

	/**
	 * 根据机器id 查找 机器操作记录
	 * @param mhid
	 * @return
	 * @throws Exception
     */
	public PageData findByMhid(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MachineRecordMapper.findByMhid", pd);
	}

}

