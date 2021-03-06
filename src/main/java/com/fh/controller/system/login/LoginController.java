package com.fh.controller.system.login;

import com.fh.controller.base.BaseController;
import com.fh.entity.system.Menu;
import com.fh.entity.system.Role;
import com.fh.entity.system.User;
import com.fh.service.fhoa.datajur.DatajurManager;
import com.fh.service.system.appuser.AppuserManager;
import com.fh.service.system.buttonrights.ButtonrightsManager;
import com.fh.service.system.fhbutton.FhbuttonManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.loginimg.LogInImgManager;
import com.fh.service.system.menu.MenuManager;
import com.fh.service.system.role.RoleManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 总入口
 * 修改日期：2015/11/2
 */
/**
 * @author Administrator
 *
 */
@Controller
public class LoginController extends BaseController {

	@Resource(name="userService")
	private UserManager userService;
	@Resource(name="menuService")
	private MenuManager menuService;
	@Resource(name="roleService")
	private RoleManager roleService;
	@Resource(name="buttonrightsService")
	private ButtonrightsManager buttonrightsService;
	@Resource(name="fhbuttonService")
	private FhbuttonManager fhbuttonService;
	@Resource(name="appuserService")
	private AppuserManager appuserService;
	@Resource(name="datajurService")
	private DatajurManager datajurService;
	@Resource(name="fhlogService")
	private FHlogManager FHLOG;
	@Resource(name="loginimgService")
	private LogInImgManager loginimgService;
	
