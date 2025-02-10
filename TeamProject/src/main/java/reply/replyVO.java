package reply;

public class replyVO {
	
	private String rno;
	private String bno;
	private String rauthor;
	private String content;
	private String createDate;
	private String updateDate;
	private int replyType;
	
	public String getRno() {
		return rno;
	}
	public String getBno() {
		return bno;
	}
	public String getRauthor() {
		return rauthor;
	}
	public String getContent() {
		return content;
	}
	public String getCreateDate() {
		return createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public int getReplyType() {
		return replyType;
	}
	public void setRno(String rno) {
		this.rno = rno;
	}
	public void setBno(String bno) {
		this.bno = bno;
	}
	public void setRauthor(String rauthor) {
		this.rauthor = rauthor;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public void setReplyType(int replyType) {
		this.replyType = replyType;
	}
	
	
}