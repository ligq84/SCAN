package com.fh.controller.fhoa.scan;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.fhoa.machine.MachineManager;
import com.fh.service.fhoa.machine.MachineRecordManager;
import com.fh.service.fhoa.scan.ScanManager;
import com.fh.service.fhoa.staff.StaffManager;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.ResultData;
import org.apache.shiro.session.Session;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/** 
 * 说明：公司信息
 * 创建人：FH Q313596790
 * 创建时间：2017-08-05
 */
@Controller
@RequestMapping(value="/scan")
public class ScanController extends BaseController {
	
		String menuUrl = "scan/list.do"; //菜单地址(权限用)
	@Resource(name="machineService")
	private MachineManager machineService;
	@Resource(name="staffService")
	private StaffManager staffService;
	@Resource(name="scanService")
	private ScanManager scanService;
	@Resource(name="machinerecordService")
	private MachineRecordManager machinerecordService;

	/**
	 * 通知扫描
	 * @return
	 * @throws Exception
     */
	@RequestMapping(value="/noticeScan")
	public ModelAndView noticeScan()throws Exception{
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		mv.setViewName("fhoa/scan/noticeScan");
		return mv;
	}

	/**
	 * 员工扫描
	 * @return
	 * @throws Exception
     */
	@RequestMapping(value="/repairmanScan")
	public ModelAndView repairmanScan()throws Exception{
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		mv.setViewName("fhoa/scan/repairmanScan");
		return mv;
	}

	/**
	 * 根据机器编码查询机器信息
	 * @return
	 * @throws Exception
     */
	@RequestMapping(value="/findByBarcode")
	@ResponseBody
	public ResultData findByBarcode()throws Exception{
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			pd.put("company_id",user.getCompanyId());
			pd = machineService.findByBarcode(pd);
			return ResultData.init(ResultData.SUCCESS,"查询成功",pd);
		} catch (Exception e) {
			e.printStackTrace();
			return ResultData.init(ResultData.FAIL,"查询异常",null);
		}
	}
	@RequestMapping(value="/list")
	@SuppressWarnings("all")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMPANY_ID",user.getCompanyId());
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList = scanService.list(page);	//列出Company列表
		mv.setViewName("fhoa/scan/scan_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	/**
	 * 扫描操作
	 * @return
	 * @throws Exception
     */
	@RequestMapping(value="/scanoperation")
	@ResponseBody
	@SuppressWarnings("all")
	public ResultData scanoperation() throws Exception {
			Session session = Jurisdiction.getSession();
			User user = (User)session.getAttribute(Const.SESSION_USER);
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			//保存扫描记录
			pd.put("company_id",user.getCompanyId());
			pd.put("srid",this.get32UUID());//主键
			PageData staffPD = staffService.findByUserId(user.getUSER_ID().toString());
			pd.put("staff_Id",staffPD.get("staff_id"));
			pd.put("staff_name",staffPD.get("NAME"));
			pd.put("car_code",session.getAttribute(Const.CARCODE));
			pd.put("car_id",session.getAttribute(Const.CARID));
			pd.put("scan_date",new Date());
		return  scanService.scanoperation(pd,user);
	}

	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
