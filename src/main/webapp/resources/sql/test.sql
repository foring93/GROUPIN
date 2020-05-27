
DROP TABLE requestCategory;

-- glocation Table Create SQL
DROP TABLE userlikegroup;
DROP SEQUENCE userlikegroupSEQ;

DROP TABLE userpolice;
DROP SEQUENCE userpoliceSEQ;

DROP TABLE bfile;
DROP SEQUENCE bfileSEQ;
        
DROP TABLE votemembber;
DROP SEQUENCE votemembberSEQ;
 
 DROP TABLE gcomment;
DROP SEQUENCE gcommentSEQ;

 DROP TABLE ladder;
DROP SEQUENCE ladderSEQ;      
        
 
 DROP TABLE maps;
 DROP TABLE postlike;

 DROP TABLE calendarmember;

 DROP TABLE prboard;
DROP SEQUENCE prboardSEQ;

 DROP TABLE usermessage;
DROP SEQUENCE usermessageSEQ;


    DROP TABLE gusercategory;     

DROP TABLE vote;
DROP SEQUENCE voteSEQ;


 DROP TABLE calendar;

DROP TABLE POST;
DROP  SEQUENCE postSEQ;

DROP TABLE ggroupboard;
DROP  SEQUENCE ggroupboardSEQ;

DROP TABLE ggroupmember;

DROP TABLE ggroup;
DROP SEQUENCE ggroupSEQ;

DROP TABLE gusers;
DROP SEQUENCE gusersSEQ;

DROP TABLE gcategory2;
DROP SEQUENCE gcategory2SEQ;

DROP TABLE gcategory;
DROP SEQUENCE gcategorySEQ;

DROP TABLE gage;
DROP SEQUENCE glocationSEQ;
DROP TABLE glocation;



CREATE TABLE glocation
(
    locationkey    NUMBER          NOT NULL, 
    swhere    VARCHAR2(40)    NOT NULL, 
    dwhere     VARCHAR2(40)    NOT NULL, 
    CONSTRAINT GLOCATIONPK PRIMARY KEY (locationkey)
);





CREATE SEQUENCE glocationSEQ
START WITH 1
INCREMENT BY 1;
CREATE TABLE gage
(
    agekey      NUMBER    NOT NULL, 
    agevalue    NUMBER    NOT NULL, 
    CONSTRAINT GAGEPK PRIMARY KEY (agekey)
);




CREATE TABLE gcategory
(
    dcategorykey     NUMBER          NOT NULL, 
    dcategoryname    VARCHAR2(50)    NOT NULL, 
    CONSTRAINT GCATEGORYPK PRIMARY KEY (dcategorykey)
);


CREATE SEQUENCE gcategorySEQ
START WITH 1
INCREMENT BY 1;





CREATE TABLE gcategory2
(
    scategorykey     NUMBER          NOT NULL, 
    dcategorykey     NUMBER          NOT NULL, 
    scategoryname    VARCHAR2(50)    NOT NULL, 
    CONSTRAINT GCATEGORY2PK PRIMARY KEY (scategorykey)
);


CREATE SEQUENCE gcategory2SEQ
START WITH 1
INCREMENT BY 1;



ALTER TABLE gcategory2
    ADD CONSTRAINT FKgcategory2dcategorykey FOREIGN KEY (dcategorykey)
        REFERENCES gcategory (dcategorykey) on delete cascade;












-- glocation Table Create SQL
CREATE TABLE gusers
(
    userkey             NUMBER            NOT NULL, 
    userid              VARCHAR2(20)      NOT NULL, 
    userpassword        VARCHAR2(30)      NOT NULL, 
    userimagefile      VARCHAR2(100)     , 
    userimageorigin    VARCHAR2(100)     , 
    userage             NUMBER            NOT NULL, 
    userlocation        NUMBER            NOT NULL, 
    gender               CHAR(1)           NOT NULL, 
    useremail           VARCHAR2(50)      NOT NULL, 
  
    userjoindate       DATE              NOT NULL, 
    useroptionadmin    CHAR(1)           NOT NULL, 
    useroptiongroup    CHAR(1)           NOT NULL, 
    userstatus          NUMBER           NOT NULL, 
    userstatuscode     DATE, 
    logintype 			number 			 NOT NULL,
    CONSTRAINT GUSERSPK PRIMARY KEY (userkey)
);



ALTER TABLE gusers
    ADD CONSTRAINT FKgusersuseragegageage FOREIGN KEY (userage)
        REFERENCES gage (agekey);
        
        
        
ALTER TABLE gusers
    ADD CONSTRAINT FKgusersuserlocationgloc FOREIGN KEY (userlocation)
        REFERENCES glocation (locationkey) on delete cascade;
        

ALTER TABLE GUSERS MODIFY (USERPASSWORD VARCHAR2(300));
                                                 
CREATE SEQUENCE gusersSEQ
START WITH 1
INCREMENT BY 1;

                               

CREATE TABLE requestCategory
(
    requestKey    NUMBER          NOT NULL, 
    dname         VARCHAR2(50)    NOT NULL, 
    sname         VARCHAR2(50)    NULL, 
    userkey       NUMBER          NOT NULL, 
    CONSTRAINT REQUESTCATEGORY_PK PRIMARY KEY (requestKey)
);



ALTER TABLE requestCategory
    ADD CONSTRAINT FK_requestCategory_userkey_g_u FOREIGN KEY (userkey)
        REFERENCES gusers (userkey) on delete cascade;
                                                 
                                                           

CREATE TABLE ggroup
(
    groupkey          NUMBER           NOT NULL, 
    groupname         VARCHAR2(60)     NOT NULL, 
    userkey           NUMBER           NOT NULL, 
    agekey            NUMBER           NOT NULL, 
    wherekey          NUMBER           NOT NULL, 
    categorykey       NUMBER           NOT NULL, 
    groupinfo         VARCHAR2(300)    NOT NULL, 
    groupdfile       VARCHAR2(100)    , 
    groupidorigin    VARCHAR2(100)    , 
    groupcfile       VARCHAR2(100)    , 
    groupcorigin     VARCHAR2(100)    , 
    groupprivate      CHAR(1)          NOT NULL, 
    grouptype         CHAR(1)          NOT NULL, 
    groupdate		  DATE			   NOT NULL,
    groupstatus        NUMBER           NOT NULL,
    CONSTRAINT GGROUPPK PRIMARY KEY (groupkey)
);



-- 이미 ggroup 테이블 생성했다면 아래의 쿼리문 추가 실행,,
-- ALTER TABLE ggroup ADD (groupddate DATE NOT NULL);
-- ALTER TABLE ggroup ADD (groupstatus NUMBER NOT NULL);
--ALTER TABLE ggroup MODIFY(groupdfile VARCHAR2(100) null);
--ALTER TABLE ggroup MODIFY(groupidorigin VARCHAR2(100) null);
--ALTER TABLE ggroup MODIFY(groupcfile VARCHAR2(100) null);
--ALTER TABLE ggroup MODIFY(groupcorigin VARCHAR2(100) null);
                                            
CREATE SEQUENCE ggroupSEQ
START WITH 1
INCREMENT BY 1;



ALTER TABLE ggroup
    ADD CONSTRAINT FKggroupuserkeygusersus FOREIGN KEY (userkey)
        REFERENCES gusers (userkey) on delete cascade;


ALTER TABLE ggroup
    ADD CONSTRAINT FKggroupagekeygageagek FOREIGN KEY (agekey)
        REFERENCES gage (agekey);


ALTER TABLE ggroup
    ADD CONSTRAINT FKggroupcategorykeygcate FOREIGN KEY (categorykey)
        REFERENCES gcategory2 (scategorykey) on delete cascade;

ALTER TABLE ggroup
    ADD CONSTRAINT FKggroupwherekeyglocatio FOREIGN KEY (wherekey)
        REFERENCES glocation (locationkey);
        
        
        
        
        

    


CREATE TABLE ggroupmember
(

    groupkey         NUMBER          NOT NULL, 
    userkey          NUMBER          NOT NULL, 
    groupnickname    VARCHAR2(30)    NOT NULL, 
    usergrade        NUMBER          NOT NULL, 
    CONSTRAINT GGROUPMEMBERPK PRIMARY KEY (groupkey,userkey)
);

/*
    유저 등급 :
                -1: 가입승인전
                0:  회원
                1:  관리자
                
*/


ALTER TABLE ggroupmember
    ADD CONSTRAINT FKggroupmembergroupkeyg FOREIGN KEY (groupkey)
        REFERENCES ggroup (groupkey) on delete cascade;


ALTER TABLE ggroupmember
    ADD CONSTRAINT FKggroupmemberuserkeygu FOREIGN KEY (userkey)
        REFERENCES gusers (userkey) on delete cascade;









-- glocation Table Create SQL
CREATE TABLE ggroupboard
(
    boardkey         NUMBER          NOT NULL, 
    groupkey         NUMBER          NOT NULL, 
    boardname        VARCHAR2(50)    NOT NULL, 
    boardtype       CHAR(1),
    boardseq           NUMBER,
    CONSTRAINT GGROUPBOARDPK PRIMARY KEY (boardkey)
);




CREATE SEQUENCE ggroupboardSEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE ggroupboard
    ADD CONSTRAINT FKggroupboardgroupkeygg FOREIGN KEY (groupkey)
        REFERENCES ggroup (groupkey) on delete cascade;







