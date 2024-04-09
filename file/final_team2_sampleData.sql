insert into member_state(ms_state) values("이용중"),("기간정지"), ("영구정지"), ("탈퇴");
insert into member_auth(ma_auth) values("관리자"),("멘토"), ("일반");

/* 운영자 정보 추가 */
insert into member(me_id, me_pw, me_nickname, me_name, me_phone, me_address, me_ms_state, me_ma_auth)
	values("admin", "admin", "운영자", "운영자", "010-1234-5678", "서울시 강남구 역삼동", "이용중", "관리자");
    
/* 일반 유저 정보 추가 */
insert into member(me_id, me_pw, me_nickname, me_name, me_phone, me_address, me_ms_state, me_ma_auth)
	values("qwert@final.com", "qwert1234", "동동이", "홍길동", "010-9877-5678", "서울시 강남구 역삼동", "이용중", "일반"),
		  ("dkdlel@final.com", "dkdlel1234", "텐텐먹고쑥쑥", "최유리", "010-4658-4214", "서울시 강남구 도곡동", "이용중", "일반");
          
/* 멘토 유저 정보 추가 */
insert into member(me_id, me_pw, me_nickname, me_name, me_phone, me_address, me_ms_state, me_ma_auth)
	values("asdfg@final.com", "asdfg3214", "꺼비", "임꺽정", "010-9876-5678", "서울시 강남구 역삼동", "이용중", "멘토");

SELECT * FROM final_team2.member;    

INSERT INTO mentor_info VALUES 
("admin", 				0, 	"admin test", 	"admin test", 	"admin test", 		"0000-000-0000", NOW(), 0),
("asdfg@final.com", 	3, 	"웹개발", 		"", 			"개발자 임꺽정입니다.", 	"0000-000-0000", NOW(), 1),
("qwert@final.com", 	0, 	"인프라개발", 		"", 			"멘토 신청 테스트.", 	"0000-000-0000", NOW(), -1);

SELECT * FROM final_team2.mentor_info;

INSERT INTO mentoring(ment_title, ment_duration, ment_content, ment_me_id, ment_state) VALUES
("웹개발 기초반", 				"2024-10-11",	"css, html, js 기초부터 알려드립니다. 줌 아이디가 필요합니다.", 						"asdfg@final.com", 1), 
("2024 웹개발자 자소서 쓰기", 	"2024-03-11",	"웹개발자 자소서 첨삭해드립니다. 작성해놓은 자소서가 있다면 신청서에 외부 링크 첨부 부탁드립니다.", "asdfg@final.com", 0), 
("2025 웹개발자 면접 준비", 		"2025-03-11",	"웹개발자 면접 준비해드립니다. 자소서가 필요합니다. 첨부 안하신 분은 신청 거절합니다.", 			"asdfg@final.com", 0);

SELECT * FROM final_team2.mentoring;


INSERT INTO mentoring_apply(mentAp_ment_num, mentAp_me_id, mentAp_content, mentAp_state) VALUES
(1, "admin", 			"admin test", 															0),
(2, "qwert@final.com", 	"자소서 첨삭 부탁드립니다. 썼던 자소서를 첨부하라고 하셔서 첨부합니다: www.xxx.xxx.com", 1),
(3, "qwert@final.com", 	"면접 꿀팁 많이 주셨으면 좋겠습니다.", 											-1);

SELECT * FROM final_team2.mentoring_apply;

INSERT INTO recruit(recu_go_num, recu_content, recu_due, recu_state, recu_type, 
	recu_topic, recu_target, recu_count, recu_required, recu_preferred, recu_online, recu_interview) VALUES
(1, "그룹 1 프로젝트 모집 공고", 			"2023-01-23", 0, 1, 	"그룹 1 주제", "그룹 1 목표", 0, "탈주 금지", 								null, 0, 1),
(2, "그룹 2 스터디 모집 공고", 			"2024-11-20", 1, 0, 	"그룹 2 주제", "그룹 2 목표", 3, "몸만 오세요.", 							"그룹 2 선호사항", 1, 0),
(3, "그룹 3 프로젝트 및 스터디 모집 공고", 	"2023-01-23", 0, 2, 	"그룹 3 주제", "그룹 3 목표", 5, "성향 파악 때문에 부분면접 진행할 수 있습니다.", 	"그룹 3 선호사항", 2, 2);

SELECT * FROM final_team2.recruit;


-- 강의 : lecture
insert into lecture (lect_mentIf_me_id, lect_name, lect_intro, lect_price, lect_posting, lect_update)
	values('asdfg@final.com', '공주와 함께하는 자바 교실', '공주님과 함께 자바 수업듣고 자바킹이 되어봅시다.', 17000, now(), now()),
		  ('asdfg@final.com', '스프링부트의 정석', '스프링부트가 어렵다? 이 강의 들으면 달인이 될 수 있습니다.', 25000, now(), now());
    
SELECT * FROM final_team2.lecture;

-- 강의 파일 : lecture_file
insert into lecture_file (lectFi_lect_num, lectFi_path, lectFi_ori_name, lectFi_choice, lectFi_link)
	values(1, '/2024/02/14/공지사항1.JPG', '자바킹', 0, 0),
		  (2, '/2024/02/14/공지사항1.JPG', '뿌시자스부', 0, 0);

SELECT * FROM final_team2.lecture_file;

-- 강의 수강 : lecture_register
insert into lecture_register(lectRg_lect_num, lectRg_me_id, lectRg_money, lectRg_state)
	values(1, 'qwert@final.com', 17000, 0),
		  (1, 'dkdlel@final.com', 17000, 1),
          (2, 'dkdlel@final.com', 25000, 0);

SELECT * FROM final_team2.lecture_register;

-- 강의 리뷰 : lecture_review
insert into lecture_review(lectRv_lect_num, lectRv_me_id, lectRv_content, lectRv_score)
	values(1, 'qwert@final.com', '강의가 이해하기 쉽고, 귀에 쏙쏙 들어와서 곧 자바킹이 될 것만 같아요.', 5),
		  (1, 'dkdlel@final.com', '헷갈렸던 부분을 이해할 수 있어서 도움이 되는 강의였습니다', 4),
          (2, 'dkdlel@final.com', '초보자가 듣기엔 조금 따라가기 버거운 수업 같습니다. 근데 전공자들은 들으면 확실히 도움이 될 거 같네요', 2);
          
SELECT * FROM final_team2.lecture_review;

-- 추천 : recommend
insert into recommend(reco_me_id, reco_state, reco_table, reco_target) 
	values('qwert@final.com', 1, 'post', '1'),
		  ('qwert@final.com', 1, 'lecture', '1'),
          ('qwert@final.com', 1, 'mentor_info', '1');

SELECT * FROM final_team2.recommend;