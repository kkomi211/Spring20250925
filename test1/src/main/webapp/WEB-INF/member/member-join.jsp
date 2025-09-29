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
            <label>주소 : <input v-model="addr"></label><button @click="fnAddr">주소검색</button>
        </div>
        <div>
            <label>문자인증 : <input v-model="inputNum" :placeholder="timer"></label>
            <template v-if="!smsFlg">
                <button @click="fnSms">인증번호 전송</button>
            </template>
            <template v-else>
                <button>인증</button>
            </template>
        </div>
        <div>
            {{timer}}
            <button @click="fnTimer">시작!</button>
        </div>
        <button @click="fnJoin">회원가입</button>
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
                flg : false,
                addr : "",
                inputNum : "",
                smsFlg : false,
                timer : 180
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnIdCheck: function () {
                let self = this;
                const idCheck = /^(?=.*[a-z0-9])[a-z0-9]{3,16}$/;
                if(!idCheck.test(self.id)){
                    alert("아이디는 3자 이상 16자 이하, 영어 또는 숫자로 구성해야합니다.")
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
                const pwdCheck = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{6,16}$/;
                if(!pwdCheck.test(self.pwd)){
                    alert("비밀번호는 6자 이상 16자 이하, 영어와 숫자의 조합으로 구성해야합니다.")
                    return;
                }
                let param = {
                    id : self.id,
                    pwd : self.pwd
                };
                $.ajax({
                    url: "/member/join.dox",
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
            fnAddr(){
                window.open("/addr.do", "addr", "width=500, height=500");
            },
            fnResult(roadFullAddr, addrDetail, zipNo){
                let self = this;
                self.addr = roadFullAddr;
            },
            fnSms : function(){
                let self = this;
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
                    if(self.timer == 0){
                        alert("시간이 만료되었습니다.");
                        clearInterval(timer);
                    } else{
                        self.timer--;
                    }
                }, 1000)
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