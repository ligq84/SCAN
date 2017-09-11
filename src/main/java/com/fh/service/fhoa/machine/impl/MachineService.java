package com.fh.service.fhoa.machine.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.fhoa.machine.MachineManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/** 
 * 说明： 机器信息
 * 创建人：FH Q313596790
 * 创建时间：2017-09-04
 * @version
 */
@Service("machineService")
public class MachineService implements MachineManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public String save(PageData pd)throws Exception{
		return dao.save("MachineMapper.save", pd).toString();
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("MachineMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("MachineMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("MachineMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("MachineMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MachineMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("MachineMapper.deleteAll", ArrayDATA_IDS);
	}

	/**
	 * 保存机器维护周期
	 * @param pd
	 * @throws Exception
     */
	public void saveMachineCycle(PageData pd)throws Exception{
		 dao.save("MachineMapper.saveMachineCycle", pd).toString();
	}

	/**
	 * 保存机器维修项目
	 * @param pd
	 * @throws Exception
     */
	public void saveMachineProject(PageData pd)throws Exception{
		dao.save("MachineMapper.saveMachineProject", pd).toString();
	}

	/**
	 * 保存机器支持规格
	 * @param pd
	 * @throws Exception
     */
	public void saveMachineRule(PageData pd)throws Exception{
		dao.save("MachineMapper.saveMachineRule", pd).toString();
	}

	/**
	 * 保存机器规格更改
	 * @param pd
	 * @throws Exception
     */
	public void saveMachineParts(PageData pd)throws Exception{
		dao.save("MachineMapper.saveMachineParts", pd).toString();
	}

	/**
	 * 获取该设备的保养周期
	 * @param pd
	 * @return
	 * @throws Exception
     */
	public List<PageData> getMachineCycle(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("MachineMapper.getMachineCycle", pd);
	}

	/**
	 * 获取设备的维护项目
	 * @param pd
	 * @return
	 * @throws Exception
     */
	public List<PageData> getMachineProjec(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("MachineMapper.getMachineProjec", pd);
	}

}

