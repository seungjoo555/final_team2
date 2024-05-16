package kr.kh.team2.model.vo.member;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MeVerifyVO {
	private String mv_me_id;
    private String mv_code;
    private Date mv_createTime;
    private Date mv_expTime;
}