CREATE TABLE post
(
    postkey              NUMBER            NOT NULL, 
    posttitle            VARCHAR2(100)     NULL, 
    postcontent          VARCHAR2(2000)    NULL, 
    postdate             DATE              NOT NULL, 
    userkey              NUMBER            NOT NULL,
    groupkey             NUMBER            NOT NULL, 
    postoptionreply     CHAR(1)           NOT NULL, 
    postoptionsearch    CHAR(1)           NOT NULL, 
    boardkey             NUMBER            NOT NULL, 
    postreadcount        NUMBER            NOT NULL, 
    PRIMARY KEY(postkey),
   FOREIGN KEY(userkey,groupkey) REFERENCES ggroupmember(userkey,groupkey) on delete cascade, /*아 이걸 이렇게 하면 되는구나...*/
  FOREIGN KEY(boardkey) REFERENCES ggroupboard(boardkey) on delete cascade
);



						 
ALTER TABLE post ADD(boardvote char(1));
ALTER TABLE post ADD(boardcalendar char(1));
ALTER TABLE post ADD(boardladder char(1));
ALTER TABLE post ADD(boardmap char(1));
				   

CREATE SEQUENCE postSEQ
START WITH 1
INCREMENT BY 1;






CREATE TABLE calendar
(
    cstartdate             DATE      NOT NULL, 
    cenddate               DATE      NOT NULL, 
    cmoney                  NUMBER    NOT NULL, 
    postkey                 NUMBER    NOT NULL, 
    grouplocation           NUMBER    NOT NULL, 
    grouplocationdetail    NUMBER    NULL, 
    CONSTRAINT CALENDARPK PRIMARY KEY (postkey)
);




ALTER TABLE calendar
    ADD CONSTRAINT FKcalendarpostkeypostpost FOREIGN KEY (postkey)
        REFERENCES post (postkey) on delete cascade;

ALTER TABLE calendar
    ADD CONSTRAINT FKcalendargrouplocationgl FOREIGN KEY (grouplocation)
        REFERENCES glocation (locationkey);
        






-- glocation Table Create SQL
CREATE TABLE vote
(
    votekey         NUMBER           NOT NULL, 
    postkey         NUMBER           NOT NULL, 
    votecontent1    VARCHAR2(200)    NOT NULL, 
    votecontent2    VARCHAR2(200)    NOT NULL, 
    votecontent3    VARCHAR2(200)    NOT NULL, 
    votecontent4    VARCHAR2(200)    NOT NULL, 
    votecontent5    VARCHAR2(200)    NOT NULL, 
    CONSTRAINT VOTEPK PRIMARY KEY (votekey)
);


CREATE SEQUENCE voteSEQ
START WITH 1
INCREMENT BY 1;



ALTER TABLE vote
    ADD CONSTRAINT FKvotepostkeypostpostkey FOREIGN KEY (postkey)
        REFERENCES post (postkey) on delete cascade;
        
        
    
-- glocation Table Create SQL
CREATE TABLE gusercategory
(
    userkey        NUMBER    NOT NULL, 
    categorykey    NUMBER    NOT NULL
);



ALTER TABLE gusercategory
    ADD CONSTRAINT FKgusercategoryuserkeyg FOREIGN KEY (userkey)
        REFERENCES gusers (userkey) on delete cascade;

ALTER TABLE gusercategory
    ADD CONSTRAINT FKgusercategorycategoryke FOREIGN KEY (categorykey)
        REFERENCES gcategory2 (scategorykey) on delete cascade;





-- glocation Table Create SQL
CREATE TABLE usermessage
(
    mgkey        NUMBER           NOT NULL, 
    mgsort       CHAR(1)          NOT NULL, 
    mgcontent    VARCHAR2(200)    NOT NULL, 
    mgdate       DATE             NOT NULL, 
    mgreceive    NUMBER           NOT NULL, 
    mgsend       NUMBER           NOT NULL, 
    CONSTRAINT USERMESSAGEPK PRIMARY KEY (mgkey)
);


        
CREATE SEQUENCE usermessageSEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE usermessage
    ADD CONSTRAINT FKusermessagemgsendguser FOREIGN KEY (mgsend)
        REFERENCES gusers (userkey) on delete cascade;

ALTER TABLE usermessage
    ADD CONSTRAINT FKusermessagemgreceivegu FOREIGN KEY (mgreceive)
        REFERENCES gusers (userkey) on delete cascade;
        



-- glocation Table Create SQL
CREATE TABLE prboard
(
    prkey        NUMBER           NOT NULL, 
    userkey      NUMBER           NOT NULL, 
    groupkey     NUMBER           NOT NULL, 
    content       VARCHAR2(200)    NOT NULL, 
    datewrite    DATE             NOT NULL, 
    CONSTRAINT PRBOARDPK PRIMARY KEY (prkey)
);



CREATE SEQUENCE prboardSEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE prboard
    ADD CONSTRAINT FKprboarduserkeyggroupm FOREIGN KEY (userkey, groupkey)
        REFERENCES ggroupmember (userkey, groupkey) on delete cascade;
        




-- glocation Table Create SQL
CREATE TABLE calendarmember
(
    userkey     NUMBER    NOT NULL, 
    postkey     NUMBER    NOT NULL, 
    groupkey    NUMBER    NOT NULL, 
    CONSTRAINT CALENDARMEMBERPK PRIMARY KEY (userkey, postkey, groupkey)
);



ALTER TABLE calendarmember
    ADD CONSTRAINT FKcalendarmemberpostkeyca FOREIGN KEY (postkey)
        REFERENCES calendar (postkey) on delete cascade;

ALTER TABLE calendarmember
    ADD CONSTRAINT FKcalendarmemberuserkeyg FOREIGN KEY (userkey, groupkey)
        REFERENCES ggroupmember (userkey, groupkey) on delete cascade;



-- glocation Table Create SQL
CREATE TABLE postlike
(
    postkey     NUMBER    NOT NULL, 
    userkey     NUMBER    NOT NULL, 
    groupkey    NUMBER    NOT NULL, 
    CONSTRAINT POSTLIKEPK PRIMARY KEY (postkey, userkey, groupkey)
);



ALTER TABLE postlike
    ADD CONSTRAINT FKpostlikepostkeypostpos FOREIGN KEY (postkey)
        REFERENCES post (postkey) on delete cascade;

ALTER TABLE postlike
    ADD CONSTRAINT FKpostlikeuserkeyggroup FOREIGN KEY (userkey, groupkey)
        REFERENCES ggroupmember (userkey, groupkey) on delete cascade;






     
-- glocation Table Create SQL
CREATE TABLE maps
(
    mapskey          NUMBER           NOT NULL, 
    postkey          NUMBER           NOT NULL, 
    lat               NUMBER(5,8)      NOT NULL, 
    lng               NUMBER(5,8)      NOT NULL, 
    markername       VARCHAR2(100)    NULL, 
    markercontent    VARCHAR2(100)    NULL, 
    mapsseq          NUMBER           NOT NULL, 
    CONSTRAINT MAPSPK PRIMARY KEY (mapskey)
);



ALTER TABLE maps
    ADD CONSTRAINT FKmapspostkeypostpostkey FOREIGN KEY (postkey)
        REFERENCES post (postkey) on delete cascade;
        
        
        
-- glocation Table Create SQL
CREATE TABLE ladder
(
    postkey          NUMBER           NOT NULL, 
    ladderkey        NUMBER           NOT NULL, 
    laddercontent    VARCHAR2(100)    NOT NULL, 
    CONSTRAINT LADDERPK PRIMARY KEY (ladderkey)
);


CREATE SEQUENCE ladderSEQ
START WITH 1
INCREMENT BY 1;



ALTER TABLE ladder
    ADD CONSTRAINT FKladderpostkeypostpostk FOREIGN KEY (postkey)
        REFERENCES post (postkey) on delete cascade;
        
        
-- glocation Table Create SQL
CREATE TABLE gcomment
(
    commnetnum        NUMBER           NOT NULL, 
    postkey           NUMBER           NOT NULL, 
    userkey           NUMBER           NOT NULL, 
    commentcontent    VARCHAR2(500)    NOT NULL, 
    commemtreref     NUMBER           NOT NULL, 
    commentrelev     NUMBER           NOT NULL, 
    commentreseq     NUMBER           NOT NULL, 
    commentdate       DATE             NOT NULL, 
    groupkey          NUMBER           NOT NULL, 
    CONSTRAINT GCOMMENTPK PRIMARY KEY (commnetnum)
);

CREATE SEQUENCE gcommentSEQ
START WITH 1
INCREMENT BY 1;       
        
        
        
        
ALTER TABLE gcomment
    ADD CONSTRAINT FKgcommentpostkeypostpos FOREIGN KEY (postkey)
        REFERENCES post (postkey) on delete cascade;
ALTER TABLE gcomment
    ADD CONSTRAINT FKgcommentuserkeyggroup FOREIGN KEY (userkey, groupkey)
        REFERENCES ggroupmember (userkey, groupkey) on delete cascade;
        
        
        
-- glocation Table Create SQL
CREATE TABLE votemembber
(
    votememberkey    NUMBER    NOT NULL, 
    userkey           NUMBER    NOT NULL, 
    votekey           NUMBER    NOT NULL, 
    checkvote         NUMBER    NOT NULL, 
    groupkey          NUMBER    NOT NULL, 
    CONSTRAINT VOTEMEMBBERPK PRIMARY KEY (votememberkey)
);

CREATE SEQUENCE votemembberSEQ
START WITH 1
INCREMENT BY 1;




ALTER TABLE votemembber
    ADD CONSTRAINT FKvotemembbervotekeyvote FOREIGN KEY (votekey)
        REFERENCES vote (votekey) on delete cascade;

