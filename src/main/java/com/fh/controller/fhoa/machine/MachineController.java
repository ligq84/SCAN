package com.fh.controller.fhoa.machine;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.fhoa.companybasic.CompanyBasicManager;
import com.fh.service.fhoa.machine.MachineManager;
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
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/** 
 * 说明：机器信息
 * 创建人：FH Q313596790
 * 创建时间：2017-09-04
 */
@Controller
@RequestMapping(value="/machine")
public class MachineController extends BaseController {
	
	String menuUrl = "machine/list.do"; //菜单地址(权限用)
	@Resource(name="machineService")
	private MachineManager machineService;
	@Resource(name="staffService")
	private StaffManager staffService;
	@Resource(name="companybasicService")
	private CompanyBasicManager companybasicService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Machine");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MACHINE_ID", this.get32UUID());	//主键
		machineService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Machine");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		machineService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Machine");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		machineService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Machine");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = machineService.list(page);	//列出Machine列表
		mv.setViewName("fhoa/machine/machine_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		//机器编码生成
		String BARCODE= "qgc"+user.getCompanyId()+new Date().getTime();
		pd.put("BARCODE",BARCODE);
		//人员选择下拉列表
		pd.put("COMPANY_ID",user.getCompanyId());
		List<PageData> staffList = staffService.listAll(pd);
		mv.addObject("staffList", staffList);

		//机器类型下拉列表
		List<PageData>	staffPostList =  getBasicData(Const.COMPANY_BASIC_MACHINETYPE,1,user.getCompanyId());
		mv.addObject("machineTypeList",staffPostList);

		//保养周期
		List<PageData>	machineCycleList =  getBasicData(Const.COMPANY_BASIC_MACHINECYCLE,1,user.getCompanyId());
		mv.addObject("machineCycleList",machineCycleList);

		//维修项目
		List<PageData>	mpList = getBasicData(Const.COMPANY_BASIC_MAINTENANCEPROJECT,1,user.getCompanyId());
		mv.addObject("mpList",mpList);

		//机器规格
		List<PageData>	ruleList = getBasicData(Const.COMPANY_BASIC_MACHINERULE,1,user.getCompanyId());
		mv.addObject("ruleList",ruleList);

		///规格更改部位
		List<PageData>	rulePosttionList = getBasicData(Const.COMPANY_BASIC_RULEPOSITION,1,user.getCompanyId());
		mv.addObject("rulePosttionList",rulePosttionList);

		mv.setViewName("fhoa/machine/machine_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	public List<PageData> getBasicData(String type,int status,String companyid) throws Exception {
		PageData pd = new PageData();
		pd.put("TYPE",type);
		pd.put("STATUS",status);
		pd.put("COMPANY_ID",companyid);
		Page page = new Page();
		page.setPd(pd);
		List<PageData>	mpList = companybasicService.list(page);
		return  mpList;

	}
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = machineService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/machine/machine_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Machine");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			machineService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Machine到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("备注1");	//1
		titles.add("机器名称");	//2
		titles.add("类型");	//3
		titles.add("型号");	//4
		titles.add("功率");	//5
		titles.add("机器负责人");	//6
		titles.add("白班维修员");	//7
		titles.add("Night_Repairman");	//8
		titles.add("机器编码");	//9
		titles.add("条码图片路径");	//10
		titles.add("公司id");	//11
		titles.add("备注12");	//12
		titles.add("备注13");	//13
		titles.add("更改规格");	//14
		dataMap.put("titles", titles);
		List<PageData> varOList = machineService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).get("MHID").toString());	//1
			vpd.put("var2", varOList.get(i).getString("NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("TYPE"));	    //3
			vpd.put("var4", varOList.get(i).getString("MODEL"));	    //4
			vpd.put("var5", varOList.get(i).getString("POWER"));	    //5
			vpd.put("var6", varOList.get(i).getString("CHARGE"));	    //6
			vpd.put("var7", varOList.get(i).getString("DAY_REPAIRMAN"));	    //7
			vpd.put("var8", varOList.get(i).getString("NIGHT_REPAIRMAN"));	    //8
			vpd.put("var9", varOList.get(i).getString("BARCODE"));	    //9
			vpd.put("var10", varOList.get(i).getString("BARCODEURL"));	    //10
			vpd.put("var11", varOList.get(i).get("COMPANY_ID").toString());	//11
			vpd.put("var12", varOList.get(i).get("DELETED").toString());	//12
			vpd.put("var13", varOList.get(i).getString("BZ"));	    //13
			vpd.put("var14", varOList.get(i).get("CHANGE_RULE").toString());	//14
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
