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
                <div>이름 : <input v-model="foodName"></div>
                <div>종류 : 
                    <select v-model="menuPart">
                        <option value="10">한식</option>
                        <option value="20">중식</option>
                        <option value="30">양식</option>
                        <option value="40">음료</option>
                        <option value="50">디저트</option>
                    </select>
                </div>
                <div>설명 : <input v-model="foodInfo"></div>
                <div>가격 : <input v-model="price"></div>
                <div>이미지 : <input type="file" id="file1" name="file1" accept=".jpg, .png"></div>
                <button class="button" @click="fnAdd">상품 추가</button>
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
                foodName : "",
                menuPart : 10,
                foodInfo : "",
                price : 0
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
                let self = this;
                self.search = "";
                self.kind = "";
                self.fnList();
            },
            fnAdd(){
                let self = this;
                let param = {
                    foodName : self.foodName,
                    menuPart : self.menuPart,
                    foodInfo : self.foodInfo,
                    price : self.price
                };
                $.ajax({
                    url: "/product/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        alert("추가되었습니다!");
                        location.href="/product.do";
                        
                    }
                });
            }
        },
        mounted() {
            var self = this;
            self.fnList();
        }
    });
    app.mount('#app');
</script>