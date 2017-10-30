package com.fh.controller.fhoa.machine;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.User;
import com.fh.interceptor.Log;
import com.fh.service.fhoa.companybasic.CompanyBasicManager;
import com.fh.service.fhoa.machine.MachineManager;
import com.fh.service.fhoa.staff.StaffManager;
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
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	@Log(model = "设备管理模块",function="添加机器",type = "添加")
	public ResultData save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Machine");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		//FHLOG.save(Jurisdiction.getUsername(), "新增机器");
		try {
			Session session = Jurisdiction.getSession();
			User user = (User)session.getAttribute(Const.SESSION_USER);
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("COMPANY_ID",user.getCompanyId());
			String MHID =  this.get32UUID();
			pd.put("MHID",MHID);
			machineService.save(pd); //保存机器主体信息

			//机器保养信息  cdesc 描述
			String[] cycle;
			if(null!=pd.get("cycleName")){
                cycle = pd.get("cycleName").toString().split(",");
                for(String c:cycle){
                    PageData cyclePD = new PageData();
                    cyclePD.put("mhid",MHID);
                    cyclePD.put("cycleid",c);
                    cyclePD.put("BZ",pd.get("cdesc"+c));
                    machineService.saveMachineCycle(cyclePD);
                }

            }
			//机器维修信息
			String[] mpv;
			if(null!=pd.get("mpv")){
                mpv=pd.get("mpv").toString().split(",");
                for(String mp:mpv){
                    PageData mpvPD = new PageData();
                    mpvPD.put("mhid",MHID);
                    mpvPD.put("projectid",mp);
                    machineService.saveMachineProject(mpvPD);
                }
            }
			if(null!=pd.get("CHANGE_RULE")&&pd.getString("CHANGE_RULE").equals("0")){
				//支持规格
				String[] ruleId;
				if(null!=pd.get("ruleId")){
					ruleId=pd.get("ruleId").toString().split(",");
					for(String rId:ruleId){
						PageData mrulePD = new PageData();
						mrulePD.put("mhid",MHID);
						mrulePD.put("ruleId",rId);
						machineService.saveMachineRule(mrulePD);
					}
				}

				//更改规格
				String[] rpv;
				if(null!=pd.get("rpv")){
					rpv=pd.get("rpv").toString().split(",");
					for(String rp:rpv){
						PageData rpPD = new PageData();
						rpPD.put("mhid",MHID);
						rpPD.put("partsId",rp);
						machineService.saveMachineParts(rpPD);
					}
				}
			}


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
	@Log(model = "设备管理模块",function="删除机器",type = "删除")
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Machine");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		//FHLOG.save(Jurisdiction.getUsername(), "删除机器");
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
	@ResponseBody
	@Log(model = "设备管理模块",function="修改机器",type = "修改")
	@SuppressWarnings("all")
	public ResultData edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Machine");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		//FHLOG.save(Jurisdiction.getUsername(), "修改机器");
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			machineService.edit(pd);
			//机器保养信息  cdesc 描述
			String MHID = pd.get("MHID").toString();
			String[] cycle;
			if(null!=pd.get("cycleName")){
                machineService.deleteMachineCycle(MHID);
                cycle = pd.get("cycleName").toString().split(",");
                for(String c:cycle){
                    PageData cyclePD = new PageData();
                    cyclePD.put("mhid",MHID);
                    cyclePD.put("cycleid",c);
                    cyclePD.put("BZ",pd.get("cdesc"+c));
                    machineService.saveMachineCycle(cyclePD);
                }

            }
			//机器维修信息
			String[] mpv;
			if(null!=pd.get("mpv")){
                machineService.deleteMachineProject(MHID);
                mpv=pd.get("mpv").toString().split(",");
                for(String mp:mpv){
                    PageData mpvPD = new PageData();
                    mpvPD.put("mhid",MHID);
                    mpvPD.put("projectid",mp);
                    machineService.saveMachineProject(mpvPD);
                }
            }
			if(null!=pd.get("CHANGE_RULE")&&pd.getString("CHANGE_RULE").equals("0")){
				//支持规格
				String[] ruleId;
				if(null!=pd.get("ruleId")){
					machineService.deleteMachineRule(MHID);
					ruleId=pd.get("ruleId").toString().split(",");
					for(String rId:ruleId){
						PageData mrulePD = new PageData();
						mrulePD.put("mhid",MHID);
						mrulePD.put("ruleId",rId);
						machineService.saveMachineRule(mrulePD);
					}
				}

				//更改规格
				String[] rpv;
				if(null!=pd.get("rpv")){
					machineService.deleteMachineParts(MHID);
					rpv=pd.get("rpv").toString().split(",");
					for(String rp:rpv){
						PageData rpPD = new PageData();
						rpPD.put("mhid",MHID);
						rpPD.put("partsId",rp);
						machineService.saveMachineParts(rpPD);
					}
				}
			}

			return ResultData.init(ResultData.SUCCESS,"修改成功",null);
		} catch (Exception e) {
			e.printStackTrace();
			return ResultData.init(ResultData.FAIL,"修改异常","");
		}


	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Machine");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
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
		List<PageData>	varList = machineService.list(page);	//列出Machine列表

		//机器类型下拉列表
		List<PageData>	staffPostList =  getBasicData(Const.COMPANY_BASIC_MACHINETYPE,1,user.getCompanyId());
		mv.addObject("machineTypeList",staffPostList);

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
		String BARCODE= ""+user.getCompanyId()+new Date().getTime();
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
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = machineService.findById(pd);	//根据ID读取

		//人员选择下拉列表
		pd.put("COMPANY_ID",user.getCompanyId());
		PageData staffPD = new PageData();
		staffPD.put("COMPANY_ID",user.getCompanyId());
		List<PageData> staffList = staffService.listAll(staffPD);
		mv.addObject("staffList", staffList);

		//机器类型下拉列表
		List<PageData>	staffPostList =  getBasicData(Const.COMPANY_BASIC_MACHINETYPE,1,user.getCompanyId());
		mv.addObject("machineTypeList",staffPostList);

		//保养周期
		List<PageData>	machineCycleList =  getBasicData(Const.COMPANY_BASIC_MACHINECYCLE,1,user.getCompanyId());
		mv.addObject("machineCycleList",machineCycleList);

		//机器保养周期
		PageData cyclePD = new PageData();
		cyclePD.put("mhid",pd.get("MHID"));
		List<PageData> cycleList  = machineService.getMachineCycle(cyclePD);
		mv.addObject("cycleList",cycleList);

		//维修项目
		List<PageData>	mpList = getBasicData(Const.COMPANY_BASIC_MAINTENANCEPROJECT,1,user.getCompanyId());
		mv.addObject("mpList",mpList);
		List<PageData> projecList = machineService.getMachineProjec(cyclePD);
		mv.addObject("projecList",projecList);

		//机器规格
		List<PageData>	ruleList = getBasicData(Const.COMPANY_BASIC_MACHINERULE,1,user.getCompanyId());
		mv.addObject("ruleList",ruleList);
		List<PageData> machineruleList = machineService.getMachineRule(cyclePD);
		mv.addObject("machineruleList",machineruleList);

		///规格更改部位
		List<PageData>	rulePosttionList = getBasicData(Const.COMPANY_BASIC_RULEPOSITION,1,user.getCompanyId());
		mv.addObject("rulePosttionList",rulePosttionList);
		List<PageData> partsList = machineService.getMachineParts(cyclePD);
		mv.addObject("partsList",partsList);

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

	@RequestMapping(value="/getMachineProject")
	@ResponseBody
	public ResultData getMachineRepairProject(){
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd = this.getPageData();

		try {
			String type = pd.getString("scan_type");
			List<PageData> result = new ArrayList<>();
			if(type.equals("3")){
                result  = machineService.getMachineCycle(pd);
            }else if(type.equals("2")){
                //维修项目
                result = machineService.getMachineProjec(pd);
            }else if(type.equals("4")){
				if(null!= pd.get("rule") && !"".equals(pd.get("rule").toString())){
					//机器规格
					result = machineService.getMachineRule(pd);
				}else{
					///规格更改部位
					result = machineService.getMachineParts(pd);
				}

            }
			return ResultData.init(ResultData.SUCCESS,"添加成功",result);
		} catch (Exception e) {
			e.printStackTrace();
			return ResultData.init(ResultData.SUCCESS,"添加成功",null);
		}

	}
	@RequestMapping(value="/getMachineCycleById")
	@ResponseBody
	public ResultData getMachineCycleById(){
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd  = machineService.getMachineCycleById(pd);
			return ResultData.init(ResultData.SUCCESS,"添加成功",pd);
		} catch (Exception e) {
			e.printStackTrace();
			return ResultData.init(ResultData.SUCCESS,"添加成功",null);
		}

	}

	/**
	 * 打印条码
	 * @return
	 * @throws Exception
     */
	@RequestMapping(value="/printPage")
	@Log(model = "设备管理模块",function="打印机条码",type = "新增")
	@SuppressWarnings("all")
	public ModelAndView printPage(HttpServletRequest request) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = machineService.findById(pd);
		FHLOG.save(Jurisdiction.getUsername(), "打印机器条码");
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
			}else{
				file.delete();
				file.createNewFile();
			}
			OneDimensionCode.getBarcodeWriteFile(pd.get("BARCODE").toString(), 600,150, file);
			String BARCODEURL ="http://" + request.getServerName()+":" +request.getServerPort()+systemPath+fileName;
			pd.put("BARCODEURL",BARCODEURL);
			machineService.edit(pd);
		//}
		mv.setViewName("fhoa/machine/printPage");
		mv.addObject("pd", pd);
		return mv;
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
