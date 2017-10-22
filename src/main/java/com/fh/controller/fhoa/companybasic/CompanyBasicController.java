package com.fh.controller.fhoa.companybasic;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.service.fhoa.companybasic.CompanyBasicManager;
import com.fh.service.system.fhlog.FHlogManager;
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
 * 说明：公司基础信息
 * 创建人：FH Q313596790
 * 创建时间：2017-08-14
 */
@Controller
@RequestMapping(value="/companybasic")
public class CompanyBasicController extends BaseController {
	
	String menuUrlField = "companybasic/fieldList.do"; //资质行业配置
	String menuUrlSequence = "companybasic/sequenceList.do"; //资质序列major
	String menuUrlMajor = "companybasic/majorList.do"; //资质专业major
	String menuUrlLevel = "companybasic/levelList.do"; //资质等级配置
	String menuUrlStaffPost = "companybasic/staffPostList.do"; //人员岗位配置
	String menuUrlMachineType = "companybasic/machineTypeList.do"; //机器类型配置
	String menuUrlCarType = "companybasic/carTypeList.do"; //小推车类型配置
	String menuUrlMachineRule = "companybasic/machineRuleList.do"; //机器规格
	String menuUrlMaintenanceProject = "companybasic/maintenanceProjectList.do"; //维修项目
	String menuUrlMachineCycle = "companybasic/machineCycleList.do"; //机器保养周期
	String menuUrlRulePosition = "companybasic/rulePositionList.do"; //规格更改部位

