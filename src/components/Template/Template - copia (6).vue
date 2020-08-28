<template>
  <v-container>

      <v-flex>
        <v-img
          :src="require('@/assets/logo.png')"
          class="my-3"
          contain
          height="100"
        ></v-img>
      </v-flex>

    isOpera {{ isOpera  }} <BR/>
    isFirefox {{ isFirefox }} <BR/>
    isSafari {{ isSafari  }} <BR/>
    isIE {{ isIE  }} <BR/>
    isEdge {{ isEdge  }} <BR/>
    isChrome {{ isChrome  }} <BR/>
    isBlink {{ isBlink  }} <BR/>

  </v-container>
</template>

<script>
// import {mixshared} from '@/mixins/mixshared.js'

export default {
  name: '',
  // mixins: [mixshared],
  // props: [''],
  components: {
    //
  },
  data: () => ({
    //
    isOpera: null,
    isFirefox: null,
    isSafari: null,
    isIE: null,
    isEdge: null,
    isChrome: null,
    isBlink: null,
  }),
  methods: {
    initialize: function () {
      let opr = null
      let safari = null
      // let isIE  = null
      // Opera 8.0+
      this.isOpera = (!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0
      // Firefox 1.0+
      this.isFirefox = typeof InstallTrigger !== 'undefined'
      // Safari 3.0+ "[object HTMLElementConstructor]" 
      this.isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || (typeof safari !== 'undefined' && safari.pushNotification))
      // Internet Explorer 6-11
      this.isIE = /*@cc_on!@*/false || !!document.documentMode
      // Edge 20+
      this.isEdge = !this.isIE && !!window.StyleMedia
      // Chrome 1 - 71
      this.isChrome = !!window.chrome && (!!window.chrome.webstore || !!window.chrome.runtime)
      // Blink engine detection
      this.isBlink = (this.isChrome || this.isOpera) && !!window.CSS


    },
    processData: function () {
      //
    }
  },
  created () {
    //
  },
  mounted () {
    this.initialize()
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