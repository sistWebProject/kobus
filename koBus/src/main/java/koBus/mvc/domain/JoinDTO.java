package koBus.mvc.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class JoinDTO {
	private String kusID;
	private String tel;
	private String subEmail;
	private String id;
	private String passwd;
	private String rank;
	private String status;
	private Date birth;
	private Date joinDate;
	private int gender;
	private int mil;	
}
