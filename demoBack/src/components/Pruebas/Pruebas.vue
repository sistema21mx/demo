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
<p> {{ $route.name
  }} </p>
  </v-container>
</template>

<script>
export default {
  name: 'Pruebas',
  components: {
    //
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
  },
  mounted () {
  },
  updated () {
  },
  watch: {
  },
  computed: {
  }
}
</script>