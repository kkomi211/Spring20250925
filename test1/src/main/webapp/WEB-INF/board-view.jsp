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
        
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>
            <table>
                <tr>
                    <th>제목</th>
                    <td>{{info.title}}</td>
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
                    <td>
                        <img v-for="item in fileList" :src="item.filePath">
                        <br>
                        <div v-html="info.contents">

                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <button @click="fnEdit">수정하기</button>
        <button @click="fnBack">돌아가기</button>
        <div>
            <table>
                <tr v-for="item in commentList">
                    <th>{{item.userId}}</th>
                    <td>{{item.contents}}</td>
                    <td><button v-if="item.userId == sessionId || status == 'A'" @click="fnDeleteComment">삭제</button></td>
                    <td><button v-if="item.userId == sessionId || status == 'A'" @click="fnEditComment">수정</button></td>
                </tr>
            </table>
        </div>
        <div v-if="sessionId != ''">
            <table>
                <tr>
                    <th>{{sessionId}}</th>
                    <td><input v-model="comment" style="width: 500px;"></td>
                    <td><button @click="fnAddComment">댓글 작성하기</button></td>
                </tr>
                <tr>

                </tr>
            </table>
        </div>
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
                sessionId : "${sessionId}",
                sessionName : "${sessionName}",
                status : "${status}",
                info : {},
                comment : "",
                commentList : [],
                fileList : []
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
                        self.fileList = data.fileList;
                        
                        
                    }
                });
            },
            fnBack(){
                location.href="board-list.do";
            },
            fnEdit(){
                let self = this;
                pageChange("board-edit.do", {boardNo : self.boardNo});
            },
            fnAddComment(){
                let self = this;
                let param = {
                    boardNo : self.boardNo,
                    userId : self.sessionId,
                    contents : self.comment
                };
                $.ajax({
                    url: "add-comment.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        alert("댓글이 작성되었습니다.")
                        self.comment = "";
                        self.fnComment();
                        
                        
                    }
                });
            },
            fnComment(){
                let self = this;
                let param = {
                    boardNo : self.boardNo
                };
                $.ajax({
                    url: "board-comment.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data.list);
                        self.commentList = data.list;
                        
                        
                    }
                });
            },
            fnCntUp(){
                let self = this;
                let param = {
                    boardNo : self.boardNo
                };
                $.ajax({
                    url: "board-cnt.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.fnInfo();
                        
                        
                    }
                });
            },
            fnDeleteComment(){
                let self = this;
                let param = {
                    commentNo : self.commentNo
                };
                $.ajax({
                    url: "comment-delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.fnInfo();
                        self.fnComment();
                        
                        
                    }
                });
            },
            fnEditComment(){
                
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnCntUp();
            
            self.fnComment();
        }
    });

    app.mount('#app');
</script>