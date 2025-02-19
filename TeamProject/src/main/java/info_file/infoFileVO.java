package info_file;

public class infoFileVO {
	
	private String fno;
	private String bno;
	private String attachOriginName;
	private String attachUploadName;
	private String attachLocation;
	private long fileSize;
	
	public String getFno() {
		return fno;
	}
	public void setFno(String fno) {
		this.fno = fno;
	}
	public String getBno() {
		return bno;
	}
	public void setBno(String bno) {
		this.bno = bno;
	}
	public String getAttachOriginName() {
		return attachOriginName;
	}
	public void setAttachOriginName(String attachOriginName) {
		this.attachOriginName = attachOriginName;
	}
	public String getAttachUploadName() {
		return attachUploadName;
	}
	public void setAttachUploadName(String attachUploadName) {
		this.attachUploadName = attachUploadName;
	}
	public String getAttachLocation() {
		return attachLocation;
	}
	public void setAttachLocation(String attachLocation) {
		this.attachLocation = attachLocation;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
	
}
