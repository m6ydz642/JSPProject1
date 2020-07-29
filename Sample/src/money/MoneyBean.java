package money;

public class MoneyBean {
	
	private int num;
	private String 회사이름;
	private String 회사개요;
	private String 대표자;
	private String 범위; // 몇월몇일 부터 몇월몇일 까지
	private String 구분; // 1분기~4분기 or 1년전체 사업보고서
	private String 종류; // 사업보고서 or 분기보고서, or 반기보고서
	private Long 매출액;
	private Long 매출원가;
	private Long 판매관리비;
	private Long 유동자산;
	private Long 유동부채;
	private Long 비유동부채;
	private Long 자본금;
	private Long 자기자본;
	private Long 자본총액;
	private Long 주식발행수;
	private Long 당기순이익;
	private Long 시가총액;
	private Long 자본총계;
	private Long 부채총계;
	private Long 자산총계;
	private int re_ref;  /*그룹번호*/
	private int re_seq; /*글순서*/
	
	
	
	
	public String get종류() {
		return 종류;
	}
	public void set종류(String 종류) {
		this.종류 = 종류;
	}
	public String get대표자() {
		return 대표자;
	}
	public void set대표자(String 대표자) {
		this.대표자 = 대표자;
	}
	public Long get자산총계() {
		return 자산총계;
	}
	public void set자산총계(Long 자산총계) {
		this.자산총계 = 자산총계;
	}
	public Long get자본총계() {
		return 자본총계;
	}
	public void set자본총계(Long 자본총계) {
		this.자본총계 = 자본총계;
	}
	public Long get부채총계() {
		return 부채총계;
	}
	public void set부채총계(Long 부채총계) {
		this.부채총계 = 부채총계;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String get회사이름() {
		return 회사이름;
	}
	public void set회사이름(String 회사이름) {
		this.회사이름 = 회사이름;
	}
	public String get회사개요() {
		return 회사개요;
	}
	public void set회사개요(String 회사개요) {
		this.회사개요 = 회사개요;
	}
	public String get범위() {
		return 범위;
	}
	public void set범위(String 범위) {
		this.범위 = 범위;
	}
	public String get구분() {
		return 구분;
	}
	public void set구분(String 구분) {
		this.구분 = 구분;
	}
	public Long get매출액() {
		return 매출액;
	}
	public void set매출액(Long 매출액) {
		this.매출액 = 매출액;
	}
	public Long get매출원가() {
		return 매출원가;
	}
	public void set매출원가(Long 매출원가) {
		this.매출원가 = 매출원가;
	}
	public Long get판매관리비() {
		return 판매관리비;
	}
	public void set판매관리비(Long 판매관리비) {
		this.판매관리비 = 판매관리비;
	}
	public Long get유동자산() {
		return 유동자산;
	}
	public void set유동자산(Long 유동자산) {
		this.유동자산 = 유동자산;
	}
	public Long get유동부채() {
		return 유동부채;
	}
	public void set유동부채(Long 유동부채) {
		this.유동부채 = 유동부채;
	}
	public Long get비유동부채() {
		return 비유동부채;
	}
	public void set비유동부채(Long 비유동부채) {
		this.비유동부채 = 비유동부채;
	}
	public Long get자본금() {
		return 자본금;
	}
	public void set자본금(Long 자본금) {
		this.자본금 = 자본금;
	}
	public Long get자기자본() {
		return 자기자본;
	}
	public void set자기자본(Long 자기자본) {
		this.자기자본 = 자기자본;
	}
	public Long get자본총액() {
		return 자본총액;
	}
	public void set자본총액(Long 자본총액) {
		this.자본총액 = 자본총액;
	}
	public Long get주식발행수() {
		return 주식발행수;
	}
	public void set주식발행수(Long 주식발행수) {
		this.주식발행수 = 주식발행수;
	}
	public Long get당기순이익() {
		return 당기순이익;
	}
	public void set당기순이익(Long 당기순이익) {
		this.당기순이익 = 당기순이익;
	}
	public Long get시가총액() {
		return 시가총액;
	}
	public void set시가총액(Long 시가총액) {
		this.시가총액 = 시가총액;
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
