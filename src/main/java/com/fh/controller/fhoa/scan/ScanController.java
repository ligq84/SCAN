package com.fh.controller.fhoa.scan;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Dictionaries;
import com.fh.entity.system.User;
import com.fh.service.fhoa.company.CompanyManager;
import com.fh.service.system.dictionaries.DictionariesManager;
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
 * 说明：公司信息
 * 创建人：FH Q313596790
 * 创建时间：2017-08-05
 */
@Controller
@RequestMapping(value="/scan")
public class ScanController extends BaseController {
	
	String menuUrl = "company/list.do"; //菜单地址(权限用)
	@Resource(name="companyService")
	private CompanyManager companyService;

	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Company");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMPANY_ID", this.get32UUID());	//主键
		companyService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Company");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		companyService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Company");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		companyService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 *公司信息首页
	 * @return
	 * @throws Exception
     */
	@RequestMapping(value="/toCompany")
	public ModelAndView toCompany() throws Exception{
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMPANY_ID",user.getCompanyId());
		pd = companyService.findById(pd);	//根据ID读取


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
		//获取公司性质下拉框
		List<Dictionaries>	natureList = dictionariesService.listSubDictByParentId("08b2ec9fbc9f426cb86530fd262412cf");
		List<PageData> nuList = new ArrayList<PageData>();
		for(Dictionaries d :natureList){
			PageData pdf = new PageData();
			pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
			pdf.put("NAME", d.getNAME());
			nuList.add(pdf);
		}
		mv.addObject("natureList",nuList);
		//获取公司经济类型
		List<Dictionaries>	economicTypeList = dictionariesService.listSubDictByParentId("a9b1cb4f23a743d0aee68b15bb865710");
		List<PageData> etList = new ArrayList<PageData>();
		for(Dictionaries d :economicTypeList){
			PageData pdf = new PageData();
			pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
			pdf.put("NAME", d.getNAME());
			etList.add(pdf);
		}
		mv.addObject("economicTypeList",etList);


		mv.setViewName("fhoa/company/company_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);

		return mv;
	}

	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Company");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = companyService.list(page);	//列出Company列表
		mv.setViewName("fhoa/company/company_list");
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
		mv.setViewName("fhoa/company/company_edit");
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
		pd = companyService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/company/company_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Company");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			companyService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Company到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
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
		titles.add("备注7");	//7
		titles.add("备注8");	//8
		titles.add("备注9");	//9
		titles.add("备注10");	//10
		titles.add("备注11");	//11
		titles.add("备注12");	//12
		titles.add("备注13");	//13
		titles.add("备注14");	//14
		titles.add("备注15");	//15
		titles.add("备注16");	//16
		titles.add("备注17");	//17
		titles.add("备注18");	//18
		titles.add("备注19");	//19
		titles.add("备注20");	//20
		titles.add("备注21");	//21
		titles.add("备注22");	//22
		titles.add("备注23");	//23
		titles.add("备注24");	//24
		titles.add("备注25");	//25
		titles.add("备注26");	//26
		titles.add("备注27");	//27
		titles.add("备注28");	//28
		titles.add("备注29");	//29
		titles.add("备注30");	//30
		titles.add("备注31");	//31
		titles.add("备注32");	//32
		titles.add("备注33");	//33
		titles.add("备注34");	//34
		titles.add("备注35");	//35
		titles.add("备注36");	//36
		titles.add("备注37");	//37
		titles.add("备注38");	//38
		titles.add("备注39");	//39
		titles.add("备注40");	//40
		titles.add("备注41");	//41
		titles.add("备注42");	//42
		titles.add("备注43");	//43
		titles.add("备注44");	//44
		dataMap.put("titles", titles);
		List<PageData> varOList = companyService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).get("COMPANY_ID").toString());	//1
			vpd.put("var2", varOList.get(i).getString("NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("CODE"));	    //3
			vpd.put("var4", varOList.get(i).get("PROVINCE").toString());	//4
			vpd.put("var5", varOList.get(i).get("CITY").toString());	//5
			vpd.put("var6", varOList.get(i).get("AREA").toString());	//6
			vpd.put("var7", varOList.get(i).getString("ADDRESS"));	    //7
			vpd.put("var8", varOList.get(i).getString("POSTAL_CODE"));	    //8
			vpd.put("var9", varOList.get(i).get("NATURE").toString());	//9
			vpd.put("var10", varOList.get(i).getString("BUSINESS_LICENSE"));	    //10
			vpd.put("var11", varOList.get(i).getString("ORGANIZATION_NUMBER"));	    //11
			vpd.put("var12", varOList.get(i).get("ECONOMIC_TYPE").toString());	//12
			vpd.put("var13", varOList.get(i).getString("REGISTERED_CAPITAL"));	    //13
			vpd.put("var14", varOList.get(i).getString("COMPANY_URL"));	    //14
			vpd.put("var15", varOList.get(i).getString("ISSUING_AUTHORITY"));	    //15
			vpd.put("var16", varOList.get(i).getString("START_TIME"));	    //16
			vpd.put("var17", varOList.get(i).getString("END_TIME"));	    //17
			vpd.put("var18", varOList.get(i).getString("CORPORATION"));	    //18
			vpd.put("var19", varOList.get(i).getString("TECHNOLOGY_DIRECTOR"));	    //19
			vpd.put("var20", varOList.get(i).getString("FINANCIAL_PRINCIPAL"));	    //20
			vpd.put("var21", varOList.get(i).get("NUMBER_EMPLOYEE").toString());	//21
			vpd.put("var22", varOList.get(i).get("NUMBER_PM").toString());	//22
			vpd.put("var23", varOList.get(i).get("NUMBER_SENIOR").toString());	//23
			vpd.put("var24", varOList.get(i).get("NUMBER_INTERMEDIATE").toString());	//24
			vpd.put("var25", varOList.get(i).get("NUMBER_PRIMARY").toString());	//25
			vpd.put("var26", varOList.get(i).get("NUMBER_TOTAL").toString());	//26
			vpd.put("var27", varOList.get(i).getString("COMPANY_DESC"));	    //27
			vpd.put("var28", varOList.get(i).getString("CONTACTS_NAME"));	    //28
			vpd.put("var29", varOList.get(i).getString("CONTACTS_TELEPHONE"));	    //29
			vpd.put("var30", varOList.get(i).getString("CONTACTS_MAIL"));	    //30
			vpd.put("var31", varOList.get(i).getString("CONTACTS_FAX"));	    //31
			vpd.put("var32", varOList.get(i).get("START_BANK").toString());	//32
			vpd.put("var33", varOList.get(i).getString("BRANCH_BANK"));	    //33
			vpd.put("var34", varOList.get(i).getString("ACCOUNT_BANK"));	    //34
			vpd.put("var35", varOList.get(i).getString("IMAGE_BUSINESS"));	    //35
			vpd.put("var36", varOList.get(i).getString("IMAGE_ORGANIZATION"));	    //36
			vpd.put("var37", varOList.get(i).getString("IMAGE_SECURITY"));	    //37
			vpd.put("var38", varOList.get(i).getString("IMAGE_CORPORATION_IDCARD_POSITIVE"));	    //38
			vpd.put("var39", varOList.get(i).getString("IMAGE_CORPORATION_IDCARD_SIDE"));	    //39
			vpd.put("var40", varOList.get(i).getString("IMAGE_OTHER1"));	    //40
			vpd.put("var41", varOList.get(i).getString("IMAGE_OTHER2"));	    //41
			vpd.put("var42", varOList.get(i).getString("IMAGE_OTHER3"));	    //42
			vpd.put("var43", varOList.get(i).getString("IMAGE_OTHER4"));	    //43
			vpd.put("var44", varOList.get(i).getString("IMAGE_OTHER5"));	    //44
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
