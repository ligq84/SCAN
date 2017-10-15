package com.fh.controller.fhoa.car;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.interceptor.Log;
import com.fh.service.fhoa.car.CarManager;
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
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/** 
 * 说明：小推车信息
 * 创建人：FH Q313596790
 * 创建时间：2017-09-03
 */
@Controller
@RequestMapping(value="/car")
public class CarController extends BaseController {
	
	String menuUrl = "car/list.do"; //菜单地址(权限用)
	@Resource(name="carService")
	private CarManager carService;
	@Resource(name="companybasicService")
	private CompanyBasicManager companybasicService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@Log(model = "设备管理模块",function="添加小推车",type = "添加")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Car");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		//FHLOG.save(Jurisdiction.getUsername(), "新增小推车");
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//pd.put("CAR_ID", this.get32UUID());	//主键
		pd.put("COMPANY_ID",user.getCompanyId());
		carService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@Log(model = "设备管理模块",function="删除小推车",type = "删除")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Car");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		//FHLOG.save(Jurisdiction.getUsername(), "删除小推车");
		PageData pd = new PageData();
		pd = this.getPageData();
		carService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	@Log(model = "设备管理模块",function="修改小推车",type = "修改")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Car");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		//FHLOG.save(Jurisdiction.getUsername(), "修改小推车");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		carService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Car");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMPANY_ID",user.getCompanyId());
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = carService.list(page);	//列出Car列表

		//获取小推车类型
		PageData carpd = new PageData();
		carpd.put("TYPE","carType");
		carpd.put("STATUS",1);
		carpd.put("COMPANY_ID",user.getCompanyId());
		Page carpage = new Page();
		carpage.setPd(carpd);
		List<PageData>	carTypeList = companybasicService.list(carpage);
		mv.addObject("carTypeList",carTypeList);

		mv.setViewName("fhoa/car/car_list");
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
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd = this.getPageData();
		//编码生成规则 qg+公司id +时间戳
		String BARCODE= ""+user.getCompanyId()+new Date().getTime();
		pd.put("BARCODE",BARCODE);

		//获取小推车类型
		pd.put("TYPE","carType");
		pd.put("STATUS",1);
		pd.put("COMPANY_ID",user.getCompanyId());
		Page page = new Page();
		page.setPd(pd);
		List<PageData>	carTypeList = companybasicService.list(page);
		pd.put("TYPE",null);
		mv.addObject("carTypeList",carTypeList);

		mv.setViewName("fhoa/car/car_edit");
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
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMPANY_ID",user.getCompanyId());
		//获取小推车类型
		pd.put("TYPE","carType");
		pd.put("STATUS",1);
		pd.put("COMPANY_ID",user.getCompanyId());
		Page page = new Page();
		page.setPd(pd);
		List<PageData>	carTypeList = companybasicService.list(page);
		pd.put("TYPE",null);
		mv.addObject("carTypeList",carTypeList);

		pd = carService.findById(pd);	//根据ID读取

		mv.setViewName("fhoa/car/car_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Car");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			carService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	@RequestMapping(value="/printPage")
	@Log(model = "设备管理模块",function="打印小推车条码",type = "新增")
	@SuppressWarnings("all")
	public ModelAndView printPage(HttpServletRequest request) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = carService.findById(pd);
		FHLOG.save(Jurisdiction.getUsername(), "打印小推车条码");
		//if(null == pd.get("BARCODEURL") || "".equals(pd.getString("BARCODEURL"))){
			String filePath = PathUtil.getClasspath();

			String fileName = pd.get("BARCODE").toString()+".jpg";
			String systemPath = "/uploadFiles/barcode/";
			File fileppath = new File(filePath+systemPath);
			if (!fileppath .exists()  && !fileppath .isDirectory())
			{
				fileppath .mkdir();
			}

			File file = new File(filePath+systemPath+fileName);
			if(!file.exists()){
				file.createNewFile();
			}else {
				file.delete();
				file.createNewFile();
			}
			OneDimensionCode.getBarcodeWriteFile(pd.get("BARCODE").toString(),600,150, file);
			String BARCODEURL ="http://" + request.getServerName()+":" +request.getServerPort()+systemPath+fileName;
			pd.put("BARCODEURL",BARCODEURL);
			carService.edit(pd);
		//}
		mv.setViewName("fhoa/car/printPage");
		mv.addObject("pd", pd);
		return mv;
	}
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Car到excel");
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
		dataMap.put("titles", titles);
		List<PageData> varOList = carService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).get("CAR_ID").toString());	//1
			vpd.put("var2", varOList.get(i).getString("NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("BIANHAO"));	    //3
			vpd.put("var4", varOList.get(i).getString("TYPE"));	    //4
			vpd.put("var5", varOList.get(i).getString("PURCHASEDATE"));	    //5
			vpd.put("var6", varOList.get(i).getString("BARCODE"));	    //6
			vpd.put("var7", varOList.get(i).getString("BARCODEURL"));	    //7
			vpd.put("var8", varOList.get(i).get("COMPANY_ID").toString());	//8
			vpd.put("var9", varOList.get(i).get("DELETED").toString());	//9
			vpd.put("var10", varOList.get(i).getString("BZ"));	    //10
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
