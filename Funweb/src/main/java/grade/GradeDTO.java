package grade;

//이용자들의 점수를 저장하는 테이블
public class GradeDTO {
	private String id; //회원 아이디
	private int year; //기출년도
	private int cnt; //기출회차
	private int subject_cd; //과목코드(0~5)
	private int score; //점수
	private String subject_name; //sub_table의 과목코드와 일치하는 과목명을 담기 위한 변수
	
	public GradeDTO() {
		super();
	}
	
	public String getSubject_name() {
		return subject_name;
	}

	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	@Override
	public String toString() {
		return "GradeDTO [id=" + id + ", year=" + year + ", cnt=" + cnt + ", subject_cd=" + subject_cd + ", score="
				+ score + "]";
	}
	
	
}
