package info_file;

public class infoFileVO {
	
	private String fno;
	private String no;
	private String attachOriginName;
	private String attachUploadName;
	private String attachLocation;
	private int fileSize;
	
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	public String getFno() {
		return fno;
	}
	public String getNo() {
		return no;
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
	public void setFno(String fno) {
		this.fno = fno;
	}
	public void setNo(String no) {
		this.no = no;
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
