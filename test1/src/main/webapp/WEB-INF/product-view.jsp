<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <title>상세 보기</title>
        <link rel="stylesheet" href="/css/product-style.css">
        <script src="/js/page-change.js"></script>
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

            table{
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
                                    <a href="#" v-if="subItem.menuPart == item.menuNo"
                                        @click="fnKind(subItem.menuNo)">{{subItem.menuName}}</a>
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
                            <th>사진</th>
                            <td><img :src="list.filePath"></td>
                        </tr>
                        <tr>
                            <th>이름</th>
                            <td>{{list.foodName}}</td>
                        </tr>
                        <tr>
                            <th>종류</th>
                            <td>{{list.foodKind}}</td>
                        </tr>
                        <tr>
                            <th>설명</th>
                            <td>{{list.foodInfo}}</td>
                        </tr>
                        <tr>
                            <th>가격</th>
                            <td>￦{{list.val}}</td>
                        </tr>
                        <tr>
                            <th>상태</th>
                            <td v-if="list.sellYN == 'Y'">구매 가능</td>
                            <td v-else>구매 불가</td>
                        </tr>
                    </table>
                </div>
                <button class="button" @click="fnMain">돌아가기</button>

            </main>

        </div>
    </body>

    </html>
    <script>
        const app = Vue.createApp({
            data() {
                return {
                    list: {},
                    search: "",
                    kind: "",
                    menuList: [],
                    foodNo: "${foodNo}"
                };
            },
            methods: {
                fnLogin() {
                    location.href = "/product/login.do";
                },
                fnList() {
                    let self = this;
                    let param = {
                        search: self.search,
                        kind: self.kind,
                        foodNo: self.foodNo
                    };
                    $.ajax({
                        url: "/product/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.list = data.list[0];
                            console.log(self.list);
                            self.menuList = data.menuList;
                        }
                    });
                },
                fnKind(kind) {
                    let self = this;
                    self.kind = kind;
                    self.fnList();
                },
                fnMain() {
                    location.href = "/product.do"
                }
            },
            mounted() {
                var self = this;
                self.fnList();
            }
        });
        app.mount('#app');
    </script>