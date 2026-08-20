# 🎓 LearnMate

> **배움을 연결하고, 함께 성장하는 교육·커뮤니티 플랫폼**

**LearnMate**는 학습을 원하는 사용자가 강의를 탐색하고,
스터디 그룹을 구성하거나 참여하며, 멘토와 연결되고
커뮤니티를 통해 다양한 정보를 공유할 수 있도록 제작한 **통합 교육 플랫폼**입니다.

단순한 강의 제공 서비스를 넘어

**강의 → 학습 → 스터디 → 멘토링 → 커뮤니티 → 성장**

으로 이어지는 학습 경험을 하나의 서비스 안에서 제공하는 것을 목표로 개발했습니다.

Spring MVC 기반의 계층형 아키텍처를 적용하고
회원, 강의, 스터디, 멘토링, 모집, 추천, 커뮤니티 등
각 기능을 독립적인 도메인으로 분리하여 개발한 팀 프로젝트입니다.

<br>

---

## 📌 Project Overview

| 구분              | 내용                              |
| :-------------- | :------------------------------ |
| **프로젝트명**       | LearnMate                       |
| **프로젝트 유형**     | 팀 프로젝트                          |
| **목적**          | 교육·학습·커뮤니티를 결합한 통합 플랫폼 개발       |
| **Backend**     | Java / Spring MVC               |
| **Frontend**    | JSP / HTML5 / CSS3 / JavaScript |
| **Database**    | MySQL                           |
| **Persistence** | MyBatis                         |
| **Security**    | Spring Security                 |
| **View**        | JSP / Apache Tiles              |
| **Build**       | Maven                           |
| **협업**          | Git / GitHub                    |

프로젝트는 Maven 기반의 WAR 애플리케이션으로 구성되어 있으며,
Spring MVC와 MyBatis를 중심으로 Controller → Service → DAO 계층을 분리했습니다.

---

## 🎯 Project Goal

### "혼자 배우는 것에서 함께 성장하는 학습으로"

온라인 강의만 제공하는 기존 학습 서비스와 달리
사용자가 **학습 과정에서 필요한 사람과 정보까지 연결될 수 있는 서비스**를 만드는 것을 목표로 했습니다.

### 핵심 목표

* 📚 다양한 강의를 탐색하고 관리할 수 있는 환경 제공
* 👥 관심사가 비슷한 사용자와 스터디 구성
* 🧑‍🏫 멘토와 학습자를 연결
* 📢 스터디 및 인원 모집 기능 제공
* 💡 사용자의 학습 관심사를 기반으로 콘텐츠 추천
* 💬 사용자 간 커뮤니티 및 SNS 기능 제공
* 🛡️ 신고 및 관리자 기능을 통한 안정적인 서비스 운영

---

# ✨ 주요 기능

## 👤 회원 관리

회원의 서비스 이용을 위한 기본적인 인증 및 사용자 관리 기능을 제공합니다.

* 회원가입
* 로그인 / 로그아웃
* 회원정보 관리
* 마이페이지
* 사용자 활동 정보 조회
* 권한에 따른 서비스 접근 제어

Spring Security를 적용하여 인증 및 접근 권한을 관리할 수 있도록 구성했습니다.

---

## 📚 강의

사용자가 원하는 강의를 탐색하고 학습할 수 있도록 강의 관리 기능을 구현했습니다.

* 강의 목록 조회
* 강의 상세 조회
* 강의 등록
* 강의 수정
* 나의 강의 목록
* 강의 정보 관리

View 역시 `list`, `detail`, `insert`, `update`, `myList` 등 기능별 화면으로 분리되어 있습니다.

```text
강의 목록
    ↓
강의 상세
    ↓
수강 / 학습
    ↓
나의 강의
```

---

## 👥 스터디 그룹

혼자 공부하는 것에서 벗어나
관심 분야가 비슷한 사용자들이 함께 학습할 수 있도록 스터디 기능을 제공합니다.

* 스터디 목록 조회
* 스터디 상세 조회
* 스터디 생성
* 스터디 모집
* 스터디 신청
* 신청 내역 관리
* 나의 스터디 관리

스터디 모집과 신청을 별도의 흐름으로 구성하여
스터디 생성자와 참여자의 역할을 구분했습니다.

```text
스터디 탐색
     ↓
스터디 상세 확인
     ↓
참여 신청
     ↓
신청 승인
     ↓
스터디 참여
```

