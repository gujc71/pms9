package gu.project;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class TaskVO {
    private String prno, 		//프로젝트 번호
    				tsno, 		//업무번호
				    tsparent, 	//부모업무번호
				    tssort, 	//정렬
				    tstitle, 	//업무 제목
				    tsstartdate, //시작일자
				    tsenddate, 	//종료일자
				    tsendreal,	//종료일자(실제)
				    tsrate; 	//진행율
    private String userno, usernm; 		// 작업자
    private String statuscolor;	// 업무 진행 상태용 색
    
    /* 첨부파일 */
    private List<MultipartFile> uploadfile;
    
	public String getPrno() {
		return prno;
	}

	public void setPrno(String prno) {
		this.prno = prno;
	}

	public String getTsno() {
		return tsno;
	}

	public void setTsno(String tsno) {
		this.tsno = tsno;
	}

	public String getTsparent() {
		return tsparent;
	}

	public void setTsparent(String tsparent) {
		this.tsparent = tsparent;
	}

	public String getTssort() {
		return tssort;
	}

	public void setTssort(String tssort) {
		this.tssort = tssort;
	}

	public String getTstitle() {
		return tstitle;
	}

	public void setTstitle(String tstitle) {
		this.tstitle = tstitle;
	}

	public String getTsstartdate() {
		return tsstartdate;
	}

	public void setTsstartdate(String tsstartdate) {
		this.tsstartdate = tsstartdate;
	}

	public String getTsenddate() {
		return tsenddate;
	}

	public void setTsenddate(String tsenddate) {
		this.tsenddate = tsenddate;
	}

	public String getTsendreal() {
		return tsendreal;
	}

	public void setTsendreal(String tsendreal) {
		this.tsendreal = tsendreal;
	}

	public String getTsrate() {
		return tsrate;
	}

	public void setTsrate(String tsrate) {
		this.tsrate = tsrate;
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

	public String getStatuscolor() {
		return statuscolor;
	}

	public void setStatuscolor(String statuscolor) {
		this.statuscolor = statuscolor;
	}

	public List<MultipartFile> getUploadfile() {
		return uploadfile;
	}

	public void setUploadfile(List<MultipartFile> uploadfile) {
		this.uploadfile = uploadfile;
	}
    
}