ALTER TABLE votemembber
    ADD CONSTRAINT FKvotemembberuserkeyggro FOREIGN KEY (userkey, groupkey)
        REFERENCES ggroupmember (userkey, groupkey) on delete cascade;
        
   
        
-- glocation Table Create SQL
CREATE TABLE bfile
(
    filekey         NUMBER           NOT NULL, 
    fileoriginal    VARCHAR2(100)    NOT NULL, 
    filename        VARCHAR2(100)    NOT NULL, 
    postkey         NUMBER           NOT NULL, 
    CONSTRAINT BFILEPK PRIMARY KEY (filekey)
);

                                                 
CREATE SEQUENCE bfileSEQ
START WITH 1
INCREMENT BY 1;



ALTER TABLE bfile
    ADD CONSTRAINT FKbfilepostkeypostpostk FOREIGN KEY (postkey)
        REFERENCES post (postkey) on delete cascade;
        


-- glocation Table Create SQL
CREATE TABLE userpolice
(
    policekey           NUMBER     NOT NULL, --자동증가
    userkey             NUMBER     NOT NULL, --신고한 유저
    policeboardsort    CHAR(1)    NOT NULL, --글/댓글 여부
    policenumber        NUMBER     NOT NULL, --글/댓글 번호
    policesort          NUMBER     NOT NULL, --욕/비방/정치/혐오/공부
    reciveuserKey number, --신고당한 유저
    
    CONSTRAINT USERPOLICEPK PRIMARY KEY (policekey)
);
      
      
      
CREATE SEQUENCE userpoliceSEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE userpolice
    ADD CONSTRAINT FKuserpoliceuserkeyguser FOREIGN KEY (userkey)
        REFERENCES gusers (userkey) on delete cascade;

ALTER TABLE userpolice
    ADD CONSTRAINT FKuserpoliceuserkeyguser1 FOREIGN KEY (reciveuserKey)
        REFERENCES gusers (userkey) on delete cascade;




CREATE TABLE userlikegroup
(
    userlikegroupkey    NUMBER    NOT NULL, 
    userkey               NUMBER    NOT NULL, 
    groupkey              NUMBER    NOT NULL, 
    CONSTRAINT USERLIKEGROUPPK PRIMARY KEY (userlikegroupkey)
);


CREATE SEQUENCE userlikegroupSEQ
START WITH 1
INCREMENT BY 1;




ALTER TABLE userlikegroup
    ADD CONSTRAINT FKuserlikegroupuserkeyg FOREIGN KEY (userkey)
        REFERENCES gusers (userkey) on delete cascade;

ALTER TABLE userlikegroup
    ADD CONSTRAINT FKuserlikegroupgroupkeyg FOREIGN KEY (groupkey)
        REFERENCES ggroup (groupkey) on delete cascade;
                                                 
                   
        
 insert into glocation values(0,'		','		');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','		');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	종로구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	중구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	용산구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	성동구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	광진구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	동대문구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	중랑구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	성북구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	강북구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	도봉구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	노원구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	은평구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	서대문구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	마포구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	양천구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	강서구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	구로구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	금천구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	영등포구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	동작구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	관악구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	서초구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	강남구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	송파구	');
insert into glocation values(glocationSEQ.nextval,'	서울특별시	','	강동구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','		');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	중구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	서구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	동구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	영도구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	부산진구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	동래구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	남구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	북구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	해운대구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	사하구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	금정구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	강서구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	연제구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	수영구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	사상구	');
insert into glocation values(glocationSEQ.nextval,'	부산광역시	','	기장군	');
insert into glocation values(glocationSEQ.nextval,'	대구광역시	','		');
insert into glocation values(glocationSEQ.nextval,'	대구광역시	','	중구	');
insert into glocation values(glocationSEQ.nextval,'	대구광역시	','	동구	');
insert into glocation values(glocationSEQ.nextval,'	대구광역시	','	서구	');
insert into glocation values(glocationSEQ.nextval,'	대구광역시	','	남구	');
insert into glocation values(glocationSEQ.nextval,'	대구광역시	','	북구	');
insert into glocation values(glocationSEQ.nextval,'	대구광역시	','	수성구	');
insert into glocation values(glocationSEQ.nextval,'	대구광역시	','	달서구	');
insert into glocation values(glocationSEQ.nextval,'	대구광역시	','	달성군	');
insert into glocation values(glocationSEQ.nextval,'	인천광역시	','		');
insert into glocation values(glocationSEQ.nextval,'	인천광역시	','	중구	');
insert into glocation values(glocationSEQ.nextval,'	인천광역시	','	동구	');
insert into glocation values(glocationSEQ.nextval,'	인천광역시	','	미추홀구	');
insert into glocation values(glocationSEQ.nextval,'	인천광역시	','	연수구	');
insert into glocation values(glocationSEQ.nextval,'	인천광역시	','	남동구	');
insert into glocation values(glocationSEQ.nextval,'	인천광역시	','	부평구	');
insert into glocation values(glocationSEQ.nextval,'	인천광역시	','	계양구	');
insert into glocation values(glocationSEQ.nextval,'	인천광역시	','	서구	');
insert into glocation values(glocationSEQ.nextval,'	인천광역시	','	강화군	');
insert into glocation values(glocationSEQ.nextval,'	인천광역시	','	옹진군	');
insert into glocation values(glocationSEQ.nextval,'	광주광역시	','		');
insert into glocation values(glocationSEQ.nextval,'	광주광역시	','	동구	');
insert into glocation values(glocationSEQ.nextval,'	광주광역시	','	서구	');
insert into glocation values(glocationSEQ.nextval,'	광주광역시	','	남구	');
insert into glocation values(glocationSEQ.nextval,'	광주광역시	','	북구	');
insert into glocation values(glocationSEQ.nextval,'	광주광역시	','	광산구	');
insert into glocation values(glocationSEQ.nextval,'	대전광역시	','		');
insert into glocation values(glocationSEQ.nextval,'	대전광역시	','	동구	');
insert into glocation values(glocationSEQ.nextval,'	대전광역시	','	중구	');
insert into glocation values(glocationSEQ.nextval,'	대전광역시	','	서구	');
insert into glocation values(glocationSEQ.nextval,'	대전광역시	','	유성구	');
insert into glocation values(glocationSEQ.nextval,'	대전광역시	','	대덕구	');
insert into glocation values(glocationSEQ.nextval,'	울산광역시	','		');
insert into glocation values(glocationSEQ.nextval,'	울산광역시	','	중구	');
insert into glocation values(glocationSEQ.nextval,'	울산광역시	','	남구	');
insert into glocation values(glocationSEQ.nextval,'	울산광역시	','	동구	');
insert into glocation values(glocationSEQ.nextval,'	울산광역시	','	북구	');
insert into glocation values(glocationSEQ.nextval,'	울산광역시	','	울주군	');
insert into glocation values(glocationSEQ.nextval,'	세종특별자치시	','		');
insert into glocation values(glocationSEQ.nextval,'	세종특별자치시	','	세종특별자치시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','		');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	수원시장안구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	수원시권선구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	수원시팔달구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	수원시영통구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	성남시수정구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	성남시중원구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	성남시분당구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	의정부시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	안양시만안구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	안양시동안구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	부천시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	광명시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	평택시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	동두천시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	안산시상록구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	안산시단원구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	고양시덕양구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	고양시일산동구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	고양시일산서구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	과천시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	구리시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	남양주시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	오산시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	시흥시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	군포시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	의왕시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	하남시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	용인시처인구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	용인시기흥구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	용인시수지구	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	파주시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	이천시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	안성시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	김포시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	화성시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	광주시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	양주시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	포천시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	여주시	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	연천군	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	가평군	');
insert into glocation values(glocationSEQ.nextval,'	경기도	','	양평군	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','		');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	춘천시	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	원주시	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	강릉시	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	동해시	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	태백시	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	속초시	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	삼척시	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	홍천군	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	횡성군	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	영월군	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	평창군	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	정선군	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	철원군	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	화천군	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	양구군	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	인제군	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	고성군	');
insert into glocation values(glocationSEQ.nextval,'	강원도	','	양양군	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','		');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	청주시상당구	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	청주시서원구	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	청주시흥덕구	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	청주시청원구	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	충주시	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	제천시	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	보은군	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	옥천군	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	영동군	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	증평군	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	진천군	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	괴산군	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	음성군	');
insert into glocation values(glocationSEQ.nextval,'	충청북도	','	단양군	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','		');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	천안시동남구	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	천안시서북구	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	공주시	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	보령시	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	아산시	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	서산시	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	논산시	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	계룡시	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	당진시	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	금산군	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	부여군	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	서천군	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	청양군	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	홍성군	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	예산군	');
insert into glocation values(glocationSEQ.nextval,'	충청남도	','	태안군	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','		');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	전주시완산구	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	전주시덕진구	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	군산시	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	익산시	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	정읍시	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	남원시	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	김제시	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	완주군	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	진안군	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	무주군	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	장수군	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	임실군	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	순창군	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	고창군	');
insert into glocation values(glocationSEQ.nextval,'	전라북도	','	부안군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','		');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	목포시	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	여수시	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	순천시	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	나주시	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	광양시	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	담양군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	곡성군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	구례군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	고흥군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	보성군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	화순군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	장흥군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	강진군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	해남군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	영암군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	무안군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	함평군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	영광군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	장성군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	완도군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	진도군	');
insert into glocation values(glocationSEQ.nextval,'	전라남도	','	신안군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','		');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	포항시남구	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	포항시북구	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	경주시	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	김천시	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	안동시	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	구미시	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	영주시	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	영천시	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	상주시	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	문경시	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	경산시	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	군위군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	의성군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	청송군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	영양군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	영덕군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	청도군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	고령군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	성주군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	칠곡군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	예천군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	봉화군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	울진군	');
insert into glocation values(glocationSEQ.nextval,'	경상북도	','	울릉군	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','		');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	창원시 의창구	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	창원시 성산구	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	창원시 마산합포구	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	창원시 마산회원구	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	창원시 진해구	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	진주시	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	통영시	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	사천시	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	김해시	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	밀양시	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	거제시	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	양산시	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	의령군	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	함안군	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	창녕군	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	고성군	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	남해군	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	하동군	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	산청군	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	함양군	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	거창군	');
insert into glocation values(glocationSEQ.nextval,'	경상남도	','	합천군	');
insert into glocation values(glocationSEQ.nextval,'	제주특별자치도	','		');
insert into glocation values(glocationSEQ.nextval,'	제주특별자치도	','	제주시	');
insert into glocation values(glocationSEQ.nextval,'	제주특별자치도	','	서귀포시	');

                                                 
                                                 
