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
        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f8ef3ce1378d4e3abf5c248cf559c71d&libraries=services"></script>
        <style>
            .map_wrap,
            .map_wrap * {
                margin: 0;
                padding: 0;
                font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
                font-size: 12px;
            }

            .map_wrap a,
            .map_wrap a:hover,
            .map_wrap a:active {
                color: #000;
                text-decoration: none;
            }

            .map_wrap {
                position: relative;
                width: 100%;
                height: 500px;
            }

            #menu_wrap {
                position: absolute;
                top: 0;
                left: 0;
                bottom: 0;
                width: 250px;
                margin: 10px 0 30px 10px;
                padding: 5px;
                overflow-y: auto;
                background: rgba(255, 255, 255, 0.7);
                z-index: 1;
                font-size: 12px;
                border-radius: 10px;
            }

            .bg_white {
                background: #fff;
            }

            #menu_wrap hr {
                display: block;
                height: 1px;
                border: 0;
                border-top: 2px solid #5F5F5F;
                margin: 3px 0;
            }

            #menu_wrap .option {
                text-align: center;
            }

            #menu_wrap .option p {
                margin: 10px 0;
            }

            #menu_wrap .option button {
                margin-left: 5px;
            }

            #placesList li {
                list-style: none;
            }

            #placesList .item {
                position: relative;
                border-bottom: 1px solid #888;
                overflow: hidden;
                cursor: pointer;
                min-height: 65px;
            }

            #placesList .item span {
                display: block;
                margin-top: 4px;
            }

            #placesList .item h5,
            #placesList .item .info {
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            #placesList .item .info {
                padding: 10px 0 10px 55px;
            }

            #placesList .info .gray {
                color: #8a8a8a;
            }

            #placesList .info .jibun {
                padding-left: 26px;
                background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
            }

            #placesList .info .tel {
                color: #009900;
            }

            #placesList .item .markerbg {
                float: left;
                position: absolute;
                width: 36px;
                height: 37px;
                margin: 10px 0 0 10px;
                background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
            }

            #placesList .item .marker_1 {
                background-position: 0 -10px;
            }

            #placesList .item .marker_2 {
                background-position: 0 -56px;
            }

            #placesList .item .marker_3 {
                background-position: 0 -102px
            }

            #placesList .item .marker_4 {
                background-position: 0 -148px;
            }

            #placesList .item .marker_5 {
                background-position: 0 -194px;
            }

            #placesList .item .marker_6 {
                background-position: 0 -240px;
            }

            #placesList .item .marker_7 {
                background-position: 0 -286px;
            }

            #placesList .item .marker_8 {
                background-position: 0 -332px;
            }

            #placesList .item .marker_9 {
                background-position: 0 -378px;
            }

            #placesList .item .marker_10 {
                background-position: 0 -423px;
            }

            #placesList .item .marker_11 {
                background-position: 0 -470px;
            }

            #placesList .item .marker_12 {
                background-position: 0 -516px;
            }

            #placesList .item .marker_13 {
                background-position: 0 -562px;
            }

            #placesList .item .marker_14 {
                background-position: 0 -608px;
            }

            #placesList .item .marker_15 {
                background-position: 0 -654px;
            }

            #pagination {
                margin: 10px auto;
                text-align: center;
            }

            #pagination a {
                display: inline-block;
                margin-right: 10px;
            }

            #pagination .on {
                font-weight: bold;
                cursor: default;
                color: #777;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <select style="margin-bottom : 20px; padding:5px">
                <option value="">:: 선택 ::</option>
                <option value="MT1">대형마트</option>
                <option value="CS2">편의점</option>
                <option value="PS3">어린이집, 유치원</option>
                <option value="SC4">학교</option>
                <option value="AC5">학원</option>
                <option value="PK6">주차장</option>
                <option value="OL7">주유소, 충전소</option>
                <option value="SW8">지하철역</option>
                <option value="BK9">은행</option>
                <option value="CT1">문화시설</option>
                <option value="AG2">중개업소</option>
                <option value="PO3">공공기관</option>
                <option value="AT4">관광명소</option>
                <option value="AD5">숙박</option>
                <option value="FD6">음식점</option>
                <option value="CE7">카페</option>
                <option value="HP8">병원</option>
                <option value="PM9">약국</option>
            </select>
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div class="map_wrap">
                <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

                <div id="menu_wrap" class="bg_white">
                    
                    <div class="option">
                        <div>
                            <form onsubmit="searchPlaces(); return false;">
                                키워드 : <input type="text" value="이태원 맛집" id="keyword" size="15">
                                <button type="submit">검색하기</button>
                            </form>
                        </div>
                    </div>
                    <hr>
                    <ul id="placesList"></ul>
                    <div id="pagination"></div>
                </div>
            </div>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    map: null,
                    ps: null,
                    infowindow: null,
                    placeOverlay: null,
                    contentNode: null,
                    markers: [],
                    currCategory: '',
                    mapContainer: null,
                    mapOption: null
                };
            },
            methods: {
                // 공통 유틸
                addEventHandle(target, type, callback) {
                    if (target.addEventListener) target.addEventListener(type, callback);
                    else target.attachEvent('on' + type, callback);
                },

                // ===== 카테고리 검색 =====
                searchByCategory() {
                    if (!this.currCategory) return;

                    this.placeOverlay.setMap(null);   // 커스텀 오버레이 숨김
                    this.removeMarker();               // 기존 마커 제거

                    this.ps.categorySearch(
                        this.currCategory,
                        this.placesSearchCB,
                        { useMapBounds: true }
                    );
                },

                // ===== 키워드 검색 (폼 submit 연동) =====
                searchByKeyword() {
                    const keyword = document.getElementById('keyword').value;
                    if (!keyword.replace(/^\s+|\s+$/g, '')) {
                        alert('키워드를 입력해주세요!');
                        return false;
                    }
                    this.ps.keywordSearch(keyword, this.placesSearchCB);
                },

                // 검색 콜백
                placesSearchCB(data, status, pagination) {
                    if (status === kakao.maps.services.Status.OK) {
                        this.displayPlaces(data);
                        this.displayPagination(pagination);
                    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                        alert('검색 결과가 존재하지 않습니다.');
                    } else if (status === kakao.maps.services.Status.ERROR) {
                        alert('검색 결과 중 오류가 발생했습니다.');
                    }
                },

                // 결과 표시 (마커 + 리스트)
                displayPlaces(places) {
                    const listEl = document.getElementById('placesList');
                    const menuEl = document.getElementById('menu_wrap');
                    const fragment = document.createDocumentFragment();
                    const bounds = new kakao.maps.LatLngBounds();

                    this.removeAllChildNodes(listEl); // 리스트 비우기
                    this.removeMarker();              // 기존 마커 제거

                    for (let i = 0; i < places.length; i++) {
                        const placePosition = new kakao.maps.LatLng(places[i].y, places[i].x);
                        const marker = this.addMarker(placePosition, i);
                        const itemEl = this.getListItem(i, places[i]);

                        bounds.extend(placePosition);

                        ((marker, title, vm = this) => {
                            kakao.maps.event.addListener(marker, 'mouseover', function () {
                                vm.displayInfowindow(marker, title);
                            });
                            kakao.maps.event.addListener(marker, 'mouseout', function () {
                                vm.infowindow.close();
                            });
                            itemEl.onmouseover = function () {
                                vm.displayInfowindow(marker, title);
                            };
                            itemEl.onmouseout = function () {
                                vm.infowindow.close();
                            };
                        })(marker, places[i].place_name, this);

                        fragment.appendChild(itemEl);
                    }

                    listEl.appendChild(fragment);
                    menuEl.scrollTop = 0;
                    this.map.setBounds(bounds);
                },

                // 검색결과 항목 엘리먼트 생성
                getListItem(index, place) {
                    const el = document.createElement('li');
                    let itemStr =
                        '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                        '<div class="info">' +
                        '  <h5>' + place.place_name + '</h5>';

                    if (place.road_address_name) {
                        itemStr +=
                            '  <span>' + place.road_address_name + '</span>' +
                            '  <span class="jibun gray">' + place.address_name + '</span>';
                    } else {
                        itemStr += '  <span>' + place.address_name + '</span>';
                    }

                    itemStr +=
                        '  <span class="tel">' + (place.phone || '') + '</span>' +
                        '</div>';

                    el.innerHTML = itemStr;
                    el.className = 'item';
                    return el;
                },

                // 마커 추가
                addMarker(position, idx) {
                    const imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png';
                    const imageSize = new kakao.maps.Size(36, 37);
                    const imgOptions = {
                        spriteSize: new kakao.maps.Size(36, 691),
                        spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10),
                        offset: new kakao.maps.Point(13, 37)
                    };
                    const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
                    const marker = new kakao.maps.Marker({ position, image: markerImage });

                    marker.setMap(this.map);
                    this.markers.push(marker);
                    return marker;
                },

                // 모든 마커 제거
                removeMarker() {
                    for (let i = 0; i < this.markers.length; i++) {
                        this.markers[i].setMap(null);
                    }
                    this.markers = [];
                },

                // 페이지네이션
                displayPagination(pagination) {
                    if (!pagination) return;
                    const paginationEl = document.getElementById('pagination');
                    const fragment = document.createDocumentFragment();

                    while (paginationEl.hasChildNodes()) {
                        paginationEl.removeChild(paginationEl.lastChild);
                    }

                    for (let i = 1; i <= pagination.last; i++) {
                        const a = document.createElement('a');
                        a.href = '#';
                        a.innerHTML = i;
                        if (i === pagination.current) {
                            a.className = 'on';
                        } else {
                            a.onclick = ((i) => () => pagination.gotoPage(i))(i);
                        }
                        fragment.appendChild(a);
                    }
                    paginationEl.appendChild(fragment);
                },

                // 인포윈도우 표시
                displayInfowindow(marker, title) {
                    const content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
                    this.infowindow.setContent(content);
                    this.infowindow.open(this.map, marker);
                },

                // 장소 정보 오버레이(커스텀 오버레이)
                displayPlaceInfo(place) {
                    let content =
                        '<div class="placeinfo">' +
                        '  <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';

                    if (place.road_address_name) {
                        content +=
                            '  <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                            '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
                    } else {
                        content += '  <span title="' + place.address_name + '">' + place.address_name + '</span>';
                    }
                    content +=
                        '  <span class="tel">' + (place.phone || '') + '</span>' +
                        '</div>' +
                        '<div class="after"></div>';

                    this.contentNode.innerHTML = content;
                    this.placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
                    this.placeOverlay.setMap(this.map);
                },

                // (선택) 카테고리 클릭 이벤트 바인딩 — HTML에 #category가 있을 때만 사용
                addCategoryClickEvent() {
                    const category = document.getElementById('category');
                    if (!category) return;
                    const children = category.children;
                    for (let i = 0; i < children.length; i++) {
                        children[i].onclick = this.onClickCategory.bind(this);
                    }
                },

                onClickCategory(e) {
                    const id = e.currentTarget.id;
                    const className = e.currentTarget.className;

                    this.placeOverlay.setMap(null);

                    if (className === 'on') {
                        this.currCategory = '';
                        this.changeCategoryClass();
                        this.removeMarker();
                    } else {
                        this.currCategory = id;
                        this.changeCategoryClass(e.currentTarget);
                        this.searchByCategory();
                    }
                },

                changeCategoryClass(el) {
                    const category = document.getElementById('category');
                    if (!category) return;
                    const children = category.children;
                    for (let i = 0; i < children.length; i++) children[i].className = '';
                    if (el) el.className = 'on';
                },

                // 유틸: 자식 노드 모두 제거
                removeAllChildNodes(el) {
                    while (el.hasChildNodes()) el.removeChild(el.lastChild);
                },
            },

            mounted() {
                // 지도/서비스 생성
                this.infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
                this.placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 });
                this.contentNode = document.createElement('div');
                this.contentNode.className = 'placeinfo_wrap';

                this.mapContainer = document.getElementById('map');
                this.mapOption = {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567),
                    level: 5
                };

                this.map = new kakao.maps.Map(this.mapContainer, this.mapOption);
                this.ps = new kakao.maps.services.Places(this.map);

                // 지도 idle 시 현재 뷰 범위에서 키워드 재검색(원하면 유지)
                kakao.maps.event.addListener(this.map, 'idle', this.searchByKeyword.bind(this));

                // 오버레이 이벤트 보호
                this.addEventHandle(this.contentNode, 'mousedown', kakao.maps.event.preventMap);
                this.addEventHandle(this.contentNode, 'touchstart', kakao.maps.event.preventMap);
                this.placeOverlay.setContent(this.contentNode);

                // (선택) 카테고리 바인딩
                this.addCategoryClickEvent();

                // ===== 전역 호출과의 호환성 (폼 onsubmit="searchPlaces()") =====
                // 전역 이름을 Vue 메서드에 연결
                window.searchPlaces = this.searchByKeyword.bind(this);

                // (초기 로딩 시 한번 검색)
                this.searchByKeyword();
            }
        });

        app.mount('#app');
    </script>