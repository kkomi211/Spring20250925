<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
        <style>
            table,
            tr,
            td,
            th {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
                text-align: center;
            }

            th {
                background-color: beige;
            }

            tr:nth-child(even) {
                background-color: azure;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div v-if="!authFlg">
                <div>
                    <label>아이디 : <input v-model="userId"></label>
                </div>
                <div>
                    <label>이름 : <input v-model="name"></label>
                </div>
                <div>
                    <label>번호 : <input v-model="phone" placeholder="-를 제외하고 입력해주세요."></label>
                </div>
                <div>
                    <button @click="fnAuth">인증</button>
                </div>
            </div>

            <div v-else>
                <div>
                    <label>비밀번호 : <input v-model="pwd" type="password"></label>
                </div>
                <div>
                    <label>비밀번호 확인 : <input v-model="pwd2" type="password"></label>
                </div>
                <div>
                    <button @click="fnEditPwd">비밀번호 수정</button>
                </div>
            </div>

        </div>
    </body>

    </html>

    <script>
        IMP.init("imp28215630");
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    authFlg: false,
                    userId: "",
                    name: "",
                    phone: "",
                    pwd: "",
                    pwd2: "",
                    authPwd : ""
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnAuth: function () {
                    let self = this;
                    console.log("공백 제거 전 ==> ", self.userId);
                    console.log("공백 제거 후 ==> ", self.userId.trim());



                    let param = {
                        id: self.userId.trim(),
                        name: self.name.trim(),
                        phone: self.phone.trim()
                    };
                    $.ajax({
                        url: "/member/auth.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.result == "fail") {
                                alert("회원 정보를 확인해주세요")
                            } else {
                                alert("안증되었습니다!");
                                self.fnCertification();
                                self.authPwd = data.info.password;
                                
                            }

                        }
                    });
                },
                fnEditPwd() {
                    let self = this;
                    if (self.pwd != self.pwd2) {
                        alert("비밀번호가 서로 다릅니다!");
                        return;
                    }
                    let param = {
                        id: self.userId,
                        pwd: self.pwd
                    };
                    $.ajax({
                        url: "/member/edit/pwd.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.result == "success") {
                                alert("수정되었습니다!");
                                location.href = "/member/login.do";
                            } else if(data.result == "fail") {
                                alert("오류났어요");
                            } else if(data.result == "same"){
                                alert("비밀번호가 이전과 동일합니다~!");
                            }
                        }
                    });
                },
                fnCertification() {
                    // IMP.certification(param, callback) 호출
                    let self = this;
                    IMP.certification(
                        {
                            // param
                            channelKey: "channel-key-0600b0c4-eef0-4a27-9085-b2a0b0a8af8e",
                            merchant_uid: "merchant_" + new Date().getTime() // 주문 번호
                        },
                        function (rsp) {
                            // callback
                            if (rsp.success) {
                            // 인증 성공 시 로직
                                alert("인증 성공!");
                                console.log(rsp);
                                self.authFlg = true;
                            } else {
                            // 인증 실패 시 로직
                                alert("인증 실패!");
                                console.log(rsp);
                            }
                        },
                    );
                }

            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
            }
        });

        app.mount('#app');
    </script>