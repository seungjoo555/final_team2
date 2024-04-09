USE final_team2;

SELECT * FROM final_team2.member;

# 멘토 정보 테이블 (멘토 아이디, 멘토 경력, 멘토 직무, 포트폴리오, 자기소개, 계좌정보, 멘토 등록일, 멘토 권한 신청 상태)
# =============================================================================
/*
멘토 권한 신청 상태
- 0: 검토중 (default)
- 1: 승인
- (-1): 거절
*/

INSERT INTO mentor_info VALUES 
("admin", 				0, 	"admin test", 	"admin test", 	"admin test", 		"0000-000-0000", NOW(), 0),
("asdfg@final.com", 	3, 	"웹개발", 		"", 			"개발자 임꺽정입니다.", 	"0000-000-0000", NOW(), 1),
("qwert@final.com", 	0, 	"인프라개발", 		"", 			"멘토 신청 테스트.", 	"0000-000-0000", NOW(), -1);

SELECT * FROM final_team2.mentor_info;

# 멘토링 테이블 (멘토링 번호(AI), 클래스 이름, 클래스 기간, 클래스 소개, 멘토 아이디, 멘토링 모집 현황)
# =============================================================================
/* 모집기간 끝난 멘토링은 자동으로 모집현황이 0이 되도록 하는 이벤트 스케쥴러 필요함 */

INSERT INTO mentoring(ment_title, ment_duration, ment_content, ment_me_id, ment_state) VALUES
("웹개발 기초반", 				"2024-10-11",	"css, html, js 기초부터 알려드립니다. 줌 아이디가 필요합니다.", 						"asdfg@final.com", 1), 
("2024 웹개발자 자소서 쓰기", 	"2024-03-11",	"웹개발자 자소서 첨삭해드립니다. 작성해놓은 자소서가 있다면 신청서에 외부 링크 첨부 부탁드립니다.", "asdfg@final.com", 0), 
("2025 웹개발자 면접 준비", 		"2025-03-11",	"웹개발자 면접 준비해드립니다. 자소서가 필요합니다. 첨부 안하신 분은 신청 거절합니다.", 			"asdfg@final.com", 0);

SELECT * FROM final_team2.mentoring;

# 멘토링 신청 테이블 (멘토링 신청 번호(AI), 멘토링 번호(FK), 멘토링 신청자 아이디(FK), 신청 내용, 멘토링 허용 여부)
# =============================================================================
/*
멘토링 신청 상태
- 0: 검토중 (default)
- 1: 승인
- (-1): 거절
*/

INSERT INTO mentoring_apply(mentAp_ment_num, mentAp_me_id, mentAp_content, mentAp_state) VALUES
(1, "admin", 			"admin test", 															0),
(2, "qwert@final.com", 	"자소서 첨삭 부탁드립니다. 썼던 자소서를 첨부하라고 하셔서 첨부합니다: www.xxx.xxx.com", 1),
(3, "qwert@final.com", 	"면접 꿀팁 많이 주셨으면 좋겠습니다.", 											-1);

SELECT * FROM final_team2.mentoring_apply;

# 그룹 모집 공고 테이블 (공고 번호(AI), 그룹 번호(FK), 공고 내용, 마감기한, 모집현황, 그룹 구분, 그룹 주제, 그룹 목적, 모집 인원, 필수 자격, 선호 자격(null), 온오프라인 여부, 면접 여부, 면접 여부)
# =============================================================================
/*
모집 현황
- 0: 모집 마감
- 1: 모집중 (default)

그룹 구분
- 0: 스터디
- 1: 프로젝트
- 2: 프로젝트 + 스터디

모집 인원
- 0으로 설정 시: 미정

온/오프라인 여부
- 0: 온라인 (default)
- 1: 오프라인
- 2: 복합

면접여부
- 0: 없음
- 1: 필수
- 2: 부분면접 (경력 1년 이하는 면접이라던지)
*/

INSERT INTO recruit(recu_go_num, recu_content, recu_due, recu_state, recu_type, 
	recu_topic, recu_target, recu_count, recu_required, recu_preferred, recu_online, recu_interview) VALUES
(1, "그룹 1 프로젝트 모집 공고", 			"2023-01-23", 0, 1, 	"그룹 1 주제", "그룹 1 목표", 0, "탈주 금지", 								null, 0, 1),
(2, "그룹 2 스터디 모집 공고", 			"2024-11-20", 1, 0, 	"그룹 2 주제", "그룹 2 목표", 3, "몸만 오세요.", 							"그룹 2 선호사항", 1, 0),
(3, "그룹 3 프로젝트 및 스터디 모집 공고", 	"2023-01-23", 0, 2, 	"그룹 3 주제", "그룹 3 목표", 5, "성향 파악 때문에 부분면접 진행할 수 있습니다.", 	"그룹 3 선호사항", 2, 2);

SELECT * FROM final_team2.recruit;
