package com.fh.service.fhoa.machine;

import com.fh.entity.Page;
import com.fh.util.PageData;

import java.util.List;

/** 
 * 说明： 机器信息接口
 * 创建人：FH Q313596790
 * 创建时间：2017-09-04
 * @version
 */
public interface MachineManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public String save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;

	/**
	 * 保存机器维护周期
	 * @param pd
	 * @throws Exception
	 */
	void saveMachineCycle(PageData pd)throws Exception;

	/**
	 * 删除机器维护周期
	 * @param MHID
	 * @throws Exception
	 */
	void deleteMachineCycle(String MHID)throws Exception;

	/**
	 * 保存机器维修项目
	 * @param pd
	 * @throws Exception
	 */
	void saveMachineProject(PageData pd)throws Exception;

	/**
	 * 删除机器维修项目
	 * @param MHID
	 * @throws Exception
	 */
	void deleteMachineProject(String MHID)throws Exception;

	/**
	 * 报错机器支持规格
	 * @param pd
	 * @throws Exception
	 */
	void saveMachineRule(PageData pd)throws Exception;

	/**
	 * 删除机器支持规格
	 * @param MHID
	 * @throws Exception
	 */
	void deleteMachineRule(String MHID)throws Exception;

	/**
	 * 保存机器规格更改
	 * @param pd
	 * @throws Exception
	 */
	void saveMachineParts(PageData pd)throws Exception;

	/**
	 * 删除机器规格更改
	 * @param MHID
	 * @throws Exception
	 */
	void deleteMachineParts(String MHID)throws Exception;

	/**
	 * 获取该设备的保养周期
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	List<PageData> getMachineCycle(PageData pd)throws Exception;

	/**
	 * 获取设备的维护项目
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	List<PageData> getMachineProjec(PageData pd)throws Exception;

	/**
	 * 获取设备的规格
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	List<PageData> getMachineRule(PageData pd)throws Exception;
	/**
	 * 获取设备更改规格
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	List<PageData> getMachineParts(PageData pd)throws Exception;
}

