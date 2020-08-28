<template>
  <v-container>
    <SystemBr ma-0 pa-0 />
    <DiV v-if="imageHeight!==null">{{ editedItem }}</DiV>
    <ResidEdt ma-0 pa-0 :item="editedItem" @setEditedItem="editedItem = $event"/>
  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'
import ResidEdt from '@/components/Residen/ResidEdt'

export default {
  name: 'Residen',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
    ResidEdt
  },
  data: () => ({
    //
    editedItem: {},
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