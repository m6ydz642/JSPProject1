package newsboard;

import java.sql.Timestamp;

public class NewsBoardBean {
	/*newsboard 부분*/
	private int num; // 그냥 글 번호
	private String userid;
	private String userpasswd;
	private String username;
	private String contentpasswd;
	private String subject;
	private String content;
	private int readcount;
	private String filename;
	private String preview;
	private String newscategory;
	
	
	
	
	
	


	public String getNewscategory() {
		return newscategory;
	}

	public void setNewscategory(String newscategory) {
		this.newscategory = newscategory;
	}

	public String getPreview() {
		return preview;
	}

	public void setPreview(String preview) {
		this.preview = preview;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	
	private Timestamp  date;
	private int re_ref; 
	private int re_seq;
	
	public NewsBoardBean () {
		
	}
	
	public NewsBoardBean(int num, String userid, String userpasswd, String username, String contentpasswd,
			String subject, String content, int readcount, Timestamp date, int re_ref, int re_seq) {
		this.num = num;
		this.userid = userid;
		this.userpasswd = userpasswd;
		this.username = username;
		this.contentpasswd = contentpasswd;
		this.subject = subject;
		this.content = content;
		this.readcount = readcount;
		this.date = date;
		this.re_ref = re_ref;
		this.re_seq = re_seq;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpasswd() {
		return userpasswd;
	}
	public void setUserpasswd(String userpasswd) {
		this.userpasswd = userpasswd;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getContentpasswd() {
		return contentpasswd;
	}
	public void setContentpasswd(String contentpasswd) {
		this.contentpasswd = contentpasswd;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	} 
	


}
