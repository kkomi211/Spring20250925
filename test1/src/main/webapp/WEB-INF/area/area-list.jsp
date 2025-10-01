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
        .active{
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>
            도/특별시 :
            <select @change="fnList" v-model="si">
                <option value="">:: 전체 ::</option>
                <option :value="list.si" v-for="list in siList">:: {{list.si}} ::</option>
            </select>
        </div>
        <div>
            <table>
                <tr>
                    <th>시</th>
                    <th>구</th>
                    <th>동</th>
                    <th>nx</th>
                    <th>ny</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.si}}</td>
                    <td>{{item.gu}}</td>
                    <td>{{item.dong}}</td>
                    <td>{{item.nx}}</td>
                    <td>{{item.ny}}</td>
                </tr>
            </table>
            <div>
                <a @click="fnMove(-10)" v-if="pageSet != 10">◀</a>
                <a v-for="num in offset" href="javascript:;" >
                    <span style="margin: 20px 15px;" :class="{active : page == num}" @click="fnPage(num)">{{num}}</span>
                </a>
                <a @click="fnMove(10)" v-if="pageSet != offset">▶</a>
            </div>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list : [],
                page : 1,
                pageSize : 20,
                offset : 0,
                pageSet : 10,
                offsetTen : 0,
                siList : [],
                si : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    pageSize : self.pageSize,
                    page : (self.page - 1) * self.pageSize,
                    si : self.si
                };
                $.ajax({
                    url: "/area/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.offset = Math.ceil(data.offset / self.pageSize);
                        self.offsetTen = Math.ceil(data.offset / 200);
                        console.log(self.offsetTen);
                        
                    }
                });
            },
            fnPage(num){
                let self = this;
                self.page = num;
                self.fnList();
            },
            fnMove(num){
                let self = this;
                if(self.pageSet + num > self.offset){
                    let cnt = self.offset - self.pageSet;
                    self.pageSet += cnt;
                    self.fnPage(self.pageSet - 9);
                } else{
                    self.pageSet = self.pageSet + num;
                    self.fnPage(self.pageSet - 9);
                }
            },
            fnSiList: function () {
                let self = this;
                let param = {
                    
                };
                $.ajax({
                    url: "/area/si.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.siList = data.list;
                        
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
            self.fnSiList();
        }
    });

    app.mount('#app');
</script>