package com.fh.controller.fhoa.staff;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Dictionaries;
import com.fh.entity.system.Role;
import com.fh.entity.system.User;
import com.fh.interceptor.Log;
import com.fh.service.fhoa.companybasic.CompanyBasicManager;
import com.fh.service.fhoa.datajur.DatajurManager;
import com.fh.service.fhoa.department.DepartmentManager;
import com.fh.service.fhoa.staff.StaffManager;
import com.fh.service.system.dictionaries.DictionariesManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.role.RoleManager;
import com.fh.service.system.user.UserManager;
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
 * 说明：员工管理
 * 创建人：FH Q313596790
 * 创建时间：2016-04-23
 */
@Controller
@RequestMapping(value="/staff")
public class StaffController extends BaseController {
	
	String menuUrl = "staff/list.do"; //菜单地址(权限用)
	@Resource(name="staffService")
	private StaffManager staffService;
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="datajurService")
	private DatajurManager datajurService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	@Resource(name="roleService")
	private RoleManager roleService;
	@Resource(name="userService")
	private UserManager userService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="companybasicService")
	private CompanyBasicManager companybasicService;

	/**保存
	 * @param
	 * @throws Exception
	 */

	@RequestMapping(value="/save")
	@ResponseBody
	@Log(model = "人员管理模块",function="添加人员",type = "添加")
	public ResultData save() throws Exception{

		logBefore(logger, Jurisdiction.getUsername()+"新增Staff");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){ return ResultData.init(ResultData.FAIL,"没有权限",null);} //校验权限
		try {
			Session session = Jurisdiction.getSession();
			User user = (User)session.getAttribute(Const.SESSION_USER);

			PageData pd = new PageData();
			pd = this.getPageData();
			//增加登录用户
			PageData uspd = new PageData();
			uspd.put("USER_ID", this.get32UUID());	//ID 主键
			uspd.put("LAST_LOGIN", "");				//最后登录时间
			uspd.put("IP", "");						//IP
			uspd.put("STATUS", "0");					//状态
			uspd.put("SKIN", "default");
			uspd.put("RIGHTS", "");
			uspd.put("PASSWORD", pd.get("PASSWORD"));	//密码加密
			uspd.put("ROLE_ID", pd.get("ROLE_ID"));
			uspd.put("USERNAME",pd.get("USERNAME"));
			uspd.put("NUMBER", Math.random()*1000+1);
			uspd.put("NAME",pd.get("NAME"));
			uspd.put("PHONE", pd.get("TEL"));
			uspd.put("EMAIL",pd.get("EMAIL"));
			uspd.put("BZ", "");
			uspd.put("COMPANY_ID",user.getCompanyId());
			if(null == userService.findByUsername(uspd)){	//判断用户名是否存在
                userService.saveU(uspd); 					//执行保存
                //FHLOG.save(Jurisdiction.getUsername(), "新增系统用户："+pd.getString("USERNAME"));
            }

			//员工信息添加
			pd.put("STAFF_ID", this.get32UUID());	//主键
			pd.put("USER_ID", uspd.get("USER_ID"));

			pd.put("COMPANY_ID",user.getCompanyId());
			staffService.save(pd);					//保存员工信息到员工表
			//FHLOG.save(Jurisdiction.getUsername(), "新增员工："+pd.getString("USERNAME"));

			String DEPARTMENT_IDS = departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID"));//获取某个部门所有下级部门ID
			pd.put("DATAJUR_ID", pd.getString("STAFF_ID")); //主键
			pd.put("DEPARTMENT_IDS", DEPARTMENT_IDS);		//部门ID集
			datajurService.save(pd);						//把此员工默认部门及以下部门ID保存到组织数据权限表
			return ResultData.init(ResultData.SUCCESS,"添加成功",null);
		} catch (Exception e) {
			e.printStackTrace();
			return ResultData.init(ResultData.FAIL,"添加异常","");
		}

	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@Log(model = "人员管理模块",function="删除人员",type = "删除")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Staff");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		staffService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	@Log(model = "人员管理模块",function="修改人员",type = "修改")
	public ResultData edit() throws Exception{

		try {

			logBefore(logger, Jurisdiction.getUsername()+"修改Staff");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限PageData uspd = new PageData();
			Session session = Jurisdiction.getSession();
			User user = (User)session.getAttribute(Const.SESSION_USER);
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("COMPANY_ID",user.getCompanyId());

			//增加登录用户
			PageData uspd = new PageData();
			uspd.put("USER_ID", this.get32UUID());	//ID 主键
			uspd.put("LAST_LOGIN", "");				//最后登录时间
			uspd.put("IP", "");						//IP
			uspd.put("STATUS", "0");					//状态
			uspd.put("SKIN", "default");
			uspd.put("RIGHTS", "");
			uspd.put("PASSWORD", pd.get("PASSWORD"));
			uspd.put("ROLE_ID", pd.get("ROLE_ID"));
			uspd.put("USERNAME",pd.get("USERNAME"));
			uspd.put("NUMBER", Math.random()*1000+1);
			uspd.put("NAME",pd.get("NAME"));
			uspd.put("PHONE", pd.get("TEL"));
			uspd.put("EMAIL",pd.get("EMAIL"));
			uspd.put("BZ", "");
			uspd.put("COMPANY_ID",user.getCompanyId());
			PageData sysuser = userService.findByUsername(uspd);
			if(null == sysuser){	//判断用户名是否存在
				userService.saveU(uspd); 					//执行保存
				//FHLOG.save(Jurisdiction.getUsername(), "新增系统用户："+pd.getString("USERNAME"));
				pd.put("USER_ID", uspd.get("USER_ID"));
			}else{
				sysuser.put("ROLE_ID",pd.get("ROLE_ID"));
				sysuser.put("PASSWORD",pd.get("PASSWORD"));
				sysuser.put("USERNAME",pd.get("USERNAME"));
				userService.editU(sysuser);
				pd.put("USER_ID", sysuser.get("USER_ID"));
			}
			staffService.edit(pd);
			String DEPARTMENT_IDS = departmentService.getDEPARTMENT_IDS(pd.getString("DEPARTMENT_ID"));//获取某个部门所有下级部门ID
			pd.put("DATAJUR_ID", pd.getString("STAFF_ID")); //主键
			pd.put("DEPARTMENT_IDS", DEPARTMENT_IDS);		//部门ID集
			datajurService.edit(pd);						//把此员工默认部门及以下部门ID保存到组织数据权限表
			return ResultData.init(ResultData.SUCCESS,"更新成功","");
		} catch (Exception e) {
			e.printStackTrace();
			return ResultData.init(ResultData.FAIL,"更新异常","");
		}

	}
	
	/**列表(检索条件中的部门，只列出此操作用户最高部门权限以下所有部门的员工)
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Staff");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMPANY_ID",user.getCompanyId());

		page.setPd(pd);
		List<PageData>	varList = staffService.list(page);

		//人员岗位下拉列表
		PageData postpd = new PageData();
		postpd.put("COMPANY_ID",user.getCompanyId());
		postpd.put("TYPE","staffPost");
		postpd.put("STATUS",1);
		Page postpage =new Page();
		postpage.setPd(postpd);
		List<PageData>	staffPostList = companybasicService.list(postpage);
		mv.addObject("staffPostList",staffPostList);

		//部门列表下拉框
		PageData spd = new PageData();
		spd.put("COMPANY_ID",user.getCompanyId());
		List<PageData>	deptList = departmentService.deptListAll(spd);

		mv.addObject("deptList", deptList);
		mv.setViewName("fhoa/staff/staff_list");
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
	@SuppressWarnings("all")
	public ModelAndView goAdd()throws Exception{
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMPANY_ID",user.getCompanyId());
		pd.put("ROLE_ID","1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);//列出会员组角色
		mv.addObject("roleList", roleList);

		List<Dictionaries>	provinceList = dictionariesService.listSubDictByParentId("1"); //用传过来的ID获取此ID下的子列表数据
		List<PageData> pnList = new ArrayList<PageData>();
		for(Dictionaries d :provinceList){
			PageData pdf = new PageData();
			pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
			pdf.put("NAME", d.getNAME());
			pnList.add(pdf);
		}
		mv.addObject("PROVINCEList",pnList);

		if(null!=pd.get("CITY")){
			List<Dictionaries>	varList = dictionariesService.listSubDictByParentId(pd.get("PROVINCE").toString()); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdList = new ArrayList<PageData>();
			for(Dictionaries d :varList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdList.add(pdf);
			}
			mv.addObject("CITYList",pdList);
		}
		if(null!=pd.get("AREA")){
			List<Dictionaries>	varList = dictionariesService.listSubDictByParentId(pd.get("CITY").toString()); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdList = new ArrayList<PageData>();
			for(Dictionaries d :varList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdList.add(pdf);
			}
			mv.addObject("AREAList",pdList);
		}
		//人员岗位下拉列表
		PageData gwpd = new PageData();
		gwpd.put("COMPANY_ID",user.getCompanyId());
		gwpd.put("TYPE","staffPost");
		gwpd.put("STATUS",1);
		Page page = new Page();
		page.setPd(gwpd);
		List<PageData>	staffPostList = companybasicService.list(page);
		mv.addObject("staffPostList",staffPostList);

		//部门列表下拉框
		PageData spd = new PageData();
		spd.put("COMPANY_ID",user.getCompanyId());
		List<PageData>	deptList = departmentService.deptListAll(spd);
		mv.addObject("deptList",deptList);

		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		mv.setViewName("fhoa/staff/staff_edit");
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	@SuppressWarnings("all")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMPANY_ID",user.getCompanyId());
		pd.put("ROLE_ID","1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);//列出会员组角色
		mv.addObject("roleList", roleList);
		pd = staffService.findById(pd);	//根据ID读取
		List<Dictionaries>	provinceList = dictionariesService.listSubDictByParentId("1"); //用传过来的ID获取此ID下的子列表数据
		List<PageData> pnList = new ArrayList<PageData>();
		for(Dictionaries d :provinceList){
			PageData pdf = new PageData();
			pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
			pdf.put("NAME", d.getNAME());
			pnList.add(pdf);
		}
		mv.addObject("PROVINCEList",pnList);

		if(null!=pd.get("CITY")){
			List<Dictionaries>	varList = dictionariesService.listSubDictByParentId(pd.get("PROVINCE").toString()); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdList = new ArrayList<PageData>();
			for(Dictionaries d :varList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdList.add(pdf);
			}
			mv.addObject("CITYList",pdList);
		}
		if(null!=pd.get("AREA")){
			List<Dictionaries>	varList = dictionariesService.listSubDictByParentId(pd.get("CITY").toString()); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdList = new ArrayList<PageData>();
			for(Dictionaries d :varList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("NAME", d.getNAME());
				pdList.add(pdf);
			}
			mv.addObject("AREAList",pdList);
		}
		//人员岗位下拉列表
		String status = pd.get("STATUS")+"";
		pd.put("TYPE","staffPost");
		pd.put("STATUS",1);
		Page page = new Page();
		page.setPd(pd);
		List<PageData>	staffPostList = companybasicService.list(page);
		mv.addObject("staffPostList",staffPostList);
		pd.put("STATUS",status);

		//部门列表下拉框
		PageData spd = new PageData();
		spd.put("COMPANY_ID",user.getCompanyId());
		List<PageData>	deptList = departmentService.deptListAll(spd);
		mv.addObject("deptList",deptList);


		mv.setViewName("fhoa/staff/staff_edit");
		//mv.addObject("depname", departmentService.findById(pd).getString("NAME"));
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Staff");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			staffService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**绑定用户
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/userBinding")
	@ResponseBody
	public Object userBinding() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"绑定用户");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		staffService.userBinding(pd);
		return AppUtil.returnObject(pd, map);
	}
	@RequestMapping(value="/listAll")
	@ResponseBody
	public ResultData staffListAll() throws Exception{
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		pd.put("COMPANY_ID",user.getCompanyId());

		List<PageData>  pageList = staffService.listAll(pd);
		List<PageData> dataList = new ArrayList<PageData>();
		for(PageData pageData:pageList){
			PageData npd = new PageData();
			npd.put("label",pageData.get("NAME"));
			npd.put("value",pageData.get("NAME"));
			npd.put("STAFF_ID",pageData.get("STAFF_ID"));
			npd.put("TEL",pageData.get("TEL"));
			dataList.add(npd);
		}
		return ResultData.init(ResultData.SUCCESS,"添加成功",dataList);
	}
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Staff到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
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
			vpd.put("var26", varOList.get(i).get("CONTRACTLENGTH").toString());	//26
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
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
