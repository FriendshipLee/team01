package users;

public class User {
	private String id;
	private String pw;
	private String nick;
	private String email;
	private String name;
	private String birth;
	private String gender;
	private int userType;
	private String number;
	private String createDate;
	private String updateDate;
	private String deleteDate;
	private String companyNumber;
	private String companyName;
	private String ceoName;
	private String businessType;
	private int companyType;
	
	public String getCompanyNumber() {
		return companyNumber;
	}
	public String getCompanyName() {
		return companyName;
	}
	public String getCeoName() {
		return ceoName;
	}
	public String getBusinessType() {
		return businessType;
	}
	public int getCompanyType() {
		return companyType;
	}
	public void setCompanyNumber(String companyNumber) {
		this.companyNumber = companyNumber;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public void setCeoName(String ceoName) {
		this.ceoName = ceoName;
	}
	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}
	public void setCompanyType(int companyType) {
		this.companyType = companyType;
	}
	
	public String getId() {
		return id;
	}
	public String getPw() {
		return pw;
	}
	public String getNick() {
		return nick;
	}
	public String getEmail() {
		return email;
	}
	public String getName() {
		return name;
	}
	public String getBirth() {
		return birth;
	}
	public String getGender() {
		return gender;
	}
	public String getNumber() {
		return number;
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
	public int getUserType() {
		return userType;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public void setNumber(String number) {
		this.number = number;
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
	public void setUserType(int userType) {
		this.userType = userType;
	}
}
