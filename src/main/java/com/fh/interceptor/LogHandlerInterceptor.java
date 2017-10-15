package com.fh.interceptor;

import com.fh.entity.system.User;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.resource.ResourceHttpRequestHandler;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

//import org.springframework.web.servlet.HandlerInterceptor;
//import org.springframework.web.servlet.ModelAndView;

/**
 * pillar
 */
public class LogHandlerInterceptor extends HandlerInterceptorAdapter {
	/**
	 * 在渲染视图之后被调用；
	 * 可以用来释放资源
	 *//*
	@Override
	public void afterCompletion(HttpServletRequest arg0,
								HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		System.out.println("MyInterceptors afterCompletion");
	}
	*//**
	 * 该方法在目标方法调用之后，渲染视图之前被调用；
	 * 可以对请求域中的属性或视图做出修改
	 *
	 *//*
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
						   Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("MyInterceptors postHandle");
	}

	*//**
	 * 可以考虑作权限，日志，事务等等
	 * 该方法在目标方法调用之前被调用；
	 * 若返回TURE,则继续调用后续的拦截器和目标方法
	 * 若返回FALSE,则不会调用后续的拦截器和目标方法
	 *
	 *//*
	@Override
	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1,
							 Object arg2) throws Exception {
		// TODO Auto-generated method stub
		HandlerMethod handlerMethod = (HandlerMethod) arg2;
		System.out.println("MyInterceptors preHandle 调用方法名："+handlerMethod.getMethod().getName());
        *//*
            写一个日记类和Service，将需要的属性保存到数据库
        *//*
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		if(user!=null) {
			Method method = handlerMethod.getMethod();
			final Log log = method.getAnnotation(Log.class);
			System.out.println(log.function() + log.model() + log.type());
		}
		return true;
	}*/


	@Resource(name="fhlogService")
	private FHlogManager fHLOG;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		if (!(handler instanceof HandlerMethod)) {
			return true;
		}

		HandlerMethod handlerMethod = (HandlerMethod) handler;

		//System.out.println("MyInterceptors preHandle 调用方法名："+handlerMethod.getMethod().getName());

		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		if(user!=null) {
			Method method = handlerMethod.getMethod();
			final Log log = method.getAnnotation(Log.class);
			if(null != log){
				System.out.println("log out1 :" + log.function() + log.model() + log.type());
				//String USERNAME, String CONTENT,String model,String function,String type,String operName,String companyId
				fHLOG.save(user.getUSERNAME(),"",log.model(),log.function(),log.type(),user.getNAME(),user.getCompanyId());
			}

		}
		return true;
	}
}
