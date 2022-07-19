HTTP/1.0 200 Document follows
Server: messerv
Content-Type: text/html; charset=utf8

<head>
<title>report02</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
CDN

<style>
  #analog {
    height: 400px;
    width: 100%;
    position: relative;
  }
  #analog .analog-face {
    border: 3px solid black;
    background-color: white;
    border-radius: 50%;
    position: absolute;
  }
  #analog div {
    box-sizing: content-box;
  }
  .analog-line1,
  .analog-line2 {
    position: absolute;
    left: 0;
    z-index: 1;
  }
  .analog-line1 {
    width: 5px;
    height: 3px;
    background: black;
    top: calc(50% - 2px);
  }
  .analog-line2 {
    width: 3px;
    height: 2px;
    background: black;
    top: calc(50% - 1px);
  }
  .analog-text {
    color: black;
    font-size: 2em;
    position: absolute;
    transform: translate(-50%, -50%);
    z-index: 2;
  }
  .analog-seconds {
    background-color: red;
    width: 5px;
    position: absolute;
    z-index: 10;
    border-radius: 5px;
  }
  .analog-hours {
    background-color: black;
    width: 10px;
    position: absolute;
    z-index: 8;
    border-radius: 5px;
  }
  .analog-minutes {
    background-color: black;
    width: 10px;
    position: absolute;
    z-index: 9;
    border-radius: 5px;
  }
  .analog-center,
  .analog-center:after {
    position: absolute;
    top: 50%;
    left: 50%;
    z-index: 15;
    border-radius: 50%;
  }
  .analog-center {
    background-color: black;
    height: 21px;
    width: 21px;
    transform: translate(-11px, -11px);
  }
  .analog-center:after {
    content: '';
    background-color: silver;
    height: 17px;
    width: 17px;
    transform: translate(-9px, -9px);
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
現在の日時(c): DATE <br>
現在の日時(js): <script> show_time(); </script> 
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

<div id="analog" class="animate__animated animate__rollIn"></div>

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

<script>
  (() => {
    const addDiv = (parentDiv, className, callBack = null) => {
      const t = document.createElement('div');
      t.classList.add(className);
      if (callBack && typeof callBack === 'function') callBack(t);
      parentDiv.appendChild(t);
      return t;
    };

    const createFace = () => {
      const analog = document.getElementById('analog');
      const vp = [analog.clientWidth, analog.clientHeight];
      const chokei = Math.min(...vp);

      const analogFace = addDiv(analog, 'analog-face', (t) => {
        [t.style.height, t.style.width] = [chokei + 'px', chokei + 'px'];
        [t.style.top, t.style.left] = [(vp[1] - chokei) / 2 + 'px', (vp[0] - chokei) / 2 + 'px'];
      });

      const r60 = 360 / 60;
      const originX = analogFace.clientWidth / 2;

      for (let i = 0; i < 60; i++) {
        const deg = i * r60;

        addDiv(analogFace, i % 5 === 0 ? 'analog-line1' : 'analog-line2', (t) => {
          if (i > 0) {
            t.style.transformOrigin = `${originX}px center`;
            t.style.transform = `rotate(${deg}deg)`;
          }
        });
      }

      const r12 = 360 / 12;
      const hankei = originX;
      const moziPos = hankei - 30;
      const MathPi = Math.PI / 180;

      for (let i = 0; i < 12; i++) {
        const deg = i * r12;
        addDiv(analogFace, 'analog-text', (t) => {
          const mojiX = hankei + moziPos * Math.sin(deg * MathPi);
          const mojiY = hankei - moziPos * Math.cos(deg * MathPi);
          [t.style.top, t.style.left] = [mojiY + 'px', mojiX + 'px'];
          t.innerText = i === 0 ? '12' : i.toString();
        });
      }

      addDiv(analogFace, 'analog-center');

      return analogFace;
    };

    const firstTransition = 'transform 0.5s ease-out';

    const handObj = function (
      className,
      { parentDiv: parentDiv, LengthPer: LengthPer, handGapPer: handGapPer, divNum: divNum }
    ) {
      const hankei = parentDiv.clientHeight / 2;
      const handLength = (hankei * LengthPer) / 100;
      const handGap = (hankei * handGapPer) / 100;

      const elm = addDiv(parentDiv, className);

      elm.style.height = handLength + handGap + 'px';
      [elm.style.top, elm.style.left] = [
        hankei - handLength + 'px',
        hankei - elm.clientWidth / 2 + 'px',
      ];
      elm.style.transformOrigin = `center ${handLength}px `;
      elm.style.transition = firstTransition;

      this.rotateText = [];
      const angle = 360 / divNum;

      for (let i = 0; i < divNum; i++) {
        this.rotateText.push(`rotate(${angle * i}deg)`);
      }
      this.elm = elm;
      this.currentValue = null;

      this.transitionFlg = true;
      this.transitionCount = 0;
    };
    handObj.prototype.moveHand = function (val) {
      if (this.currentValue === val) return;
      if (this.transitionFlg && ++this.transitionCount > 1) {
        this.elm.style.transition = '';
        this.transitionFlg = false;
      }
      this.currentValue = val;

      this.elm.style.transform = this.rotateText[val];
    };

    window.addEventListener('DOMContentLoaded', () => {
      const analogFace = createFace();

      const secondHand = new handObj('analog-seconds', {
        parentDiv: analogFace,
        LengthPer: 85,
        handGapPer: 20,
        divNum: 60,
      });

      const hourHand = new handObj('analog-hours', {
        parentDiv: analogFace,
        LengthPer: 55,
        handGapPer: 10,
        divNum: 12 * 60,
      });

      const minuteHand = new handObj('analog-minutes', {
        parentDiv: analogFace,
        LengthPer: 80,
        handGapPer: 10,
        divNum: 60,
      });

      setInterval(() => {
        const date = new Date();
        secondHand.moveHand(date.getSeconds());
        hourHand.moveHand((date.getHours() % 12) * 60 + date.getMinutes());
        minuteHand.moveHand(date.getMinutes());
      }, 1000);
    });
  })();
</script>
</body>
