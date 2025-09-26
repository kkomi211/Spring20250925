<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
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
            width: 500px;
        }
        textarea {
            width: 500px;
            height: 500px;
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
                    <td><input v-model="info.title"></td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>{{info.userId}}</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td>{{info.cdate}}</td>
                </tr>
                <tr>
                    <th>조회수</th>
                    <td>{{info.cnt}}</td>
                </tr>
                <tr>
                    <th>좋아요 수</th>
                    <td>{{info.favorite}}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea v-model="info.contents"></textarea></td>
                </tr>
            </table>
        </div>
        <button @click="fnEdit">수정하기</button>
        <button @click="fnBack">돌아가기</button>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                test : "${test}",
                boardNo : "${boardNo}",
                info : {}
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = {
                    boardNo : self.boardNo
                };
                $.ajax({
                    url: "board-view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.info = data.info;
                        
                        
                    }
                });
            },
            fnBack(){
                let self = this;
                pageChange("board-view.do", {boardNo : self.boardNo});
            },
            fnEdit(){
                let self = this;
                let param = {
                    title : self.info.title,
                    contents : self.info.contents,
                    boardNo : self.boardNo
                };
                $.ajax({
                    url: "board-edit.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("수정되었어요!");
                        self.fnBack()
                        
                        
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>