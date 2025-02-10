package board;

public class boardVO {
	
	private String no;
	private String author;
	private String title;
	private String content;
	private String createDate;
	private String updateDate;
	private String deleteDate;
	private int boardType;
	private String attachOriginName;
	private String attachUploadName;
	private String attachLocation;
	private long fileSize;
	
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
	public String getNo() {
		return no;
	}
	public String getAuthor() {
		return author;
	}
	public String getTitle() {
		return title;
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
	public String getDeleteDate() {
		return deleteDate;
	}
	public int getBoardType() {
		return boardType;
	}
	public String getAttachOriginName() {
		return attachOriginName;
	}
	public String getAttachUploadName() {
		return attachUploadName;
	}
	public String getAttachLocation() {
		return attachLocation;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public void setDeleteDate(String deleteDate) {
		this.deleteDate = deleteDate;
	}
	public void setBoardType(int boardType) {
		this.boardType = boardType;
	}
	public void setAttachOriginName(String attachOriginName) {
		this.attachOriginName = attachOriginName;
	}
	public void setAttachUploadName(String attachUploadName) {
		this.attachUploadName = attachUploadName;
	}
	public void setAttachLocation(String attachLocation) {
		this.attachLocation = attachLocation;
	}
	
}
