package board;

import java.sql.Timestamp;

//VO

//1.DB게시판의 하나의 글정보를 검색하여 각변수에 저장할 용도의 클래스
//2.입력한 새글정보를  DB로 전송하여 INSERT하기전에 임시로 각변수에 저장할 용도의 클래스 
public class BoardBean {

	private int num;
	private String name;
	private String userid;
	private String passwd;
	private String subject;
	private String content;
	private int re_ref;
	private int re_lev;
	private int re_seq;
	private int readcount;
	private Timestamp date;
	private String ip;

	public BoardBean() {

	}

	public BoardBean(int num, String name, String userid, String passwd, String subject, String content, int re_ref,
			int re_lev, int re_seq, int readcount, Timestamp date, String ip) {
		super();
		this.num = num;
		this.name = name;
		this.userid = userid;
		this.passwd = passwd;
		this.subject = subject;
		this.content = content;
		this.re_ref = re_ref;
		this.re_lev = re_lev;
		this.re_seq = re_seq;
		this.readcount = readcount;
		this.date = date;
		this.ip = ip;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
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

	public int getRe_ref() {
		return re_ref;
	}

	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}

	public int getRe_lev() {
		return re_lev;
	}

	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}

	public int getRe_seq() {
		return re_seq;
	}

	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
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

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

}