insert into gage values(0,0);
insert into gage values(1,10);
insert into gage values(2,20);
insert into gage values(3,30);
insert into gage values(4,40);
insert into gage values(5,50);
insert into gage values(6,60);

                                                 

insert into gcategory values(gcategorySEQ.nextval,'게임');
insert into gcategory values(gcategorySEQ.nextval,'연예/방송');
insert into gcategory values(gcategorySEQ.nextval,'스포츠');
insert into gcategory values(gcategorySEQ.nextval,'교육/금융/IT');
insert into gcategory values(gcategorySEQ.nextval,'여행/음식/생물');
insert into gcategory values(gcategorySEQ.nextval,'취미/생활');
                                                 
                                                 
                                                 


insert into gcategory2 values(gcategory2SEQ.nextval,1,'리그오브레전드');
insert into gcategory2 values(gcategory2SEQ.nextval,1,'오버워치');
insert into gcategory2 values(gcategory2SEQ.nextval,1,'바람의나라');
insert into gcategory2 values(gcategory2SEQ.nextval,1,'카트라이더');
insert into gcategory2 values(gcategory2SEQ.nextval,1,'테라');
insert into gcategory2 values(gcategory2SEQ.nextval,1,'리니지');



insert into gcategory2 values(gcategory2SEQ.nextval,2,'트와이스');
insert into gcategory2 values(gcategory2SEQ.nextval,2,'태연');
insert into gcategory2 values(gcategory2SEQ.nextval,2,'소녀시대');
insert into gcategory2 values(gcategory2SEQ.nextval,2,'아이돌학교');
insert into gcategory2 values(gcategory2SEQ.nextval,2,'스토브리그');
insert into gcategory2 values(gcategory2SEQ.nextval,2,'도꺠비');



insert into gcategory2 values(gcategory2SEQ.nextval,3,'야구');
insert into gcategory2 values(gcategory2SEQ.nextval,3,'축구');
insert into gcategory2 values(gcategory2SEQ.nextval,3,'자전거');
insert into gcategory2 values(gcategory2SEQ.nextval,3,'수영');
insert into gcategory2 values(gcategory2SEQ.nextval,3,'스키');
insert into gcategory2 values(gcategory2SEQ.nextval,3,'볼링');



insert into gcategory2 values(gcategory2SEQ.nextval,4,'공무원');
insert into gcategory2 values(gcategory2SEQ.nextval,4,'편입');
insert into gcategory2 values(gcategory2SEQ.nextval,4,'자격증');
insert into gcategory2 values(gcategory2SEQ.nextval,4,'토익');
insert into gcategory2 values(gcategory2SEQ.nextval,4,'증권');
insert into gcategory2 values(gcategory2SEQ.nextval,4,'노트북');



insert into gcategory2 values(gcategory2SEQ.nextval,5,'제주도');
insert into gcategory2 values(gcategory2SEQ.nextval,5,'일본');
insert into gcategory2 values(gcategory2SEQ.nextval,5,'중국');
insert into gcategory2 values(gcategory2SEQ.nextval,5,'미국');
insert into gcategory2 values(gcategory2SEQ.nextval,5,'치킨');
insert into gcategory2 values(gcategory2SEQ.nextval,5,'피자');




insert into gcategory2 values(gcategory2SEQ.nextval,6,'유투브');
insert into gcategory2 values(gcategory2SEQ.nextval,6,'웹툰');
insert into gcategory2 values(gcategory2SEQ.nextval,6,'만화');
insert into gcategory2 values(gcategory2SEQ.nextval,6,'관상');
insert into gcategory2 values(gcategory2SEQ.nextval,6,'사주');


/*관리자 계정*/ 
insert into gusers values(0, 'admin','$2a$10$DGdkEZGSwAL1tOEmaEEqB.qfcKQrREhIo4wwgIfD5LWi/eICNg5Ha',
NULL,NULL,2,1,'F','plain64@naver.com',sysdate,'Y','N',0,null,0);




-- ############################### 고여니 테스트 ###############################

-- ### 기본 조회 ###
-- 모임에 속해있는 회원 조회
SELECT * FROM GGROUPMEMBER ORDER BY GROUPKEY, USERKEY;

-- 모임 조회
SELECT * FROM GGROUP ORDER BY GROUPKEY;

-- 게시글 조회
SELECT * FROM POST ORDER BY POSTKEY, USERKEY, GROUPKEY;

-- 댓글 조회
SELECT * FROM GCOMMENT ORDER BY COMMNETNUM, POSTKEY;

-- 회원 조회
SELECT * FROM GUSERS;

-- 좋아요 조회
SELECT * FROM POSTLIKE; 

-- 가입 양식 조회
SELECT * FROM JOINQUEST;

-- 가입 양식 입력 조회
SELECT * FROM JOINANSWER;
-- #############

SELECT COUNT(USERKEY) FROM GGROUPMEMBER WHERE GROUPKEY = 3;  
SELECT * FROM GGROUPMEMBER WHERE GROUPKEY = 3;

SELECT * FROM GGROUP WHERE GROUPKEY IN (SELECT GROUPKEY FROM GGROUPMEMBER WHERE USERKEY = 1); -- 회원수 조인해서 구해야 되는데.. 모르겠어 일단 보류 

