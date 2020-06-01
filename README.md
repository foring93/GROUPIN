# GROUPIN
모임 커뮤니티 서비스
지역별, 나이대별로 공통 관심사를 가진 사람들과 소모임을 편리하게 만들 수 있는 사이트. 
사용자의 관심사를 통해 추천 소모임도 알려준다.

## 기여한 역할
- 모임 회원 가입
- 모임 회원 가입양식 설정
- 모임 회원 관리
- 모임 회원 상세 정보 조회
- 게시글 상세 페이지
- 게시글의 댓글 

### 모임에 가입되지 않은 경우
**1. 우측 상단의 가입하기 버튼** 

![1  가입](https://user-images.githubusercontent.com/44693915/83006510-4ba12780-a04d-11ea-90e8-808bcdeddd90.png)


**2. 비회원의 모임 후기 게시판 접근 불가 (가입 승인 전인 회원도 접근 불가)**

![image](https://user-images.githubusercontent.com/44693915/83407912-ab803f80-a44c-11ea-8b8c-484fc6b80864.png)

![image](https://user-images.githubusercontent.com/44693915/83408037-e71b0980-a44c-11ea-99c9-bf1a2eba0033.png)


### 모임에 가입하기
**1. 모임장이 지정한 가입양식이 띄워진다.**

![가입 닉네임 유효성검사](https://user-images.githubusercontent.com/44693915/83409310-264a5a00-a44f-11ea-88ee-ac2553586719.png)


**2. 닉네임은 기존 회원의 닉네임과 중복되지 않고 지정된 형식과 맞춰야만 가입이 완료된다.**

![주석 2020-06-01 220403](https://user-images.githubusercontent.com/44693915/83411766-d752f380-a453-11ea-90fd-534132fbee07.png)


### 모임 회원 가입 설정
**1. 가입양식 수정 전**

![가입양식 수정 완료 전](https://user-images.githubusercontent.com/44693915/83413368-ab853d00-a456-11ea-8ef6-57d186fa3120.png)


**2. 가입양식 수정 후**

![image](https://user-images.githubusercontent.com/44693915/83413265-85f83380-a456-11ea-939d-b14fdb56e268.png)


### 모임 회원 관리
**1. 가입 승인 된 일반 회원 리스트**

![image](https://user-images.githubusercontent.com/44693915/83413473-d7a0be00-a456-11ea-8f47-f7a67cc16644.png)

* *강제 탈퇴 시 회원 목록에서 ajax를 통해 즉시 삭제된 모습이 반영되며, 회원은 가입하지 않은 것처럼 탈퇴당한다.*

* *회원 강등 시 회원 목록에서 ajax를 통해 즉시 삭제된 모습이 반영되며, 회원은 가입 요청 목록으로 옮겨진다. (가입 승인 대기 상태)*


**2. 가입 승인 전 대기 회원 리스트**

![image](https://user-images.githubusercontent.com/44693915/83413507-e5eeda00-a456-11ea-89e8-8695a7d1b80c.png)

* *요청 거절 시 가입 요청 목록에서 ajax를 통해 즉시 삭제된 모습이 반영되며, 회원은 가입하지 않은 것처럼 탈퇴당한다.*

* *가입 승인 시 가입 요청 목록에서 ajax를 통해 즉시 삭제된 모습이 반영되며, 회원은 회원 목록으로 옮겨진다. (일반회원 상태)*


### 모임 회원 상세정보 조회
**1. 회원의 가입한 모임 조회** 

![image](https://user-images.githubusercontent.com/44693915/83414904-35cea080-a459-11ea-805c-80bfcf059a89.png)
* *모임 클릭 시 해당 모임 페이지로 이동한다.*


**2. 회원의 현재 모임에서 작성한 글 조회**

![image](https://user-images.githubusercontent.com/44693915/83414956-48e17080-a459-11ea-877f-bbb218cada58.png)
* *클릭 시 해당 게시글로 이동한다.*


**3. 회원의 현재 모임에서 작성한 댓글 조회**

![image](https://user-images.githubusercontent.com/44693915/83414996-5860b980-a459-11ea-8aec-4ff668b0b552.png)
* *클릭 시 해당 작성댓글이 달린 게시글로 이동한다.*


**4. 회원의 가입 양식 조회**

![image](https://user-images.githubusercontent.com/44693915/83415029-67e00280-a459-11ea-826f-2de9e67c5ebe.png)
* *회원 본인과 모임장이 아닌 경우 해당 작성한 가입양식 탭을 볼 수 없다.*


### 게시글 상세 페이지
![image](https://user-images.githubusercontent.com/44693915/83415605-4895a500-a45a-11ea-8408-74bc4b37a708.png)

* *댓글의 수정/삭제 아이콘은 본인일 경우에만 보인다.*
* *좋아요 는 클릭 시 ajax로 페이지 이동 없이 즉각 반영되어 변한다. (취소의 경우와 동일하다.)*

### 게시글의 댓글 
**1. 댓글 등록**

![image](https://user-images.githubusercontent.com/44693915/83415974-f30dc800-a45a-11ea-8b15-a8b54fd822bc.png)

![image](https://user-images.githubusercontent.com/44693915/83416054-10429680-a45b-11ea-94d2-d683130a3551.png)

* *ajax를 통해 페이지 이동 없이 등록한 댓글을 업데이트 한다.*


**2. 댓글 수정**

![image](https://user-images.githubusercontent.com/44693915/83416380-89da8480-a45b-11ea-93db-c74318d38a0e.png)

* *수정 버튼 클릭 시 댓글의 내용이 댓글창에 띄워진다.*

![image](https://user-images.githubusercontent.com/44693915/83416437-9c54be00-a45b-11ea-9f67-1e92b6b8b786.png)

* *댓글창에서 댓글 수정*

![image](https://user-images.githubusercontent.com/44693915/83416474-ac6c9d80-a45b-11ea-9120-139eabcbbd52.png)

* *ajax를 통해 페이지 이동 없이 수정된 댓글을 업데이트 한다.*


**3. 댓글 삭제** 

![image](https://user-images.githubusercontent.com/44693915/83416934-619f5580-a45c-11ea-8355-c0dd1e74d679.png)

* *삭제 버튼 클릭 시 확인창이 띄워진다.*

![image](https://user-images.githubusercontent.com/44693915/83416959-66fca000-a45c-11ea-82c8-82878fcb6b4b.png)

* *확인 버튼 클릭 시 댓글을 삭제, 취소 버튼 클릭 시 기존 화면이 보여진다.*

![image](https://user-images.githubusercontent.com/44693915/83416989-724fcb80-a45c-11ea-8468-15c0b4d55cd4.png)

* *ajax를 통해 페이지 이동 없이 삭제된 후의 댓글 리스트를 가져온다.*


**4. 답글 달기**

![image](https://user-images.githubusercontent.com/44693915/83417471-19346780-a45d-11ea-8689-93d8f15bd191.png)

* *댓글에 답글 버튼 클릭 시 댓글창에 포커스가 간다.*

![image](https://user-images.githubusercontent.com/44693915/83417523-2baea100-a45d-11ea-97bc-647e6ba62563.png)

* *ajax를 통해 페이지 이동 없이 답글을 업데이트 한다.*
