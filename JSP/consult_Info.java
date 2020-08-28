package enrollBean;

public class consult_Info {

	String p_name;
	int year;
	int semester;
	
	public consult_Info() {
		p_name=null;
		year=semester=0;
	}
	public void setPname(String p_name) {
		this.p_name=p_name;
	}
	public void setYear(int year) {
		this.year=year;
	}
	public void setSemester(int semester) {
		this.semester=semester;
	}
	public String getPname() { return p_name; }
	public int getYear() { return year; }
	public int getSemester() { return semester; }
}