---

## 🧑‍🏫 멘토링

학습자가 자신의 부족한 부분을 보완할 수 있도록
멘토와 학습자를 연결하는 멘토링 기능을 제공합니다.

* 멘토 등록
* 멘토 목록 조회
* 멘토 상세 조회
* 멘토 검색
* 멘토링 신청
* 멘토 정보 관리

Controller와 Service 계층에서도 멘토링 기능을 독립적인 도메인으로 분리하여 관리하고 있습니다.

---

## 📢 모집

스터디 및 다양한 활동에 필요한 인원을 모집할 수 있도록
모집 게시글 기반의 기능을 제공합니다.

* 모집글 작성
* 모집글 조회
* 모집글 상세 조회
* 모집 신청
* 신청 정보 관리

---

## 💡 추천

사용자의 학습 활동과 관심 분야를 고려하여
관심을 가질 만한 콘텐츠를 제공할 수 있도록 추천 기능을 구성했습니다.

* 콘텐츠 추천
* 추천 목록 조회
* 사용자 맞춤형 콘텐츠 탐색

추천 기능은 별도의 `RecommendController`와 `RecommendService`로 분리하여 관리하고 있습니다.

---

## 💬 커뮤니티 / SNS

학습 과정에서 발생하는 정보와 경험을 공유할 수 있도록
사용자 간 커뮤니케이션 기능을 제공합니다.

* 게시글 작성
* 게시글 조회
* 게시글 수정 / 삭제
* 댓글 및 사용자 간 소통
* 커뮤니티 콘텐츠 관리
* SNS 형태의 콘텐츠 공유

커뮤니티 기능은 별도의 `SnsController`와 서비스 계층으로 분리하여 구현했습니다.

---

## 🚨 신고 / 관리자

서비스 내에서 발생할 수 있는 부적절한 콘텐츠나 사용자를 관리하기 위한
신고 및 관리자 기능을 제공합니다.

### 사용자

* 콘텐츠 신고
* 사용자 신고
* 신고 내역 관리

### 관리자

* 회원 관리
* 서비스 콘텐츠 관리
* 신고 내역 관리
* 관리자 기능 제공

관리자 기능은 별도의 `AdminController`를 통해 분리했으며,
신고 기능 역시 `ReportController`와 `ReportService`를 통해 독립적으로 구성했습니다.

---

# 🏗️ System Architecture

```text
                         ┌───────────────────┐
                         │      Browser      │
                         │   JSP / JS / CSS  │
                         └─────────┬─────────┘
                                   │
                                   │ HTTP Request
                                   ▼
                    ┌──────────────────────────┐
                    │       Spring MVC         │
                    │       Controller         │
                    └────────────┬─────────────┘
                                 │
                                 ▼
                    ┌──────────────────────────┐
                    │         Service          │
                    │      Business Logic      │
                    └────────────┬─────────────┘
                                 │
                                 ▼
                    ┌──────────────────────────┐
                    │           DAO            │
                    │     Data Access Layer    │
                    └────────────┬─────────────┘
                                 │
                                 ▼
                    ┌──────────────────────────┐
                    │         MyBatis           │
                    │       Mapper / SQL        │
                    └────────────┬─────────────┘
                                 │
                                 ▼
                    ┌──────────────────────────┐
                    │          MySQL            │
                    │        Database           │
                    └──────────────────────────┘
```

프로젝트의 Java 패키지는 `controller`, `service`, `dao`, `model`, `pagination`, `interceptor`, `utils` 등으로 분리되어 있으며, 도메인별 책임을 나누는 구조로 구성되어 있습니다.

---

# 🛠️ Tech Stack

