package com.fh.service.fhoa.scan;

import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.util.PageData;
import com.fh.util.ResultData;

import java.util.List;

/** 
 * 说明： 员工管理接口
 * 创建人：FH Q313596790
 * 创建时间：2016-04-23
 * @version
 */
public interface ScanManager {

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;

	
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

	List<PageData> michineScanReport(Page page)throws Exception;

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

	public ResultData scanoperation(PageData pd,User user);
	
}

