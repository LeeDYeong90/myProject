package board;

import java.sql.Date;

public class FileBoardDTO {
//	CREATE TABLE file_board (
//	num INT PRIMARY KEY,
//	name VARCHAR(16) NOT NULL,
//	pass VARCHAR(16) NOT NULL,
//	subject VARCHAR(100) NOT NULL,
//	content VARCHAR(1000) NOT NULL,
//	file VARCHAR(100) NOT NULL, 
//	original_file VARCHAR(100) NOT NULL,
//	date DATETIME NOT NULL,	
//	readcount INT NOT NULL);
	
	
	private int num;
	private String name;
	private String pass;
	private String subject;
	private String content;
	private String file;
	private String original_file;
	private Date date;
	private int readcount;
	
	public FileBoardDTO() { //기본생성자
		super();
	}

//	각 멤버변수들의 getter/setter 생성
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

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
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

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getOriginal_file() {
		return original_file;
	}

	public void setOriginal_file(String original_file) {
		this.original_file = original_file;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	@Override
	public String toString() {
		return "FileBoardDTO [num=" + num + ", name=" + name + ", pass=" + pass + ", subject=" + subject + ", content="
				+ content + ", file=" + file + ", original_file=" + original_file + ", date=" + date + ", readcount="
				+ readcount + "]";
	}
	
	
	
	
	
}


