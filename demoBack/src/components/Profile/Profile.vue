<template>
  <v-container>
    <Listar v-if="viewData.act==='listing'"/>
    <Editar v-if="viewData.act==='editing'"/>
  </v-container>
</template>

<script>
import Listar from '@/components/Profile/ProfiList';
import Editar from '@/components/Profile/ProfilEdit';

export default {
  name: 'Profile',
  components: {
    //
    Listar,
    Editar
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
    this.$store.dispatch('loadViewData', { act: 'listing', param: {} } )
  },
  mounted () {
  },
  updated () {
  },
  watch: {
  },
  computed: {
    viewData: function () {
      return this.$store.getters.getViewData
    }
  }
}
</script>