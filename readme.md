## 과제 관리 시스템(Project Management System)
본 샘플은  Spring 4 + MyBatis 3 + MariaDB (Maven) 기반으로  제작한 과제 관리 시스템이다.

Project9을 기반으로 Project9을 응용하는 방법을 표현하기 위해 제작하였다. 

데모는 [여기](http://52.78.20.235/pms9/)에서 확인할 수 있다.

데모는 AWS 무료를 사용하는 관계로  2017-09-17 이후에는 접속이 안될 수 있다.

### 주요 구현 기능 ###
- 과제 생성 및 개인별 할당
- 과제 상제 정보 보기(과제, 일정, 사용자 중심)
- 개인별 과제 진행 사항 입력

### 주요 LIB  ###
- jQuery EasyUI 1.4.3
- FullCalendar v3.0.1 


### 개발 환경 ###
    Programming Language - Java 1.7
    IDE - Eclipse
    DB - MariaDB 
    Framework - MyBatis, Spring 4
    Build Tool - Maven

### 설치 ###
- MariaDB에 데이터 베이스(pms9)를 생성하고 tables.sql, tableData.sql를 실행하여 테이블과 데이터를 생성한다.
- applicationContext.xml에 적절한 접속 정보를 입력한다.
- 톰캣이나 이클립스에서 pms9를 실행
- http://localhost:8080/pms9/로 접속
- ID/PW: admin/admin, user1/user1, user2/user2 ...

### License ###
GPL v3
  
  