package com.fh.util;

/**
 * 说明：结果集封装
 * 创建人：李国强
 * 修改时间：2017年8月29号
 * @version
 */
public class ResultData {
	public final static String SUCCESS="success";
	public final static String FAIL="fail";

	private String result;
	private String mesg;
	private Object data;
	public static ResultData init(String result,String mesg,Object data){
		ResultData resultData= new ResultData();
		resultData.setResult(result);
		resultData.setMesg(mesg);
		resultData.setData(data);
		return resultData;
	}
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getMesg() {
		return mesg;
	}

	public void setMesg(String mesg) {
		this.mesg = mesg;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
}
