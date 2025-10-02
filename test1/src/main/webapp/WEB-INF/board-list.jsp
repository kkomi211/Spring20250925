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
        .index{
            margin: 0px 20px;
        }
        #app{
            text-align: center;
        }
        .active{
            color: black;
            font-weight: bold;
        }
        .cursor{
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>
            <select v-model="pageSize" @change="fnList">
                <option value="5">5개씩</option>
                <option value="10">10개씩</option>
                <option value="15">15개씩</option>
            </select>
            <select v-model="kind" @change="fnList">
                <option value="">:: 전체 ::</option>
                <option value="1">:: 공지사항 ::</option>
                <option value="2">:: 자유게시판 ::</option>
                <option value="3">:: 문의게시판 ::</option>
            </select>
            <select v-model="order" @change="fnList">
                <option value="1">:: 번호순 ::</option>
                <option value="2">:: 제목순 ::</option>
                <option value="3">:: 조회수 ::</option>
                <option value="4">:: 최신순 ::</option>
            </select>
        </div>
        <div>
			<table style="margin: 0px auto;">
				<tr>
                    <th><input type="checkbox" @click="fnAllCheck"></th>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
					<th>삭제</th>
				</tr>
				<tr v-for="item in list">
                    <td><input type="checkbox" v-model="selectItem" :value="item.boardNo"></td>
					<td>{{item.boardNo}}</td>
					<td>
                        <a href="javascript:;" @click="fnView(item.boardNo)">{{item.title}}</a>
                        <span v-if="item.commentCnt != 0" style="color:red;"> [{{item.commentCnt}}]</span>
                    </td>
					<td>{{item.userId}}</td>
					<td>{{item.cnt}}</td>
					<td>{{item.cdate}}</td>
                    <td><button v-if="item.userId == sessionId || status == 'A'" @click="fnDelete(item.boardNo)">삭제</button></td>
				</tr>
			</table>
            <div>
                <a @click="fnPage('-')" class="cursor" v-if="page != 1">◀</a>
                <a href="javascript:;" v-for="num in index" class="index" @click="fnPage(num)">
                    <span :class="{active : page == num}">{{num}}</span>
                    <!-- <span v-if="num == page" class="active">{{num}}</span>
                    <span v-else>{{num}}</span> -->
                </a>
                <a @click="fnPage('+')" class="cursor" v-if="page != index">▶</a>
            </div>
		</div>
        <button @click="fnAdd">글 작성하기</button>
        <button @click="fnDeleteList">삭제하기</button>
            
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list : [],
                kind : "",
                order : 4,
                sessionId : "${sessionId}",
                sessionName : "${sessionName}",
                status : "${status}",
                pageSize : 5, // 한페이지에 출력할 개수
                page : 1, // 현재 페이지 
                index : 0, // 전체 페이지
                selectItem : [],
                selectFlg : false
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    kind : self.kind,
                    order : self.order,
                    pageSize : self.pageSize,
                    page : self.pageSize * (self.page - 1)
                };
                $.ajax({
                    url: "board-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.index = Math.ceil(data.cnt / self.pageSize);
                    }
                });
            },
            fnDelete(boardNo){
                let self = this;
                let param = {
                    boardNo : boardNo
                };
                $.ajax({
                    url: "board-delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제되었습니다!");
                        self.fnList();
                    }
                });
            },
            fnAdd(){
                location.href="board-add.do"
            },
            fnView(boardNo){
                pageChange("board-view.do", {boardNo : boardNo});
            },
            fnPage(page){
                let self = this;
                if(page == "+"){
                    if(self.page + 1 > self.index){
                        return;
                    }
                    self.page++;
                    self.fnList();
                } else if(page == "-"){
                    if(self.page - 1 == 0){
                        return;
                    }
                    self.page--;
                    self.fnList();
                } else {
                    let self = this;
                    self.page = page;
                    self.fnList();
                }
            },
            fnAllCheck(){
                let self = this;
                self.selectFlg = !self.selectFlg;
                if(self.selectFlg){
                    self.selectItem = [];
                    for(let i = 0; i < self.list.length; i++){
                        self.selectItem.push(self.list[i].boardNo);
                    }
                } else{
                    self.selectItem = [];
                }
            },
            fnDeleteList(){
                let self = this;
                console.log(self.selectItem);
                var fList = JSON.stringify(self.selectItem);
                var param = {selectItem : fList};
                
                $.ajax({
                    url: "/board/delete/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제되었습니다!");
                        self.fnList();
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
        }
    });

    app.mount('#app');
</script>