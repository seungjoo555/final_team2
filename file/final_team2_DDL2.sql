DROP DATABASE if exists final_team2;
CREATE DATABASE IF NOT EXISTS final_team2;
USE final_team2;

/*
ERD CLOUD 수정사항

1. group_member 테이블에 복합키 설정
- primary key(`gome_me_id`,`gome_go_num`)

2. mutual_review 테이블에서 group_member 테이블을 참조하면서 생기는 복합키 외래키 참조 오류 수정
- FK_group_member_TO_mutual_review_2 제약조건 설정 쿼리를 삭제하고, FK_group_member_TO_mutual_review_1에서 두 개의 참조 내용을 한 번에 설정하도록 함
- 따로하면 오류가 뜸(이유 불명...)
- 결과적으로,
	
    ALTER TABLE `mutual_review` ADD CONSTRAINT `FK_group_member_TO_mutual_review_1` FOREIGN KEY (
		`mure_me_id`, `mure_go_num`
	)
	REFERENCES `group_member` (
		`gome_me_id`, `gome_go_num`
	);
	
    이거만 있으면 되고,
    그 아래에 있을 FK_group_member_TO_mutual_review_2 제약조건은 삭제해야함
*/

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
	`me_id`	varchar(50) primary key	NOT NULL,
	`me_ms_state`	varchar(20)	NOT NULL,
	`me_ma_auth`	varchar(20)	NOT NULL,
	`me_pw`	varchar(250)	NULL,
	`me_nickname`	varchar(8) unique	NOT NULL,
	`me_name`	varchar(20)	NOT NULL,
	`me_phone`	varchar(13)	NOT NULL,
	`me_point`	int default 0	NULL,
	`me_address`	varchar(50)	NOT NULL,
	`me_failcount`	int default 0	NULL,
	`me_reportcount`	int default 0	NULL,
	`me_login`	int default 0	NULL,
	`me_date`	datetime default now()	NULL,
	`me_type`	int default 0	NOT NULL,
	`me_degree`	float default 36.5	NULL,
	`me_interests`	varchar(20)	NULL,
	`me_preferloc`	varchar(10)	NULL,
	`me_prefertime`	int	NULL,
	`me_onoff`	int	NULL,
	`me_intro`	text	NULL
);

DROP TABLE IF EXISTS `mentor_job`;

CREATE TABLE `mentor_job` (
	`ment_job`	varchar(50) primary key	NOT NULL
);
DROP TABLE IF EXISTS `mentor_info`;

CREATE TABLE `mentor_info` (
	`mentIf_me_id`	varchar(50) primary key	NOT NULL,
	`mentIf_exp`	int default 0	NOT NULL,
	`mentIf_portfolio`	text	NULL,
	`mentIf_intro`	text	NULL,
	`mentIf_account`	varchar(20)	NOT NULL,
	`mentIf_date`	date	NOT NULL,
	`mentIf_state`	int default 0	NOT NULL,
	`mentIf_ment_job`	varchar(50)	NOT NULL
);

DROP TABLE IF EXISTS `mentoring_review`;

CREATE TABLE `mentoring_review` (
	`mentRv_num`	int primary key auto_increment	NOT NULL,
	`mentRv_content`	text	NULL,
	`mentRv_rate`	int default 5	NOT NULL,
	`mentRv_date`	datetime	NOT NULL,
	`mentRv_ment_num`	int	NOT NULL,
	`mentRv_mentAp_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `recruit`;

CREATE TABLE `recruit` (
	`recu_num`	int primary key auto_increment	NOT NULL,
	`recu_go_num`	int	NOT NULL,
	`recu_content`	longtext	NOT NULL,
	`recu_due`	datetime	NOT NULL,
	`recu_state`	int default 1	NOT NULL,
	`recu_type`	int	NOT NULL,
	`recu_topic`	varchar(20)	NOT NULL,
	`recu_target`	varchar(20)	NOT NULL,
	`recu_count`	int default 0	NOT NULL,
	`recu_required`	text not null	NOT NULL,
	`recu_preferred`	text	NULL,
	`recu_online`	int not null default 0	NOT NULL,
	`recu_interview`	int default 0	NOT NULL,
	`recu_repoCount`	int default 0	NOT NULL
);

DROP TABLE IF EXISTS `group_apply`;

CREATE TABLE `group_apply` (
	`goap_num`	int primary key auto_increment	NOT NULL,
	`goap_go_num`	int	NOT NULL,
	`goap_recu_num`	int	NOT NULL,
	`goap_content`	text	NULL,
	`goap_state`	int default 0	NOT NULL,
	`goap_me_id`	varchar(50)	NOT NULL
);

DROP TABLE IF EXISTS `mutual_review`;

CREATE TABLE `mutual_review` (
	`mure_num`	int auto_increment primary key	NOT NULL,
	`mure_content`	text	NULL,
	`mure_rate`	int default 5	NOT NULL,
	`mure_me_id`	varchar(50)	NOT NULL,
	`mure_target_id`	varchar(50)	NOT NULL,
	`mure_go_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
	`go_num`	int primary key auto_increment	NOT NULL,
	`go_name`	varchar(20)	NOT NULL,
	`go_time`	bigint default 0	NULL,
	`go_update`	boolean default 0	NOT NULL
);

