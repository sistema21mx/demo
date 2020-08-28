<template>
  <v-container>
    <SystemBr ma-0 pa-0 />
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
  }),
  methods: {
    initialize: function () {
      //
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