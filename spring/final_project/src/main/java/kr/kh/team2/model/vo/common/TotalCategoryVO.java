package kr.kh.team2.model.vo.common;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor

public class TotalCategoryVO {
    private int toCt_num;
    private int toCt_progCt_num;
    private String toCt_progCt_name; // 프로그래밍 이름
    private String toCt_table_name;
    private String toCt_table_pk;
}