# 스프링 프레임워크 프로젝트를 docker 배포해보기
## 목차
1. [컨테이너 구성](https://github.com/HuiEun-Lim/Cogather/blob/master/docker/readme.md#1-%EC%BB%A8%ED%85%8C%EC%9D%B4%EB%84%88-%EA%B5%AC%EC%84%B1)
2. [docker-compose 파일 설명](https://github.com/HuiEun-Lim/Cogather/blob/master/docker/readme.md#2-docker-compose-%ED%8C%8C%EC%9D%BC-%EC%84%A4%EB%AA%85)
3. [배포 과정](https://github.com/HuiEun-Lim/Cogather/blob/master/docker/readme.md#3-%EB%B0%B0%ED%8F%AC-%EA%B3%BC%EC%A0%95)
4. [배포중 만난 문제들](https://github.com/HuiEun-Lim/Cogather/blob/master/docker/readme.md#4-%EB%B0%B0%ED%8F%AC%EC%A4%91-%EB%A7%8C%EB%82%9C-%EB%AC%B8%EC%A0%9C%EB%93%A4)
---
### 1. 컨테이너 구성
1. tomcat 웹애플리케이션 서버 컨테이너
2. oracle 11g database 서버 컨테이너
3. redis 서버 컨테이너

**컨테이너 구성**
![docker 구성 그림](https://user-images.githubusercontent.com/46335198/117306838-002d0580-aebb-11eb-90fa-40293aac7eea.png)

### 2. docker-compose 파일 설명

위의 컨테이너 구성을 만들기 위해 docker compose를 이용했고 아래는 docker-compose.yml 설정 파일에 대한 설명이다

*docker-compose.yml*
```yaml
version: '3'
services:
  web:
#    build:
#      context: ./tomcat
#      dockerfile: Dockerfile # Dockerfile로 image를 빌드하고 사용하는 것인데 느려서 컨테이너를 따로 빌드하고 사용
    image: qhxmaoflr/cogather-tomcat
    container_name: cogather # 컨테이너 별칭
    networks: # docker에서 만든 별도의 private network
      - cogather-network
    ports:
      - "80:8080" # web server port : 컨테이너 내부 포트
    environment:
      - TZ="Asia/Seoul" # 시간에 대한 환경변수
    volumes:
      - ./webapps:/usr/local/tomcat/webapps # 배포할 파일을 두는 곳 volumes로 매핑해두어 파일만 갈아 끼울 수 있게 함
    depends_on: # 아래의 종속된 컨테이너가 실행된뒤에 실행됨
      - oracle-db
      - redis-chat
    restart: always
  oracle-db: # oracle db container 별칭
    image: wnameless/oracle-xe-11g-r2
    container_name: oracle-db
    networks:
      - cogather-network
    ports:
      - "12345:1521"
    volumes:
      - ./db:/docker-entrypoint-initdb.d # oracle 컨테이너가 실행될시 처음 실행하게 되는 초기화 부분으로 초기 테이블 생성과 같은 쿼리문을 두면 됨
    environment:
      - TZ="Asia/Seoul"
      - ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe # 컨테이너 내부에서 해당 환경변수가 세팅이 안되어 있어서 리스터 확인하기가 안되서 세팅해줌
    restart: always
  redis-chat: # redis server container 별칭
    image: redis:latest
    container_name: redis-chat
    networks:
      - cogather-network
    ports: 
      - "6379:6379"
    restart: always
networks: # 네트워크 생성 -여러 가지 설정이 가능하지만 일단은 기본으로 둠
  cogather-network:

```

---
### 3. 배포 과정

eclipse IDE에서 로컬로 개발되었기 때문에 host 명이나 기타 포트에 대해 조금 수정이 필요했음

---
1. redis 서버에 대한 연결 정보를 변경

*SpringRedisConfig.java*
```java
...
...
@Bean // Redis server 연결을 위한 Redis Client Factory bean 생성
	public JedisConnectionFactory connectionFactory() {
		RedisStandaloneConfiguration connection = new RedisStandaloneConfiguration();
		connection.setHostName("redis-chat"); // - > 원래는 localhost 였지만 컨테이너로 바뀌면서 'redis-chat'으로 변경
		connection.setPort(6379); 
		return new JedisConnectionFactory(connection); 
	}
...
...

```
---
2. oracle db 서버에 대한 url 변경

*root-context.xml*

```xml
<beans:bean name="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
		<beans:property name="driverClassName" value="oracle.jdbc.driver.OracleDriver"/>
		<beans:property name="url" value="jdbc:oracle:thin:@oracle-db:1521:XE"/>
        <!-- jdbc:oracle:thin:@localhost:1521:XE -> jdbc:oracle:thin:@oracle-db:1521:XE --> 
		<beans:property name="username" value="cogather"/>
		<beans:property name="password" value="1234"/>
</beans:bean>
```
---
3. 테이블을 세팅할 sql문을 써놓음
 
*./docker/db/cogatherDB.sql* 

추후 컴포즈에서 volumes로 연결하여 읽어감

--- 
4. ./webapps 폴더에 배포 파일 넣기
*./webapps* 폴더에 프로젝트 배포파일인 war 파일 넣어주기

-> 도커 컨테이너 실행시 해당 war파일을 읽어서 tomcat에 올려줌

---
5. tomcat 컨테이너 만들기
*.docker/tomcat/Dockerfile*

qhxmaoflr/cogather-tomcat 이라는 별도의 톰캣 컨테이너를 만들기 위함인데, 사실 아무 tomcat 컨테이너를 사용했어도 무방했다.

---
6. compose up 
   
컨테이너들을 하나로 뭉쳐서 실행을 한다.

compose 파일이 위치한 곳에서 

```console
cogather\docker\tomcat> compose up -d
```

클라우드에 올리고 싶다면 클라우드 서버에 docker를 설치하고 
해당 프로젝트 폴더를 받아서 *compose up -d*를 하면 된다. (위에서 변경한 설정은 반영되어 있지 않으니 변경하고 배포파일로 만든 뒤에 진행하면 된다.)

### 4. 배포중 만난 문제들
1. 절대 경로 문제 
   - 프로젝트 내부 코드들 중에 절대 경로를 사용하는 부분이 있었고 심지어 'C:\\'로 시작하는 것이 있었음. tomcat 컨테이너는 ubuntu가 base 이미지인 컨테이너이므로 해당 코드들을 전부 상대 경로로 수정함
2. 컨테이너와 프로젝트 연결
   - db와 redis에 대한 컨테이너들을 연결할 때 url이나 기타 설정들을 어떻게 해야 연결이 되는지 감이 안잡혔었음 
   -> compose 설정시 컨테이너들의 별칭이 compose가 생성하는 네트워크 내에서 공유가 되고 해당 별칭들은 생성된 private network ip를 매핑하고 있으므로 host 부분을 컨테이너 별칭으로 수정하면 됨
3. db 연결 문제
   - 컨테이너들 끼리 연결은 되어 insert 하는 쿼리가 들어가는 것은 확인 되지만 로그인 시 유저 정보를 select 하는 부분에서 connection refused 에러가 뜸 
   -> db와 커넥션을 위한 설정인 dataSource에 대한 bean이 servlet-context.xml, root-context.xml에 들어있었고 docker 용으로 수정했던 servlet-context.xml과 기존의 root-context.xml이 충돌이 났던 것이었고 servlet-context.xml의 bean을 삭제했음