	/**访问登录页
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login_toLogin")
	public ModelAndView toLogin()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = this.setLoginPd(pd);	//设置登录页面的配置参数
		//pd.put("errLoginCount",0);
		mv.setViewName("system/index/login");
		mv.addObject("pd",pd);

		return mv;
	}

	@RequestMapping(value="/slogin")
	public ModelAndView toScan()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = this.setLoginPd(pd);	//设置登录页面的配置参数
		//pd.put("errLoginCount",0);
		mv.setViewName("system/index/scan");
		mv.addObject("pd",pd);
		return mv;
	}

	/**请求登录，验证用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login_login" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	@SuppressWarnings("all")
	public Object login()throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "";
		String KEYDATA[] = pd.getString("KEYDATA").split(",fh,");
		Session session = Jurisdiction.getSession();
		String sessionCode = (String) session.getAttribute(Const.SESSION_SECURITY_CODE);        //获取session中的验证码
		int errLoginCount = Integer.parseInt(null == session.getAttribute("errLoginCount")?"0":session.getAttribute("errLoginCount").toString());
		String code = KEYDATA[2];
		String USERNAME = KEYDATA[0];    //登录过来的用户名
		String PASSWORD = KEYDATA[1];    //登录过来的密码
		String COMPANYCODE = KEYDATA[3];//公司编码
		pd.put("USERNAME", USERNAME);
		pd.put("COMPANYCODE", COMPANYCODE);
		if(errLoginCount>3){
			if (null == code || "".equals(code)) {//判断效验码
				errInfo = "nullcode";            //效验码为空
				errLoginCount+=1;
				session.setAttribute("errLoginCount",errLoginCount);
				//pd.put("errLoginCount",errLoginCount);
			}else {
				if (Tools.notEmpty(sessionCode) && sessionCode.equalsIgnoreCase(code)) {        //判断登录验证码
					pd.put("PASSWORD", PASSWORD);
					pd = userService.getUserByNameAndPwd(pd);    //根据用户名和密码去读取用户信息
					if (pd != null) {
						this.removeSession(USERNAME);//请缓存
						pd.put("LAST_LOGIN", DateUtil.getTime().toString());
						userService.updateLastLogin(pd);
						User user = this.setUserOption(pd,session,USERNAME);
						FHLOG.save(USERNAME, "登录系统", pd.getString("IP"), pd.getString("NAME"), pd.get("COMPANY_ID").toString());
						//shiro加入身份验证
						Subject subject = SecurityUtils.getSubject();
						UsernamePasswordToken token = new UsernamePasswordToken(USERNAME, PASSWORD);
						try {
							subject.login(token);
							errInfo = "success";
							session.setAttribute("errLoginCount",0);
						} catch (AuthenticationException e) {
							errInfo = "身份验证失败！";
							errLoginCount+=1;
							session.setAttribute("errLoginCount",errLoginCount);
						}
					} else {
						errInfo = "usererror";                //用户名或密码有误
						logBefore(logger, USERNAME + "登录系统密码或用户名错误");
						errLoginCount+=1;
						session.setAttribute("errLoginCount",errLoginCount);
					}
				}else {
					errInfo = "carerror";
					errLoginCount+=1;
					session.setAttribute("errLoginCount",errLoginCount);
				}
			}
		}else{
			pd.put("PASSWORD", PASSWORD);
			pd = userService.getUserByNameAndPwd(pd);    //根据用户名和密码去读取用户信息
			if (pd != null) {
				this.removeSession(USERNAME);//请缓存
				pd.put("LAST_LOGIN", DateUtil.getTime().toString());
				userService.updateLastLogin(pd);
				User user = this.setUserOption(pd,session,USERNAME);

				FHLOG.save(USERNAME, "登录系统", pd.getString("IP"), pd.getString("NAME"), pd.get("COMPANY_ID").toString());
				//shiro加入身份验证
				Subject subject = SecurityUtils.getSubject();
				UsernamePasswordToken token = new UsernamePasswordToken(USERNAME, PASSWORD);
				try {
					subject.login(token);
					errInfo = "success";
					session.setAttribute("errLoginCount",0);
				} catch (AuthenticationException e) {
					errInfo = "身份验证失败！";
					errLoginCount+=1;
					session.setAttribute("errLoginCount",errLoginCount);
				}
			} else {
				errInfo = "usererror";                //用户名或密码有误
				logBefore(logger, USERNAME + "登录系统密码或用户名错误");
				errLoginCount+=1;
				session.setAttribute("errLoginCount",errLoginCount);
			}
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);

	}
	public User setUserOption(PageData pd,Session session,String USERNAME){
		User user = new User();
		user.setUSER_ID(pd.getString("USER_ID"));
		user.setUSERNAME(pd.getString("USERNAME"));
		user.setPASSWORD(pd.getString("PASSWORD"));
		user.setNAME(pd.getString("NAME"));
		user.setRIGHTS(pd.getString("RIGHTS"));
		user.setROLE_ID(pd.getString("ROLE_ID"));
		user.setLAST_LOGIN(pd.getString("LAST_LOGIN"));
		user.setIP(pd.getString("IP"));
		user.setSTATUS(pd.getString("STATUS"));
		user.setCompanyId(pd.get("COMPANY_ID").toString());
		String sessionBS = this.get32UUID();
		session.setAttribute(Const.SESSION_USER, user);            //把用户信息放session中
		session.removeAttribute(Const.SESSION_SECURITY_CODE);    //清除登录验证码的session
		session.setAttribute(USERNAME + "_" + user.getCompanyId(), sessionBS);
		Const.USERSESSION.put(USERNAME + "_" + user.getCompanyId(), sessionBS);
		return user;
	}
	/**扫描机器用户登录
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/scan_login" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	@SuppressWarnings("all")
	public Object scanLogin()throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "";
		String KEYDATA[] = pd.getString("KEYDATA").split(",fh,");
		Session session = Jurisdiction.getSession();
		String sessionCode = (String) session.getAttribute(Const.SESSION_SECURITY_CODE);        //获取session中的验证码
		int errLoginCount = Integer.parseInt(null == session.getAttribute("errLoginCount")?"0":session.getAttribute("errLoginCount").toString());
		String code = KEYDATA[2];
		String USERNAME = KEYDATA[0];    //登录过来的用户名
		String PASSWORD = KEYDATA[1];    //登录过来的密码
		String MACHINECODE = KEYDATA[3];//公司编码
		pd.put("USERNAME", USERNAME);
		if(errLoginCount>3){
			if (null == code || "".equals(code)) {//判断效验码
				errInfo = "nullcode";            //效验码为空
				errLoginCount+=1;
				session.setAttribute("errLoginCount",errLoginCount);
			}else {
				if (Tools.notEmpty(sessionCode) && sessionCode.equalsIgnoreCase(code)) {        //判断登录验证码
					PageData pdm = userService.getCodeByCarCode(MACHINECODE);
					if(null == pdm || null == pdm.get("MCODE")){
						errInfo = "carerror";
					}else {
						pd.put("COMPANYCODE",pdm.get("MCODE"));
						pd.put("PASSWORD", PASSWORD);
						pd = userService.getUserByNameAndPwd(pd);    //根据用户名和密码去读取用户信息
						if (pd != null) {
							this.removeSession(USERNAME);//请缓存
							pd.put("LAST_LOGIN", DateUtil.getTime().toString());
							userService.updateLastLogin(pd);
							User user = this.setUserOption(pd,session,USERNAME);
							session.setAttribute(Const.CARCODE,MACHINECODE);
							session.setAttribute(Const.CARID,pdm.get("CAR_ID"));

							FHLOG.save(USERNAME, "登录系统", pd.getString("IP"), pd.getString("NAME"), pd.get("COMPANY_ID").toString());
							//shiro加入身份验证
							Subject subject = SecurityUtils.getSubject();
							UsernamePasswordToken token = new UsernamePasswordToken(USERNAME, PASSWORD);
							try {
								subject.login(token);
								errInfo = "success";
								session.setAttribute("errLoginCount",0);
							} catch (AuthenticationException e) {
								errInfo = "身份验证失败！";
								errLoginCount+=1;
								session.setAttribute("errLoginCount",errLoginCount);
							}
						} else {
							errInfo = "usererror";                //用户名或密码有误
							logBefore(logger, USERNAME + "登录系统密码或用户名错误");
							errLoginCount+=1;
							session.setAttribute("errLoginCount",errLoginCount);
						}
					}

				}else {
					errInfo = "carerror";
					errLoginCount+=1;
					session.setAttribute("errLoginCount",errLoginCount);
				}
			}
		}else{
			PageData pdm = userService.getCodeByCarCode(MACHINECODE);
			if(null == pdm || null == pdm.get("MCODE")){
				errInfo = "carerror";
			}else {
				pd.put("COMPANYCODE",pdm.get("MCODE"));
				pd.put("PASSWORD", PASSWORD);
				pd = userService.getUserByNameAndPwd(pd);    //根据用户名和密码去读取用户信息
				if (pd != null) {
					this.removeSession(USERNAME);//请缓存
					pd.put("LAST_LOGIN", DateUtil.getTime().toString());
					userService.updateLastLogin(pd);
					User user = this.setUserOption(pd,session,USERNAME);
					session.setAttribute(Const.CARCODE,MACHINECODE);
					session.setAttribute(Const.CARID,pdm.get("CAR_ID"));

					FHLOG.save(USERNAME, "登录系统", pd.getString("IP"), pd.getString("NAME"), pd.get("COMPANY_ID").toString());
					//shiro加入身份验证
					Subject subject = SecurityUtils.getSubject();
					UsernamePasswordToken token = new UsernamePasswordToken(USERNAME, PASSWORD);
					try {
						subject.login(token);
						errInfo = "success";
						session.setAttribute("errLoginCount",0);
					} catch (AuthenticationException e) {
						errInfo = "身份验证失败！";
						errLoginCount+=1;
						session.setAttribute("errLoginCount",errLoginCount);
					}
				} else {
					errInfo = "usererror";                //用户名或密码有误
					logBefore(logger, USERNAME + "登录系统密码或用户名错误");
					errLoginCount+=1;
					session.setAttribute("errLoginCount",errLoginCount);
				}
			}

		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**访问系统首页
	 * @param changeMenu：切换菜单参数
	 * @return
	 */
	@RequestMapping(value="/main/{changeMenu}")
	@SuppressWarnings("all")
	public ModelAndView login_index(@PathVariable("changeMenu") String changeMenu){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Session session = Jurisdiction.getSession();
			User user = (User)session.getAttribute(Const.SESSION_USER);						//读取session中的用户信息(单独用户信息)
			if (user != null) {
				User userr = (User)session.getAttribute(Const.SESSION_USERROL);				//读取session中的用户信息(含角色信息)
				if(null == userr){
					user = userService.getUserAndRoleById(user.getUSER_ID());				//通过用户ID读取用户信息和角色信息
					session.setAttribute(Const.SESSION_USERROL, user);						//存入session	
				}else{
					user = userr;
				}
				String USERNAME = user.getUSERNAME();
				Role role = user.getRole();													//获取用户角色
				String roleRights = role!=null ? role.getRIGHTS() : "";						//角色权限(菜单权限)
				session.setAttribute(USERNAME + Const.SESSION_ROLE_RIGHTS, roleRights); 	//将角色权限存入session
				session.setAttribute(Const.SESSION_USERNAME, USERNAME);						//放入用户名到session
				this.setAttributeToAllDEPARTMENT_ID(session, USERNAME,user.getUSER_ID());						//把用户的组织机构权限放到session里面
				List<Menu> allmenuList = new ArrayList<Menu>();
				if(changeMenu.equals("scan")){
					allmenuList = this.getAttributeMenu(session, USERNAME, roleRights,"2");			//菜单缓存
				}else {
					allmenuList = this.getAttributeMenu(session, USERNAME, roleRights,"1");			//菜单缓存
				}

				List<Menu> menuList = new ArrayList<Menu>();
				menuList = this.changeMenuF(allmenuList, session, USERNAME, changeMenu);	//切换菜单
				if(null == session.getAttribute(USERNAME + Const.SESSION_QX)){
					session.setAttribute(USERNAME + Const.SESSION_QX, this.getUQX(USERNAME,user.getCompanyId()));//按钮权限放到session中
				}
				this.getRemortIP(USERNAME);	//更新登录IP
				mv.setViewName("system/index/main");
				mv.addObject("user", user);
				if(changeMenu.equals("scan")){
					mv.addObject("scanUrl", "scanTab.do");
				}else{
					mv.addObject("scanUrl", "tab.do");
				}

				mv.addObject("menuList", menuList);
			}else {
				mv.setViewName("system/index/login");//session失效后跳转登录页面
			}
		} catch(Exception e){
			mv.setViewName("system/index/login");
			logger.error(e.getMessage(), e);
		}
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
		mv.addObject("pd",pd);
		return mv;
	}

	/**菜单缓存
	 * @param session
	 * @param USERNAME
	 * @param roleRights
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Menu> getAttributeMenu(Session session, String USERNAME, String roleRights) throws Exception{
		List<Menu> allmenuList = new ArrayList<Menu>();
		if(null == session.getAttribute(USERNAME + Const.SESSION_allmenuList)){	
			allmenuList = menuService.listAllMenuQx("0");							//获取所有菜单
			if(Tools.notEmpty(roleRights)){
				allmenuList = this.readMenu(allmenuList, roleRights);				//根据角色权限获取本权限的菜单列表
			}
			session.setAttribute(USERNAME + Const.SESSION_allmenuList, allmenuList);//菜单权限放入session中
		}else{
			allmenuList = (List<Menu>)session.getAttribute(USERNAME + Const.SESSION_allmenuList);
		}
		return allmenuList;
	}
	@SuppressWarnings("unchecked")
	public List<Menu> getAttributeMenu(Session session, String USERNAME, String roleRights,String SYSTEM_TYPE) throws Exception{
		List<Menu> allmenuList = new ArrayList<Menu>();
		if(null == session.getAttribute(USERNAME + Const.SESSION_allmenuList)){
			allmenuList = menuService.listAllMenuQx("0",SYSTEM_TYPE);							//获取所有菜单
			if(Tools.notEmpty(roleRights)){
				allmenuList = this.readMenu(allmenuList, roleRights);				//根据角色权限获取本权限的菜单列表
			}
			session.setAttribute(USERNAME + Const.SESSION_allmenuList, allmenuList);//菜单权限放入session中
		}else{
			allmenuList = (List<Menu>)session.getAttribute(USERNAME + Const.SESSION_allmenuList);
		}
		return allmenuList;
	}
	
	/**根据角色权限获取本权限的菜单列表(递归处理)
	 * @param menuList：传入的总菜单
	 * @param roleRights：加密的权限字符串
	 * @return
	 */
	public List<Menu> readMenu(List<Menu> menuList,String roleRights){
		for(int i=0;i<menuList.size();i++){
			menuList.get(i).setHasMenu(RightsHelper.testRights(roleRights, menuList.get(i).getMENU_ID()));
			if(menuList.get(i).isHasMenu()){		//判断是否有此菜单权限
				this.readMenu(menuList.get(i).getSubMenu(), roleRights);//是：继续排查其子菜单
			}
		}
		return menuList;
	}
	
	/**切换菜单处理
	 * @param allmenuList
	 * @param session
	 * @param USERNAME
	 * @param changeMenu
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Menu> changeMenuF(List<Menu> allmenuList, Session session, String USERNAME, String changeMenu){
		List<Menu> menuList = new ArrayList<Menu>();
		if(null == session.getAttribute(USERNAME + Const.SESSION_menuList) || ("yes".equals(changeMenu))){
			List<Menu> menuList1 = new ArrayList<Menu>();
			List<Menu> menuList2 = new ArrayList<Menu>();
			for(int i=0;i<allmenuList.size();i++){//拆分菜单
				Menu menu = allmenuList.get(i);
				if("1".equals(menu.getMENU_TYPE())){
					menuList1.add(menu);
				}else{
					menuList2.add(menu);
				}
			}
			session.removeAttribute(USERNAME + Const.SESSION_menuList);
			if("2".equals(session.getAttribute("changeMenu"))){
				session.setAttribute(USERNAME + Const.SESSION_menuList, menuList1);
				session.removeAttribute("changeMenu");
				session.setAttribute("changeMenu", "1");
				menuList = menuList1;
			}else{
				session.setAttribute(USERNAME + Const.SESSION_menuList, menuList2);
				session.removeAttribute("changeMenu");
				session.setAttribute("changeMenu", "2");
				menuList = menuList2;
			}
		}else{
			menuList = (List<Menu>)session.getAttribute(USERNAME + Const.SESSION_menuList);
		}
		return menuList;
	}
	
	/**把用户的组织机构权限放到session里面
	 * @param session
	 * @param USERNAME
	 * @return
	 * @throws Exception 
	 */
	public void setAttributeToAllDEPARTMENT_ID(Session session, String USERNAME,String USEER_ID) throws Exception{
		String DEPARTMENT_IDS = "0",DEPARTMENT_ID = "0";
		if(!"admin".equals(USERNAME)){
			PageData pd = datajurService.getDEPARTMENT_IDS(USEER_ID);
			DEPARTMENT_IDS = null == pd?"无权":pd.getString("DEPARTMENT_IDS");
			DEPARTMENT_ID = null == pd?"无权":pd.getString("DEPARTMENT_ID");
		}
		session.setAttribute(Const.DEPARTMENT_IDS, DEPARTMENT_IDS);	//把用户的组织机构权限集合放到session里面
		session.setAttribute(Const.DEPARTMENT_ID, DEPARTMENT_ID);	//把用户的最高组织机构权限放到session里面
	}
	
	/**
	 * 进入tab标签
	 * @return
	 */
	@RequestMapping(value="/tab")
	public String tab(){
		return "system/index/tab";
	}

	@RequestMapping(value="/scanTab")
	public String scanTab(){
		return "fhoa/scan/tab";
	}
	
	/**
	 * 进入首页后的默认页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/login_default")
	@SuppressWarnings("all")
	public ModelAndView defaultPage() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("userCount", Integer.parseInt(userService.getUserCount("").get("userCount").toString())-1);				//系统用户数
		pd.put("appUserCount", Integer.parseInt(appuserService.getAppUserCount("").get("appUserCount").toString()));	//会员数
		mv.addObject("pd",pd);
		mv.setViewName("system/index/default");
		return mv;
	}

	@RequestMapping(value="/login_default_scan")
	@SuppressWarnings("all")
	public ModelAndView defaultScanPage() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		//pd.put("userCount", Integer.parseInt(userService.getUserCount("").get("userCount").toString())-1);				//系统用户数
		//pd.put("appUserCount", Integer.parseInt(appuserService.getAppUserCount("").get("appUserCount").toString()));	//会员数
		mv.addObject("pd",pd);
		mv.setViewName("fhoa/scan/repairmanScan");
		return mv;
	}
	
	/**
	 * 用户注销
	 * @param
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/logout")
	public ModelAndView logout() throws Exception{
		String USERNAME = Jurisdiction.getUsername();	//当前登录的用户名
		logBefore(logger, USERNAME+"退出系统");
		FHLOG.save(USERNAME, "退出登录");
		ModelAndView mv = this.getModelAndView();
		Object carId = Jurisdiction.getSession().getAttribute(Const.CARID);
		PageData pd = new PageData();
		this.removeSession(USERNAME);//请缓存
		//shiro销毁登录
		Subject subject = SecurityUtils.getSubject(); 
		subject.logout();
		pd = this.getPageData();
		pd.put("msg", pd.getString("msg"));
		pd = this.setLoginPd(pd);	//设置登录页面的配置参数
		if(null!=carId){
			mv.setViewName("system/index/scan");
		}else{
			mv.setViewName("system/index/login");
		}

		mv.addObject("pd",pd);
		return mv;
	}
	
	/**
	 * 清理session
	 */
	public void removeSession(String USERNAME){
		Session session = Jurisdiction.getSession();	//以下清除session缓存
		session.removeAttribute(Const.SESSION_USER);
		session.removeAttribute(USERNAME + Const.SESSION_ROLE_RIGHTS);
		session.removeAttribute(USERNAME + Const.SESSION_allmenuList);
		session.removeAttribute(USERNAME + Const.SESSION_menuList);
		session.removeAttribute(USERNAME + Const.SESSION_QX);
		session.removeAttribute(Const.SESSION_userpds);
		session.removeAttribute(Const.SESSION_USERNAME);
		session.removeAttribute(Const.SESSION_USERROL);
		session.removeAttribute("changeMenu");
		session.removeAttribute("DEPARTMENT_IDS");
		session.removeAttribute("DEPARTMENT_ID");
	}
	
	/**设置登录页面的配置参数
	 * @param pd
	 * @return
	 */
	public PageData setLoginPd(PageData pd){
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); 		//读取系统名称
		String strLOGINEDIT = Tools.readTxtFile(Const.LOGINEDIT);	//读取登录页面配置
		if(null != strLOGINEDIT && !"".equals(strLOGINEDIT)){
			String strLo[] = strLOGINEDIT.split(",fh,");
			if(strLo.length == 2){
				pd.put("isZhuce", strLo[0]);
				pd.put("isMusic", strLo[1]);
			}
		}
		try {
			List<PageData> listImg = loginimgService.listAll(pd);	//登录背景图片
			pd.put("listImg", listImg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pd;
	}
	
	/**获取用户权限
	 * @param
	 * @return
	 */
	public Map<String, String> getUQX(String USERNAME,String companyId){
		PageData pd = new PageData();
		Map<String, String> map = new HashMap<String, String>();
		try {
			pd.put(Const.SESSION_USERNAME, USERNAME);
			pd.put("COMPANY_ID",companyId);
			pd.put("ROLE_ID", userService.findByUsername(pd).get("ROLE_ID").toString());//获取角色ID
			pd = roleService.findObjectById(pd);										//获取角色信息														
			map.put("adds", pd.getString("ADD_QX"));	//增
			map.put("dels", pd.getString("DEL_QX"));	//删
			map.put("edits", pd.getString("EDIT_QX"));	//改
			map.put("chas", pd.getString("CHA_QX"));	//查
			List<PageData> buttonQXnamelist = new ArrayList<PageData>();
			if("admin".equals(USERNAME)){
				buttonQXnamelist = fhbuttonService.listAll(pd);					//admin用户拥有所有按钮权限
			}else{
				buttonQXnamelist = buttonrightsService.listAllBrAndQxname(pd);	//此角色拥有的按钮权限标识列表
			}
			for(int i=0;i<buttonQXnamelist.size();i++){
				map.put(buttonQXnamelist.get(i).getString("QX_NAME"),"1");		//按钮权限
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}	
		return map;
	}
	
	/** 更新登录用户的IP
	 * @param USERNAME
	 * @throws Exception
	 */
	public void getRemortIP(String USERNAME) throws Exception {  
		PageData pd = new PageData();
		HttpServletRequest request = this.getRequest();
		String ip = "";
		if (request.getHeader("x-forwarded-for") == null) {  
			ip = request.getRemoteAddr();  
	    }else{
	    	ip = request.getHeader("x-forwarded-for");  
	    }
		pd.put("USERNAME", USERNAME);
		pd.put("IP", ip);
		userService.saveIP(pd);
	}  
	
}
