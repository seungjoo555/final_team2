  
        
/*
========================================================================================================
샘플 데이터
========================================================================================================
*/

-- ==========report=========
/* 
member, post, comment, recruit 신고 가능
	신고 내역1 : asdfg@final.com 유저 신고
	신고 내역2 : 1번 그룹 신고
    신고 내역3 : 1번 강의 신고
*/
insert into report(repo_repo_content,repo_repo_state, repo_me_id, repo_detail, 
			repo_date, repo_table, repo_target) 
		values("욕설 및 혐오 발언", "대기중", "qwert@final.com", "험한 말을 했습니다.",
				now(), "member", "asdfg@final.com"),
               ("스팸 또는 광고", "대기중", "qwert@final.com", "스팸글입니다.",
				now(), "recruit", "1"),
                ("부정확한 정보", "대기중", "qwert@final.com", "부적절한 정보를 담은 글입니다.",
				now(), "post", "1");

-- ==========file=========
/* 
	파일1 : 1번 게시글 파일 
	파일2 : 1번 그룹 공고 파일
    파일3 : 1번 멘토링 게시글 파일
*/
insert into file(file_name, file_ori_name, file_table, file_target) 
			values("/2024/04/09/첨부파일1.JPG","첨부파일1.JPG","post",1),
				  ("/2024/04/10/그룹소개.JPG","그룹소개.JPG","recruit",1),
                  ("/2024/04/11/멘토소개.JPG","멘토소개.JPG","mentoring",1);

-- ==========community=========
/* board */
insert into board(board_name) values("자유게시판"), ("질문게시판"), ("신고게시판");
/* post */
insert into post(post_name, post_content, post_date, post_board_num, post_me_id) 
		values("공지사항", "공지사항입니다.", now(), 1, "admin"),
			  ("질문이 있어요~", "질문질문", now(), 2, "qwert@final.com"),
              ("안녕하세요!", "안녕안녕", now(), 1, "asdfg@final.com");
/* comment */
insert into comment(cmmt_content, cmmt_post_num, cmmt_me_id) 
		values("네! 확인했습니다. 이곳에서 많이 배우고 가겠습니다~", 1, "qwert@final.com"), 
        ("좋은 질문입니다~", 2, "asdfg@final.com"), 
        ("안녕하세요!", 3, "qwert@final.com");
