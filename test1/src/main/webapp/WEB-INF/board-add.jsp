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
        td input{
            width: 300px;
        }
        td textarea{
            width: 300px;
            height: 300px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            <table>
                <tr>
                    <th>제목</th>
                    <td><input v-model="title" type="text"></td>                    
                </tr>
                <tr>
                    <th>작성자</th>
                    <td><input v-model="userId" type="text"></td>                    
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea v-model="contents"></textarea></td>                    
                </tr>
            </table>
         </div>
         <button @click="fnAdd">작성</button>
         <button @click="fnBack">돌아가기</button>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                title : "",
                userId : "",
                contents : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAdd: function () {
                let self = this;
                let param = {
                    title : self.title,
                    userId : self.userId,
                    contents : self.contents
                };
                $.ajax({
                    url: "board-insert.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("작성이 완료되었습니다!");
                        self.fnBack();
                    }
                });
            },
            fnBack(){
                location.href="board-list.do"
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>