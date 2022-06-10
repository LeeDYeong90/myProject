package archive;

public class ArchiveDTO {

//	create table archive (
//			year int(10) not null, 
//			cnt int(10) not null,
//			subject_cd int(10) not null,
//			q_num int(20) not null,
//			q_subject varchar(100) not null,
//			q_content varchar(100),
//			a_1 varchar(100) not null,
//			a_2 varchar(100) not null,
//			a_3 varchar(100) not null,
//			a_4 varchar(100) not null,
//			answer int(10),
//			FOREIGN KEY(subject_cd)
//			REFERENCES sub_table(cd),
//			PRIMARY KEY(year,cnt,subject_cd,q_num)
//			 );
	
	
	private int year; //기출년도
	private int cnt; //기출회차
	private int subject_cd; //과목코드(0~5)
	private int q_num; //문제번호
	private String q_subject; //문제명
	private String q_content; //문제자료
	private String a_1; //보기1번
	private String a_2; //보기2번
	private String a_3; //보기3번
	private String a_4; //보기4번
	private int answer; //정답
	private String name; //sub_table의 과목코드와 일치하는 과목명을 담기 위한 변수
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public ArchiveDTO() {
		super();
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getSubject_cd() {
		return subject_cd;
	}
	public void setSubject_cd(int subject_cd) {
		this.subject_cd = subject_cd;
	}
	public int getQ_num() {
		return q_num;
	}
	public void setQ_num(int q_num) {
		this.q_num = q_num;
	}
	public String getQ_subject() {
		return q_subject;
	}
	public void setQ_subject(String q_subject) {
		this.q_subject = q_subject;
	}
	public String getQ_content() {
		return q_content;
	}
	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}
	
	
	public String getA_1() {
		return a_1;
	}
	public void setA_1(String a_1) {
		this.a_1 = a_1;
	}
	public String getA_2() {
		return a_2;
	}
	public void setA_2(String a_2) {
		this.a_2 = a_2;
	}
	public String getA_3() {
		return a_3;
	}
	public void setA_3(String a_3) {
		this.a_3 = a_3;
	}
	public String getA_4() {
		return a_4;
	}
	public void setA_4(String a_4) {
		this.a_4 = a_4;
	}
	public int getAnswer() {
		return answer;
	}
	public void setAnswer(int answer) {
		this.answer = answer;
	}
	@Override
	public String toString() {
		return "ArchiveDTO [year=" + year + ", cnt=" + cnt + ", subject_cd=" + subject_cd + ", q_num=" + q_num
				+ ", q_subject=" + q_subject + ", q_content=" + q_content + ", q_1=" + a_1 + ", q_2=" + a_2 + ", q_3="
				+ a_3 + ", q_4=" + a_4 + "]";
	}
	
	
}
