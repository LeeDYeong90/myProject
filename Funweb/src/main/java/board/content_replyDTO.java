package board;

import java.sql.Date;

public class content_replyDTO {

//	CREATE TABLE  content_reply (
//			index_comment int(30) auto_increment primary key, 
//			post_num int(30) not null, 
//			comment_id varchar(16) not null, 
//			comment varchar(200) not null, 
//			date datetime not null, 
//			comment_class int(10) not null, 
//			group_num int(30) not null); 
	
	private int index_comment; //댓글 인덱스 번호(자동증가)
	private int post_num; //게시글 번호
	private String comment_id; //댓글작성자 아이디
	private String comment; //댓글 내용
	private Date date; //댓글 작성일
	private int comment_class; //댓글과 대댓글 구분 계층(댓글은 0/ 대댓글은 1)
	private int group_num; //댓글과 대댓글을 묶어줌(댓글은 자기 인덱스번호 / 대댓글은 부모댓글의 인덱스번호)
	public content_replyDTO() {
		super();
	}
	public int getIndex_comment() {
		return index_comment;
	}
	public void setIndex_comment(int index_comment) {
		this.index_comment = index_comment;
	}
	public int getPost_num() {
		return post_num;
	}
	public void setPost_num(int post_num) {
		this.post_num = post_num;
	}
	public String getComment_id() {
		return comment_id;
	}
	public void setComment_id(String comment_id) {
		this.comment_id = comment_id;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getComment_class() {
		return comment_class;
	}
	public void setComment_class(int comment_class) {
		this.comment_class = comment_class;
	}
	public int getGroup_num() {
		return group_num;
	}
	public void setGroup_num(int group_num) {
		this.group_num = group_num;
	}
	@Override
	public String toString() {
		return "commentsDTO [index_comment=" + index_comment + ", post_num=" + post_num + ", comment_id=" + comment_id
				+ ", comment=" + comment + ", date=" + date + ", comment_class=" + comment_class + ", group_num="
				+ group_num + "]";
	}
	
	
}
