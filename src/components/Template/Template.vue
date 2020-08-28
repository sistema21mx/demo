<template>
  <v-container>
    <SystemBr ma-0 pa-0 />
    <v-btn 
    @click.stop="processData"
    :loading="loading"
    :disabled="loading">Ejecutar
    </v-btn>
    {{ responseData }} <br/>
    {{ data2 }}
    <BR/>
    {{ jwtDecoded }}
    <br/>
    {{ expires }} <BR/>
<div id="reloj">
  <div id="clock">
    <p class="date">{{ date }}</p>
    <p class="tiempo">{{ time }}</p>
    <p class="text">DIGITAL CLOCK with Vue.js</p>
</div>
</div>


  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'

export default {
  name: '',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
  },
  data: () => ({
    //
    data2: [],
    loading:false,
    jwtDecoded: '',
    expires: '',
    time: '',
    date: '',
    clock: document.getElementById('clock'),
    week: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
    timerID: '',

  }),
  mounted() {
    this.jwtDecoded = JSON.parse(atob(this.loadKeyPass.split('.')[1]))
    this.expires = new Date(parseInt(this.jwtDecoded.exp)*1000)
    this.timerID = setInterval(this.updateTime(), 1000)
    this.updateTime()
  },
  methods: {
    initialize: function () {
      //
    },
    processData: function () {
      //
      // alert('entro')
      this.loading = true
      this.axios.all([
        this.axios.post(this.urlApi + '/providerlist' , FormData, {headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + this.loadKeyPass
        }
        }),
        this.axios.post(this.urlApi + '/budgetlist' , FormData, {headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + this.loadKeyPass
        }
        })
      ]).then(responseArr => {
            // console.log(response.data)
            // console.log( '*** ' + this.$route.name + ' *** is good !! '  )
            // alert('entro2')
            console.log('response.data')
            this.responseData = responseArr[0].data
            this.data2 = responseArr[1].data
            this.$store.dispatch('loadLoadData', 1)
            this.loading = false
      }).catch(e => {
            console.log( '*** ' + ' *** is Not good !! ' + e )
            this.loading = false
      })
    },
    updateTime() {
    var cd = new Date();
    this.time = this.zeroPadding(cd.getHours(), 2) + ':' + this.zeroPadding(cd.getMinutes(), 2) + ':' + this.zeroPadding(cd.getSeconds(), 2);
    this.date = this.zeroPadding(cd.getFullYear(), 4) + '-' + this.zeroPadding(cd.getMonth()+1, 2) + '-' + this.zeroPadding(cd.getDate(), 2) + ' ' + this.week[cd.getDay()];
    setTimeout(()=>{
        this.updateTime()
    },1000); // 500

    },
    zeroPadding(num, digit) {
    var zero = '';
    for(var i = 0; i < digit; i++) {
        zero += '0';
    }
    return (zero + num).slice(-digit);
    }
    
  },
  created () {
    //
  },
  updated () {
    //
  },
  watch: {
    //
  },
  computed: {
    //
  }
}
</script>
<style>
html,body {
    height: 100%;
}
#reloj {
    background: #0f3854;
    background: radial-gradient(ellipse at center,  #0a2e38  0%, #000000 70%);
    background-size: 100%;
    border: solid;
    height: 50%;
    width: 80%;

}
p {
    margin: 0;
    padding: 0;
}
#clock {
    font-family: 'Share Tech Mono', monospace;
    color: #ffffff;
    text-align: center;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    color: #daf6ff;
    text-shadow: 0 0 20px rgba(10, 175, 230, 1),  0 0 20px rgba(10, 175, 230, 0);
    border: solid;
    background: #0f3854;
    background: radial-gradient(ellipse at center,  #0a2e38  0%, #000000 70%);
    background-size: 100%;
}

    .tiempo {
        letter-spacing: 0.05em;
        font-size: 80px;
        padding: 5px 0;
    }
    .date {
        letter-spacing: 0.1em;
        font-size: 24px;
    }
    .text {
        letter-spacing: 0.1em;
        font-size: 12px;
        padding: 20px 0 0;
    }

</style>