### Backend

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge\&logo=openjdk\&logoColor=white)
![Spring](https://img.shields.io/badge/Spring%20MVC-6DB33F?style=for-the-badge\&logo=spring\&logoColor=white)
![Spring Security](https://img.shields.io/badge/Spring%20Security-6DB33F?style=for-the-badge\&logo=springsecurity\&logoColor=white)
![MyBatis](https://img.shields.io/badge/MyBatis-000000?style=for-the-badge)

### Frontend

![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge\&logo=html5\&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge\&logo=css3\&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge\&logo=javascript\&logoColor=black)
![JSP](https://img.shields.io/badge/JSP-323330?style=for-the-badge)

### Database

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge\&logo=mysql\&logoColor=white)

### View / Build

![Apache Tiles](https://img.shields.io/badge/Apache%20Tiles-D22128?style=for-the-badge)
![Maven](https://img.shields.io/badge/Maven-C71A36?style=for-the-badge\&logo=apachemaven\&logoColor=white)

프로젝트의 `pom.xml`에는 Spring MVC, MyBatis, MySQL Connector, Spring Security, Apache Tiles, Lombok, log4jdbc 등이 실제 의존성으로 구성되어 있습니다.

---

# 📂 Project Structure

```text
final_project
│
├── src
│   └── main
│       │
│       ├── java
│       │   └── kr.kh.team2
│       │       │
│       │       ├── advise
│       │       │
│       │       ├── controller
│       │       │   ├── AdminController
│       │       │   ├── GroupController
│       │       │   ├── HomeController
│       │       │   ├── LectureController
│       │       │   ├── LoginController
│       │       │   ├── MentorController
│       │       │   ├── MypageController
│       │       │   ├── RecommendController
│       │       │   ├── RecruitController
│       │       │   ├── ReportController
│       │       │   ├── SignupController
│       │       │   └── SnsController
│       │       │
│       │       ├── dao
│       │       ├── interceptor
│       │       ├── model
│       │       │   ├── dto
│       │       │   └── vo
│       │       ├── pagination
│       │       ├── service
│       │       └── utils
│       │
│       ├── resources
│       │   └── mapper
│       │
│       └── webapp
│           │
│           ├── WEB-INF
│           │   ├── views
│           │   │   ├── admin
│           │   │   ├── common
│           │   │   ├── group
│           │   │   ├── lecture
│           │   │   ├── layout
│           │   │   ├── login
│           │   │   ├── main
│           │   │   ├── mentor
│           │   │   ├── mypage
│           │   │   └── signup
│           │   └── web.xml
│           │
│           └── resources
│               ├── bs
│               ├── css
│               ├── img
│               └── js
│
└── pom.xml
```

실제 프로젝트 역시 Controller / Service / DAO / Model을 분리하고 JSP View를 `admin`, `group`, `lecture`, `mentor`, `mypage` 등의 기능별 디렉터리로 구성하고 있습니다.

---

# 🔄 주요 서비스 Flow

### 📚 학습 Flow

```text
회원가입
   ↓
로그인
   ↓
강의 탐색
   ↓
강의 상세
   ↓
학습
   ↓
나의 강의 관리
```

### 👥 스터디 Flow

```text
스터디 탐색
     ↓
스터디 상세
     ↓
참여 신청
     ↓
신청 승인
     ↓
스터디 참여
```

### 🧑‍🏫 멘토링 Flow

```text
멘토 탐색
   ↓
멘토 상세
   ↓
멘토링 신청
   ↓
멘토 ↔ 학습자 연결
```

### 💬 커뮤니티 Flow

```text
콘텐츠 탐색
    ↓
게시글 작성 / 조회
    ↓
댓글 / 소통
    ↓
정보 공유
    ↓
신고 / 관리
```

---

# 🔐 Security

Spring Security를 활용하여 사용자의 인증과 권한에 따른 접근 제어를 구성했습니다.

```text
Request
   ↓
Spring Security
   ↓
Authentication
   ↓
Authorization
   ↓
Controller
```

관리자와 일반 사용자의 접근 영역을 구분하여
서비스의 주요 기능에 대한 권한을 관리할 수 있도록 구성했습니다.

---

# 🧩 Layered Architecture

각 계층의 역할을 분리하여 유지보수성과 확장성을 고려했습니다.

| Layer          | 역할                 |
| :------------- | :----------------- |
| **Controller** | HTTP 요청 및 응답 처리    |
| **Service**    | 비즈니스 로직 처리         |
| **DAO**        | 데이터 접근             |
| **Mapper**     | SQL 및 DB 처리        |
| **Model**      | DTO / VO 기반 데이터 전달 |
| **View**       | JSP 기반 사용자 화면      |

특히 `Lecture`, `Group`, `Mentor`, `Recommend`, `Recruit`, `Report`, `Review` 등 기능별 Service와 구현체를 분리하여 도메인별 책임을 명확하게 구성했습니다.

---

# 💡 프로젝트에서 얻은 경험

이번 프로젝트에서는 단순 CRUD 구현을 넘어
**하나의 서비스가 여러 도메인으로 구성될 때 이를 어떻게 분리하고 연결할 것인지**를 경험하는 데 집중했습니다.

### 🏗️ Spring MVC

* MVC 디자인 패턴 이해
* Controller / Service / DAO 계층 분리
* 의존성 주입을 통한 객체 간 결합도 관리
* 도메인별 기능 분리

### 🗄️ Database

* MyBatis 기반 SQL 관리
* Mapper를 활용한 데이터 접근
* 여러 도메인 간 데이터 관계 설계
* 페이징 및 검색 처리

### 🔐 Security

* Spring Security 기반 인증
* 사용자 권한에 따른 접근 제어
* 로그인 사용자와 비로그인 사용자의 접근 영역 분리

### 🖥️ Web

* JSP 기반 View 구성
* Apache Tiles를 활용한 공통 Layout 관리
* JavaScript를 활용한 동적 UI 구현
* CSS를 활용한 사용자 화면 구성

### 👥 Team Collaboration

* Git / GitHub 기반 소스 관리
* 기능별 브랜치 개발
* 팀원 간 코드 공유
* 기능 간 의존성을 고려한 협업
* 충돌 및 코드 통합 경험

---

# 🚧 Challenges & Improvements

### 1. 기능 증가에 따른 코드 복잡도 관리

프로젝트가 커지면서 Controller와 Service에 많은 기능이 추가될 수 있었습니다.

이를 해결하기 위해 기능별로 Controller / Service / DAO를 분리하고
각 도메인의 책임을 명확하게 구분했습니다.

```text
Lecture
 ├── LectureController
 ├── LectureService
 └── LectureDAO

Group
 ├── GroupController
 ├── GroupService
 └── GroupDAO

Mentor
 ├── MentorController
 ├── MentorService
 └── MentorDAO
```

이러한 구조를 통해 특정 기능을 수정할 때 다른 기능에 미치는 영향을 줄이고
향후 기능 확장이 가능하도록 구성했습니다.

---

### 2. 공통 UI 관리

페이지가 증가하면서 동일한 Layout을 여러 JSP에서 반복해서 관리하는 문제를 줄이기 위해
**Apache Tiles 기반 Layout 구조**를 활용했습니다.

```text
┌──────────────────────────────┐
│            Header            │
├──────────────┬───────────────┤
│              │               │
│   Sidebar    │     Content   │
│              │               │
├──────────────┴───────────────┤
│            Footer            │
└──────────────────────────────┘
```

이를 통해 공통 영역과 개별 페이지 영역을 분리하여
View 코드의 중복을 줄일 수 있도록 구성했습니다.

---

# 📈 프로젝트를 통해

이번 프로젝트를 통해 단순히 Java 문법이나 Spring Framework를 사용하는 것에서 나아가,

> **"여러 기능이 연결된 하나의 웹 서비스를 어떻게 설계하고 개발할 것인가?"**

를 경험할 수 있었습니다.

특히

**Spring MVC + MyBatis + MySQL + Spring Security**

를 기반으로 실제 서비스 형태의 프로젝트를 구현하면서
웹 애플리케이션의 전체적인 데이터 흐름과 계층 구조를 이해할 수 있었습니다.

또한 강의, 스터디, 멘토링, 추천, 커뮤니티 등 서로 다른 도메인이 하나의 서비스 안에서 연결되는 구조를 구현하면서
**기능 단위 개발뿐만 아니라 서비스 전체의 흐름을 고려하는 개발 경험**을 쌓았습니다.

---

# 🚀 Getting Started

### 1. Clone

```bash
git clone https://github.com/seungjoo555/final_team2.git
```

### 2. Project Import

Maven 프로젝트를 Eclipse 또는 IntelliJ IDEA에서 Import합니다.

```text
spring/
└── final_project/
    ├── pom.xml
    └── src/
```

### 3. Database

MySQL 데이터베이스를 구성한 후
프로젝트의 DB 연결 설정을 환경에 맞게 수정합니다.

### 4. Run

Tomcat을 연결한 후 Maven 기반 Spring Web Application을 실행합니다.

---

# 🔗 Repository

[![GitHub](https://img.shields.io/badge/GitHub-final__team2-181717?style=for-the-badge\&logo=github)](https://github.com/seungjoo555/final_team2)

---

<p align="center">

### 🎓 LearnMate

**Learn · Connect · Grow**

학습을 연결하고, 사람을 연결하고, 성장을 연결합니다.

</p>
