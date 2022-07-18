HTTP/1.0 200 Document follows
Server: messerv
Content-Type: text/html; charset=utf8

<head>
<title>report02</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>

<style>
/* 時計本体 */
#clock {
  margin: 40px auto;
  max-width: 700px;
  position: relative;
}

/* 秒針 */
#second-hand {
  animation: rotation-s2 60s linear infinite; /* 60秒かけて一周 */
  background-color: #999;
  border-radius: 2px;
  height: 4px; /* 線幅 */
  position: absolute;
  right: calc(50% - 2px); /* 位置調整 線幅の半分ずらす */
  top: calc(50% - 2px); /* 位置調整 線幅の半分ずらす */
  transform-origin: calc(100% - 2px) center; /* アニメーションの中心軸 線幅の半分ずらす */
  width: 50%;
}

/* 分針 */
#minute-hand {
  animation: rotation-m2 3600s linear infinite; /* 3600秒、1時間かけて一周 */
  background-color: #000;
  border-radius: 5px;
  height: 10px; /* 線幅 */
  position: absolute;
  right: calc(50% - 5px); /* 位置調整 線幅の半分ずらす */
  top: calc(50% - 5px); /* 位置調整 線幅の半分ずらす */
  transform-origin: calc(100% - 5px) center; /* アニメーションの中心軸 線幅の半分ずらす */
  width: 40%;
}

/* 時針 */
#hour-hand {
  animation: rotation-h2 86400s linear infinite; /* 86400秒、12時間かけて一周 */
  background-color: #cc3b3b;
  border-radius: 5px;
  height: 10px; /* 線幅 */
  position: absolute;
  right: calc(50% - 5px); /* 位置調整 線幅の半分ずらす */
  top: calc(50% - 5px); /* 位置調整 線幅の半分ずらす */
  transform-origin: calc(100% - 5px) center; /* アニメーションの中心軸 線幅の半分ずらす */
  width: 25%;
}
</style>

<script>
// 現在の日時: DATE
function show_time() {
  let nowDate = new Date();
  console.log(nowDate);
  document.write(nowDate);
}
</script>
</head>


<body bgcolor=#eeeeff>
現在の日時： <script> show_time(); </script> 
<br>

<div id="app">
  <h1 class="animate__animated animate__bounce">{{ message }}</h1>
  <h2 class="animate__animated animate__bounce text-center mb-3">{{ title }}</h2>
  <ul class="animate__animated animate__bounce list-group">
    <li class="list-group-item" v-show="timestamp"><strong>Timestamp:</strong> {{ timestamp }}</li>
    <li class="list-group-item" v-show="date"><strong>Date:</strong> {{ date }}</li>
    <li class="list-group-item" v-show="time"><strong>Time:</strong> {{ time }}</li>
    <li class="list-group-item" v-show="year"><strong>Current Year:</strong> {{ year }}</li>
    <li class="list-group-item" v-show="fulldatetime"><strong>Full Date:</strong> {{ fulldatetime }}</li>
  </ul>
</div>

<div id="clock" class="animate__animated animate__rubberBand">
  <div id="hour-hand"></div>
  <div id="minute-hand"></div>
  <div id="second-hand"></div>
</div>

<script>
// 時計
// 現在時刻の設定
let time = new Date();
let second = time.getSeconds();
let minute = time.getMinutes();
let hour = time.getHours();

// 現在時刻を元にした角度の設定
let secondDeg = (second * 360 / 60) + 90 ;
let minuteDeg = (minute * 360 / 60) + ((second * 360 / 60) / 60) + 90;
let hourDeg = (hour * 360 / 12) + ((minute * 360 / 60) / 12)  + ((second * 360 / 60) / 720) + 90;

// style 要素を作り、その中に keyframes アニメーションを入れる
let animation = document.createElement("style");
animation.innerHTML = "@keyframes rotation-s2 {0% {transform: rotate(" + secondDeg + "deg)}100% {transform: rotate(" + (secondDeg + 360) + "deg)}}@keyframes rotation-m2 {0% {transform: rotate(" + minuteDeg + "deg)}100% {transform: rotate(" + (minuteDeg + 360) + "deg)}}@keyframes rotation-h2 {0% {transform: rotate(" + hourDeg + "deg)}100% {transform: rotate(" + (hourDeg + 360) + "deg)}}";
document.head.appendChild(animation);

// レスポンシブな正方形を作る
document.getElementById("clock").style.height = document.getElementById("clock").scrollWidth + "px";
</script>


<script>
// vue.js
let app = new Vue({
  el: '#app',
  data: {
    message: 'Use Vue.js!',
    title: 'Vue Get Full Date and Time',
    date: '',
    time: '',
    year: '',
    timestamp: '',
    fulldatetime: '',
  },
  methods: {
    printDate: function () {
      return new Date().toLocaleDateString();
    },
    printTime: function () {
      return new Date().toLocaleTimeString();
    },
    printYear: function () {
      return new Date().getFullYear();
    },          
    printTimestamp: function () {
      return Date.now();
    },
    printFullDate: function(){
      return new Date();
    }
  },
  mounted: function () {
    this.date = this.printDate();
    this.time = this.printTime();
    this.timestamp = this.printTimestamp();
    this.year = this.printYear();
    this.fulldatetime = this.printFullDate();
  },
})
</script>
</body>