-- 작성한 댓글
-- POST의 POSTTITLE, POSTCONTENT, POSTDATE를 받아오자..
SELECT POSTKEY, POSTTITLE, POSTCONTENT, POSTDATE
FROM POST
WHERE BOARDKEY IN (SELECT BOARDKEY
					FROM GGROUPBOARD
					WHERE GROUPKEY = #{GROUPKEY})

-- POSTKEY와 USERKEY에 해당하는 댓글 가져오기 
SELECT COMMENTCONTENT
FROM GCOMMENT
WHERE POSTKEY = #{POSTKEY} AND USERKEY = #{USERKEY}

INSERT INTO POST VALUES(postSEQ.NEXTVAL, '나는 바보야 페이지도 빨리 못 만드는 바보 ㅠ', '엉엉', sysdate, 2, 3, 'Y', 'Y', 2, 0);
INSERT INTO POST VALUES(postSEQ.NEXTVAL, '할 일이 많은데 속도가 안 붙어요', '바보죠?', sysdate, 2, 3, 'Y', 'Y', 2, 0);
INSERT INTO POST VALUES(postSEQ.NEXTVAL, '작성한 글은 뽑았는데 작성한 댓글은 못 뽑겠어..', '엉엉', sysdate, 2, 3, 'Y', 'Y', 2, 0);
INSERT INTO POST VALUES(postSEQ.NEXTVAL, '큰일났어요 큰일ㅇ났어..', 'ㅠㅠㅠㅠㅠㅠㅠㅠㅠ', sysdate, 2, 3, 'Y', 'Y', 2, 0);
INSERT INTO POST VALUES(postSEQ.NEXTVAL, '우와아앙오야양', '엉엉', sysdate, 2, 3, 'Y', 'Y', 2, 0);

SELECT * FROM POST WHERE USERKEY = 2 AND GROUPKEY = 3;

SELECT GROUPKEY, GROUPNAME, GROUPDFILE, TO_CHAR(GROUPDATE, 'YYYY-MM-DD') AS GROUPDATE, COUNT(*)
FROM ggroup
WHERE groupkey IN ( SELECT groupkey
					FROM ggroupmember
					WHERE userkey = 2)	
ORDER BY GROUPDATE DESC;			

-- 모임 조회 + 모임에 가입한 회원수
SELECT GROUPKEY, GROUPNAME, GROUPDFILE, GROUPDATE, USERKEY
FROM (	SELECT DISTINCT G.GROUPKEY AS GROUPKEY, G.GROUPNAME AS GROUPNAME, G.GROUPDFILE AS GROUPDFILE, G.GROUPDATE AS GROUPDATE, M.USERKEY
		FROM GGROUP G INNER JOIN GGROUPMEMBER M
		ON G.GROUPKEY = M.GROUPKEY
		ORDER BY GROUPKEY, USERKEY)
GROUP BY GROUPKEY
HAVING GROUPKEY IN (1, 3, 5);

-- 해당 회원이 참여하는 모임 목록
-- 각 모임들은 몇 명의 회원이 있는지 알아야 한다.
SELECT GROUPKEY, GROUPNAME, GROUPDFILE, TO_CHAR(GROUPDATE, 'YYYY-MM-DD') AS GROUPDATE, COUNT(GROUPKEY) AS MEMBERCOUNT
FROM (	SELECT G.GROUPKEY AS GROUPKEY, G.GROUPNAME AS GROUPNAME, G.GROUPDFILE AS GROUPDFILE, G.GROUPDATE AS GROUPDATE, M.USERKEY AS USERKEY
		FROM GGROUP G INNER JOIN GGROUPMEMBER M
		ON G.GROUPKEY = (SELECT GROUPKEY AS M.GROUPKEY FROM GGROUPMEMBER WHERE USERKEY = )
		ORDER BY GROUPKEY, USERKEY)
GROUP BY GROUPKEY, GROUPNAME, GROUPDFILE, GROUPDATE
HAVING USERKEY IN (2)
ORDER BY GROUPDATE DESC;


-- 그 모임들의 모임키, 모임명, 모임사진, 모임설립일, 회원수
SELECT GROUPKEY, COUNT(GROUPKEY) AS MEMBERCOUNT
FROM GGROUPMEMBER
GROUP BY GROUPKEY
HAVING GROUPKEY IN (SELECT GROUPKEY 
					FROM GGROUPMEMBER
					WHERE USERKEY = 2);
					
SELECT GROUPKEY, GROUPNAME, GROUPDFILE, TO_CHAR(GROUPDATE, 'YYYY-MM-DD') AS GROUPDATE, MEMBERCOUNT
FROM GGROUP NATURAL JOIN ( 	SELECT GROUPKEY, COUNT(GROUPKEY) AS MEMBERCOUNT
							FROM GGROUPMEMBER
							GROUP BY GROUPKEY
							HAVING GROUPKEY IN (SELECT GROUPKEY 
												FROM GGROUPMEMBER
												WHERE USERKEY = 2)) 
ORDER BY GROUPDATE DESC;




-- 댓글 달기
INSERT INTO GCOMMENT VALUES (GCOMMENTSEQ.NEXTVAL, 15, 2, '아뇨 할 수 있어요!!', 1, 0, 0, sysdate, 3); 			-- 3번 모임의 15번 글에 2번 유저가 댓글을 달 것임 
INSERT INTO GCOMMENT VALUES (GCOMMENTSEQ.NEXTVAL, 14, 2, '노력하면 속도 붙을 거예요 홧팅', 1, 0, 0, sysdate, 3); 	-- 3번 모임의 14번 글에 2번 유저가 댓글을 달 것임 
INSERT INTO GCOMMENT VALUES (GCOMMENTSEQ.NEXTVAL, 16, 2, '미 친 듯 이 달 려 라 아 자', 1, 0, 0, sysdate, 3);
INSERT INTO GCOMMENT VALUES (GCOMMENTSEQ.NEXTVAL, 17, 2, '왕오아오아앙ㅇ', 1, 0, 0, sysdate, 3);
INSERT INTO GCOMMENT VALUES (GCOMMENTSEQ.NEXTVAL, 13, 2, '노.. 유 아 낫 바 보', 1, 0, 0, sysdate, 3);
INSERT INTO GCOMMENT VALUES (GCOMMENTSEQ.NEXTVAL, 11, 2, '노.. 유 아 낫 바 보', 1, 0, 0, sysdate, 6); 			-- 6번 모임의 11번 글에 2번 유저가 댓글을 달 것임
INSERT INTO GCOMMENT VALUES (GCOMMENTSEQ.NEXTVAL, 15, 3, 'ㅇㅇㅇㅇ', 1, 0, 0, SYSDATE, 3);
INSERT INTO GCOMMENT VALUES (GCOMMENTSEQ.NEXTVAL, 15, 4, 'SSSSS', 1, 0, 0, SYSDATE, 3);


-- 현재 모임(3번)에서 해당 유저가(2번) 어떤 글에 무슨 댓글을 달았는지
SELECT POSTKEY, USERKEY, COMMENTCONTENT, GROUPKEY FROM GCOMMENT WHERE USERKEY = 2 AND GROUPKEY = 3 ORDER BY COMMENTDATE DESC;

SELECT POSTKEY, POSTTITLE, POSTDATE FROM POST WHERE POSTKEY IN (13, 17);
SELECT POSTKEY, USERKEY, COMMENTCONTENT, GROUPKEY 
FROM GCOMMENT WHERE USERKEY = 2 AND GROUPKEY = 3

-- 글에 달린 댓글 개수 
SELECT POSTKEY, POSTTITLE, USERKEY, COMMENTCONTENT, GROUPKEY
FROM POST NATURAL JOIN (	SELECT POSTKEY, USERKEY, COMMENTCONTENT, GROUPKEY 
							FROM GCOMMENT 
							WHERE USERKEY = 2 AND GROUPKEY = 3
							ORDER BY COMMENTDATE DESC) 

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
SELECT POSTKEY, POSTTITLE, POSTCONTENT, USERKEY, GROUPKEY
FROM POST NATURAL JOIN (SELECT POSTKEY, COUNT(USERKEY), COMMENTCONTENT, GROUPKEY FROM GCOMMENT WHERE GROUPKEY = 3)

SELECT C.POSTKEY, C.COMMENTCONTENT, C.GROUPKEY
FROM GCOMMENT C JOIN (	SELECT POSTKEY, COUNT(POSTKEY) AS "#COUNT#"
						FROM GCOMMENT C
						GROUP BY POSTKEY);	

SELECT *
FROM POST
WHERE POSTKEY IN (	SELECT POSTKEY 
					FROM GCOMMENT 
					WHERE USERKEY = 2 AND GROUPKEY = 3 )	

-- 댓글이 어느 글에 달렸는지 알 수 있는 원문글 번호
-- 어떤 유저가 댓글을 달았는지 알 수 있는 유저번호
-- 유저가 단 댓글
-- 유저가 댓글 쓴 날짜
-- 어느 모임에서 썼는지에 대한 모임번호
-- 글제목
SELECT C.POSTKEY AS POSTKEY, C.USERKEY AS USERKEY, C.COMMENTCONTENT AS COMMENTCONTENT, C.COMMENTDATE AS COMMENTDATE, C.GROUPKEY AS GROUPKEY, P.POSTTITLE AS POSTTITLE
FROM GCOMMENT C LEFT JOIN POST P
ON C.POSTKEY = P.POSTKEY

-- 글번호와 그 글들에 대한 댓글수 
SELECT POSTKEY, COUNT(POSTKEY) AS COMMENTCOUNT
FROM (	SELECT C.POSTKEY AS POSTKEY, C.USERKEY AS USERKEY, C.COMMENTCONTENT AS COMMENTCONTENT, C.COMMENTDATE AS COMMENTDATE, C.GROUPKEY AS GROUPKEY, P.POSTTITLE AS POSTTITLE
		FROM GCOMMENT C LEFT JOIN POST P
		ON C.POSTKEY = P.POSTKEY)
GROUP BY POSTKEY
-- 노답인데;

SELECT POSTKEY, COUNT(POSTKEY) AS "COMMENTCOUNT"
FROM GCOMMENT
GROUP BY POSTKEY

select * from GCOMMENT a left join post using(postkey) where a.userkey=2

select count(*),postkey from gcomment group by postkey
select commentcount, posttitle from post left join (select count(postkey) commentcount, postkey from gcomment group by userkey) using(postkey) where groupkey=3

select count(postkey) from post group by postkey having userkey = 2;

select * 
from post a left outer join (select count(b.postkey) commentcount, b.postkey 
							from gcomment b 
							group by b.postkey) p 
							on a.postkey = p.postkey
							where groupkey = 3 and userkey = 2;
							
SELECT POSTKEY, POSTTITLE, COMMENTDATE, USERKEY, COMMENTCONTENT, GROUPKEY
FROM POST NATURAL JOIN ( 	SELECT POSTKEY, USERKEY, COMMENTCONTENT, GROUPKEY, COMMENTDATE 
							FROM GCOMMENT 
							WHERE USERKEY = 2 AND GROUPKEY = 3
							ORDER BY COMMENTDATE DESC) 							
							
-- 모임 회원의 프사를 위해,,
ALTER TABLE GGROUPMEMBER ADD(PROFILEFILE VARCHAR2(100) NULL);			
ALTER TABLE GGROUPMEMBER ADD(PROFILEORIGIN VARCHAR2(100) NULL);			
													
INSERT INTO GGROUPMEMBER
VALUES (0, 1, '프사테스트', 1, '/2020-1-20/group202012096380152.jpeg', '/2020-1-20/group202012096380152.jpeg');

INSERT INTO POST
VALUES (POSTSEQ.NEXTVAL, '테스트입니다 테스트', '테스트인데 사진 넣을 땐 어떡하징', SYSDATE, 8, 3, 'N', 'N', 2, 0);
							
게시글을 조회하면 할 것
게시글의 조회수 1 증가	OK
게시글의 작성자 닉네임 	
작성자의 프사		PROFILEFILE
게시글 제목			POSTTITLE 
게시글 작성일		POSTDATE 
게시글 내용			POSTCONTENT
게시글 조회수 		POSTREADCOUNT
게시글 댓글수 	
게시글 좋아요수	
게시글에 달린 댓글 	

-- 작성자 닉네임, 작성자 프사, 게시글키값, 제목, 내용, 작성일, 작성자키값, 글 조회수
SELECT GROUPNICKNAME, PROFILEFILE, POSTKEY, POSTTITLE, POSTCONTENT, POSTDATE, USERKEY, POSTREADCOUNT 
FROM GGROUPMEMBER JOIN POST 
USING (USERKEY) 
WHERE POSTKEY = 19;

-- 글키값, 글제목, 댓글수
SELECT POSTKEY, POSTTITLE, REPLYCOUNT
FROM POST LEFT JOIN (SELECT POSTKEY, COUNT(POSTKEY) REPLYCOUNT
					 FROM GCOMMENT
					 GROUP BY POSTKEY)
USING (POSTKEY)

-- 회원의 작성한 댓글 쿠ㅓ리
SELECT USERKEY, POSTKEY, COMMENTCONTENT, GROUPKEY, REPLYCOUNT, POSTTITLE, COMMENTDATE 
FROM GCOMMENT LEFT JOIN (SELECT POSTKEY, POSTTITLE, REPLYCOUNT
						 FROM POST LEFT JOIN (SELECT POSTKEY, COUNT(POSTKEY) REPLYCOUNT
					 						  FROM GCOMMENT
					 						  GROUP BY POSTKEY)
					 	 USING (POSTKEY)) 
USING(POSTKEY)					 						  
WHERE USERKEY = 2 AND GROUPKEY = 3

-------------------------------------------------------------------------------------------
SELECT USERKEY, POSTKEY, COMMENTCONTENT, GROUPKEY, REPLYCOUNT, POSTTITLE, COMMENTDATE, POSTREADCOUNT 
FROM GCOMMENT LEFT JOIN (SELECT POSTKEY, POSTTITLE, REPLYCOUNT, POSTREADCOUNT
						 FROM POST LEFT JOIN (SELECT POSTKEY, COUNT(POSTKEY) REPLYCOUNT
					 						  FROM GCOMMENT
					 						  GROUP BY POSTKEY)
					 	 USING (POSTKEY)) 
USING(POSTKEY)					 						  
WHERE USERKEY = 2 AND GROUPKEY = 3

-- 좋아요 데이터 생성
INSERT INTO POSTLIKE VALUES(10, 2, 3);	-- 3번 모임의 10번 게시글에 2번 유저가 좋아요 함
INSERT INTO POSTLIKE VALUES(10, 8, 3);	-- 3번 모임의 10번 게시글에 8번 유저가 좋아요 함	

-- 3번 모임의 10번 게시글의 좋아요 수 구하기
SELECT POSTKEY, COUNT(POSTKEY) LIKECOUNT FROM POSTLIKE GROUP BY POSTKEY;


-- 모임 가입양식 예상 쿼리
-- JOINQUEST TABLE
DROP TABLE JOINQUEST;
DROP TABLE JOINANSWER;

CREATE TABLE JOINQUEST(
	QUESTKEY	NUMBER			NOT NULL,
	GROUPKEY	NUMBER			NOT NULL,
	QUEST1		VARCHAR2(100)	NULL,
	QUEST2		VARCHAR2(100)	NULL,
	QUEST3		VARCHAR2(100)	NULL,
	QUEST4		VARCHAR2(100)	NULL,
	QUEST5		VARCHAR2(100)	NULL,
	INTRODUCE	VARCHAR2(100)	NULL,
	CONSTRAINT JOINQUESTPK PRIMARY KEY (GROUPKEY)
);
-- 모임의 가입양식 데이터 생성
INSERT INTO JOINQUEST VALUES(NVL((SELECT MAX(QUESTKEY) FROM JOINQUEST), 0) + 1, 3, '어디 사세요?', '왜 사세요?', '잘 사세요?', '살만 하세요?', '왜 살만 하세요?', '자기소개 해주세요');
INSERT INTO JOINQUEST VALUES(NVL((SELECT MAX(QUESTKEY) FROM JOINQUEST), 0) + 1, 1, '어디 사세요?', '왜 사세요?', '', '', '', '자기소개 해주세요');
INSERT INTO JOINQUEST VALUES(NVL((SELECT MAX(QUESTKEY) FROM JOINQUEST), 0) + 1, 5, '배드민턴 좋아하세요?', '평소에 얼마나 치시나요?', '참가는 잘 하실 수 있나요?', '', '', '');


SELECT * FROM JOINQUEST;

--------------------------------------------------------------------------------------
QUESTKEY	GROUPKEY	QUEST1		QUEST2		QUSET3		QUEST4		INTRODUCE
	1			3		"어디사냐"		"왜 사냐"		"잘 사냐"		"살만 하냐"		"자기소개를 해주세요"
	2			1		"옵치주캐?"	"난장판 좋냐"	"힐딜탱?"		"경쟁/빠대"	"자기소개를 해주세요"
---------------------------------------------------------------------------------------

CREATE TABLE JOINANSWER(
	GROUPKEY	NUMBER			NOT NULL,
	USERKEY		NUMBER			NOT NULL,
	ANSWER1		VARCHAR2(500),
	ANSWER2		VARCHAR2(500),
	ANSWER3		VARCHAR2(500),
	ANSWER4		VARCHAR2(500),
	ANSWER5		VARCHAR2(500),
	INTRODUCE	VARCHAR2(800),
	CONSTRAINT JOINANSWERPK PRIMARY KEY (GROUPKEY, USERKEY)
);

-- 모임이 사라지는 경우 / 질문을 받았다가 아예 질문을 지워버리는 경우가 있을 수도 있다.
ALTER TABLE JOINANSWER
ADD CONSTRAINT FKJOINANSWERTOQUESTKEY FOREIGN KEY (GROUPKEY)
REFERENCES JOINQUEST (GROUPKEY) ON DELETE CASCADE;
---------------------------------------------------------------------------------------------------
QUESTKEY	GROUPKEY	USERKEY		QUEST1		QUEST2		QUSET3		QUEST4		INTRODUCE
	1			3			2		"어디사냐"		"왜 사냐"		"잘 사냐"		"살만 하냐"		"자기소개를 해주세요"
	1			3			1		"옵치주캐?"	"난장판 좋냐"	"힐딜탱?"		"경쟁/빠대"	"자기소개를 해주세요"
---------------------------------------------------------------------------------------------------

SELECT NVL(GROUPNICKNAME, -1)
		FROM GGROUPMEMBER
		WHERE GROUPNICKNAME = '하마';
		

-- # 게시글 상세보기 
-- GGROUPMEMBER, POST, GCOMMENT
-- PROFILEFILE(작성자 프사), GROUPNICKNAME(작성자 닉네임)
-- PROFILEFILE(댓글러 프사), GROUPNICKNAME(댓글러 닉네임)
-- POSTTITLE(글제목), POSTDATE(작성일), POSTREADCOUNT(조회수), REPLYCOUNT(댓글수), POSTLIKE(좋아요), POSTCONTENT(글내용)
-- COMMENTCONTENT(댓글내용), COMMENTDATE(댓글 작성일)
SELECT * FROM GGROUPMEMBER;
 
=======
SELECT * FROM POST;
SELECT * FROM GCOMMENT;
		
-- 파라미터 값으로는 POSTKEY를 가져온다. + GROUPKEY도 가져와야 할 것 같다.
-- 1. 글키값(13), 글제목, 글내용, 글작성일, 글작성자키, 조회수
SELECT POSTKEY, POSTTITLE, POSTCONTENT, TO_CHAR(POSTDATE, 'YYYY-MM-DD') POSTDATE, USERKEY, POSTREADCOUNT 
FROM POST 
WHERE POSTKEY = 13;

-- 2. 1번 + 글키값(13)의 작성자 닉네임, 작성자 프사
SELECT PROFILEFILE, GROUPNICKNAME, POSTKEY, POSTTITLE, POSTCONTENT, POSTDATE, USERKEY, POSTREADCOUNT, GROUPKEY
FROM GGROUPMEMBER JOIN (SELECT POSTKEY, POSTTITLE, POSTCONTENT, TO_CHAR(POSTDATE, 'YYYY-MM-DD') POSTDATE, USERKEY, POSTREADCOUNT 
						FROM POST 
						WHERE POSTKEY = 13)
USING (USERKEY)
WHERE GROUPKEY = 3;

-- 3. 2번 + 글에 대한 좋아요 
SELECT PROFILEFILE, GROUPNICKNAME, POSTKEY, POSTTITLE, POSTCONTENT, POSTDATE, USERKEY, POSTREADCOUNT, GROUPKEY, POSTLIKE
FROM GGROUPMEMBER JOIN (SELECT POSTKEY, POSTTITLE, POSTCONTENT, TO_CHAR(POSTDATE, 'YYYY-MM-DD') POSTDATE, USERKEY, POSTREADCOUNT, POSTLIKE 
						FROM POST LEFT JOIN (	SELECT COUNT(POSTKEY) POSTLIKE, POSTKEY
												FROM POSTLIKE
												GROUP BY POSTKEY
												HAVING POSTKEY = 13)
						USING (POSTKEY)
						WHERE POSTKEY = 13)
USING (USERKEY)
WHERE GROUPKEY = 3;


-- 4. 3번 + 글에 대한 댓글수
SELECT PROFILEFILE, GROUPNICKNAME, POSTKEY, POSTTITLE, POSTCONTENT, POSTDATE, USERKEY, POSTREADCOUNT, GROUPKEY, POSTLIKE, REPLYCOUNT
FROM GGROUPMEMBER JOIN (SELECT POSTKEY, POSTTITLE, POSTCONTENT, POSTDATE, USERKEY, POSTREADCOUNT, POSTLIKE, REPLYCOUNT
						FROM (	SELECT POSTKEY, POSTTITLE, POSTCONTENT, TO_CHAR(POSTDATE, 'YYYY-MM-DD') POSTDATE, USERKEY, POSTREADCOUNT, POSTLIKE
								FROM POST LEFT JOIN (	SELECT COUNT(POSTKEY) POSTLIKE, POSTKEY
														FROM POSTLIKE
														GROUP BY POSTKEY
														HAVING POSTKEY = 13)			
								USING (POSTKEY)
								WHERE POSTKEY = 13) LEFT JOIN (	SELECT POSTKEY, COUNT(POSTKEY) REPLYCOUNT 
																FROM GCOMMENT
																GROUP BY POSTKEY
																HAVING POSTKEY = 13)		
								USING (POSTKEY))
USING (USERKEY)
WHERE GROUPKEY = 3;

-- 5. 댓글러 프사, 댓글러 닉네임, 댓글내용, 댓글 작성일
SELECT * FROM POST;
SELECT * FROM GCOMMENT;
SELECT * FROM GGROUPMEMBER ORDER BY GROUPKEY, USERKEY;

SELECT POSTKEY, USERKEY, COMMENTCONTENT, COMMEMTREREF, COMMENTRELEV, COMMENTRESEQ, COMMENTDATE, GROUPKEY
FROM GCOMMENT JOIN (SELECT POSTKEY 
					FROM POST 
					WHERE POSTKEY = 13)
USING (POSTKEY)

SELECT DISTINCT GROUPNICKNAME, PROFILEFILE, C.POSTKEY, M.USERKEY, COMMENTCONTENT, COMMEMTREREF, COMMENTRELEV, COMMENTRESEQ, COMMENTDATE, GROUPKEY
FROM GGROUPMEMBER M JOIN (	SELECT POSTKEY, USERKEY, COMMENTCONTENT, COMMEMTREREF, COMMENTRELEV, COMMENTRESEQ, COMMENTDATE, GROUPKEY
								FROM GCOMMENT JOIN (SELECT POSTKEY 
													FROM POST 
													WHERE POSTKEY = 13)
								USING (POSTKEY)) C	
USING (GROUPKEY)								
WHERE M.USERKEY IN (	SELECT USERKEY
						FROM GCOMMENT JOIN (SELECT POSTKEY 
											FROM POST 
											WHERE POSTKEY = 13)
						USING (POSTKEY));

---------------------------------------------------------------------------------------------------
-- 댓글러 프사, 닉네임, 유저키, 그룹키
SELECT *
FROM GGROUPMEMBER
WHERE USERKEY IN (	SELECT USERKEY
					FROM GCOMMENT JOIN (SELECT POSTKEY 
										FROM POST 
										WHERE POSTKEY = 13)
					USING (POSTKEY)) AND GROUPKEY = 3;
					
-- 댓글러 프사, 닉네임, 유저키, 그룹키, 댓글 내용, 작성일 등 
-- C부분은 딱 결과가 2개 나온느데 M이랑 JOIN하는 순간 NULL 값인 것도 들어가면서 결과가 4개가 된다.
SELECT M.GROUPKEY, M.USERKEY, M.GROUPNICKNAME, M.PROFILEFILE, C.COMMENTCONTENT, C.COMMEMTREREF, C.COMMENTRELEV, C.COMMENTRESEQ, C.COMMENTDATE
FROM GGROUPMEMBER M LEFT JOIN (	SELECT USERKEY, COMMENTCONTENT, COMMEMTREREF, COMMENTRELEV, COMMENTRESEQ, COMMENTDATE, GROUPKEY
								FROM GCOMMENT JOIN (SELECT POSTKEY 
													FROM POST 
													WHERE POSTKEY = 13)
								USING (POSTKEY)) C
ON (M.GROUPKEY = C.GROUPKEY)								
WHERE M.USERKEY IN (SELECT USERKEY
					FROM GCOMMENT JOIN (SELECT POSTKEY 
										FROM POST 
										WHERE POSTKEY = 13)
					USING (POSTKEY)) 
AND M.GROUPKEY = 3;		

SELECT C.POSTKEY, C.USERKEY, C.COMMENTCONTENT, C.COMMEMTREREF, C.COMMENTRELEV, C.COMMENTRESEQ, C.COMMENTDATE, GROUPKEY, M.GROUPNICKNAME, M.PROFILEFILE
FROM (	SELECT POSTKEY, USERKEY, COMMENTCONTENT, COMMEMTREREF, COMMENTRELEV, COMMENTRESEQ, COMMENTDATE, GROUPKEY
		FROM GCOMMENT INNER JOIN (SELECT POSTKEY 
							FROM POST 
							WHERE POSTKEY = 13)
		USING (POSTKEY)
	  ) C JOIN 
	  (	SELECT GROUPKEY, USERKEY, GROUPNICKNAME, PROFILEFILE
	  	FROM GGROUPMEMBER
	  	WHERE USERKEY IN (	SELECT USERKEY
							FROM GCOMMENT JOIN (SELECT POSTKEY 
												FROM POST 
												WHERE POSTKEY = 13)
							USING (POSTKEY)) 
		AND GROUPKEY = 3
		) M
USING (GROUPKEY)
WHERE C.POSTKEY = 13;


-- 완성된 쿼리쓰,,,,,, 댓글러의 유저키, 댓글내용, 댓글 깊이ST, 댓글 작성일, 모임키, 닉네임, 프사 
SELECT C.POSTKEY, C.USERKEY, COMMENTCONTENT, COMMEMTREREF, COMMENTRELEV, COMMENTRESEQ, COMMENTDATE, M.GROUPKEY, GROUPNICKNAME, PROFILEFILE
FROM (	SELECT POSTKEY, USERKEY, COMMENTCONTENT, COMMEMTREREF, COMMENTRELEV, COMMENTRESEQ, COMMENTDATE, GROUPKEY
		FROM GCOMMENT INNER JOIN (	SELECT POSTKEY 
									FROM POST 
									WHERE POSTKEY = 13)
		USING (POSTKEY)
	  ) C,  
	  (	SELECT GROUPKEY, USERKEY, GROUPNICKNAME, PROFILEFILE
	  	FROM GGROUPMEMBER
	  	WHERE USERKEY IN (	SELECT USERKEY
							FROM GCOMMENT JOIN (SELECT POSTKEY 
												FROM POST 
												WHERE POSTKEY = 13)
							USING (POSTKEY)) 
		AND GROUPKEY = 3
		) M
WHERE C.USERKEY = M.USERKEY AND C.POSTKEY = 13
ORDER BY COMMENTDATE

---------------------------------------------------------------------------------------------------
-- 샘플 데이터 추가
INSERT INTO GCOMMENT
VALUES (GCOMMENTSEQ.NEXTVAL, 13, 7, '주옥된 줄 알았으면 열심히 좀 해;', 5, 0, 0, SYSDATE, 3);

SELECT USERKEY, GROUPNICKNAME, PROFILEFILE
FROM GGROUPMEMBER JOIN (SELECT POSTKEY, USERKEY, COMMENTCONTENT 
						FROM GCOMMENT
						WHERE POSTKEY = 13)	
USING (USERKEY);

SELECT POSTKEY, USERKEY, COMMENTCONTENT 
FROM GCOMMENT
WHERE POSTKEY = 13;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 답댓 작성
-- 1단계
UPDATE GCOMMENT
SET COMMENTRESEQ = COMMENTRESEQ + 1
WHERE COMMENTREREF = #{COMMENTREREF} AND COMMENTRESEQ > #{COMMENTRESEQ}

-- 2단계
INSERT INTO GCOMMENT
VALUES (GCOMMENTSEQ.NEXTVAL, #{POSTKEY}, #{USERKEY}, #{COMMENTCONTENT}, #{COMMENTREREF}, #{COMMENTRELEV}, #{COMMENTRESEQ}, SYSDATE, #{GROUPKEY})

-- 댓글 삭제
DELETE FROM GCOMMENT
WHERE COMMENTREREF = #{COMMENTREREF}
AND COMMENTREREV >= #{COMMENTRELEV}
AND COMMENTRESEQ >= #{COMMENTRESEQ}
AND COMMENTRESEQ < (
					NVL((SELECT MIN(COMMENTRESEQ)
						 FROM GCOMMENT
						 WHERE COMMENTREREF = #{COMMENTREREF}
						 AND	COMMENTRELEV = #{COMMENTRELEV}
						 AND COMMENTRESEQ = #{COMMENTRESEQ}),
						 (SELECT MAX(COMMENTRESEQ) + 1
						 FROM GCOMMENT
						 WHERE COMMENTREREF = #{COMMENTREREF}))
					)

					
--------------------------------------------------------------------------------
-- 회원이 관심있어 할 만한 모임 
-- 페이지에서는 모임키, 모임 대표 사진, 모임명, 모임에 가입한 회원수, 모임 공개여부 보여줘야 한다.

-- CASE 1 : 현재 로그인한 회원
SELECT USERKEY
FROM GUSERS
WHERE USERID = 'foring'
-- CASE 2 : 그 회원이 관심 등록한 카테고리
SELECT CATEGORYKEY
FROM GUSERCATEGORY
WHERE USERKEY = (	SELECT USERKEY
					FROM GUSERS
					WHERE USERID = 'foring')	
-- CASE 3 : 카테고리에 해당하는 모임들의 키값, 대표사진, 모임명, 모임 공개여부
SELECT GROUPKEY, GROUPDFILE, GROUPNAME, GROUPPRIVATE
FROM GGROUP 
WHERE CATEGORYKEY IN (	SELECT CATEGORYKEY
						FROM GUSERCATEGORY
						WHERE USERKEY = (	SELECT USERKEY
											FROM GUSERS
											WHERE USERID = 'foring')
					 );

-- CASE 4 : CASE3 + 가입한 회원수
SELECT GROUPKEY, MEMBERCOUNT, GROUPDFILE, GROUPNAME, GROUPPRIVATE
FROM (	SELECT GROUPKEY, COUNT(GROUPKEY) MEMBERCOUNT
		FROM GGROUPMEMBER
		GROUP BY GROUPKEY)
	 JOIN
	 (	SELECT GROUPKEY, GROUPDFILE, GROUPNAME, GROUPPRIVATE
		FROM GGROUP 
		WHERE CATEGORYKEY IN (	SELECT CATEGORYKEY
								FROM GUSERCATEGORY
								WHERE USERKEY = 2)
	 )
USING (GROUPKEY)

-- CASE 5 : 근데 내가 가입한 모임은 제외해야 함
SELECT GROUPKEY, MEMBERCOUNT, GROUPDFILE, GROUPNAME, GROUPPRIVATE
FROM (	SELECT GROUPKEY, COUNT(GROUPKEY) MEMBERCOUNT
		FROM GGROUPMEMBER
		GROUP BY GROUPKEY)
	 JOIN
	 (	SELECT GROUPKEY, GROUPDFILE, GROUPNAME, GROUPPRIVATE
		FROM GGROUP 
		WHERE CATEGORYKEY IN (	SELECT CATEGORYKEY
								FROM GUSERCATEGORY
								WHERE USERKEY = 2)
	 )
USING (GROUPKEY)
WHERE GROUPKEY NOT IN (	SELECT GROUPKEY
						FROM GGROUPMEMBER
						WHERE USERKEY = 2)

-----------------------------------------------------------

SELECT * FROM (	SELECT ROWNUM R, C.*
				FROM (	SELECT USERKEY, POSTKEY, COMMENTCONTENT, GROUPKEY, REPLYCOUNT, POSTTITLE, TO_CHAR(COMMENTDATE, 'YYYY-MM-DD') COMMENTDATE, POSTREADCOUNT 
						FROM GCOMMENT LEFT JOIN (SELECT POSTKEY, POSTTITLE, REPLYCOUNT, POSTREADCOUNT
												 FROM POST LEFT JOIN (SELECT POSTKEY, COUNT(POSTKEY) REPLYCOUNT
											 						  FROM GCOMMENT
											 						  GROUP BY POSTKEY)
											 	 USING (POSTKEY)) 
						USING(POSTKEY)					 						  
						WHERE USERKEY = 2 AND GROUPKEY = 3
						ORDER BY COMMENTDATE DESC) C
			)
WHERE R >= 1 AND R <= 10
					 
INSERT INTO POST
VALUES(POSTSEQ.NEXTVAL, '페이지네이션 오라', '커몬', SYSDATE, 2, 3, 'Y', 'Y', 2, 0);
INSERT INTO POST
VALUES(POSTSEQ.NEXTVAL, '제발 편하게 가자', 'ㅠㅠ', SYSDATE, 2, 3, 'Y', 'Y', 2, 0);
INSERT INTO POST
VALUES(POSTSEQ.NEXTVAL, '11개가 돼버렷', '빠알리잉', SYSDATE, 2, 3, 'Y', 'Y', 2, 0);
					 
-- 글 좋아요 여부					 
SELECT COUNT(*) FROM POSTLIKE WHERE USERKEY = 1 AND GROUPKEY = 3 AND POSTKEY = 21

-- 예전 예제 참고용
SELECT * FROM 
				(SELECT ROWNUM R, B.* 
				 FROM (SELECT board_num, board_subject, board_re_ref, board_re_lev, board_re_seq, board_date 
					   FROM BOARD 
					   ORDER BY BOARD_RE_REF DESC, BOARD_RE_SEQ ASC) B) 
WHERE R >= 1 and R <= 7


-----------------------------------------------------------------------------------------
-- 댓글 테이블 
-- 원댓에 새로 답댓 달리면 그 댓글은 SEQ = 1이고 기존의 답댓들 SEQ +1 된다.  
COMMENTNUM	POSTKEY		USERKEY		COMMENTCONTENT			COMMENTREREF		COMMENTRELEV		COMMENTRESEQ		COMMENTDATE			GROUPKEY
1			15			6			댓글 쿼리 짭시다.			1					0					0					2020-02-01			3
2			14			3			머리 아프다..				2					0					0					2020-02-02			10	
3			15			17			짜기 싫어					1					1					2					2020-02-03			3
4			15			39			ㄹㅇ 하기 싫다				1					2					1					2020-02-03			3

-- 댓글 달 때 첫 번째 과정
UPDATE GCOMMENT
SET COMMENTRESEQ = COMMENTRESEQ + 1
WHERE COMMENTREREF = 1 AND COMMENTRESEQ > 0
-------------------------------------------
SELECT * FROM POSTLIKE;
POST USER GROUP		
21, 41, 3		

SELECT * FROM POST
SELECT * FROM GUSERS
SELECT * FROM GGROUPMEMBER
SELECT * FROM GCOMMENT;

-- 댓글 비밀댓글 여부 칼럼 추가
ALTER TABLE GCOMMENT ADD(commentshow NUMBER)

update GCOMMENT
set commentshow = 0

ALTER TABLE gcomment MODIFY(commentshow number not null)


SELECT * FROM 
				(SELECT ROWNUM R, B.* 
				 FROM (SELECT COMMNETNUM, COMMENTCONTENT, COMMEMTREREF, COMMENTRELEV, COMMENTRESEQ, COMMENTDATE, POSTKEY, GROUPKEY, USERKEY, COMMENTSHOW 
					   FROM GCOMMENT 
					   ORDER BY COMMEMTREREF DESC, COMMENTRESEQ ASC) B) 
WHERE R >= 1 and R <= 50

SELECT * FROM GGROUPMEMBER ORDER BY GROUPKEY, USERKEY;
SELECT count(*)
		FROM GGROUPMEMBER
		WHERE GROUPKEY = 3 AND USERGRADE = 0

SELECT * FROM GCOMMENT;
SELECT * FROM GGROUP;
SELECT * FROM GGROUPBOARD;

SELECT * FROM (	SELECT ROWNUM R, P.*
						FROM (	SELECT BOARDKEY, BOARDNAME, BOARDTYPE, POSTKEY, GROUPKEY, POSTTITLE, POSTREADCOUNT, POSTDATE
								FROM (SELECT BOARDKEY, BOARDNAME, BOARDTYPE 
									  FROM GGROUPBOARD) 
	 							JOIN 
	 								 (SELECT BOARDKEY, POSTKEY, GROUPKEY, POSTTITLE, POSTREADCOUNT, TO_CHAR(POSTDATE, 'YYYY-MM-DD') AS POSTDATE 
	 								  FROM POST
	 								  WHERE USERKEY = #{userkey} AND GROUPKEY = #{groupkey}
	  								 )
								USING (BOARDKEY)
								ORDER BY POSTDATE DESC) P
					  )

-----------------------------------------------------------------------------------------------------------------------------------------

SELECT BOARDKEY, BOARDTYPE, USERKEY, POSTKEY, COMMENTCONTENT, GROUPKEY, REPLYCOUNT, POSTTITLE, TO_CHAR(COMMENTDATE, 'YYYY-MM-DD') COMMENTDATE, POSTREADCOUNT, COMMENTSHOW 
FROM GCOMMENT LEFT JOIN (SELECT BOARDKEY, BOARDTYPE, POSTKEY, POSTTITLE, REPLYCOUNT, POSTREADCOUNT
						 FROM GGROUPBOARD JOIN (SELECT BOARDKEY, POSTKEY, POSTTITLE, REPLYCOUNT, POSTREADCOUNT
												 FROM POST LEFT JOIN (SELECT POSTKEY, COUNT(POSTKEY) REPLYCOUNT
																	  FROM GCOMMENT
																	  GROUP BY POSTKEY)
									  			 USING (POSTKEY))
						 USING (BOARDKEY)) 
USING (POSTKEY)					 						  
WHERE USERKEY = 5 AND GROUPKEY = 0
ORDER BY COMMENTDATE DESC

-----------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM POST
SELECT BOARDKEY, BOARDTYPE FROM GGROUPBOARD JOIN (SELECT BOARDKEY, POSTKEY, POTTITLE, REPLYCOUNT, POSTREADCOUNT FROM POST)
USING ()

SELECT * FROM GGROUPBOARD


SELECT * FROM (	SELECT ROWNUM R, C.*
						FROM (	SELECT BOARDKEY, BOARDTYPE, USERKEY, POSTKEY, COMMENTCONTENT, GROUPKEY, REPLYCOUNT, POSTTITLE, TO_CHAR(COMMENTDATE, 'YYYY-MM-DD') COMMENTDATE, POSTREADCOUNT, COMMENTSHOW 
								FROM GCOMMENT LEFT JOIN (SELECT BOARDKEY, BOARDTYPE, POSTKEY, POSTTITLE, REPLYCOUNT, POSTREADCOUNT
						 								 FROM GGROUPBOARD JOIN (SELECT BOARDKEY, POSTKEY, POSTTITLE, REPLYCOUNT, POSTREADCOUNT
																	 			FROM POST LEFT JOIN (SELECT POSTKEY, COUNT(POSTKEY) REPLYCOUNT
													 						  						FROM GCOMMENT
													 						  						GROUP BY POSTKEY)
													 	 						USING (POSTKEY)) 
														 USING (BOARDKEY))
								USING(POSTKEY)					 						  
						WHERE USERKEY = 0 AND GROUPKEY = 5
						ORDER BY COMMENTDATE DESC) C
					)
		WHERE R >= 1 AND R <= 10


SELECT * FROM GGROUPMEMBER WHERE USERKEY = 41
SELECT * FROM GUSERS


SELECT * FROM JOINANSWER;

DELETE JOINANSWER WHERE USERKEY = 41;





