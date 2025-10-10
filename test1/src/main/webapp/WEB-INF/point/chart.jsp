<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
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
    
    <div id="chart">
    </div>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>
            <table>
                <tr>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>주소</th>
                    <th>성별</th>
                    <th>잔여포인트</th>
                    <th>최근사용날짜</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.name}}</td>
                    <td>{{item.userId}}</td>
                    <td>{{item.address}}</td>
                    <td>{{item.gender}}</td>
                    <td>{{item.aPoint}}</td>
                    <td>{{item.cDate}}</td>
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
                list : [],
                point : [],
                name : []
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/point/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data.list);
                        self.list = data.list;

                        self.point = data.list.map(item => item.aPoint);
                        self.name = data.list.map(item => item.name);

                        var options = {
                            series: [{
                            name: '잔여포인트',
                            data: self.point
                            }],
                            chart: {
                            width: 600,
                            height: 350,
                            type: 'bar',
                            },
                            plotOptions: {
                            bar: {
                                borderRadius: 10,
                                dataLabels: {
                                position: 'top', // top, center, bottom
                                },
                            }
                            },
                            dataLabels: {
                            enabled: true,
                            formatter: function (val) {
                                return val;
                            },
                            offsetY: -20,
                            style: {
                                fontSize: '12px',
                                colors: ["#304758"]
                            }
                            },
                            
                            xaxis: {
                            categories: self.name,
                            position: 'bottom',
                            axisBorder: {
                                show: false
                            },
                            axisTicks: {
                                show: false
                            },
                            crosshairs: {
                                fill: {
                                type: 'gradient',
                                gradient: {
                                    colorFrom: '#D8E3F0',
                                    colorTo: '#BED1E6',
                                    stops: [0, 100],
                                    opacityFrom: 0.4,
                                    opacityTo: 0.5,
                                }
                                }
                            },
                            tooltip: {
                                enabled: true,
                            }
                            },
                            yaxis: {
                            axisBorder: {
                                show: false
                            },
                            axisTicks: {
                                show: false,
                            },
                            labels: {
                                show: false,
                                formatter: function (val) {
                                return val;
                                }
                            }
                            
                            },
                            title: {
                            text: '잔여포인트',
                            floating: true,
                            offsetY: 0,
                            align: 'center',
                            style: {
                                color: '#444'
                            }
                            }
                            };

                            var chart = new ApexCharts(document.querySelector("#chart"), options);
                            chart.render();
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