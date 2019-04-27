package com.ysd.entity;

public class Classes {
	private Integer classesid;
	private String classname;
	public Integer getClassesid() {
		return classesid;
	}
	public void setClassesid(Integer classesid) {
		this.classesid = classesid;
	}
	public String getClassname() {
		return classname;
	}
	public void setClassname(String classname) {
		this.classname = classname;
	}
	@Override
	public String toString() {
		return "Classes [classesid=" + classesid + ", classname=" + classname + "]";
	}
	
	

}
