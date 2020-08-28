<template>
  <v-container ma-0 pa-0>

    <v-system-bar
      color="orange"
      :height="systembarHeight"
      :lights-out="systembarLightsOut"
      :window="systembarWindow"
      class="ma-0 pa-0"
      >
      <v-icon>mdi-circle</v-icon>
      <span>{{ labelBar }}</span>
      <v-spacer></v-spacer>
      <v-icon>mdi-clock</v-icon>
      <span>{{ dateNow.hours}}:{{ dateNow.minutes}}-{{ dateNow.ampm}}</span>
    </v-system-bar>

  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'

export default {
  name: 'SystemBr',
  mixins: [mixshared],
  // props: [''],
  components: {
    //
  },
  data: () => ({
    //
    dateNow: {
      hours: 0,
      minutes: 0,
      seconds: 0,
      ampm: null
    },
  }),
  methods: {
    initialize: function () {
      //
    },
    updateTime() {
      const time = new Date();
      // this.dateNow.hours = time.getHours();
      // this.dateNow.minutes = time.getMinutes();
      this.dateNow.seconds = time.getSeconds();
      this.dateNow.hours = this.leadZero(time.getHours(),2)
      this.dateNow.minutes = this.leadZero(time.getMinutes(),2)
    },
    startTime() {
      // let startTime
      let time = new Date();
      let h = time.getHours()
      let m = time.getMinutes()
      let s = time.getSeconds()
      let ampm = h >= 12 ? 'pm' : 'am'
      h = h % 12
      h = h ? h : 12
      m = this.checkTime(m)
      s = this.checkTime(s)
      this.dateNow.hours = h
      this.dateNow.minutes = m
      this.dateNow.seconds = s
      this.dateNow.ampm = ampm
      // let t = setTimeout(this.startTime, 500)
      setTimeout(()=>{
        this.startTime()
      },50000); // 500

    },
    checkTime(i) {
      if (i < 10) {i = "0" + i}  // add zero in front of numbers < 10
      return i
    },
    processData: function () {
      //
    }
  },
  created () {
    //
  },
  mounted () {
    //
    // this.updateTime()
    // setTimeout(()=>{
    //   this.showTime = false
    // },50000);
    this.startTime()
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