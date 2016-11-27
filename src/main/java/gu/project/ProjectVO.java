package gu.project;

public class ProjectVO {
    private String prno, 			//프로젝트 번호
				    prstartdate,	//시작일자
				    prenddate,		//종료일자
				    prtitle,		//프로젝트 제목
				    prdate,			//작성일자
				    userno,			//사용자번호
				    usernm, 
				    prstatus,		//상태
				    deleteflag;		//삭제

	public String getPrno() {
		return prno;
	}

	public void setPrno(String prno) {
		this.prno = prno;
	}

	public String getPrstartdate() {
		return prstartdate;
	}

	public void setPrstartdate(String prstartdate) {
		this.prstartdate = prstartdate;
	}

	public String getPrenddate() {
		return prenddate;
	}

	public void setPrenddate(String prenddate) {
		this.prenddate = prenddate;
	}

	public String getPrtitle() {
		return prtitle;
	}

	public void setPrtitle(String prtitle) {
		this.prtitle = prtitle;
	}

	public String getPrdate() {
		return prdate;
	}

	public void setPrdate(String prdate) {
		this.prdate = prdate;
	}

	public String getUserno() {
		return userno;
	}

	public void setUserno(String userno) {
		this.userno = userno;
	}

	public String getUsernm() {
		return usernm;
	}

	public void setUsernm(String usernm) {
		this.usernm = usernm;
	}

	public String getPrstatus() {
		return prstatus;
	}

	public void setPrstatus(String prstatus) {
		this.prstatus = prstatus;
	}

	public String getDeleteflag() {
		return deleteflag;
	}

	public void setDeleteflag(String deleteflag) {
		this.deleteflag = deleteflag;
	}


}
