<template>
  <v-container>
    <div id="clouds">
      <div class="cloud x1"></div>
            <div class="cloud x1_5"></div>
            <div class="cloud x2"></div>
            <div class="cloud x3"></div>
            <div class="cloud x4"></div>
            <div class="cloud x5"></div>
    </div>
    <div class='c'>
            <div class='_404'>404</div>
            <!-- hr -->
            <div class='_1'>Error: Esta opción no existe o presenta problemas</div>
            <div class='_2'>Contacte a su administrador</div>
            <a class='btn' href='#' @click="regresar()">Regresar a Principal</a>
    </div>
  </v-container>
</template>
<script>
  export default {
    data: () => ({
      drawer: false
    }),
    name: 'Error404',
    methods: {
      some: function () {
      },
      regresar: function () {
        this.$store.dispatch('loadLoadRoute', { route: 'Home', param: '', title: '' })
      }
    }
  }
</script>
<style scoped lang="scss">

</style>