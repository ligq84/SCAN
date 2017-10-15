package com.fh.controller.fhoa.scan;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.fhoa.machine.MachineManager;
import com.fh.service.fhoa.machine.MachineRecordManager;
import com.fh.service.fhoa.scan.ScanManager;
import com.fh.service.fhoa.staff.StaffManager;
import com.fh.util.*;
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
import java.util.*;

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
	@RequestMapping(value="/findByBarcodeList")
	@ResponseBody
	public ResultData findByBarcodeList()throws Exception{
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			pd.put("company_id",user.getCompanyId());
			List<PageData> pdList = machineService.findByBarcodeList(pd);
			return ResultData.init(ResultData.SUCCESS,"查询成功",pdList);
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

		page.setPd(pd);
		List<PageData> varList = scanService.list(page);	//列出Company列表
		mv.setViewName("fhoa/scan/scan_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	@RequestMapping(value="/listrecord")
	@SuppressWarnings("all")
	public ModelAndView listrecord(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMPANY_ID",user.getCompanyId());

		page.setPd(pd);
		List<PageData> varList = scanService.list(page);	//列出Company列表
		mv.setViewName("fhoa/scan/scan_record");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	@RequestMapping(value="/michineScanReport")
	@SuppressWarnings("all")
	public ModelAndView michineScanReport(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMPANY_ID",user.getCompanyId());
		if(null == pd.get("lastStart")){
			pd.put("lastStart", DateUtil.getDay());
		}
		if(null == pd.get("lastEnd")){
			pd.put("lastEnd", DateUtil.getDay());
		}
		page.setPd(pd);
		List<PageData> varList = scanService.michineScanReport(page);	//列出Company列表
		mv.setViewName("fhoa/scan/machine_scan_report");
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

	@RequestMapping(value="/scanExcel")
	@SuppressWarnings("all")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Staff到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMPANY_ID",user.getCompanyId());

		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("姓名");	//1
		titles.add("英文");	//2
		titles.add("编码");	//3
		titles.add("部门");	//4
		titles.add("职责");	//5
		titles.add("电话");	//6
		titles.add("邮箱");	//7
		titles.add("性别");	//8
		titles.add("出生日期");	//9
		titles.add("民族");	//10
		titles.add("岗位类别");	//11
		titles.add("参加工作时间");	//12
		titles.add("籍贯");	//13
		titles.add("政治面貌");	//14
		titles.add("入团时间");	//15
		titles.add("身份证号");	//16
		titles.add("婚姻状况");	//17
		titles.add("进本单位时间");	//18
		titles.add("现岗位");	//19
		titles.add("上岗时间");	//20
		titles.add("学历");	//21
		titles.add("毕业学校");	//22
		titles.add("专业");	//23
		titles.add("职称");	//24
		titles.add("职业资格证");	//25
		titles.add("劳动合同时长");	//26
		titles.add("签订日期");	//27
		titles.add("终止日期");	//28
		titles.add("现住址");	//29
		titles.add("绑定账号ID");	//30
		titles.add("备注");	//31
		dataMap.put("titles", titles);
		List<PageData> varOList = staffService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("NAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("NAME_EN"));	    //2
			vpd.put("var3", varOList.get(i).getString("BIANMA"));	    //3
			vpd.put("var4", varOList.get(i).getString("DEPARTMENT_ID"));	    //4
			vpd.put("var5", varOList.get(i).getString("FUNCTIONS"));	    //5
			vpd.put("var6", varOList.get(i).getString("TEL"));	    //6
			vpd.put("var7", varOList.get(i).getString("EMAIL"));	    //7
			vpd.put("var8", varOList.get(i).getString("SEX"));	    //8
			vpd.put("var9", varOList.get(i).getString("BIRTHDAY"));	    //9
			vpd.put("var10", varOList.get(i).getString("NATION"));	    //10
			vpd.put("var11", varOList.get(i).getString("JOBTYPE"));	    //11
			vpd.put("var12", varOList.get(i).getString("JOBJOINTIME"));	    //12
			vpd.put("var13", varOList.get(i).getString("FADDRESS"));	    //13
			vpd.put("var14", varOList.get(i).getString("POLITICAL"));	    //14
			vpd.put("var15", varOList.get(i).getString("PJOINTIME"));	    //15
			vpd.put("var16", varOList.get(i).getString("SFID"));	    //16
			vpd.put("var17", varOList.get(i).getString("MARITAL"));	    //17
			vpd.put("var18", varOList.get(i).getString("DJOINTIME"));	    //18
			vpd.put("var19", varOList.get(i).getString("POST"));	    //19
			vpd.put("var20", varOList.get(i).getString("POJOINTIME"));	    //20
			vpd.put("var21", varOList.get(i).getString("EDUCATION"));	    //21
			vpd.put("var22", varOList.get(i).getString("SCHOOL"));	    //22
			vpd.put("var23", varOList.get(i).getString("MAJOR"));	    //23
			vpd.put("var24", varOList.get(i).getString("FTITLE"));	    //24
			vpd.put("var25", varOList.get(i).getString("CERTIFICATE"));	    //25
			vpd.put("var26", varOList.get(i).get("CONTRACTLENGTH"));	//26
			vpd.put("var27", varOList.get(i).getString("CSTARTTIME"));	    //27
			vpd.put("var28", varOList.get(i).getString("CENDTIME"));	    //28
			vpd.put("var29", varOList.get(i).getString("ADDRESS"));	    //29
			vpd.put("var30", varOList.get(i).getString("USER_ID"));	    //30
			vpd.put("var31", varOList.get(i).getString("BZ"));	    //31
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
}
