package com.fh.controller.fhoa.scan;

import com.fh.controller.base.BaseController;
import com.fh.entity.system.User;
import com.fh.service.fhoa.machine.MachineManager;
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

/** 
 * 说明：公司信息
 * 创建人：FH Q313596790
 * 创建时间：2017-08-05
 */
@Controller
@RequestMapping(value="/scan")
public class ScanController extends BaseController {
	
	String menuUrl = "scan/noticeScan.do"; //菜单地址(权限用)
	@Resource(name="machineService")
	private MachineManager machineService;

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
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
