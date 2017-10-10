package com.fh.service.fhoa.scan.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.fhoa.scan.ScanManager;
import com.fh.util.PageData;
import com.fh.util.ResultData;
import com.fh.util.UuidUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/** 
 * 说明： 员工管理
 * 创建人：FH Q313596790
 * 创建时间：2016-04-23
 * @version
 */
@Service("scanService")
public class ScanService implements ScanManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ScanMapper.save", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ScanMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ScanMapper.datalistPage", page);
	}


	public List<PageData> michineScanReport(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ScanMapper.michineScanReport", page);
	}
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ScanMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ScanMapper.findById", pd);
	}
	
	public ResultData scanoperation(PageData pd, User user){
		try {
			//保存巡视记录
			PageData mrecord  = (PageData)dao.findForObject("MachineRecordMapper.findByMhid", pd);
			if(null!= mrecord && (mrecord.get("scan_type").equals("2") ||mrecord.get("scan_type").equals("4"))){
				PageData staff = (PageData)dao.findForObject("StaffMapper.findByUserId", user.getUSER_ID());
				if(!staff.getString("staff_id").equals(mrecord.getString("staff_Id"))){
					return ResultData.init(ResultData.SUCCESS,"当前部位正在由其他维修员处理，\n 操作失败！","");
				}

				pd.put("end_date",new Date());
				pd.put("mrid",mrecord.get("mrid"));
				dao.update("MachineRecordMapper.edit", pd);
			}else{
				if(pd.get("scan_type").equals("2") ||pd.get("scan_type").equals("4")){
					//获取通知发送时间 同时标记通知为已处理
					pd.put("SMS_TYPE",pd.get("scan_type"));
					List<PageData> mhList = (List<PageData>)dao.findForList("FhsmsMapper.listAll", pd);
					if(null!= mhList && mhList.size()>0){
						pd.put("notice_date",mhList.get(0).get("SEND_TIME"));
						for(PageData smspd:mhList){
							smspd.put("response_status","1");
							dao.update("FhsmsMapper.editResponseStatus", smspd);
						}
					}
				}
				pd.put("mrid", UuidUtil.get32UUID());
				pd.put("start_date",new Date());
				dao.save("MachineRecordMapper.save", pd);
			}
			//保存扫描记录
			pd.put("repair_position",pd.get("repair_position_scan"));
			pd.put("target_rule",pd.get("target_rule_scan"));
			pd.put("change_position",pd.get("change_position_scan"));
			pd.put("cycle_type",pd.get("cycle_type_scan"));
			save(pd);
			return ResultData.init(ResultData.SUCCESS,"操作成功","");
		} catch (Exception e) {
			e.printStackTrace();
			return ResultData.init(ResultData.FAIL,"操作失败",null);
		}
	}
}

