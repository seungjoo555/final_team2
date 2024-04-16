insert into `group`(go_name,go_update) values("파이썬프로젝트",1);
insert into `group`(go_name,go_update) values("스프링공부모임",1);
insert into `group`(go_name,go_update) values("KH방과후스터디",1);
SELECT * FROM RECRUIT;
insert into `recruit`(recu_go_num,recu_content,recu_due,recu_state,recu_type,recu_topic,recu_target,
					  recu_count,recu_required,recu_preferred,recu_online,recu_interview) 
			   values(1,
					   "소개.
						안녕하세요, 현업에서 개발직에 종사하고 있는 사람들로 구성된 팀입니다.
						계속 반복적인 업무에 지쳐 재미 + 포트폴리오 용으로 사이드 프로젝트를 진행하려고 하는데, 디자인을 담당해줄 인력이 없어 이렇게 구인을 하게 되었습니다.
						주제는 점심모임 매칭 어플리케이션입니다.
						같은 회사 사람들과의 잦은 식사로 새로운 리프레쉬가 필요한 사람들이 모여 다른 도메인과 다른 인사이트를 가진 사람들을 만날 수 있는 교두보가 되고자 합니다.
						매칭 알고리즘을 통한 매칭, 매칭 후 채팅 등의 기능이 포함된 어플을 개발할 예정입니다.
						주로 온라인으로 미팅을 진행할 예정이지만 가능하다면 달에 한번씩은 오프라인으로 만나서 서로 대화 나누는 것도 나쁘지 않다고 생각하는 중입니다.(물론 가능한 분만요!)
						관심 있으신 분은 많은 연락 바랍니다.", "2024-04-20", 1, 1, "점심모임매칭프로젝트", "프로젝트", 5, "파이썬,jsp,git,notion", "django, MySQL", 0,0);
                        

insert into `recruit`(recu_go_num,recu_content,recu_due,recu_state,recu_type,recu_topic,recu_target,
					  recu_count,recu_required,recu_preferred,recu_online,recu_interview) 
			   values(2,
						"[모임 목표 및 진행 방식]
						목표 : 개인 포트폴리오 제작 및 완성, 스프링 역량 강화를 위한 스터디 습관을 잡기 위해 온라인으로 인풋과 아웃풋 인증을 하고자 합니다.
						진행 방식 : 매주 개인 분량 설정 및 인&아웃풋 인증
						장소/횟수 : 본인이 집중하기 편한 곳/횟수 월~일 요일, 횟수 자유
						기간 : 3달 정도 진행하고자 합니다.
						참여 조건
						지식수준 : 저도 부족한 실력이라 상관은 없습니다. 질문도 서로 자유롭게 주고받아도 괜찮습니다.
						다만, 너무 기본적인 질문들은 자제해 주시고 구글링을 먼저 이용해 주세요 :)
						참여회비 : 참여회비는 없으나 잠수 or 불성실한 태도로 방 분위기를 헤치는 분은 내보내기 될 수 있습니다. (우리 짧고 굵게 하고 끝내요.ᐟ)",
                        "2024-04-15", 1, 0, "스프링스터디", "스터디", 5, "Spring,jsp,git,notion", "React, MySQL,node.js", 1,1);

insert into `recruit`(recu_go_num,recu_content,recu_due,recu_state,recu_type,recu_topic,recu_target,
					  recu_count,recu_required,recu_preferred,recu_online,recu_interview) 
			   values(3,
					"
					----
					스터디 소개
					하루 최소 30분에서 2시간 정도의
					그날 배운 내용을 공유하는 스터디
					매일 수업이 끝난 후 
					스터디 한 내용을 카톡으로 공유하기
					-> 자세한 운영방식은 스터디 시작 전에
					논의하며 구체적으로 정하면 좋을 것 같아요.
					->제가 챌린지 형식의 스터디 운영 경험이 많기 때문에
					이 부분은 크게 걱정 하지 않으셔도 됩니다.
					함께하고 싶은 분
					모든 스터디가 그렇듯 초기에만 열심히 하고
					그만두는 것이 아닌 꾸준히 할 수 있도록
					이 프로젝트를 해야만 하는 강한 동기부여가
					이미 되어 있으신 분과 함께하고싶습니다",
					  "2024-04-09",0,0,"학원 방과후 스터디하실분~","방과후 스터디","3","java, jsp, github, java script","",0,1);

insert into `group_apply`(goap_go_num,goap_recu_num,goap_content,goap_state,goap_me_id)
			values(1,1,"지원합니다. 저는 프로젝트에서 프론트엔드를 맡을 수 있습니다.",0,"qwert@final.com");
insert into `group_apply`(goap_go_num,goap_recu_num,goap_content,goap_state,goap_me_id)
			values(2,2,"스프링스터디에 지원합니다.",0,"asdfg@final.com");
insert into `group_apply`(goap_go_num,goap_recu_num,goap_content,goap_state,goap_me_id)
			values(3,3,"KH 방과후 스터디에 지원합니다.",1,"abcde@final.com");

insert into `group_member`(gome_me_id,gome_go_num,gome_type)
			values("qwert@final.com",1,0);
insert into `group_member`(gome_me_id,gome_go_num,gome_type)
			values("asdfg@final.com",2,0);
insert into `group_member`(gome_me_id,gome_go_num,gome_type)
			values("abcde@final.com",3,0);

insert into `group_post`(gopo_title,gopo_content,gopo_date,gopo_gome_me_id,gopo_gome_go_num)
			values("프로젝트 일정 확인부탁드립니다.","프로젝트 진행 일정을 게시하였으니 확인 부탁드립니다.",now(),"qwert@final.com",1);
insert into `group_post`(gopo_title,gopo_content,gopo_date,gopo_gome_me_id,gopo_gome_go_num)
			values("스터디 가입했습니다.","다들 잘 부탁드립니다.",now(),"asdfg@final.com",2);
insert into `group_post`(gopo_title,gopo_content,gopo_date,gopo_gome_me_id,gopo_gome_go_num)
			values("방과후 저녁 드시나요?","저메추",now(),"abcde@final.com",3);

insert into `group_calendar`(gocal_title,gocal_startdate,gocal_enddate,gocal_memo,gocal_me_id,gocal_go_num)
		    values("프로젝트 진행일정","2024-04-20","2024-05-22","확인 댓글 바람", "qwert@final.com",1);
insert into `group_calendar`(gocal_title,gocal_startdate,gocal_enddate,gocal_memo,gocal_me_id,gocal_go_num)
		    values("스프링스터디 정기회의","2024-04-30","2024-04-30","미참시 미참 댓글 바랍니다.", "asdfg@final.com",2);     
insert into `group_calendar`(gocal_title,gocal_startdate,gocal_enddate,gocal_memo,gocal_me_id,gocal_go_num)
		    values("방과후 스터디 첫 모임","2024-04-09","2024-04-09","", "abcde@final.com",3);        
            
