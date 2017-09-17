package com.fh.controller.fhoa.machine;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.fhoa.machine.MachineRecordManager;
import com.fh.util.*;
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
 * 说明：机器操作记录
 * 创建人：FH Q313596790
 * 创建时间：2017-09-16
 */
@Controller
@RequestMapping(value="/machinerecord")
public class MachineRecordController extends BaseController {
	
	String menuUrl = "machinerecord/list.do"; //菜单地址(权限用)
	@Resource(name="machinerecordService")
	private MachineRecordManager machinerecordService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增MachineRecord");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MACHINERECORD_ID", this.get32UUID());	//主键
		machinerecordService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除MachineRecord");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		machinerecordService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改MachineRecord");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		machinerecordService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表MachineRecord");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = machinerecordService.list(page);	//列出MachineRecord列表
		mv.setViewName("fhoa/machinerecord/machinerecord_list");
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
		mv.setViewName("fhoa/machinerecord/machinerecord_edit");
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
		pd = machinerecordService.findById(pd);	//根据ID读取
		mv.setViewName("fhoa/machinerecord/machinerecord_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除MachineRecord");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			machinerecordService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 根据机器id
	 * @return
	 * @throws Exception
     */
	@RequestMapping(value="/findByMhid")
	@ResponseBody
	public ResultData findByMhid()throws Exception{
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			if(pd.get("mhid") == null || "".equals(pd.get("mhid").toString())){
				return ResultData.init(ResultData.SUCCESS,"参数不对",null);
			}
			pd = machinerecordService.findByMhid(pd);	//根据ID读取
			return ResultData.init(ResultData.SUCCESS,"查询成功",pd);
		} catch (Exception e) {
			e.printStackTrace();
			return ResultData.init(ResultData.SUCCESS,"查询失败",null);
		}
	}

	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出MachineRecord到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("备注1");	//1
		titles.add("机器id");	//2
		titles.add("员工id");	//3
		titles.add("小车id");	//4
		titles.add("扫描了类型");	//5
		titles.add("操作类型");	//6
		titles.add("维修部位");	//7
		titles.add("目标规格");	//8
		titles.add("更改部位");	//9
		titles.add("维修开始时间");	//10
		titles.add("维修结束时间");	//11
		titles.add("公司id");	//12
		dataMap.put("titles", titles);
		List<PageData> varOList = machinerecordService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("MRID"));	    //1
			vpd.put("var2", varOList.get(i).getString("MHID"));	    //2
			vpd.put("var3", varOList.get(i).getString("STAFF_ID"));	    //3
			vpd.put("var4", varOList.get(i).get("CAR_ID").toString());	//4
			vpd.put("var5", varOList.get(i).getString("SCAN_TYPE"));	    //5
			vpd.put("var6", varOList.get(i).getString("OPERATION_TYPE"));	    //6
			vpd.put("var7", varOList.get(i).getString("REPAIR_POSITION"));	    //7
			vpd.put("var8", varOList.get(i).getString("TARGET_RULE"));	    //8
			vpd.put("var9", varOList.get(i).getString("CHANGE_POSITION"));	    //9
			vpd.put("var10", varOList.get(i).getString("START_DATE"));	    //10
			vpd.put("var11", varOList.get(i).getString("String,END_DATE"));	    //11
			vpd.put("var12", varOList.get(i).get("String,COMPANY_ID").toString());	//12
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