	@Resource(name="companybasicService")
	private CompanyBasicManager companybasicService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增CompanyBasic");

		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String type = pd.get("TYPE").toString();
		if(type.equals(Const.COMPANY_BASIC_FIELD)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlField, "add")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "新增资质行业配置");
		}else if(type.equals(Const.COMPANY_BASIC_SEQUENCE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlSequence, "add")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "新增资质序列");
		}else if(type.equals(Const.COMPANY_BASIC_MAJOR)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMajor, "add")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "新增资质专业");
		}else if(type.equals(Const.COMPANY_BASIC_LEVE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlLevel, "add")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "新增资质等级配置");
		}else if(type.equals(Const.COMPANY_BASIC_MACHINETYPE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineType, "add")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "新增机器类型配置");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","添加机器类型","添加",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_CARTYPE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlCarType, "add")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "新增小推车类型配置");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","添加小推车类型","添加",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_MACHINERULE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineRule, "add")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "新增机器规格");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","添加机器规格","添加",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_MAINTENANCEPROJECT)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMaintenanceProject, "add")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "新增维修项目");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","添加维修项目","添加",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_MACHINECYCLE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineCycle, "add")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "新增机器保养周期");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","添加维修周期","添加",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_RULEPOSITION)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlRulePosition, "add")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "新增规格更改部位");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","添加规格更改部位","添加",user.getNAME(),user.getCompanyId());
		}
		pd.put("COMPANY_ID",user.getCompanyId());

		companybasicService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除CompanyBasic");

		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd = this.getPageData();
		String type = pd.get("TYPE").toString();
		if(type.equals(Const.COMPANY_BASIC_FIELD)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlField, "del")){return;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_SEQUENCE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlSequence, "del")){return;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_MAJOR)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMajor, "del")){return;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_LEVE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlLevel, "del")){return;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_STAFFPOST)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlStaffPost, "del")){return;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "删除人员岗位配置");
		}else if(type.equals(Const.COMPANY_BASIC_MACHINETYPE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineType, "del")){return;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "删除机器类型配置");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","删除机器类型","删除",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_CARTYPE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlCarType, "del")){return;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "删除小推车类型配置");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","删除小推车类型","删除",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_MACHINERULE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineRule, "del")){return;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "删除机器规格");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","删除机器规格","删除",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_MAINTENANCEPROJECT)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMaintenanceProject, "del")){return;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "删除维修项目");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","删除维修项目","删除",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_MACHINECYCLE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineCycle, "del")){return;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "删除机器保养周期");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","删除维修周期","删除",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_RULEPOSITION)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlRulePosition, "del")){return;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "删除规格更改部位");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","删除规格更改部位","删除",user.getNAME(),user.getCompanyId());
		}
		companybasicService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改CompanyBasic");

		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String type = pd.get("TYPE").toString();
		if(type.equals(Const.COMPANY_BASIC_FIELD)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlField, "edit")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_SEQUENCE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlSequence, "edit")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_MAJOR)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMajor, "edit")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_LEVE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlLevel, "edit")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_STAFFPOST)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlStaffPost, "edit")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "修改人员岗位配置");
		}else if(type.equals(Const.COMPANY_BASIC_MACHINETYPE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineType, "edit")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "修改机器类型配置");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","修改机器类型","修改",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_CARTYPE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlCarType, "edit")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "修改小推车类型配置");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","修改小推车类型","修改",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_MACHINERULE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineRule, "edit")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "修改机器规格");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","修改机器规格","修改",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_MAINTENANCEPROJECT)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMaintenanceProject, "edit")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "修改维修项目");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","修改维修项目","修改",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_MACHINECYCLE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineCycle, "edit")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "修改机器保养周期");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","修改维修周期","修改",user.getNAME(),user.getCompanyId());
		}else if(type.equals(Const.COMPANY_BASIC_RULEPOSITION)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlRulePosition, "edit")){return null;} //校验权限
			//FHLOG.save(Jurisdiction.getUsername(), "修改规格更改部位");
			FHLOG.save(user.getUSERNAME(),null,"设备管理模块","修改规格更改部位","修改",user.getNAME(),user.getCompanyId());
		}

		pd.put("COMPANY_ID",user.getCompanyId());
		companybasicService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/fieldList")
	public ModelAndView fieldList(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表CompanyBasic");
		//if(!Jurisdiction.buttonJurisdiction(menuUrlField, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		return  allList(page,Const.COMPANY_BASIC_FIELD);
	}
	@RequestMapping(value="/sequenceList")
	public ModelAndView sequenceList(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表CompanyBasic");
		//if(!Jurisdiction.buttonJurisdiction(menuUrlSequence, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		return  allList(page,Const.COMPANY_BASIC_SEQUENCE);
	}
	@RequestMapping(value="/majorList")
	public ModelAndView majorList(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表CompanyBasic");
		//if(!Jurisdiction.buttonJurisdiction(menuUrlMajor, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		return  allList(page,Const.COMPANY_BASIC_MAJOR);
	}

	@RequestMapping(value="/levelList")
	public ModelAndView levelList(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表CompanyBasic");
		//if(!Jurisdiction.buttonJurisdiction(menuUrlLevel, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		return  allList(page,Const.COMPANY_BASIC_LEVE);
	}

	/**
	 * 人员岗位配置
	 * @param page
	 * @return
	 * @throws Exception
     */
	@RequestMapping(value="/staffPostList")
	public ModelAndView staffPost(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表 staffPost");
		//if(!Jurisdiction.buttonJurisdiction(menuUrlStaffPost, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		return  allList(page,Const.COMPANY_BASIC_STAFFPOST);
	}

	/**
	 * 机器类型配置
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/machineTypeList")
	public ModelAndView machineType (Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表 machineType");
		//if(!Jurisdiction.buttonJurisdiction(menuUrlMachineType, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		return  allList(page,Const.COMPANY_BASIC_MACHINETYPE);
	}

	/**
	 * 小推车配置
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/carTypeList")
	public ModelAndView carType(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表 carType");
		//if(!Jurisdiction.buttonJurisdiction(menuUrlCarType, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		return  allList(page,Const.COMPANY_BASIC_CARTYPE);
	}

	/**
	 * 机器规格配置
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/machineRuleList")
	public ModelAndView machineRule(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表 machineRule");
		//if(!Jurisdiction.buttonJurisdiction(menuUrlMachineRule, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		return  allList(page,Const.COMPANY_BASIC_MACHINERULE);
	}

	/**
	 * 维修项目配置
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/maintenanceProjectList")
	public ModelAndView maintenanceProject(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表 maintenanceProject");
		//if(!Jurisdiction.buttonJurisdiction(menuUrlMaintenanceProject, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		return  allList(page,Const.COMPANY_BASIC_MAINTENANCEPROJECT);
	}

	/**
	 * 保养周期配置
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/machineCycleList")
	public ModelAndView machineCycle(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表 machineCycle");
		//if(!Jurisdiction.buttonJurisdiction(menuUrlMachineCycle, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		return  allList(page,Const.COMPANY_BASIC_MACHINECYCLE);
	}

	/**
	 * 规格更改部位	配置
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/rulePositionList")
	public ModelAndView rulePosition(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表staffPost");
		//if(!Jurisdiction.buttonJurisdiction(menuUrlRulePosition, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		return  allList(page,Const.COMPANY_BASIC_RULEPOSITION);
	}

	public ModelAndView allList(Page page,String type)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		//设置公司信息查询
		pd.put("COMPANY_ID",user.getCompanyId());
		//设置查询类型
		pd.put("TYPE",type);

		page.setPd(pd);
		List<PageData>	varList = companybasicService.list(page);	//列出CompanyBasic列表
		mv.setViewName("fhoa/companybasic/companybasic_list");
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
		int orderNum = companybasicService.getTypeOrder(pd);
		pd.put("OCB_ORDER",orderNum+1);
		mv.setViewName("fhoa/companybasic/companybasic_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
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
		pd = companybasicService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/companybasic/companybasic_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除CompanyBasic");
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String type = pd.get("TYPE").toString();
		if(type.equals(Const.COMPANY_BASIC_FIELD)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlField, "del")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_SEQUENCE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlSequence, "del")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_MAJOR)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMajor, "del")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_LEVE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlLevel, "del")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_STAFFPOST)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlStaffPost, "del")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_MACHINETYPE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineType, "del")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_CARTYPE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlCarType, "del")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_MACHINERULE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineRule, "del")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_MAINTENANCEPROJECT)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMaintenanceProject, "del")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_MACHINECYCLE)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlMachineCycle, "del")){return null;} //校验权限
		}else if(type.equals(Const.COMPANY_BASIC_RULEPOSITION)){
			if(!Jurisdiction.buttonJurisdiction(menuUrlRulePosition, "del")){return null;} //校验权限
		}
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			companybasicService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出CompanyBasic到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrlField, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("备注1");	//1
		titles.add("备注2");	//2
		titles.add("备注3");	//3
		titles.add("备注4");	//4
		titles.add("备注5");	//5
		titles.add("备注6");	//6
		dataMap.put("titles", titles);
		List<PageData> varOList = companybasicService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).get("OCBID").toString());	//1
			vpd.put("var2", varOList.get(i).getString("NAME"));	    //2
			vpd.put("var3", varOList.get(i).get("STATUS").toString());	//3
			vpd.put("var4", varOList.get(i).get("OCB_ORDER").toString());	//4
			vpd.put("var5", varOList.get(i).getString("OCB_DESC"));	    //5
			vpd.put("var6", varOList.get(i).getString("TYPE"));	    //6
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
