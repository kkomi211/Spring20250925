<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
        }
        .phone{
            width:40px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>
            <label v-if="!flg">아이디 : <input v-model="id"></label>
            <label v-else>아이디 : <input v-model="id" disabled></label>
            <button @click="fnIdCheck">중복 체크</button>
        </div>
        <div>
            <label>비밀번호 : <input type="password" v-model="pwd"></label>
        </div>
        <div>
            <label>비밀번호 확인 : <input type="password" v-model="pwd2"></label>
        </div>
        <div>
            <label>이름 : <input v-model="name"></label>
        </div>
        <div>
            <label>주소 : <input v-model="addr"></label><button @click="fnAddr">주소검색</button>
        </div>
        <div v-if="!joinFlg">
            핸드폰 번호 :
            <input class="phone" v-model="phone1">-
            <input class="phone" v-model="phone2">-
            <input class="phone" v-model="phone3">
        </div>
        <div v-if="!joinFlg">
            <label>문자인증 : <input v-model="inputNum" :placeholder="timer"></label>
            <template v-if="!smsFlg">
                <button @click="fnSms">인증번호 전송</button>
            </template>
            <template v-else>
                <button @click="fnSmsAuth">인증</button>
            </template>
        </div>
        <div v-else style="color: red;">
            문자인증이 완료되었습니다.
        </div>

        <div>
            성별 :
            <label><input type="radio" v-model="gender" value="M">남자 </label>
            <label><input type="radio" v-model="gender" value="F">여자</label>
        </div>
        <div>
            가입 권한 :
            <select v-model="status">
                <option value="A">관리자</option>
                <option value="S">판매자</option>
                <option value="C">소비자</option>
            </select>
        </div>
        <div>
            <button @click="fnJoin">회원가입</button>
        </div>
    </div>
</body>
</html>

<script>
    

    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            console.log(roadFullAddr);
            console.log(addrDetail);
            console.log(zipNo);
           
            window.vueObj.fnResult(roadFullAddr, addrDetail, zipNo);
        }

    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                id : "",
                pwd : "",
                pwd2 : "",
                flg : false,
                addr : "",
                inputNum : "",
                smsFlg : false,
                timer : "",
                count : 180,
                joinFlg : false, // 문자인증유무
                ranStr : "",
                phone1 : "",
                phone2 : "",
                phone3 : "",
                gender : "M",
                name : "",
                status : "A"
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnIdCheck: function () {
                let self = this;
                const idCheck = /^[a-zA-Z0-9]{5,}$/;
                if(!idCheck.test(self.id)){
                    alert("아이디는 5자 이상, 영어 대소문자, 숫자로만 이루어질수 있습니다.")
                    return;
                }
                let param = {
                    id : self.id
                };
                $.ajax({
                    url: "/member/check.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        
                        alert(data.msg);
                        if(data.result == "success"){
                            self.flg = true;
                        }
                        
                    }
                });
            },
            fnJoin: function () {
                let self = this;
                if(!self.flg){
                    alert("아이디 중복체크를 해주세요!");
                    return;
                }
                const pwdCheck = /^(?=.*[^a-zA-Z0-9]).{6,}$/;
                if(!pwdCheck.test(self.pwd)){
                    alert("비밀번호는 6자 이상, 특수문자가 하나이상 포함되어야합니다!")
                    return;
                }
                if(self.pwd != self.pwd2){
                    alert("비밀번호가 서로 다릅니다!");
                    return;
                }
                if(self.name == ""){
                    alert("이름을 입력해 주세요!");
                    return;
                }
                if(self.addr == ""){
                    alert("주소를 입력해 주세요!");
                    return;
                }
                
                if(!self.joinFlg){
                    alert("문자 인증을 해주세요");
                    return;
                }
                let param = {
                    id : self.id,
                    pwd : self.pwd,
                    name : self.name,
                    addr : self.addr,
                    phone : self.phone1 + "-" + self.phone2 + "-" + self.phone3,
                    gender : self.gender,
                    status : self.status
                };
                $.ajax({
                    url: "/member/join.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        alert("가입이 완료되었습니다");
                        location.href="/member/login.do"
                        
                    }
                });
            },
            fnAddr(){
                window.open("/addr.do", "addr", "width=500, height=500");
            },
            fnResult(roadFullAddr, addrDetail, zipNo){
                let self = this;
                self.addr = roadFullAddr;
            },
            fnSms : function(){
                let self = this;
                if(self.phone1 == "" || self.phone2 == "" || self.phone3 == ""){
                    alert("휴대폰 번호를 입력해주세요!");
                    return;
                }
                let param = {
                   
                };
                $.ajax({
                    url: "/send-one",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.res.statusCode == "2000"){
                            self.ranStr = data.ranStr;
                            alert("문자 전송 완료");
                            self.smsFlg = true;
                            self.fnTimer();
                        } else {
                            alert("잠시 후 다시 시도해주세요.");
                        }
                    }
                });
            },
            fnTimer(){
                let self = this;
                let timer = setInterval(()=>{
                    if(self.count == 0){
                        alert("시간이 만료되었습니다.");
                        clearInterval(timer);
                    } else{
                        let min = parseInt(self.count / 60);
                        let sec = self.count % 60;
                        min = min < 10 ? "0" + min : min;
                        sec = sec < 10 ? "0" + sec : sec;

                        self.timer = min + " : " + sec;


                        self.count--;
                    }
                }, 1000)
            },
            fnSmsAuth(){
                let self = this;
                if(self.inputNum == self.ranStr){
                    alert("문자 인증이 완료되었습니다.");
                    self.joinFlg = true;
                }else{
                    alert("문자 인증에 실패했습니다.");
                }
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            window.vueObj = this;
        }
    });

    app.mount('#app');
</script>