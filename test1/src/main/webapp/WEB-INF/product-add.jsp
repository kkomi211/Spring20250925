<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>상품 추가</title>
    <link rel="stylesheet" href="/css/product-style.css">
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
        table {
            margin: 0px auto;
        }
    </style>
</head>

<body>
    <div id="app">
        <header>
            <div class="logo">
                <img src="/img/logo.png" alt="쇼핑몰 로고" @click="fnMain" style="cursor: pointer;">
            </div>

            <nav>
                <ul>
                    <li class="dropdown" v-for="item in menuList">
                        <a href="#" v-if="item.depth == 1" @click="fnKind(item.menuNo)">{{item.menuName}}</a>
                        <ul class="dropdown-menu" v-if="item.cnt > 0">
                            <li v-for="subItem in menuList">
                                <a href="#" v-if="subItem.menuPart == item.menuNo" @click="fnKind(subItem.menuNo)">{{subItem.menuName}}</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div class="search-bar">
                <input type="text" @keyup.enter="fnList" placeholder="상품을 검색하세요..." v-model="search">
                <button @click="fnList">검색</button>
            </div>
            <div class="login-btn">
                <button @click="fnLogin">로그인</button>
            </div>
        </header>

        <main>
            <div class="product-item">
                <table>
                    <tr>
                        <th>카테고리</th>
                        <td>
                            <select v-model="menuPart">
                                <option v-for="item in menu" :value="item.menuNo">{{item.menuName}}</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>제품번호</th>
                        <td><input v-model="menuNo"></td>
                    </tr>
                    <tr>
                        <th>음식이름</th>
                        <td><input v-model="foodName"></td>
                    </tr>
                    <tr>
                        <th>음식설명</th>
                        <td>
                            <textarea v-model="foodInfo" cols="25" rows="5"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th>가격</th>
                        <td><input v-model="price"></td>
                    </tr>
                    <tr>
                        <th>이미지</th>
                        <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td>
                    </tr>
                </table>
                <button class="button" @click="fnAdd">제품 등록</button>
            </div>
        </main>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list : [],
                search : "",
                kind : "",
                menuList : [],
                menuPart : 10,
                menuNo : "",
                foodName : "",
                foodInfo : "",
                price : 0,
                menu : []
            };
        },
        methods: {
            fnLogin() {
                location.href="/product/login.do";
            },
            fnList() {
                let self = this;
                let param = {
                    search : self.search,
                    kind : self.kind
                };
                $.ajax({
                    url: "/product/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        console.log(self.list);
                        self.menuList = data.menuList;
                    }
                });
            },
            fnKind(kind){
                let self = this;
                self.kind = kind;
                self.fnList();
            },
            fnMain(){
                location.href="/product.do";
            },
            fnAdd(){
                let self = this;
                let param = {
                    foodName : self.foodName,
                    menuPart : self.menuPart,
                    foodInfo : self.foodInfo,
                    price : self.price,
                    menuNo : self.menuNo
                };
                $.ajax({
                    url: "/product/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        alert("추가되었습니다!");
                        var form = new FormData();
                        form.append( "file1",  $("#file1")[0].files[0] );
                        form.append( "foodNo",  data.foodNo); // 임시 pk
                        self.upload(form);
                        self.fnMain();
                        
                    }
                });
            },
            fnMenuList(){
                let self = this;
                let param = {
                    depth : 1
                };
                $.ajax({
                    url: "/product/menu.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.menu = data.menuList;
                    }
                });
            },
            upload : function(form){
                var self = this;
                $.ajax({
                    url : "/food/fileUpload.dox"
                , type : "POST"
                , processData : false
                , contentType : false
                , data : form
                , success:function(data) { 
                    console.log(data);
                    
                }	           
                });
            }
        },
        mounted() {
            var self = this;
            self.fnList();
            self.fnMenuList();
        }
    });
    app.mount('#app');
</script>