DROP TABLE IF EXISTS `group_member`;

CREATE TABLE `group_member` (
	`gome_me_id`	varchar(50)	NOT NULL,
	`gome_go_num`	int	NOT NULL,
	`gome_type`	int default 0	NOT NULL,
	`gome_warn`	int default 0	NOT NULL,
    primary key(`gome_me_id`,`gome_go_num`)
);

DROP TABLE IF EXISTS `group_post`;

CREATE TABLE `group_post` (
	`gopo_num`	int  primary key auto_increment	NOT NULL,
	`gopo_content`	longtext	NULL,
	`gopo_date`	datetime	NULL,
	`gopo_gome_me_id`	varchar(50)	NOT NULL,
	`gopo_gome_go_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `lecture_review`;

CREATE TABLE `lecture_review` (
	`lectRv_num`	int auto_increment primary key	NOT NULL,
	`lectRv_lect_num`	int	NOT NULL,
	`lectRv_me_id`	varchar(50)	NOT NULL,
	`lectRv_content`	text	NOT NULL,
	`lectRv_score`	int	NOT NULL
);

DROP TABLE IF EXISTS `member_state`;

CREATE TABLE `member_state` (
	`ms_state`	varchar(20) primary key	NOT NULL
);

DROP TABLE IF EXISTS `report_content`;

CREATE TABLE `report_content` (
	`repo_content`	varchar(100) primary key	NOT NULL
);

DROP TABLE IF EXISTS `report_state`;

CREATE TABLE `report_state` (
	`repo_state`	varchar(10) primary key	NOT NULL
);

DROP TABLE IF EXISTS `lecture`;

CREATE TABLE `lecture` (
	`lect_num`	int auto_increment primary key	NOT NULL,
	`lect_mentIf_me_id`	varchar(50)	NOT NULL,
	`lect_name`	varchar(100)	NOT NULL,
	`lect_intro`	longtext	NOT NULL,
	`lect_price`	int	NOT NULL,
	`lect_posting`	date	NOT NULL,
	`lect_update`	date	NOT NULL
);

DROP TABLE IF EXISTS `board`;

CREATE TABLE `board` (
	`board_num`	int  auto_increment primary key	NOT NULL,
	`board_name`	varchar(30)	NOT NULL
);

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
	`post_num`	int auto_increment primary key	NOT NULL,
	`post_name`	varchar(100)	NOT NULL,
	`post_content`	longtext	NOT NULL,
	`post_view`	int	NOT NULL default 0,
	`post_date`	datetime	NOT NULL,
    `post_repoCount` int default 0 not null,
	`post_board_num`	int	NOT NULL,
	`post_me_id`	varchar(50)	NOT NULL
);

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
	`cmmt_num`	int auto_increment primary key	NOT NULL,
	`cmmt_content`	text	NOT NULL,
	`cmmt_repoCount`	int default 0	NOT NULL,
	`cmmt_post_num`	int	NOT NULL,
	`cmmt_me_id`	varchar(50)	NOT NULL
);

DROP TABLE IF EXISTS `mentoring`;

CREATE TABLE `mentoring` (
	`ment_num`	int primary key auto_increment	NOT NULL,
	`ment_title`	varchar(30)	NOT NULL,
	`ment_duration`	datetime	NOT NULL,
	`ment_content`	longtext	NULL,
	`ment_me_id`	varchar(50)	NOT NULL,
	`ment_state`	int default 1	NOT NULL
);

DROP TABLE IF EXISTS `mentoring_apply`;

CREATE TABLE `mentoring_apply` (
	`mentAp_num`	int primary key auto_increment	NOT NULL,
	`mentAp_ment_num`	int	NOT NULL,
	`mentAp_me_id`	varchar(50)	NOT NULL,
	`mentAp_content`	text	NOT NULL,
	`mentAp_state`	int default 0	NOT NULL
);

DROP TABLE IF EXISTS `lecture_register`;

CREATE TABLE `lecture_register` (
	`lectRg_num`	int auto_increment primary key	NOT NULL,
	`lectRg_lect_num`	int	NOT NULL,
	`lectRg_me_id`	varchar(50)	NOT NULL,
	`lectRg_money`	int	NOT NULL,
	`lectRg_state`	boolean	NOT NULL
);

DROP TABLE IF EXISTS `member_auth`;

CREATE TABLE `member_auth` (
	`ma_auth`	varchar(20) primary key	NOT NULL
);

DROP TABLE IF EXISTS `group_calendar`;

CREATE TABLE `group_calendar` (
	`gocal_ num`	int primary key auto_increment	NOT NULL,
	`gocal_title`	varchar(30)	NOT NULL,
	`gocal_startdate`	date	NOT NULL,
	`gocal_enddate`	date	NULL,
	`gocal_memo`	text	NULL,
	`gocal_me_id`	varchar(50)	NOT NULL,
	`gocal_go_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `lecture_file`;

CREATE TABLE `lecture_file` (
	`lectFi_num`	int auto_increment primary key	NOT NULL,
	`lectFi_lect_num`	int	NOT NULL,
	`lectFi_path`	varchar(100)	NOT NULL,
	`lectFi_ori_name`	varchar(50)	NOT NULL,
	`lectFi_choice`	boolean	NOT NULL,
	`lectFi_link`	boolean	NOT NULL
);

DROP TABLE IF EXISTS `programming_category`;

CREATE TABLE `programming_category` (
	`progCt_num`	int  auto_increment primary key	NOT NULL,
	`progCt_name`	varchar(15)	NOT NULL
);

DROP TABLE IF EXISTS `me_verify`;

CREATE TABLE `me_verify` (
	`mv_me_id`	varchar(50) primary key	NOT NULL,
	`mv_code`	varchar(6)	NOT NULL,
	`mv_durate`	time	NOT NULL
);

DROP TABLE IF EXISTS `search_menu`;

CREATE TABLE `search_menu` (
	`sear_num`	int  auto_increment primary key	NOT NULL,
	`sear_progCt_num`	int	NOT NULL,
	`sear_lang_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `total_category`;

CREATE TABLE `total_category` (
	`toCt_num`	int auto_increment primary key	NOT NULL,
	`toCt_progCt_num`	int	NOT NULL,
	`toCt_table_name`	varchar(30)	NOT NULL,
	`toCt_table_pk`	varchar(50)	NOT NULL
);

DROP TABLE IF EXISTS `programming_language`;

CREATE TABLE `programming_language` (
	`lang_num`	int  auto_increment primary key	NOT NULL,
	`lang_name`	varchar(20)	NOT NULL
);

DROP TABLE IF EXISTS `total_language`;

CREATE TABLE `total_language` (
	`toLg_num`	int auto_increment primary key	NOT NULL,
	`toLg_lang_num`	int	NOT NULL,
	`toLg_table_name`	varchar(30)	NOT NULL,
	`toLg_table_pk`	varchar(50)	NOT NULL
);

DROP TABLE IF EXISTS `report`;

CREATE TABLE `report` (
	`repo_num`	int primary key auto_increment	NOT NULL,
	`repo_repo_content`	varchar(100)	NOT NULL,
	`repo_repo_state`	varchar(10)	NOT NULL,
	`repo_me_id`	varchar(50)	NOT NULL,
	`repo_detail`	text	NOT NULL,
	`repo_date`	Datetime	NOT NULL,
	`repo_table`	varchar(15)	NOT NULL,
	`repo_target`	varchar(50)	NOT NULL
);

DROP TABLE IF EXISTS `recommend`;

CREATE TABLE `recommend` (
	`reco_num`	int auto_increment primary key	NOT NULL,
	`reco_me_id`	varchar(50)	NOT NULL,
	`reco_state`	int	NOT NULL,
	`reco_table`	varchar(30)	NOT NULL,
	`reco_target`	varchar(50)	NOT NULL
);

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
	`file_num`	int  auto_increment primary key	NOT NULL,
	`file_name`	varchar(150)	NOT NULL,
	`file_ori_name`	varchar(150)	NOT NULL,
	`file_table`	varchar(50)	NOT NULL,
	`file_target`	int	NOT NULL
);

ALTER TABLE `member` ADD CONSTRAINT `FK_member_state_TO_member_1` FOREIGN KEY (
	`me_ms_state`
)
REFERENCES `member_state` (
	`ms_state`
);

ALTER TABLE `member` ADD CONSTRAINT `FK_member_auth_TO_member_1` FOREIGN KEY (
	`me_ma_auth`
)
REFERENCES `member_auth` (
	`ma_auth`
);

ALTER TABLE `mentor_info` ADD CONSTRAINT `FK_member_TO_mentor_info_1` FOREIGN KEY (
	`mentIf_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `mentor_info` ADD CONSTRAINT `FK_mentor_job_TO_mentor_info_1` FOREIGN KEY (
	`mentIf_ment_job`
)
REFERENCES `mentor_job` (
	`ment_job`
);


ALTER TABLE `mentoring_review` ADD CONSTRAINT `FK_mentoring_TO_mentoring_review_1` FOREIGN KEY (
	`mentRv_ment_num`
)
REFERENCES `mentoring` (
	`ment_num`
);

ALTER TABLE `mentoring_review` ADD CONSTRAINT `FK_mentoring_apply_TO_mentoring_review_1` FOREIGN KEY (
	`mentRv_mentAp_num`
)
REFERENCES `mentoring_apply` (
	`mentAp_num`
);

ALTER TABLE `recruit` ADD CONSTRAINT `FK_group_TO_recruit_1` FOREIGN KEY (
	`recu_go_num`
)
REFERENCES `group` (
	`go_num`
);

ALTER TABLE `group_apply` ADD CONSTRAINT `FK_group_TO_group_apply_1` FOREIGN KEY (
	`goap_go_num`
)
REFERENCES `group` (
	`go_num`
);

ALTER TABLE `group_apply` ADD CONSTRAINT `FK_recruit_TO_group_apply_1` FOREIGN KEY (
	`goap_recu_num`
)
REFERENCES `recruit` (
	`recu_num`
);

ALTER TABLE `group_apply` ADD CONSTRAINT `FK_member_TO_group_apply_1` FOREIGN KEY (
	`goap_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `mutual_review` ADD CONSTRAINT `FK_group_member_TO_mutual_review_1` FOREIGN KEY (
	`mure_me_id`,	`mure_go_num`
)
REFERENCES `group_member` (
	`gome_me_id`, `gome_go_num`
);

ALTER TABLE `mutual_review` ADD CONSTRAINT `FK_member_TO_mutual_review_1` FOREIGN KEY (
	`mure_target_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `group_member` ADD CONSTRAINT `FK_member_TO_group_member_1` FOREIGN KEY (
	`gome_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `group_member` ADD CONSTRAINT `FK_group_TO_group_member_1` FOREIGN KEY (
	`gome_go_num`
)
REFERENCES `group` (
	`go_num`
);

ALTER TABLE `group_post` ADD CONSTRAINT `FK_group_member_TO_group_post_1` FOREIGN KEY (
	`gopo_gome_me_id`
)
REFERENCES `group_member` (
	`gome_me_id`
)
ON DELETE CASCADE;

ALTER TABLE `group_post` ADD CONSTRAINT `FK_group_member_TO_group_post_2` FOREIGN KEY (
	`gopo_gome_go_num`
)
REFERENCES `group_member` (
	`gome_go_num`
)
ON DELETE CASCADE;

ALTER TABLE `lecture_review` ADD CONSTRAINT `FK_lecture_TO_lecture_review_1` FOREIGN KEY (
	`lectRv_lect_num`
)
REFERENCES `lecture` (
	`lect_num`
);

ALTER TABLE `lecture_review` ADD CONSTRAINT `FK_member_TO_lecture_review_1` FOREIGN KEY (
	`lectRv_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `lecture` ADD CONSTRAINT `FK_mentor_info_TO_lecture_1` FOREIGN KEY (
	`lect_mentIf_me_id`
)
REFERENCES `mentor_info` (
	`mentIf_me_id`
);

ALTER TABLE `post` ADD CONSTRAINT `FK_board_TO_post_1` FOREIGN KEY (
	`post_board_num`
)
REFERENCES `board` (
	`board_num`
);

ALTER TABLE `post` ADD CONSTRAINT `FK_member_TO_post_1` FOREIGN KEY (
	`post_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_post_TO_comment_1` FOREIGN KEY (
	`cmmt_post_num`
)
REFERENCES `post` (
	`post_num`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_member_TO_comment_1` FOREIGN KEY (
	`cmmt_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `mentoring` ADD CONSTRAINT `FK_mentor_info_TO_mentoring_1` FOREIGN KEY (
	`ment_me_id`
)
REFERENCES `mentor_info` (
	`mentIf_me_id`
);

ALTER TABLE `mentoring_apply` ADD CONSTRAINT `FK_mentoring_TO_mentoring_apply_1` FOREIGN KEY (
	`mentAp_ment_num`
)
REFERENCES `mentoring` (
	`ment_num`
);

ALTER TABLE `mentoring_apply` ADD CONSTRAINT `FK_member_TO_mentoring_apply_1` FOREIGN KEY (
	`mentAp_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `lecture_register` ADD CONSTRAINT `FK_lecture_TO_lecture_register_1` FOREIGN KEY (
	`lectRg_lect_num`
)
REFERENCES `lecture` (
	`lect_num`
);

ALTER TABLE `lecture_register` ADD CONSTRAINT `FK_member_TO_lecture_register_1` FOREIGN KEY (
	`lectRg_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `group_calendar` ADD CONSTRAINT `FK_group_member_TO_group_calendar_1` FOREIGN KEY (
	`gocal_me_id`
)
REFERENCES `group_member` (
	`gome_me_id`
)
ON DELETE CASCADE;

ALTER TABLE `group_calendar` ADD CONSTRAINT `FK_group_member_TO_group_calendar_2` FOREIGN KEY (
	`gocal_go_num`
)
REFERENCES `group_member` (
	`gome_go_num`
)
ON DELETE CASCADE;

ALTER TABLE `lecture_file` ADD CONSTRAINT `FK_lecture_TO_lecture_file_1` FOREIGN KEY (
	`lectFi_lect_num`
)
REFERENCES `lecture` (
	`lect_num`
);

ALTER TABLE `me_verify` ADD CONSTRAINT `FK_member_TO_me_verify_1` FOREIGN KEY (
	`mv_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `search_menu` ADD CONSTRAINT `FK_programming_category_TO_search_menu_1` FOREIGN KEY (
	`sear_progCt_num`
)
REFERENCES `programming_category` (
	`progCt_num`
);

ALTER TABLE `search_menu` ADD CONSTRAINT `FK_programming_language_TO_search_menu_1` FOREIGN KEY (
	`sear_lang_num`
)
REFERENCES `programming_language` (
	`lang_num`
);

ALTER TABLE `total_category` ADD CONSTRAINT `FK_programming_category_TO_total_category_1` FOREIGN KEY (
	`toCt_progCt_num`
)
REFERENCES `programming_category` (
	`progCt_num`
);

ALTER TABLE `total_language` ADD CONSTRAINT `FK_programming_language_TO_total_language_1` FOREIGN KEY (
	`toLg_lang_num`
)
REFERENCES `programming_language` (
	`lang_num`
);

ALTER TABLE `report` ADD CONSTRAINT `FK_report_content_TO_report_1` FOREIGN KEY (
	`repo_repo_content`
)
REFERENCES `report_content` (
	`repo_content`
);

ALTER TABLE `report` ADD CONSTRAINT `FK_report_state_TO_report_1` FOREIGN KEY (
	`repo_repo_state`
)
REFERENCES `report_state` (
	`repo_state`
);

ALTER TABLE `report` ADD CONSTRAINT `FK_member_TO_report_1` FOREIGN KEY (
	`repo_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `recommend` ADD CONSTRAINT `FK_member_TO_recommend_1` FOREIGN KEY (
	`reco_me_id`
)
REFERENCES `member` (
	`me_id`
);